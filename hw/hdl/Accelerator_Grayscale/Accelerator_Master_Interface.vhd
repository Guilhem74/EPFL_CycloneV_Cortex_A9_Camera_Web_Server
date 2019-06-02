-- Accelerator_Master_Interface.vhd
--
-- Authors : Azzano Guilhem and Fourcade Pierre

-- Description:
-- ------------
-- This file corresponds to the Master Interface of the Accelerator.
-- It is the finite state machine that, by using the Avalon Bus, will go read the pixel data in the memory, then 
-- activates the Processing Module and finally write (in the same address) the processed data.

--------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ENTITY ----------------------------------------------------------------------------

entity Accelerator_Master_Interface is
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
end entity Accelerator_Master_Interface;

--------------------------------------------------------------------------------------

-- ARCHITECTURE ----------------------------------------------------------------------

architecture Behavioral of Accelerator_Master_Interface is
	
	-- State
	-- -----
	-- The different states and the FSM of this architecture are described in the report.
	type state is (Init, Copy, Read_State, Processing, Combination, Write_State, Final);
	signal state_reg, state_next : state;

	-- Signal
	-- ------
	signal Start       : std_logic;
	signal Data_R      : std_logic_vector(7 downto 0);
	signal Data_G      : std_logic_vector(7 downto 0);
	signal Data_B      : std_logic_vector(7 downto 0);
	signal R_Processed : std_logic_vector(7 downto 0);
	signal G_Processed : std_logic_vector(7 downto 0);
	signal B_Processed : std_logic_vector(7 downto 0);
	signal Done_R      : std_logic;
	signal Done_G      : std_logic;
	signal Done_B      : std_logic;
	
	-- Register
	-----------
	signal Add_reg, Add_next   : unsigned(31 downto 0);
	signal Data_reg, Data_next : std_logic_vector(15 downto 0);
	signal R_reg, R_next       : std_logic_vector(7  downto 0);
	signal G_reg, G_next       : std_logic_vector(7  downto 0);
	signal B_reg, B_next       : std_logic_vector(7  downto 0);
	
	-- Constant
	-- --------
	constant R : std_logic_vector(1 downto 0) := "00";
	constant G : std_logic_vector(1 downto 0) := "01";
	constant B : std_logic_vector(1 downto 0) := "10";	
	
	-- Component
	-- ---------
	component Accelerator_Processing_Module is
		Port (Clk    : in std_logic;
				nReset : in std_logic;
				-- Processing Module - Master Interface
				Start    : in  std_logic;
				RGB      : in  std_logic_vector(1 downto 0);
				Data_In  : in  std_logic_vector(7 downto 0);
				Data_Out : out std_logic_vector(7 downto 0);
				Done     : out std_logic);
	end component Accelerator_Processing_Module;	
	
	BEGIN
	
		-------------------------------------------------------------------
		
		R_Processing : Accelerator_Processing_Module
			Port Map(Clk    => Clk,
						nReset => nReset,
						-- Processing Module - Master Interface
						Start    => Start,
						RGB      => R,
						Data_In  => Data_R,
						Data_Out => R_Processed,
						Done     => Done_R);
						
		G_Processing : Accelerator_Processing_Module
			Port Map(Clk    => Clk,
						nReset => nReset,
						-- Processing Module - Master Interface
						Start    => Start,
						RGB      => G,
						Data_In  => Data_G,
						Data_Out => G_Processed,
						Done     => Done_G);
						
		B_Processing : Accelerator_Processing_Module
			Port Map(Clk    => Clk,
						nReset => nReset,
						-- Processing Module - Master Interface
						Start    => Start,
						RGB      => B,
						Data_In  => Data_B,
						Data_Out => B_Processed,
						Done     => Done_B);
	
		-------------------------------------------------------------------
		
		Next_State_Logic : process(state_reg, Enable, avm_WaitRequest, Done_R, Done_G, Done_B, Add_reg, Address, Length_Address)
		
			begin
				
				state_next <= state_reg;
				case state_reg is
					-- Init --------------------
					when Init =>
						if Enable = '1' then 
							state_next <= Copy; 
						end if;
					-- Copy --------------------
					when Copy =>
						state_next <= Read_State;
					-- Read_State --------------
					when Read_State =>
						if avm_WaitRequest = '0' then 
							state_next <= Processing;
						end if;
					-- Processing --------------
					when Processing =>
						if ((Done_R = '1') and (Done_G = '1') and (Done_B = '1')) then
							state_next <= Combination;
						end if;
					-- Combination -------------
					when Combination =>
						state_next <= Write_State;
					-- Write_State -------------
					when Write_State =>
						if avm_WaitRequest = '0' then
							if Add_reg = unsigned(Address) + unsigned(Length_Address) then 
								state_next <= Final;
							else
								state_Next <= Read_State;
							end if;
						end if;
					-- Final -------------------
					when Final =>
						if Enable = '0' then
							state_next <= Init;
						end if;
					-- Others ------------------
					when others => 
						null;
				end case;
										
		end process Next_State_Logic;
					
		-------------------------------------------------------------------			

		Register_Logic : process(Clk, nReset)
		
			begin
			
				if nReset = '0' then
					state_reg <= Init;
					Add_reg   <= (others => '0');
					Data_reg  <= (others => '0');
					R_reg     <= (others => '0');
					G_reg     <= (others => '0');
					B_reg     <= (others => '0');
				elsif rising_edge(clk) then
					state_reg <= state_next;
					Add_reg   <= Add_next;
					Data_reg  <= Data_next;
					R_reg     <= R_next;
					G_reg     <= G_next;
					B_reg     <= B_next;
				end if;
		
		end process Register_Logic;

		-------------------------------------------------------------------
		
		Combinational_Logic : process(state_reg, Add_reg, Data_reg, R_reg, G_reg, B_reg, Done_R, Done_G, Done_B, R_Processed, G_Processed, B_Processed, avm_WaitRequest, avm_ReadData, Address, Length_Address)
		
			begin
				
				-- Usual output values --------
				Add_next       <= Add_reg;
				Data_next      <= Data_reg;
				R_next         <= R_reg;
				G_next         <= G_reg;
				B_next         <= B_reg;
				Start          <= '0';
				Data_R         <= (others => '0');
				Data_G         <= (others => '0');
				Data_B         <= (others => '0');
				avm_WriteData  <= (others => '0');
				avm_Read       <= '0';
				avm_Write      <= '0';
				avm_Address    <= (others => '0');
				avm_ByteEnable <= (others => '0');
				Done           <= '0';
				Capture_Read   <= '0';
				Capture_Write  <= '0';
				Data_Read      <= (others => '0');
				Data_Write     <= (others => '0');
				case state_reg is
					-- Init --------------------
					when Init =>
						Add_next  <= (others => '0');
						Data_next <= (others => '0');
						R_next    <= (others => '0');
						G_next    <= (others => '0');
						B_next    <= (others => '0');
					-- Copy --------------------
					when Copy =>
						Add_next <= unsigned(Address);
					-- Read_State --------------
					when Read_State =>
						avm_Read       <= '1';
						avm_Address    <= std_logic_vector(Add_reg);
						avm_ByteEnable <= "11";
						if avm_WaitRequest = '0' then
							Data_next    <= avm_ReadData;
							Capture_Read <= '1';
							Data_Read    <= avm_ReadData;
						end if;
					-- Processing --------------
					when Processing =>
						Start  <= '1';
						Data_R <= "000" & Data_reg(15 downto 11);
						Data_G <= "00"  & Data_reg(10 downto 5);
						Data_B <= "000" & Data_reg(4  downto 0);
						if (Done_R = '1') then
							R_next <= R_Processed;
						end if;
						if (Done_G = '1') then
							G_next <= G_Processed;
						end if;
						if (Done_B = '1') then
							B_next <= B_Processed;
						end if;
					-- Combination -------------
					when Combination =>
						Data_next <= "00000000" & std_logic_vector(unsigned(R_reg) + unsigned(G_reg) + unsigned(B_reg));
					-- Write_State -------------
					when Write_State =>
						avm_WriteData  <= Data_reg;
						avm_Write      <= '1';
						avm_Address    <= std_logic_vector(Add_reg);
						avm_ByteEnable <= "11";
						Capture_Write  <= '1';
						Data_Write     <= Data_reg;
						if avm_WaitRequest = '0' then
							if Add_reg < unsigned(Address) + unsigned(Length_Address) then
								Add_next <= Add_reg + 2;
							end if;
						end if;
					-- Final -------------------
					when Final =>
						Done <= '1';
					-- Others ------------------
					when others => 
						null;
				end case;
				
		end process Combinational_Logic;
		
		-------------------------------------------------------------------
				
end architecture Behavioral;