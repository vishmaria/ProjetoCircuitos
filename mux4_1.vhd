library IEEE;
use IEEE.Std_Logic_1164.all;

entity mux4_1 is
port (F1: in std_logic_vector(17 downto 0);
      F2: in std_logic_vector(17 downto 0);
      F3: in std_logic_vector(17 downto 0);
      F4: in std_logic_vector(17 downto 0);
      SEL: in std_logic_vector(1 downto 0);
      saida: out std_logic_vector(17 downto 0)
      );
end mux4_1;

architecture arcmux of mux4_1 is
begin 
  saida <= F1 when SEL = "00" else
	       F2 when SEL = "01" else
	       F3 when SEL = "10" else
	       F4;
end arcmux;
	     