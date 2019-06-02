-- Accelerator_Slave_Interface.vhd
--
-- Authors : Azzano Guilhem and Fourcade Pierre

-- Description:
-- ------------
-- This file corresponds to the Slave Interface of the Accelerator.
-- The user accesses this interface by the Avalon Bus to specify the start of address of the image data that will be
-- converted in gray and its length. It is also by this interface that the user starts the accelerator and knows
-- when the convertion is complete.
--
-- Here is the register map of the interface:
--			Address (word)	*	Address (byte)	*	Type of access	*	Name					*	Size (bit)	*	Purpose
--			------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--			0					*	0					*	W/R				*	RegCommand			*	8				*	Register that commands the accelerator.
--			1					*	4					*	W/R				*	RegAddress			*	32				*	Register storing the start address of the image data.
--			2					*	8					*	W/R				*	RegLength_Address	*	32				*	Register storing the length of the image data in byte.
--			3					*	12					*	R					*	RegData_Read		*	16				*	Debugging purpose, so that the user can access the last data read from the memory.
--			4					*	16					*	R					*	ReagData_Write		*	16				*	Debugging purpose, so that the user can access the last data writen into the memory.

--------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ENTITY ----------------------------------------------------------------------------

entity Accelerator_Slave_Interface is
	Port(	Clk    : in std_logic;
			nReset : in std_logic;
			-- Slave interface - Avalon Bus
			avs_Address    : in  std_logic_vector(2  downto 0);
			avs_ChipSelect : in  std_logic;
			avs_Read       : in  std_logic;
			avs_Write      : in  std_logic;
			avs_WriteData  : in  std_logic_vector(31 downto 0);
			avs_ReadData   : out std_logic_vector(31 downto 0);
			-- Slave interface - Master interface
			Done           : in  std_logic;
			Capture_Read   : in  std_logic;
			Capture_Write  : in  std_logic;
			Data_Read      : in  std_logic_vector(15 downto 0);
			Data_Write     : in  std_Logic_vector(15 downto 0);
			Enable         : out std_logic;
			Address        : out std_logic_vector(31 downto 0);
			Length_Address : out std_logic_vector(31 downto 0));
end entity Accelerator_Slave_Interface;

--------------------------------------------------------------------------------------

-- ARCHITECTURE ----------------------------------------------------------------------

architecture Behavioral of Accelerator_Slave_Interface is
	
	-- Register
	-- --------
	signal RegCommand        : std_logic_vector(7  downto 0); -- RegCommand : 7 Available - 6 Available - 5 Available - 4 Available - 3 Available - 2 Available - 1 Available - 0 Enable
	signal RegAddress        : std_logic_vector(31 downto 0);
	signal RegLength_Address : std_logic_vector(31 downto 0);
	signal RegData_Read      : std_logic_vector(15 downto 0);
	signal RegData_Write     : std_logic_vector(15 downto 0);
	
	BEGIN

		-------------------------------------------------------------------
		
		Avalon_Write : process(Clk, nReset) -- Process for writing the registers.
		
			begin
			
				if nReset = '0' then
					RegCommand        <= (others => '0');
					RegAddress        <= (others => '0');
					RegLength_Address <= (others => '0');
					RegData_Read      <= (others => '0');
					RegData_Write     <= (others => '0');
				elsif rising_edge(Clk) then
					if Done = '1' then
						RegCommand <= (others => '0');
					else
						if (avs_ChipSelect = '1' and avs_Write = '1') then
							case avs_Address(2 downto 0) is
								when "000"   => RegCommand        <= avs_WriteData(7 downto 0);
								when "001"   => RegAddress        <= avs_WriteData;
								when "010"   => RegLength_Address <= avs_WriteData;
								when others => null;
							end case;
						end if;
						if Capture_Read = '1' then
							RegData_Read  <= Data_Read;
						end if;
						if Capture_Write = '1' then
							RegData_Write <= Data_Write;
						end if;
					end if;
				end if;
					
		end process Avalon_Write;
		
		-------------------------------------------------------------------
		
		Avalon_Read : process(Clk) -- Process to read the registers.
		
			begin	
			
				if rising_edge(Clk) then
					avs_ReadData <= (others => '0');
					if (avs_ChipSelect = '1' and avs_Read = '1') then
						case avs_Address(2 downto 0) is
							when "000"   => avs_ReadData(7  downto 0) <= RegCommand;
							when "001"   => avs_ReadData              <= RegAddress;
							when "010"   => avs_ReadData              <= RegLength_Address;
							when "011"   => avs_ReadData(15 downto 0) <= RegData_Read;
							when "100"   => avs_ReadData(15 downto 0) <= RegData_Write;
							when others => null;
						end case;
					end if;
				end if;
				
		end process Avalon_Read;
		
		-------------------------------------------------------------------
		
		Slave_Signals : process(Clk, nReset)
		
			begin
			
				if nReset = '0' then
					Enable         <= '0';
					Address        <= (others => '0');
					Length_Address <= (others => '0');
				elsif rising_edge(Clk) then
					Enable         <= RegCommand(0);
					Address        <= RegAddress;
					Length_Address <= RegLength_Address;
				end if;
		
		end process Slave_Signals;
		
		-------------------------------------------------------------------
				
end architecture Behavioral;