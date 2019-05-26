library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
Entity Camera_Master_Interface is
Port(
 Clk : IN STD_LOGIC ;
 Reset_n : IN STD_LOGIC ;
 Address: IN STD_LOGIC_VECTOR(31 downto 0) ;
 Length_Frame: IN STD_LOGIC_VECTOR(31 downto 0) ;
 Ready: IN STD_LOGIC ;
 --LCD Connection
 Buffer_Saved : OUT STD_LOGIC_VECTOR(1 downto 0) ;
 Display_Buffer  : IN STD_LOGIC_VECTOR(1 downto 0) ;
 --FIFO Connection
 FIFO_Data_Available: IN STD_LOGIC ;
 FIFO_Read_Request : OUT STD_LOGIC ;
 FIFO_Read_Data : IN STD_LOGIC_VECTOR(31 downto 0) ; 
-- Avalon Master :
 AM_readdatavalid: IN STD_LOGIC;
 AM_Adresse : OUT STD_LOGIC_VECTOR(31 downto 0) ;
 AM_ByteEnable : OUT STD_LOGIC_VECTOR(3 downto 0) ;
 AM_Write : OUT STD_LOGIC ;
 AM_Read : OUT STD_LOGIC ;
 AM_DataWrite : OUT STD_LOGIC_VECTOR(31 downto 0) ;
 AM_BurstCount : OUT STD_LOGIC_VECTOR(3 downto 0) ;
 AM_DataRead : IN STD_LOGIC_VECTOR(31 downto 0) ;
 AM_WaitRequest : IN STD_LOGIC
) ; 
end entity Camera_Master_Interface;

Architecture Comp of Camera_Master_Interface is

	TYPE Master_State IS (IDLE_FOR_READY,IDLE_FOR_DATA,CLOCK_WAIT_DATA_FIFO,Collect_Data_FIFO,DMA_Send_Init,DMA_Send_Loop);
	signal State:Master_State;
	signal Current_Address,Base_Address, Offset_Address: STD_LOGIC_VECTOR(31 downto 0) ;
	signal Indice_Array_FIFO,Indice_Array_DMA: unsigned ( 4 downto 0):= "00000";
	type DATA is array (8 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
	signal DATA_Array: Data;
Begin 
	
	-- Acquisition
	Avalon_Bus:
	Process(Clk, Reset_n)
		variable Indice_Memory_Zone: unsigned ( 1 downto 0):= "00";
		variable New_Address: STD_LOGIC_VECTOR ( 33 downto 0):= (others =>'0');
		Begin
		 if Reset_n = '0' then
			Offset_Address<=(others=>'0');
			Current_Address<=(others=>'0');
 			DATA_Array<=(others=>(others=>'0'));
			FIFO_Read_Request<='0';
			Indice_Array_FIFO<="00000";
			Indice_Array_DMA<="00000";
 			AM_Adresse<=(others=>'0');
 			AM_ByteEnable<=(others=>'0');
 			AM_Write<='0';
 			AM_Read<='0';
 			AM_DataWrite<=(others=>'0');
 			AM_BurstCount<=(others=>'0');
 			State<=IDLE_FOR_READY;
			Base_Address<=(others=>'0');
			Indice_Memory_Zone:="00";
		 elsif rising_edge(Clk) then
			case State is
			when IDLE_FOR_READY => 	
				AM_Write<='0';
				AM_BurstCount<="0000";
					if Ready='1' then
						State<=IDLE_FOR_DATA;
						Indice_Array_DMA<="00000";
						Indice_Array_FIFO<="00000";
						if Offset_Address>=Length_Frame then -- New frame
							Offset_Address<=(others=>'0');	
							Buffer_Saved<=std_logic_vector(Indice_Memory_Zone); --output the previous value of Indice
							case Display_Buffer is
								when "00" =>
									case Indice_Memory_Zone is
										when "01" =>
											Indice_Memory_Zone:="10";
											Base_Address<=std_logic_vector(unsigned(Address)+unsigned(Length_Frame)+unsigned(Length_Frame));
										when others =>
											Indice_Memory_Zone:="01";
											Base_Address<=std_logic_vector(unsigned(Address)+unsigned(Length_Frame));
									end case;
								when "01" =>
									case Indice_Memory_Zone is
										when "10" =>
											Indice_Memory_Zone:="00";
											Base_Address<=std_logic_vector(unsigned(Address));
										when others =>
											Indice_Memory_Zone:="10";
											Base_Address<=std_logic_vector(unsigned(Address)+unsigned(Length_Frame)+unsigned(Length_Frame));
									end case;
								when "10" =>
									case Indice_Memory_Zone is
										when "00" =>
											Indice_Memory_Zone:="01";
											Base_Address<=std_logic_vector(unsigned(Address)+unsigned(Length_Frame));
										when others =>
											Indice_Memory_Zone:="00";
											Base_Address<=std_logic_vector(unsigned(Address));
									end case;
								when others => Indice_Memory_Zone:="00";
								Base_Address<=std_logic_vector(unsigned(Address));
							end case;
							
						end if;
					else
						Current_Address<=(others=>'0');
						Offset_Address<=(others=>'0');
						Base_Address<=std_logic_vector(unsigned(Address));
					end if;
				when IDLE_FOR_DATA =>
					Current_Address<=std_logic_vector(unsigned(Base_Address)+unsigned(Offset_Address));
					if FIFO_Data_Available='0' and Ready='1' then
						FIFO_Read_Request<='1';
						State<=CLOCK_WAIT_DATA_FIFO;
					elsif Ready='0' then
						State<=IDLE_FOR_READY;
						
					end if;
				when CLOCK_WAIT_DATA_FIFO=>
					State<=Collect_Data_FIFO;
				when  Collect_Data_FIFO =>
					DATA_Array(to_integer(Indice_Array_FIFO))<=FIFO_Read_Data;
					Indice_Array_FIFO<=Indice_Array_FIFO+1;
					if Indice_Array_FIFO=7 then
						
						State<=DMA_Send_Init;
					elsif Indice_Array_FIFO=6 then
						FIFO_Read_Request<='0';
					end if;
				when DMA_Send_Init =>
					AM_Write<='1';
					AM_Adresse<=Current_Address;
					AM_BurstCount<="1000";
					AM_ByteEnable<="1111";
					AM_DataWrite<=DATA_Array(0);
					State<=DMA_Send_Loop;
				when DMA_Send_Loop =>
					if AM_WaitRequest='0' then
						AM_DataWrite<=DATA_Array(to_integer(Indice_Array_DMA+1));
						if Indice_Array_DMA<6 then
							Indice_Array_DMA<=Indice_Array_DMA+1;
						else
							Offset_Address<=std_logic_vector(unsigned(Offset_Address)+to_unsigned(32,32));-- 8 
							
							State<=IDLE_FOR_READY;
						end if;
					end if;
			end case;	
		 end if;
	End Process Avalon_Bus;

End Comp; 