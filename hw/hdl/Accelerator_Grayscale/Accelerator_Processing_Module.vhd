-- Accelerator_Processing_Module.vhd
--
-- Author: Azzano Guilhem and Fourcade Pierre

-- Description:
-- ------------
-- This file corresponds to the Processing Module of the Accelerator.

--------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ENTITY ----------------------------------------------------------------------------

entity Accelerator_Processing_Module is
	Port (Clk    : in std_logic;
			nReset : in std_logic;
			-- Processing Module - Master Interface
			Start    : in  std_logic;
			RGB      : in  std_logic_vector(1 downto 0);
			Data_In  : in  std_logic_vector(7 downto 0);
			Data_Out : out std_logic_vector(7 downto 0);
			Done     : out std_logic);
end entity Accelerator_Processing_Module;

--------------------------------------------------------------------------------------

-- ARCHITECTURE ----------------------------------------------------------------------

architecture Behavioral of Accelerator_Processing_Module is
	
	-- State
	-- -----
	-- The different states and the FSM of this architecture are described in the report.
	type state is (Init, Convert_Int_To_Single, Divide, Multiply_255, Ponderation, Convert_Singe_To_Int, Final);
	signal state_reg, state_next : state;
	
	-- Signal
	-- ------
	signal Reset      : std_logic;
	signal Enable_M1  : std_logic;
	signal Enable_M2  : std_logic_vector(0 downto 0);
	signal Enable_M3  : std_logic_vector(0 downto 0);
	signal Enable_M4  : std_logic_vector(0 downto 0);
	signal Enable_M5  : std_logic;
	signal Data_M1    : std_logic_vector(8  downto 0);
	signal Data_M2    : std_logic_vector(31 downto 0);
	signal Data_M3    : std_logic_vector(31 downto 0);
	signal Data_M4    : std_logic_vector(31 downto 0);
	signal Data_M5    : std_logic_vector(31 downto 0);
	signal Result_M1  : std_logic_vector(31 downto 0);
	signal Result_M2  : std_logic_vector(31 downto 0);
	signal Result_M3  : std_logic_vector(31 downto 0);
	signal Result_M4  : std_logic_vector(31 downto 0);
	signal Result_M5  : std_logic_vector(8  downto 0);
	
	-- Register
	-- --------
	signal Function_Counter_next, Function_Counter_reg : natural range 0 to 15;
	signal Divisor_next, Divisor_reg                   : std_logic_vector(31 downto 0);
	signal Ponderator_next, Ponderator_reg             : std_logic_vector(31 downto 0);
	
	-- Constant
	-- --------
	constant div_RB   : std_logic_vector(31 downto 0) := "01000001111110000000000000000000"; -- 31 in floating point (single).
	constant div_G    : std_logic_vector(31 downto 0) := "01000010011111000000000000000000"; -- 63 in floating point (single).
	constant mult_255 : std_logic_vector(31 downto 0) := "01000011011111110000000000000000"; -- 255 in floating point (single).
	constant mult_R   : std_logic_vector(31 downto 0) := "00111110010110011011001111010000"; -- 0.2126 in floating point (single).
	constant mult_G   : std_logic_vector(31 downto 0) := "00111111001101110001011101011001"; -- 0.7152 in floating point (single).
	constant mult_B   : std_logic_vector(31 downto 0) := "00111101100100111101110110011000"; -- 0.0722 in floating point (single).
	
	-- Component
	-- ---------
	component FP_Function_Convert_Int_To_Single
		Port (aclr   : in  std_logic;
				clk_en : in  std_logic;
				clock  : in  std_logic;
				dataa  : in  std_logic_vector(8  downto 0);
				result : out std_logic_vector(31 downto 0));
	end component;
	
	component FP_Function_Div
		Port (a      : in  std_logic_vector(31 downto 0);
				areset : in  std_logic;
				b      : in  std_logic_vector(31 downto 0);
				clk    : in  std_logic;
				en     : in  std_logic_vector(0  downto 0);
				q      : out std_logic_vector(31 downto 0));
	end component;
	
	component FP_Function_Multiply
		Port (clk    : in  std_logic;
				a      : in  std_logic_vector(31 downto 0);
				b      : in  std_logic_vector(31 downto 0);
				en     : in  std_logic_vector(0  downto 0);
				areset : in  std_logic;
				q      : out std_logic_vector(31 downto 0));
	end component;
	
	component FP_Function_Convert_Single_To_Int
		Port (aclr   : in  std_logic;
				clk_en : in  std_logic;
				clock  : in  std_logic;
				dataa  : in  std_logic_vector(31 downto 0);
				result : out std_logic_vector(8  downto 0));
	end component;
	
	BEGIN

		-------------------------------------------------------------------
		
		Reset <= not(nReset);
		
		-------------------------------------------------------------------
		
		Module1 : FP_Function_Convert_Int_To_Single
			Port Map(aclr   => Reset,
						clk_en => Enable_M1,
						clock  => Clk,
						dataa  => Data_M1,
						result => Result_M1);
						
		Module2 : FP_Function_Div
			Port Map(a      => Data_M2,
						areset => Reset,
						b      => Divisor_reg,
						clk    => Clk,
						en     => Enable_M2,
						q      => Result_M2);
						
		Module3 : FP_Function_Multiply
			Port Map(clk    => Clk,
						a      => Data_M3,
						b      => mult_255,
						en     => Enable_M3,
						areset => Reset,
						q      => Result_M3);
						
		Module4 : FP_Function_Multiply
			Port Map(clk    => Clk,
						a      => Data_M4,
						b      => Ponderator_reg,
						en     => Enable_M4,
						areset => Reset,
						q      => Result_M4);
					
		Module5 : FP_Function_Convert_Single_To_Int
			Port Map(aclr   => Reset,
						clk_en => Enable_M5,
						clock  => Clk,
						dataa  => Data_M5,
						result => Result_M5);	
		
		-------------------------------------------------------------------
		
		Next_State_Logic : process(state_reg, Start, Function_Counter_reg)
		
			begin
				
				state_next <= state_reg;
				case state_reg is
					-- Init --------------------
					when Init =>
						if Start = '1' then
							state_next <= Convert_Int_To_Single;
						end if;
					-- Convert_Int_To_Single ---
					when Convert_Int_To_Single =>
						if Function_Counter_reg = 7 then
							state_next <= Divide;
						end if;
					-- Divide ------------------
					when Divide =>
						if Function_Counter_reg = 13 then
							state_next <= Multiply_255;
						end if;
					-- Multiply_255 ------------
					when Multiply_255 =>
						if Function_Counter_reg = 3 then
							state_next <= Ponderation;
						end if;
					-- Ponderation -------------
					when Ponderation =>
						if Function_Counter_reg = 3 then
							state_next <= Convert_Singe_To_Int;
						end if;
					-- Convert_Singe_To_Int ----
					when Convert_Singe_To_Int =>
						if Function_Counter_reg = 7 then
							state_next <= Final;
						end if;
					-- Final -------------------
					when Final =>
						if Start = '0' then
							state_next <= Init;
						end if;
					-- Others ------------------
					when others =>
						null;
				end case;
														
		end process Next_State_Logic;
					
		-------------------------------------------------------------------			
		
		Register_Logic : process(nReset, Clk)
		
			begin
			
				if nReset = '0' then
					state_reg            <= Init;
					Function_Counter_reg <= 0;
					Divisor_reg          <= (others => '0');
					Ponderator_reg       <= (others => '0');
				elsif rising_edge(Clk) then
					state_reg            <= state_next;
					Function_Counter_reg <= Function_Counter_next;
					Divisor_reg          <= Divisor_next;
					Ponderator_reg       <= Ponderator_next;
				end if;

		end process Register_Logic;

		-------------------------------------------------------------------
		
		Combinational_Logic : process(state_reg, Function_Counter_reg, Divisor_reg, Ponderator_reg, Start, RGB, Data_In, Result_M1, Result_M2, Result_M3, Result_M4, Result_M5)
		
			begin
				
				-- Usual output values --------
				Function_Counter_next <= Function_Counter_reg;
				Divisor_next          <= Divisor_reg;
				Ponderator_next       <= Ponderator_reg;
				Data_Out              <= (others => '0');
				Done                  <= '0';
				Enable_M1             <= '0';
				Enable_M2             <= (others => '0');
				Enable_M3             <= (others => '0');
				Enable_M4             <= (others => '0');
				Enable_M5             <= '0';
				Data_M1               <= (others => '0');
				Data_M2               <= (others => '0');
				Data_M3               <= (others => '0');
				Data_M4               <= (others => '0');
				Data_M5               <= (others => '0');
				case state_reg is
					-- Init --------------------
					when Init =>
						Function_Counter_next <= 0;
						if Start = '1' then
							case RGB is
								when "00"   =>	Divisor_next    <= div_RB;
													Ponderator_next <= mult_R;
								when "01"   =>	Divisor_next    <= div_G;
													Ponderator_next <= mult_G;
								when "10"   =>	Divisor_next    <= div_RB;
													Ponderator_next <= mult_B;
								when others => null;
							end case;
						end if;
					-- Convert_Int_To_Single ---
					when Convert_Int_To_Single =>
						Enable_M1 <= '1';
						Data_M1   <= '0'&Data_In;
						if Function_Counter_reg = 7 then
							Function_Counter_next <= 0;
						else
							Function_Counter_next <= Function_Counter_reg + 1;
						end if;
					-- Divide ------------------
					when Divide =>
						Enable_M2(0) <= '1';
						Data_M2      <= Result_M1;
						if Function_Counter_reg = 13 then
							Function_Counter_next <= 0;
						else
							Function_Counter_next <= Function_Counter_reg + 1;
						end if;
					-- Multiply_255 ------------
					when Multiply_255 =>
						Enable_M3(0) <= '1';
						Data_M3      <= Result_M2;
						if Function_Counter_reg = 3 then
							Function_Counter_next <= 0;
						else
							Function_Counter_next <= Function_Counter_reg + 1;
						end if;
					-- Ponderation -------------
					when Ponderation =>
						Enable_M4(0) <= '1';
						Data_M4      <= Result_M3;
						if Function_Counter_reg = 3 then
							Function_Counter_next <= 0;
						else
							Function_Counter_next <= Function_Counter_reg + 1;
						end if;
					-- Convert_Singe_To_Int ----
					when Convert_Singe_To_Int =>
						Enable_M5 <= '1';
						Data_M5   <= Result_M4;
						if Function_Counter_reg = 7 then
							Function_Counter_next <= 0;
						else
							Function_Counter_next <= Function_Counter_reg + 1;
						end if;
					-- Final -------------------
					when Final =>
						Data_Out <= Result_M5(7 downto 0);
						Done     <= '1';
					-- Others ------------------
					when others =>
						null;
				end case;
				
		end process Combinational_Logic;											
		
		-------------------------------------------------------------------
				
end architecture Behavioral;