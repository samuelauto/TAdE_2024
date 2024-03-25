library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity div_freq is
  generic(
    --N : integer := ##  --Divisor Generico, colocar aqui el valor que se quiere dividir la frecuencia 
  );
  port (
    clk :  in std_logic;
    rst :  in std_logic;
    en  :  in std_logic
    output : out std_logic;
  ) ;
end div_freq ; 

architecture arch of div_freq is

    signal d_out : std_logic := '0';
    signal count : std_logic := '0';

begin

    count_process:process(clk) is
    begin
        if (clk'event and clk = '1') then
            if (rst = '1') then
                d_out <= '0';
                count <= '0';
            elsif (en = '1') then
                if (count = N) then
                    count <= '0';
                    d_out <= not d_out;
                else
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;

    output <= d_out;

end architecture arch ;