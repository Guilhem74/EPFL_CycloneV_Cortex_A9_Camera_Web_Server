library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity Top_Level is
	Port(
		Clk_FPGA       : IN  STD_LOGIC;
		Reset_n        : IN  STD_LOGIC;
		-- Avalon Bus :
			--Master Part
			AM_readdatavalid: IN STD_LOGIC;
			AM_Adresse     : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			AM_BurstCount  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			AM_ByteEnable  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			AM_DataRead    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
			AM_DataWrite   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			AM_Read        : OUT STD_LOGIC;
			AM_WaitRequest : IN  STD_LOGIC;
			AM_Write       : OUT STD_LOGIC;
			-- Slave part
			avs_Address    : IN  std_logic_vector(2 DOWNTO 0);
			avs_ChipSelect : IN  std_logic;
			avs_Read       : IN  std_logic;
			avs_Write      : IN  std_logic;
			avs_ReadData   : OUT std_logic_vector(31 DOWNTO 0);
			avs_WriteData  : IN  std_logic_vector(31 DOWNTO 0);		
		--Camera I/O
		Clk_Camera     :     STD_LOGIC;
		FVAL           : IN  STD_LOGIC;
		LVAL           : IN  STD_LOGIC;
		Data_Camera    : IN  STD_LOGIC_VECTOR(11 downto 0);
		Debug    : OUT  STD_LOGIC_VECTOR(31 downto 0);
		--LCD Connection
		Buffer_Saved 		  : OUT STD_LOGIC_VECTOR(1 downto 0) ;
		Display_Buffer      : IN STD_LOGIC_VECTOR(1 downto 0) 
	);
