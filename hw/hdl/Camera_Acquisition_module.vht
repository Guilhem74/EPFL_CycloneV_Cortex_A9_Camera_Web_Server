-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "12/14/2018 10:40:35"
                                                            
-- Vhdl Test Bench template for design  :  Acquisition_module
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;                                

ENTITY Acquisition_module_vhd_tst IS
END Acquisition_module_vhd_tst;
ARCHITECTURE Acquisition_module_arch OF Acquisition_module_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL Clk : STD_LOGIC:= '0';
SIGNAL Data_Camera : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL FVAL : STD_LOGIC;
SIGNAL LVAL : STD_LOGIC;
SIGNAL Out_Pixel : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL Reset_n : STD_LOGIC;
SIGNAL Pixel_Valid_Out: STD_LOGIC;
signal finished : boolean := FALSE;
constant CLK_PER :time := 20 ns ;

COMPONENT Acquisition_module
	PORT (
	Clk : IN STD_LOGIC;
	Data_Camera : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	FVAL : IN STD_LOGIC;
	LVAL : IN STD_LOGIC;
	Out_Pixel : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	Reset_n : IN STD_LOGIC;
	Pixel_Valid_Out: OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : Acquisition_module
	PORT MAP (
-- list connections between master ports and signals
	Clk => Clk,
	Data_Camera => Data_Camera,
	FVAL => FVAL,
	LVAL => LVAL,
	Out_Pixel => Out_Pixel,
	Reset_n => Reset_n,
	Pixel_Valid_Out=> Pixel_Valid_Out
	);

   Clk <= not(Clk) after CLK_PER/2 when not finished;
process
      procedure init is
      begin
         Reset_n <= '1';
	FVAL<='0';
	LVAL<='0';  
         wait for CLK_PER/4;
         Reset_n <= '0';
         wait for CLK_PER/2;
         Reset_n <= '1';
         wait until rising_edge(Clk);
      end procedure init;
      -- do one multiplication and verify the result
      procedure Send_Frame (a : in STD_LOGIC_VECTOR(31 downto 0)) is
	variable i: integer:=0;
	variable j: integer:=0;
      
      begin
	wait until rising_edge(Clk);
		FVAL<='1' after  CLK_PER/4;
         for i in 0 to 5 loop
		for j in 0 to 6 loop
			wait until rising_edge(Clk);
			LVAL<='1'after  CLK_PER/4;
	 		Data_Camera<=std_logic_vector(to_unsigned((j+1)*(i+1)*64,12)) after CLK_PER/4;
			
		end loop;
		LVAL<='0' after  CLK_PER/4;
		wait until rising_edge(Clk);
		wait until rising_edge(Clk);
	end loop;

	FVAL<='0'  after  CLK_PER/4;
	wait until rising_edge(Clk);
      end procedure Send_Frame;

   begin
      init;
	Send_Frame(std_logic_vector(to_unsigned(21,32)));
      wait until rising_edge(clk);
    wait for 10*CLK_PER;
      finished <= TRUE;
      wait;
end process;                                                           
END Acquisition_module_arch;
