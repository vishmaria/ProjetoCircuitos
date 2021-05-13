library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

Entity contador_bonus is port ( 
    data: in std_logic_vector(5 downto 0);
    setup_user: in std_logic_vector(3 downto 0);
    setup: in std_logic;
    clock: in std_logic;
    enable: in std_logic;
    contagem: buffer std_logic_vector(5 downto 0);
    end_count: out std_logic);
end contador_bonus;

Architecture circuito of contador_bonus is
    begin
    P1: process(clock, setup, data, enable)
        begin
         if setup= '1' then
             contagem <= "00" & setup_user;
             
         elsif ((clock'event and clock= '1') and enable ='1') then
             contagem <= std_logic_vector(signed(contagem) - signed(data));
             
         end if;
    end process;
    end_count <= '1' when signed(contagem) <0 else '0';
end circuito;
