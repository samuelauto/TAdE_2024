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
   uut: noise_suppressor 
      generic map(
         g_nClkIgnore => 20
      )
      PORT MAP (
          i_clk => i_clk,
          i_rst => rst,
          i_data => i_data,
          o_data => o_data,

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
      
      if o_data = '1' then
         report "ERROR: RST = 1";  --Informa que la señal se estabilizo en rst = 1
		else
         report "PASS: RST = 1";
      end if
      ---------------------------------------
      rst <= '0';
		wait for 2* i_clk_period;
         
      if o_data = '1' then
         report "ERROR: RST = 0; 2*CLK_PERIOD";  --Informa que la señal se estabilizo en 2*clk_period con rst = 0
		else
         report "PASS: RST = 0; 2*CLK_PERIOD";
      end if
      -----------------------------------
		i_data <= '1';
		wait for 0.5 * i_clk_period;
        
      if o_data = '1' then
         report "ERROR: I_DATA = 1; 0.5*CLK_PERIOD";  --Informa que la señal se estabilizo en 0.5*clk_period con i_data = 1
		else
         report "PASS: I_DATA = 1; 0.5*CLK_PERIOD";
      end if
      ----------------------------------
		i_data <= '0';
		wait for 1 * i_clk_period;

      if o_data = '1' then
         report "ERROR: I_DATA = 0; 1*CLK_PERIOD";  --Informa que la señal se estabilizo en 1*clk_period con i_data = 0
		else
         report "PASS: I_DATA = 0; 1*CLK_PERIOD";
      end if
      -----------------------------------   
		i_data <= '1';
		wait for 1.5* i_clk_period;
      
      if o_data = '1' then
         report "ERROR: I_DATA = 1; 1.5*CLK_PERIOD";  --Informa que la señal se estabilizo en 1.5*clk_period con i_data = 1
		else
         report "PASS: I_DATA = 1; 1.5*CLK_PERIOD";
      end if;
      -------------------------------------
		i_data <= '0';
		wait for 3*i_clk_period;

      if o_data = '1' then
         report "ERROR: I_DATA = 0; 3*CLK_PERIOD";  --Informa que la señal se estabilizo en 3*clk_period con i_data = 0
		else
         report "PASS: I_DATA = 0; 3*CLK_PERIOD";
      end if;
      --------------------------------------
		i_data <= '1';
		wait for 25*i_clk_period;

      if o_data = '1' then
         report "TEST_COMPLETE"; 
      else 
         report "ERROR: I_DATA = 1; 25*CLK_PERIOD";--Informa que la señal no se estabilizo en 25*clk_period con i_data = 1
      end if;

      wait;
   end process;

END;
