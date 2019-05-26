library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
ENTITY Camera_Slave_Interface IS
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
End Camera_Slave_Interface;

ARCHITECTURE comp OF Camera_Slave_Interface IS
	signal iRegCamAddr     : std_logic_vector(31 DOWNTO 0);
	signal iRegCamLength   : std_logic_vector(31 DOWNTO 0);
	signal iRegCamStart    : std_logic:='0';
BEGIN
	Start_Signal <= iRegCamStart;
	CamAddress   <= iRegCamAddr;
	Length_Frame	<=iRegCamLength;
	--   Process Write to registers
	Write_process : process(Clk, nReset)
	begin
		if nReset = '0' then
			iRegCamAddr     <= (others => '0');
			iRegCamLength   <= (others => '0');
			iRegCamStart    <= ('0');
		elsif rising_edge(Clk) then
			if avs_ChipSelect = '1' and avs_Write = '1' then --   Write cycl
				case avs_Address(2 downto 0) is
					when "000"  => iRegCamAddr <= avs_WriteData;
					when "001"  => iRegCamLength <= avs_WriteData;
					when "010"  => iRegCamStart <= avs_WriteData(0);
					when "011"  => iRegCamStart <= not (avs_WriteData(0));
					when others => null;
				end case;
			end if;
		end if;
	end process Write_process;

	--   Process Read to registers
	Read_Process : process(clk, nReset)
	begin
		if nReset = '0' then
			
		elsif rising_edge(Clk) then
			avs_ReadData <= (others => '0'); --   default value
			if avs_ChipSelect = '1' and avs_Read = '1' then --   Read cycle
				case avs_Address(2 downto 0) is
					when "000"  => avs_ReadData <= iRegCamAddr;
					when "001"  => avs_ReadData <= iRegCamLength;
					when "010"  => avs_ReadData(0) <= iRegCamStart;
					when "011"  => avs_ReadData(0) <= not (iRegCamStart);
					when others => null;
				end case;
			end if;
		end if;
	end process Read_Process;

end comp;