end entity Top_Level;
Architecture Comp of Top_Level is
	SIGNAL Address                             : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL FIFO_Data_Available                 : STD_LOGIC;
	SIGNAL FIFO_Read_Data                      : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL FIFO_Master_Interface_Read_Request  : STD_LOGIC;
	SIGNAL Ready                               : STD_LOGIC;
	SIGNAL FIFO_Master_Interface_Write_Request : STD_LOGIC;
	SIGNAL Out_Pixel                           : STD_LOGIC_VECTOR(15 downto 0);
	SIGNAL Reset_H                             : STD_LOGIC;
	signal rdreq_FIFO_Inter_Clock_Domain   : STD_LOGIC;
	signal wrreq_FIFO_Inter_Clock_Domain   : STD_LOGIC;
	signal Output_Camera_2Pixels_32Bits    : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal rdempty_FIFO_Inter_Clock_Domain : STD_LOGIC;
	signal Combination_Signal  : STD_LOGIC:='0';
	signal Length_Frame_Interconnect : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	SIGNAL FIFO_Flush_Signal: STD_LOGIC;
	SIGNAL Clock_Camera_PLL  : STD_LOGIC;

	COMPONENT Camera_Master_Interface
		PORT(
			Address             : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
			Length_Frame		: IN STD_LOGIC_VECTOR(31 downto 0) ;
			AM_Adresse          : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			AM_BurstCount       : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			AM_ByteEnable       : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			AM_DataRead         : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
			AM_DataWrite        : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			AM_Read             : OUT STD_LOGIC;
			AM_WaitRequest      : IN  STD_LOGIC;
			AM_Write            : OUT STD_LOGIC;
			AM_readdatavalid	  : IN STD_LOGIC;
			Clk                 : IN  STD_LOGIC;
			FIFO_Data_Available : IN  STD_LOGIC;
			FIFO_Read_Data      : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
			FIFO_Read_Request   : OUT STD_LOGIC;
			Ready               : IN  STD_LOGIC;
			Buffer_Saved 		  : OUT STD_LOGIC_VECTOR(1 downto 0) ;
			Display_Buffer      : IN STD_LOGIC_VECTOR(1 downto 0) ;
			Reset_n             : IN  STD_LOGIC
		);
	END COMPONENT;
	COMPONENT Camera_Slave_Interface IS
		PORT(
			--   Avalon interfaces signals
			Clk            : IN  std_logic;
			nReset         : IN  std_logic;
			avs_Address    : IN  std_logic_vector(2 DOWNTO 0);
			avs_ChipSelect : IN  std_logic;
			avs_Read       : IN  std_logic;
			avs_Write      : IN  std_logic;
			avs_ReadData   : OUT std_logic_vector(31 DOWNTO 0);
			avs_WriteData  : IN  std_logic_vector(31 DOWNTO 0);
			--   UART external interface
			Start_Signal   : OUT std_logic;
		 	Length_Frame : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); 
			CamAddress     : OUT std_logic_vector(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT FIFO_Master_Interface_Avalon_Bus IS                 -- Fifo feeding the master interface
		PORT(
			aclr         : IN  STD_LOGIC;
			clock        : IN  STD_LOGIC;
			data         : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
			rdreq        : IN  STD_LOGIC;
			wrreq        : IN  STD_LOGIC;
			almost_empty : OUT STD_LOGIC;
			almost_full  : OUT STD_LOGIC;
			empty        : OUT STD_LOGIC;
			full         : OUT STD_LOGIC;
			q            : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			usedw        : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT Camera_Acquisition_module        -- Interface capturing the data coming from the camera
		PORT(
			Clk             : IN  STD_LOGIC;
			Data_Camera     : IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
			Ready				 : IN  STD_LOGIC;
			FVAL            : IN  STD_LOGIC;
			LVAL            : IN  STD_LOGIC;
			Out_Pixel       : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			Reset_n         : IN  STD_LOGIC;
			Pixel_Valid_Out : OUT STD_LOGIC
		);
	END COMPONENT;
	component FIFO_Inter_Clock_Domain   --Fifo doing the cross domain, feeded by the camera interface and feed the master avalon interface
		PORT(
			aclr    : IN  STD_LOGIC := '0';
			data    : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
			rdclk   : IN  STD_LOGIC;
			rdreq   : IN  STD_LOGIC;
			wrclk   : IN  STD_LOGIC;
			wrreq   : IN  STD_LOGIC;
			q       : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			rdempty : OUT STD_LOGIC;
			wrfull  : OUT STD_LOGIC
		);
	end component;
	component PLL_Camera is
	port (
		refclk   : in  std_logic := '0'; --  refclk.clk
		rst      : in  std_logic := '0'; --   reset.reset
		outclk_0 : out std_logic         -- outclk0.clk
	);
	end component;
Signal INTERCONNECT : STD_LOGIC_VECTOR(31 downto 0);
BEGIN

	Reset_H <= not (Reset_n) or FIFO_Flush_Signal;
	FIFO_Flush_Signal<= not (Ready);
	PLL_Camera_inst : PLL_Camera
		PORT MAP (
		refclk  => Clk_Camera,
		rst     => Reset_H,
		outclk_0 => Clock_Camera_PLL
		);
	
	Master_Interface_inst : Camera_Master_Interface
		PORT MAP(
			-- list connections between master ports and signals
			Address             => Address,
			Length_Frame 		=> Length_Frame_Interconnect,
			AM_readdatavalid    => AM_readdatavalid,
			AM_Adresse          => AM_Adresse,
			AM_BurstCount       => AM_BurstCount,
			AM_ByteEnable       => AM_ByteEnable,
			AM_DataRead         => AM_DataRead,
			AM_DataWrite        => AM_DataWrite,
			AM_Read             => AM_Read,
			AM_WaitRequest      => AM_WaitRequest,
			AM_Write            => AM_Write,
			Clk                 => Clk_FPGA,
			FIFO_Data_Available => FIFO_Data_Available,
			FIFO_Read_Data      => FIFO_Read_Data,
			FIFO_Read_Request   => FIFO_Master_Interface_Read_Request,
			Ready               => Ready,
			Buffer_Saved		  => Buffer_Saved,
			Display_Buffer		  => Display_Buffer,
			Reset_n             => Reset_n
			
		);
	Slave_Interface_inst : Camera_Slave_Interface
		PORT MAP(
			--   Avalon interfaces signals
			Clk             => Clk_FPGA,
			nReset          => Reset_n,
			avs_Address     => avs_Address,
			avs_ChipSelect  => avs_ChipSelect,
			avs_Read        => avs_Read,
			avs_Write       => avs_Write,
			avs_ReadData    => avs_ReadData,
			avs_WriteData   => avs_WriteData,
			--   UART external interface
			Start_Signal    => Ready,
			Length_Frame   => Length_Frame_Interconnect,
			CamAddress     =>Address
		);
	FIFO_Master_Interface_Avalon_Bus_inst : FIFO_Master_Interface_Avalon_Bus
		PORT MAP(
			aclr         => Reset_H ,
			clock        => Clk_FPGA,
			data         => Output_Camera_2Pixels_32Bits,
			rdreq        => FIFO_Master_Interface_Read_Request,
			wrreq        => FIFO_Master_Interface_Write_Request,
			almost_empty => FIFO_Data_Available,
			almost_full  => open,
			empty        => open,
			full         => open,
			q            => FIFO_Read_Data,
			usedw        => open
		);
	Acquisition_module_inst : Camera_Acquisition_module
		PORT MAP(
			Clk             => Clock_Camera_PLL,
			Data_Camera     => Data_Camera,
			Ready 			 => Ready,
			FVAL            => FVAL,
			LVAL            => LVAL,
			Out_Pixel       => Out_Pixel,
			Reset_n         => Reset_n,
			Pixel_Valid_Out => wrreq_FIFO_Inter_Clock_Domain
		);
		Debug<=INTERCONNECT;
	INTERCONNECT<=Address;
	FIFO_Inter_Clock_Domain_inst : FIFO_Inter_Clock_Domain
		PORT MAP(
			aclr    => Reset_H,
			data    => Out_Pixel,
			rdclk   => Clk_FPGA,
			rdreq   => rdreq_FIFO_Inter_Clock_Domain,
			wrclk   => Clock_Camera_PLL,
			wrreq   => wrreq_FIFO_Inter_Clock_Domain,
			q       => Output_Camera_2Pixels_32Bits,
			rdempty => rdempty_FIFO_Inter_Clock_Domain,
			wrfull  => open
		);
	Transfert_Fifo : Process(Clk_FPGA, Reset_n)
	begin
		if Reset_n = '0' then
			Combination_Signal <= '0';
			
		elsif rising_edge(Clk_FPGA) then
			if (rdreq_FIFO_Inter_Clock_Domain = '1') then
				Combination_Signal <= '1';
			else
				Combination_Signal <= '0';
			end if;
			if rdempty_FIFO_Inter_Clock_Domain = '0' then
				rdreq_FIFO_Inter_Clock_Domain<='1';
			else
				rdreq_FIFO_Inter_Clock_Domain<='0';
			end if;
		end if;
	End Process Transfert_Fifo;
FIFO_Master_Interface_Write_Request<=Combination_Signal and rdreq_FIFO_Inter_Clock_Domain;
End Comp;
