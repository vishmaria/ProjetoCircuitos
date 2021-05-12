-----------------------------------
library ieee;
use ieee.std_logic_1164.all;
------------------------------------
entity SEQ4 is
  port ( address : in std_logic_vector(3 downto 0);
         data : out std_logic_vector(17 downto 0) );
end entity;

architecture Rom_Arch of SEQ4 is
  type memory is array (00 to 15) of std_logic_vector(17 downto 0);
  constant my_Rom : memory := (
	00 => "111111000000111111",
	01 => "110110000000000000",
   	02 => "011011000000000000",
	03 => "001101100000000000",
	04 => "000110110000000000",
	05 => "000011011000000000",
	06 => "000001101100000000",
	07 => "000000110110000000",
	08 => "000000011011000000",
	09 => "000000001101100000",
	10 => "000000000110110000",
	11 => "000000000011011000",
	12 => "000000000001101100",
	13 => "000000000000110110",
	14 => "000000000000011011",
	15 => "111100111110001111");
	
begin
   process (address) --//o adress vai ser o número da rodada.
   begin
     case address is
       when "0000" => data <= my_rom(00);
       when "0001" => data <= my_rom(01);
       when "0010" => data <= my_rom(02);
       when "0011" => data <= my_rom(03);
       when "0100" => data <= my_rom(04);
       when "0101" => data <= my_rom(05);
       when "0110" => data <= my_rom(06);
       when "0111" => data <= my_rom(07);
       when "1000" => data <= my_rom(08);
       when "1001" => data <= my_rom(09);
       when "1010" => data <= my_rom(10);
       when "1011" => data <= my_rom(11);
       when "1100" => data <= my_rom(12);
       when "1101" => data <= my_rom(13);
       when "1110" => data <= my_rom(14);
       when others => data <= my_rom(15);
       end case;
  end process;
end architecture Rom_Arch;
