library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 

Entity Camera_Acquisition_module is
Port(
 Clk : IN STD_LOGIC ;
 Reset_n : IN STD_LOGIC ;
 Ready : IN STD_LOGIC;
-- Avalon Slave :
 FVAL : IN STD_LOGIC;
 LVAL : IN STD_LOGIC ;
 Data_Camera : IN STD_LOGIC_VECTOR(11 downto 0) ;
 Out_Pixel: OUT STD_LOGIC_VECTOR(15 downto 0) ;
 Pixel_Valid_Out: OUT STD_LOGIC
) ; 
end entity Camera_Acquisition_module;
Architecture Comp of Camera_Acquisition_module is

	signal Data_Write_FIFO_Store_Line,Data_Read_FIFO_Store_Line: STD_LOGIC_VECTOR(15 downto 0);
	signal Write_Req_FIFO_Store_Line,Read_Req_FIFO_Store_Line: std_logic;
	signal Clear_FIFO_Store_Line: std_logic;
	signal Number_Words_FIFO_Store_Line: STD_LOGIC_VECTOR(9 downto 0);
	Component FIFO_Store_Line IS
	PORT
	(
		clock		: IN STD_LOGIC ;
		data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		rdreq		: IN STD_LOGIC ;
		aclr		: IN STD_LOGIC ;
		wrreq		: IN STD_LOGIC ;
		empty		: OUT STD_LOGIC ;
		full		: OUT STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
		usedw		: OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
	);
	END component FIFO_Store_Line;
	
	TYPE Acquisition_State IS (Idle_Frame,Idle_Line, Getting_Pixels);
	Signal State: Acquisition_State;
	signal Pixel_Number:integer :=0;
	signal Line_Number:integer :=0;
	signal Pixel_Value_Even: STD_LOGIC_VECTOR(4 downto 0);
	signal FVAL_Previous,LVAL_Previous: std_logic;

Begin 
	FIFO_Store_Line_inst : FIFO_Store_Line PORT MAP (
		clock	 => Clk,
		data	 => Data_Write_FIFO_Store_Line,
		rdreq	 => Read_Req_FIFO_Store_Line,
		aclr	 => Clear_FIFO_Store_Line,
		wrreq	 => Write_Req_FIFO_Store_Line,
		empty	 => open,
		full	 => open,
		q	 => Data_Read_FIFO_Store_Line,
		usedw	 => open
	);

	-- Use of the avalon Bus
	Camera_Acq:
	Process(Clk, Reset_n)
		variable Convert_Pixel: unsigned(23 downto 0)  :=(others=>'0');
		variable Storage_Pixel: STD_LOGIC_VECTOR(4 downto 0):="00000";
		variable Sum_Pixel: unsigned(5 downto 0):="000000";
		begin
		if Reset_n = '0' then
			Clear_FIFO_Store_Line<='0';
			Data_Write_FIFO_Store_Line(15 downto 0)<=(others => '0');
			Write_Req_FIFO_Store_Line<='0';
			Read_Req_FIFO_Store_Line<='0';
			Clear_FIFO_Store_Line<='1';
			State<=Idle_Frame;
			Pixel_Number<=0;
			Line_Number<=0;
			Pixel_Valid_Out<='0';
			Out_Pixel<=(others=>'0');
			FVAL_Previous<='1';
			LVAL_Previous<='1';
			Pixel_Value_Even<=(others=>'0');
		elsif falling_edge(Clk) then
			FVAL_Previous<=FVAL;
			LVAL_Previous<=LVAL;
			Clear_FIFO_Store_Line<='0';
			Data_Write_FIFO_Store_Line(15 downto 0)<=(others => '0');
			Write_Req_FIFO_Store_Line<='0';
			Read_Req_FIFO_Store_Line<='0';
			Clear_FIFO_Store_Line<='0';
			Out_Pixel<=(others=>'0');
			Pixel_Valid_Out<='0';
			case State is
				when Idle_Frame =>
					if FVAL='1' and FVAL_Previous='0' and Ready='1' then --Rising edge of FVAL 
						State<=Idle_Line;
					end if;
					Pixel_Number<=0;
					Line_Number<=0;
					Pixel_Value_Even<=(others => '0');
					Clear_FIFO_Store_Line<='1';
				when Idle_Line =>
					Pixel_Number<=0;
					Pixel_Value_Even<=(others => '0');
					if LVAL='1' and LVAL_Previous='0' then --Rising edge of LVAL and read the first pixel
						State<=Getting_Pixels;-- Even pixel so Blue or green1
						Convert_Pixel:=(unsigned(Data_Camera)*31/4095);
						Storage_Pixel:=std_logic_vector(Convert_Pixel(4 downto 0));
						Pixel_Value_Even<=Storage_Pixel;
						Pixel_Number<=1;
						if Line_Number mod 2=1 then --Even Line, need to request the fifo_tmp value
							Read_Req_FIFO_Store_Line<='1';--Ask value to the fifo_tmp
						end if;
					end if;
				when Getting_Pixels =>
					if LVAL='0' and (LVAL_Previous='1' and (FVAL='1' and FVAL_Previous='1')) then --Falling edge of LVAL 
						State<=Idle_Line;
						Line_Number<=Line_Number+1;
					elsif FVAL='0' and FVAL_Previous='1' then -- HVal Falling
						State<=Idle_Frame;
					else
						Convert_Pixel:=(unsigned(Data_Camera)*31/4095);
						Storage_Pixel:=std_logic_vector(Convert_Pixel(4 downto 0));
						if Line_Number mod 2=0 then--Line Even
							if Pixel_Number mod 2=0 then-- Even pixel so green1
								
								Pixel_Value_Even<=Storage_Pixel;
								Write_Req_FIFO_Store_Line<='0';-- Concatenate pixels in 16 bits  + Send them to fifo_tmp
							else -- Odd Pixel so red
								Data_Write_FIFO_Store_Line(15 downto 11)<=Storage_Pixel;
								Data_Write_FIFO_Store_Line(10 )<='0';
								Data_Write_FIFO_Store_Line(9 downto 5 )<=Pixel_Value_Even;
								Data_Write_FIFO_Store_Line(4 downto 0 )<=(others => '0');
								Write_Req_FIFO_Store_Line<='1';-- Concatenate pixels in 16 bits  + Send them to fifo_tmp
							end if;
						else -- Line odd
							if Pixel_Number mod 2=0 then-- Even pixel so Blue 
								Pixel_Value_Even<=Storage_Pixel;
								Read_Req_FIFO_Store_Line<='1';--Ask value to the fifo_tmp
							else -- Odd Pixel so green 2
								Read_Req_FIFO_Store_Line<='0';-- Collect from Fifo, concatenate the last pixels and sedn it to the FIFO_CLOCK_Interface
								Out_Pixel(15 downto 11)<=Data_Read_FIFO_Store_Line(15 downto 11);--Pixel Red
								Sum_Pixel:=('0' & unsigned(Pixel_Value_Even))+('0' & unsigned(Data_Read_FIFO_Store_Line(9 downto 5)));
								Out_Pixel(10 downto 5 )<=std_logic_vector(Sum_Pixel);----Sum of two green pixels
								Out_Pixel(4 downto 0 )<=Storage_Pixel;--Pixel Blue 
								Pixel_Valid_Out<='1';
							end if;
						end if;
						Pixel_Number<=Pixel_Number+1;
					end if;
				end case;
				if Ready='0' then
					State<= Idle_Frame;
				end if;
		end if;
	End Process Camera_Acq;

End Comp; 