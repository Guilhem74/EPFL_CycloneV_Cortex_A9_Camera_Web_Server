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
-- Generated on "12/07/2018 10:51:47"
                                                            
-- Vhdl Test Bench template for design  :  Master_Interface
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;                              

ENTITY Master_Interface_vhd_tst IS
END Master_Interface_vhd_tst;
ARCHITECTURE Master_Interface_arch OF Master_Interface_vhd_tst IS
-- constants  
constant CLK_PER :time := 20 ns ;                                             
-- signals                                                   
SIGNAL Address : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL AM_Adresse : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL AM_BurstCount : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL AM_ByteEnable : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL AM_DataRead : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL AM_DataWrite : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL AM_Read : STD_LOGIC;
SIGNAL AM_WaitRequest : STD_LOGIC;
SIGNAL AM_Write : STD_LOGIC;
SIGNAL Clk : STD_LOGIC := '0';
SIGNAL FIFO_Data_Available : STD_LOGIC;
SIGNAL FIFO_Read_Data : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL FIFO_Read_Request : STD_LOGIC;
SIGNAL Ready : STD_LOGIC;
SIGNAL Reset_n : STD_LOGIC;
SIGNAL data_sig : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL wrreq_sig : STD_LOGIC;
SIGNAL almost_full_sig : STD_LOGIC;
SIGNAL empty_sig : STD_LOGIC;
SIGNAL full_sig : STD_LOGIC;
SIGNAL usedw_sig : STD_LOGIC_VECTOR (4 DOWNTO 0);
signal finished : boolean := FALSE;

COMPONENT Master_Interface
	PORT (
	Address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	AM_Adresse : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	AM_BurstCount : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	AM_ByteEnable : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	AM_DataRead : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	AM_DataWrite : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	AM_Read : OUT STD_LOGIC;
	AM_WaitRequest : IN STD_LOGIC;
	AM_Write : OUT STD_LOGIC;
	Clk : IN STD_LOGIC;
	FIFO_Data_Available : IN STD_LOGIC;
	FIFO_Read_Data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	FIFO_Read_Request : OUT STD_LOGIC;
	Ready : IN STD_LOGIC;
	Reset_n : IN STD_LOGIC
	);
END COMPONENT;

COMPONENT FIFO_1 IS
	PORT
	(
		aclr		: IN STD_LOGIC ;
		clock		: IN STD_LOGIC ;
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		rdreq		: IN STD_LOGIC ;
		wrreq		: IN STD_LOGIC ;
		almost_empty		: OUT STD_LOGIC ;
		almost_full		: OUT STD_LOGIC ;
		empty		: OUT STD_LOGIC ;
		full		: OUT STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		usedw		: OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
	);
END COMPONENT FIFO_1;


signal clear: STD_LOGIC;
BEGIN
		i1 : Master_Interface
		PORT MAP (
	-- list connections between master ports and signals
		Address => Address,
		AM_Adresse => AM_Adresse,
		AM_BurstCount => AM_BurstCount,
		AM_ByteEnable => AM_ByteEnable,
		AM_DataRead => AM_DataRead,
		AM_DataWrite => AM_DataWrite,
		AM_Read => AM_Read,
		AM_WaitRequest => AM_WaitRequest,
		AM_Write => AM_Write,
		Clk => Clk,
		FIFO_Data_Available => FIFO_Data_Available,
		FIFO_Read_Data => FIFO_Read_Data,
		FIFO_Read_Request => FIFO_Read_Request,
		Ready => Ready,
		Reset_n => Reset_n
		);
		clear<= not(Reset_n);
		FIFO_1_inst : FIFO_1 PORT MAP (
			aclr	 => clear,
			clock	 => Clk,
			data	 => data_sig,
			rdreq	 => FIFO_Read_Request,
			wrreq	 => wrreq_sig,
			almost_empty	 => FIFO_Data_Available,
			almost_full	 => almost_full_sig,
			empty	 => empty_sig,
			full	 => full_sig,
			q	 => FIFO_Read_Data,
			usedw	 => usedw_sig
		);
	
process
      procedure init is
      begin
         Reset_n <= '1';
         wait for CLK_PER/4;
         Reset_n <= '0';
         wait for CLK_PER/2;
         Reset_n <= '1';
         wait until rising_edge(Clk);
      end procedure init;

      -- do one multiplication and verify the result
      procedure Fill_Fifo (a : in STD_LOGIC_VECTOR(31 downto 0)) is
	variable i: integer:=0;
      begin
	wait until rising_edge(Clk);
	wrreq_sig<='1' after 1 ns;
         for i in 0 to 16 loop
	 	data_sig<=std_logic_vector(unsigned(a)+to_unsigned(i,32)) after 1 ns;
		wait until rising_edge(Clk);
	end loop;
	wrreq_sig<='0';
      end procedure Fill_Fifo;

   begin
      init;
	Fill_Fifo(std_logic_vector(to_unsigned(21,32)));
      wait until rising_edge(clk);
	Ready<='1'after 1 ns;
	Address<=std_logic_vector(to_unsigned(5,32));
	AM_BurstCount<=std_logic_vector(to_unsigned(8,4));
	AM_WaitRequest<='0';
	wait for 5*CLK_PER;
	AM_WaitRequest<='1';
	wait for 5*CLK_PER;
	AM_WaitRequest<='0';

	wait for 100*CLK_PER;
      finished <= TRUE;
      wait;
end process;                                      
END Master_Interface_arch;