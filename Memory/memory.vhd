----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:29:25 03/19/2024 
-- Design Name: 
-- Module Name:    memory - Behavioral 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory is
    Port ( clk,rst,en,wr,rd : in  STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (31 downto 0);
           addr : in  STD_LOGIC_VECTOR (7 downto 0);
           dout : out  STD_LOGIC_VECTOR (31 downto 0));
end memory;

architecture Behavioral of memory is

    type ram_type is array ((2**8)-1 downto 0) of std_logic_vector (31 downto 0);
    signal RAM: ram_type;
	 signal d_out : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');

begin

	process (clk)
begin
   if (clk'event and clk = '1') then
      if ( en = '1' and wr = '1') then
         RAM(conv_integer(addr)) <= din;
      end if;
      if (rd = '1') then
         d_out <= RAM(conv_integer(addr));
      end if;
   end if;
end process;

dout<=d_out;


end Behavioral;

