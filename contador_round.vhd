library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

Entity contador_round is port ( 
    data: in std_logic_vector(3 downto 0);
    vetor: in std_logic_vector(3 downto 0);
    setup: in std_logic;
    clock: in std_logic;
    enable: in std_logic;
    contagem: buffer std_logic_vector(3 downto 0);
    end_count: out std_logic);
end contador_round;

Architecture circuito of contador_round is
    begin
    P1: process(clock, setup, enable)
        begin
         if setup= '1' then
             contagem <= vetor;
         elsif ((clock'event and clock= '1') and enable ='1') then
             contagem <= contagem - 1;
         end if;
    end process;
    end_count <= '1' when contagem = "0000" else '0';
end circuito;
