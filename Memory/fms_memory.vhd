library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity fms_memory is
  port (
    clk: in std_logic;
    rst: in std_logic;
    lap_btn: in std_logic;
    en : in std_logic;
    stp: in std_logic;
    output: out std_logic_vector (2 downto 0)
  ) ;
end fms_memory ; 

architecture arch of fms_memory is

    type state is (rest,wr,rd); --Señales internas
    signal d_bus,q_bus: state := rest; --Estableciendolo en tercer estado

begin

    config_process:process(clk,rst) is 
    begin
        if (rst = '1') then
            q_bus <= rest;
        elsif (clk'event and clk = '1') then
            q_bus <= d_bus;
        end if;
    end process;

    --Bloque de Estado Presente

    output <= "101" when q_bus = wr else --bit menos significativo signal de escritura
              "110" when q_bus = rd else --signal de lectura
              "000"; --ni lee ni escribe, y en deshabilitado

    --Bloque de estado siguiente

    next_state:process(q_bus,en,lap_btn,stp) is
        begin
            case(q_bus) is

                when wr =>
                    if (lap_btn = '1' and en= '1') then
                        d_bus <= wr;
                    elsif(lap_btn = '1' and stp = '1') then
                        d_bus <= rd;
                    else
                        d_bus <= rest;
                    end if;
                
                when rd =>
                    if (lap_btn = '1' and en= '1') then
                        d_bus <= wr;
                    elsif(lap_btn = '1' and stp = '1') then
                        d_bus <= rd;
                    else
                        d_bus <= rest;
                    end if;

                when rest =>
                    if (lap_btn = '1' and en= '1') then
                        d_bus <= wr;
                    elsif(lap_btn = '1' and stp = '1') then
                        d_bus <= rd;
                    else
                        d_bus <= rest;
                    end if;

                when others =>
                        d_bus <= rest;
            end case;
    end process;
                    
end architecture arch  ;