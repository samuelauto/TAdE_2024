--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:44:24 03/21/2024
-- Design Name:   
-- Module Name:   /home/ise/VM/PE_2024/tb_noise_suppressor.vhd
-- Project Name:  PE_2024
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: noise_suppressor
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_noise_suppressor IS
END tb_noise_suppressor;
 
ARCHITECTURE behavior OF tb_noise_suppressor IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT noise_suppressor
	 
	 generic(
        g_nClkIgnore : integer := 20 
    )
	 
    PORT(
         i_clk : IN  std_logic;
         i_rst : IN  std_logic;
         i_data : IN  std_logic;
         o_data : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal i_clk : std_logic := '0';
   signal i_rst : std_logic := '0';
   signal i_data : std_logic := '0';

 	--Outputs
   signal o_data : std_logic;

   -- Clock period definitions
   constant i_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: noise_suppressor PORT MAP (
          i_clk => i_clk,
          i_rst => rst,
          i_data => i_data,
          o_data => o_data
        );

   -- Clock process definitions
   i_clk_process :process
   begin
		i_clk <= '0';
		wait for i_clk_period/2;
		i_clk <= '1';
		wait for i_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for i_clk_period*10;

      -- insert stimulus
		
		rst <= '1';
      wait for 3 * i_clk_period;
		rst <= '0';
		wait for 2* i_clk_period;
		i_data <= '1';
		wait for 0.5 * i_clk_period;
		i_data <= '0';
		wait for 1 * i_clk_period;
		i_data <= '1';
		wait for 1.5* i_clk_period;
		i_data <= '0';
		wait for 3*i_clk_period;
		i<data <= '1';
		wait for 25*i_clk_period;

      wait;
   end process;

END;
