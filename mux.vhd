library IEEE;
use IEEE.Std_Logic_1164.all;

entity mux is

port (
	F1: in std_logic_vector(17 downto 0);
	F2: in std_logic_vector(17 downto 0);
	sel: in std_logic;
	F: out std_logic_vector(17 downto 0)
	);

end mux;

architecture circuito of mux is
begin
F <= F1 when sel = '0' else
     F2;
end circuito;
