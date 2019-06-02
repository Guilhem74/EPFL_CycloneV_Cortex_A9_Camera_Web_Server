-- Accelerator_Grayscale.vhd
--
-- Authors : Azzano Guilhem and Fourcade Pierre

-- Description:
-- ------------
-- This file corresponds to the Top Level of the Accelerator performing the convertion of RGB pixel data
-- (R 5 bits, G 6 bits and B 5 bits) into grayscale pixel data (8 bits).
-- This file is then the port map of the two interfaces composing this accelerator:
-- "Accelerator_Slave_Interface.vhd" and "Accelerator_Master_Interface.vhd".

--------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ENTITY ----------------------------------------------------------------------------

entity Accelerator_Grayscale is
	PORT (Clk    : in std_logic;
			nReset : in std_logic;
			-- Slave interface - Avalon Bus
			avs_Address    : in  std_logic_vector(2  downto 0);
			avs_ChipSelect : in  std_logic;
			avs_Read       : in  std_logic;
			avs_Write      : in  std_logic;
			avs_WriteData  : in  std_logic_vector(31 downto 0);
			avs_ReadData   : out std_logic_vector(31 downto 0);
			-- Master interface - Avalon Bus
			avm_WaitRequest : in  std_logic;
			avm_ReadData    : in  std_logic_vector(15 downto 0);
			avm_WriteData   : out std_logic_vector(15 downto 0);
			avm_Read        : out std_logic;
			avm_Write       : out std_logic;
			avm_Address     : out std_logic_vector(31 downto 0);
			avm_ByteEnable  : out std_logic_vector(1  downto 0));
end entity Accelerator_Grayscale;

--------------------------------------------------------------------------------------

-- ARCHITECTURE ----------------------------------------------------------------------

architecture Behavioral of Accelerator_Grayscale is
	
	-- Wire
	-- ----
	signal Enable_Wire         : std_logic;
	signal Done_Wire           : std_logic;
	signal Capture_Read_Wire   : std_logic;
	signal Capture_Write_Wire  : std_logic;
	signal Data_Read_Wire      : std_logic_vector(15 downto 0);
	signal Data_Write_Wire     : std_logic_vector(15 downto 0);
	signal Address_Wire        : std_logic_vector(31 downto 0);
	signal Length_Address_Wire : std_logic_vector(31 downto 0);
	
	-- Component
	-- ---------
	component Accelerator_Slave_Interface is
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
	end component Accelerator_Slave_Interface;
	
	
	component Accelerator_Master_Interface is
		Port (Clk    : in std_logic;
				nReset : in std_logic;
				-- Master interface - Avalon Bus
				avm_WaitRequest : in  std_logic;
				avm_ReadData    : in  std_logic_vector(15 downto 0);
				avm_WriteData   : out std_logic_vector(15 downto 0);
				avm_Read        : out std_logic;
				avm_Write       : out std_logic;
				avm_Address     : out std_logic_vector(31 downto 0);
				avm_ByteEnable  : out std_logic_vector(1  downto 0);
				-- Master interface - Slave interface
				Enable         : in  std_logic;
				Address        : in  std_logic_vector(31 downto 0);
				Length_Address : in  std_logic_vector(31 downto 0);
				Done           : out std_logic;
				Capture_Read   : out std_logic;
				Capture_Write  : out std_logic;
				Data_Read      : out std_logic_vector(15 downto 0);
				Data_Write     : out std_Logic_vector(15 downto 0));				
	end component Accelerator_Master_Interface;
	
	BEGIN
	
		-------------------------------------------------------------------
		
		Slave_Component : Accelerator_Slave_Interface
			Port Map(	Clk    => Clk,
							nReset => nReset,
							-- Slave interface - Avalon Bus
							avs_Address    => avs_Address,
							avs_ChipSelect => avs_ChipSelect,
							avs_Read       => avs_Read,
							avs_Write      => avs_Write,
							avs_WriteData  => avs_WriteData,
							avs_ReadData   => avs_ReadData,
							-- Slave interface - Master interface
							Done           => Done_Wire,
							Capture_Read   => Capture_Read_Wire,
							Capture_Write  => Capture_Write_Wire,
							Data_Read      => Data_Read_Wire,
							Data_Write     => Data_Write_Wire,
							Enable         => Enable_Wire,
							Address        => Address_Wire,
							Length_Address => Length_Address_Wire);
		
		-------------------------------------------------------------------
		
		Master_Component : Accelerator_Master_Interface
			Port Map(Clk    => Clk,
						nReset => nReset,
						-- Master interface - Avalon Bus
						avm_WaitRequest   => avm_WaitRequest,
						avm_ReadData      => avm_ReadData,
						avm_WriteData     => avm_WriteData,
						avm_Read          => avm_Read,
						avm_Write         => avm_Write,
						avm_Address       => avm_Address,
						avm_ByteEnable    => avm_ByteEnable,
						-- Master interface - Slave interface
						Enable         => Enable_Wire,
						Address        => Address_Wire,
						Length_Address => Length_Address_Wire,
						Done           => Done_Wire,
						Capture_Read   => Capture_Read_Wire,
						Capture_Write  => Capture_Write_Wire,
						Data_Read      => Data_Read_Wire,
						Data_Write     => Data_Write_Wire);
		
		-------------------------------------------------------------------
				
end architecture Behavioral;