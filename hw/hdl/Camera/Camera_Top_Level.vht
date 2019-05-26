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
-- Generated on "12/15/2018 19:51:32"
                                                            
-- Vhdl Test Bench template for design  :  Top_Level
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;                                
                              

ENTITY Top_Level_vhd_tst IS
END Top_Level_vhd_tst;
ARCHITECTURE Top_Level_arch OF Top_Level_vhd_tst IS
-- constants        
signal finished : boolean := FALSE;
constant CLK_PER :time := 20 ns ;     
constant CLK_Camera_Period :time := 20 ns ;                                         
                                    
-- signals                                                   
SIGNAL AM_Adresse : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL AM_readdatavalid : STD_LOGIC;
SIGNAL AM_BurstCount : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL AM_ByteEnable : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL AM_DataRead : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL AM_DataWrite : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL AM_Read : STD_LOGIC;
SIGNAL AM_WaitRequest : STD_LOGIC;
SIGNAL AM_Write : STD_LOGIC;
SIGNAL	avs_Address : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	avs_ChipSelect : STD_LOGIC;
SIGNAL	avs_Read : STD_LOGIC;
SIGNAL	avs_Write : STD_LOGIC;
SIGNAL	avs_WriteData : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	avs_ReadData : STD_LOGIC_VECTOR(31 DOWNTO 0);	
SIGNAL Clk_FPGA : STD_LOGIC:='0';
SIGNAL Clk_Camera : STD_LOGIC:='0';
SIGNAL Data_Camera : STD_LOGIC_VECTOR(11 DOWNTO 0):="000000000000";

SIGNAL FVAL : STD_LOGIC;
SIGNAL LVAL : STD_LOGIC;
SIGNAL Reset_n : STD_LOGIC;
SIGNAL		Buffer_Saved 		  :  STD_LOGIC_VECTOR(1 downto 0) :="00";
SIGNAL		Display_Buffer      :  STD_LOGIC_VECTOR(1 downto 0):="00";
Component Top_Level is
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
		Buffer_Saved 		  : OUT STD_LOGIC_VECTOR(1 downto 0) ;
		Display_Buffer      : IN STD_LOGIC_VECTOR(1 downto 0) 
	);
end component;

BEGIN
	i1 : Top_Level
	PORT MAP (
-- list connections between master ports and signals
	AM_readdatavalid=> AM_readdatavalid,
	avs_Address => avs_Address,
	avs_ChipSelect => avs_ChipSelect,
	avs_Read => avs_Read,
	avs_Write => avs_Write,
	avs_ReadData => avs_ReadData,
	avs_WriteData => avs_WriteData,
	AM_Adresse => AM_Adresse,
	AM_BurstCount => AM_BurstCount,
	AM_ByteEnable => AM_ByteEnable,
	AM_DataRead => AM_DataRead,
	AM_DataWrite => AM_DataWrite,
	AM_Read => AM_Read,
	AM_WaitRequest => AM_WaitRequest,
	AM_Write => AM_Write,
	Clk_FPGA => Clk_FPGA,
	Data_Camera => Data_Camera,
	Clk_Camera=> Clk_Camera,
	FVAL => FVAL,
	LVAL => LVAL,
	Reset_n => Reset_n,
		Buffer_Saved 		  =>Buffer_Saved,
		Display_Buffer      =>Display_Buffer
	
	);
 Clk_FPGA <= not(Clk_FPGA) after CLK_PER/2 when not finished;
Clk_Camera<= not(Clk_Camera) after CLK_Camera_Period/2 when not finished;

process
      procedure init is
      begin
         Reset_n <= '1';
			FVAL<='0';
			LVAL<='0';  
			avs_Write<='0';
			avs_WriteData<=std_logic_vector(to_unsigned(0,32));  
			avs_Address<="000";
			avs_ChipSelect<='0';
			
			AM_DataRead<= (others =>'0');
         wait for CLK_PER/4;
         Reset_n <= '0';
         wait for CLK_PER/2;
         Reset_n <= '1';

         wait until rising_edge(Clk_FPGA);
      end procedure init;
      -- do one multiplication and verify the result
   procedure Send_Frame (a : in STD_LOGIC_VECTOR(31 downto 0)) is
		variable i: integer:=0;
		variable j: integer:=0;

		variable Size: integer:=32;
   begin
		wait until falling_edge(Clk_Camera);
		FVAL<='1' after  CLK_Camera_Period/4;
      for i in 0 to Size-1 loop
			for j in 0 to Size-1 loop
				wait until falling_edge(Clk_Camera);
				LVAL<='1'after  CLK_Camera_Period/4;
				Data_Camera<=std_logic_vector(to_unsigned(20*(i+1)*(j+1),12)) after CLK_Camera_Period/4;
				
			end loop;
			wait until falling_edge(Clk_Camera);
			Data_Camera<=std_logic_vector(to_unsigned(0,12)) after CLK_Camera_Period/4;
			LVAL<='0' after  CLK_Camera_Period/4;
			wait until falling_edge(Clk_Camera);
			wait until falling_edge(Clk_Camera);
		end loop;
		FVAL<='0'  after  CLK_Camera_Period/4;
		wait until falling_edge(Clk_Camera);
	end procedure Send_Frame;
	procedure Write_And_Read_Avalon_Slave (Address : in STD_LOGIC_VECTOR(2 downto 0);Data : in STD_LOGIC_VECTOR(31 downto 0)) is
   	begin
		wait until rising_edge(Clk_FPGA);
		avs_Write<='1';
		avs_WriteData<= Data;--std_logic_vector(to_unsigned(2604,32));  --Baudrate
		avs_Address<=Address;
		avs_ChipSelect<='1';
		wait until rising_edge(Clk_FPGA);
		avs_Address<=Address;
		avs_Read<='1';
		avs_ChipSelect<='1';
		wait until rising_edge(Clk_FPGA);
		avs_Address<="000";
		avs_Read<='0';
		avs_ChipSelect<='0';
   end procedure Write_And_Read_Avalon_Slave;
	
   begin
   	init;
   	Write_And_Read_Avalon_Slave("000",std_logic_vector(to_unsigned(21,32)));--Address
   	Write_And_Read_Avalon_Slave("001",std_logic_vector(to_unsigned(32*4,32)));--Length
   	Write_And_Read_Avalon_Slave("010",std_logic_vector(to_unsigned(1,32)));--Start
   	
	  Send_Frame(std_logic_vector(to_unsigned(21,32)));
      wait until rising_edge(Clk_FPGA);
      --Send_Frame(std_logic_vector(to_unsigned(21,32)));
      wait until rising_edge(Clk_FPGA);
      --Send_Frame(std_logic_vector(to_unsigned(21,32)));
	  wait for 200*CLK_PER;
      finished <= TRUE;
      wait;
end process; 

process 
begin
AM_WaitRequest<='0';
	wait until rising_edge(AM_Write);
AM_WaitRequest<='0';--1
wait for 100ns;
AM_WaitRequest<='0';
wait for 30ns;
AM_WaitRequest<='0';--1
wait for 100ns;
AM_WaitRequest<='0';
end process;                                                      
END Top_Level_arch;
