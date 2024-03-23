----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:38:05 03/21/2024 
-- Design Name: 
-- Module Name:    counter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is

	generic (
		g_dataSize : integer := 8
	);

    Port ( i_en,i_clk,i_rst : in  STD_LOGIC;
           i_data : in  STD_LOGIC_VECTOR (g_dataSize-1 downto 0);
           o_end : out  STD_LOGIC;
           o_data : out  STD_LOGIC_VECTOR (g_dataSize-1 downto 0));
end counter;

architecture Behavioral of counter is

	signal count : STD_LOGIC_VECTOR (g_dataSize-1 downto 0) := (others => '0');
	signal end_count : STD_LOGIC;

begin

	count_proccess:process (i_clk)		
		begin
         if (i_clk'event and i_clk = '1') then
            if (i_rst = '1') then
                count <= (others => '0');
             end if;
            if (count = i_data) then
             end_count <= '1';
             count <= (others => '0');
            end if;
            if (i_en = '1') then
                count <= count + 1;
            end if; 
         end if;
      end process;
            
    o_data <= count;
    o_end <= end_count;


end Behavioral;

