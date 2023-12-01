library ieee;
use ieee.std_logic_1164.all;

entity decoBCD7s is
	port(
	A, B, C, D : in std_logic;
	abdce : out std_logic_vector(6 downto 0)
	);
end decoBCD7s;

architecture codigoo of decoBCD7s is
	signal ABCD : std_logic_vector(3 downto 0);
begin
	ABCD <= D & C & B & A;
	with (ABCD) select

		abdce <= "0000001" when "0000",
				  "1001111" when "0001",
				  "0010010" when "0010",
				  "0000110" when "0011",
				  "1001100" when "0100",
				  "0100100" when "0101",
				  "0100000" when "0110",
				  "0001111" when "0111",
				  "0000000" when "1000",
				  "0000100" when "1001",
				  "0001000" when "1010",
				  "1100000" when "1011",
				  "0110001" when "1100",
				  "1000010" when "1101",
				  "0110000" when "1110",
				  "0111000" when "1111";
end codigoo;