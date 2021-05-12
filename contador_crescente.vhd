library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

Entity contador_crescente is port ( 
    data: in std_logic_vector (3 downto 0);
    reset: in std_logic;
    clock: in std_logic;
    enable: in std_logic;
    contagem: out std_logic_vector(3 downto 0);
    end_count: out std_logic);
end contador_crescente;

Architecture circuito of contador_crescente is
signal mem_contagem: std_logic_vector(3 downto 0);
    begin
    P1: process(clock, reset, enable, data)
        begin
         if reset= '1' then
             contagem <= "0000";
             mem_contagem <= "0000";
         elsif ((clock'event and clock= '1') and enable ='1') then
             mem_contagem <= mem_contagem + 1;
             contagem <= mem_contagem;
        end if;
         if mem_contagem = data then
             end_count <='1';
             contagem <= "0000";
             mem_contagem <= "0000";
         
         end if;
    end process;
end circuito;
