-----------------------------------
library ieee;
use ieee.std_logic_1164.all;
------------------------------------
entity SEQ3 is
  port ( address : in std_logic_vector(3 downto 0);
         data : out std_logic_vector(17 downto 0) );
end entity;

architecture Rom_Arch of SEQ3 is
  type memory is array (00 to 15) of std_logic_vector(17 downto 0);
  constant my_Rom : memory := (
	00 => "111101010110101011",
	01 => "011111111111111110",
   	02 => "111110110101011000",
	03 => "110101101000100000",
	04 => "000000001010010100",
	05 => "001010010111011111",
	06 => "111111111111101010",
	07 => "000010111010111000",
	08 => "011101000101000111",
	09 => "000000001110110000",
	10 => "011000001100000110",
	11 => "000101010100000000",
	12 => "100000000000001101",
	13 => "000101000100000111",
	14 => "100000000000001111",
	15 => "010010000000011100");
	
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
