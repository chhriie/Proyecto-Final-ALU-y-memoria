library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity memory_test is
port(clock, reset, writee: in std_logic;
			data_in, address : in std_logic_vector(7 downto 0);
			dec_address, uni_address, dec_data_out, uni_data_out : out std_logic_vector(6 downto 0);
			port_out_00 : out std_logic_vector(7 downto 0)
			);
end entity;

architecture arquitectura of memory_test is

	component decoBCD7s 
		port(
		A, B, C, D : in std_logic;
		abdce : out std_logic_vector(6 downto 0)
		);
	end component;

	component memory 
	port(clock, reset, writee: in std_logic;
				data_in, address: in std_logic_vector(7 downto 0);
				port_in_00, port_in_01 : in std_logic_vector(7 downto 0);
				port_out_00, port_out_01 : out std_logic_vector(7 downto 0);
				data_out: out std_logic_vector(7 downto 0));
	end component;
	
	signal po00, po01, data_out: std_logic_vector(7 downto 0);
	signal dec1 : std_logic_vector(3 downto 0):= address(7 downto 4);
	signal uni1 : std_logic_vector(3 downto 0):= address(3 downto 0);
	signal dec2 : std_logic_vector(3 downto 0):= data_out(7 downto 4);
	signal uni2 : std_logic_vector(3 downto 0):= data_out(3 downto 0);
	
	begin
	
	A0: memory port map(clock, reset, writee, data_in, address, "00000000", "00000000", port_out_00, po01, data_out);
	
	DECAU: decoBCD7s port map(uni1(0), uni1(1), uni1(2), uni1(3), uni_address);
	DECAD: decoBCD7s port map(dec1(0), dec1(1), dec1(2), dec1(3), dec_address);
	
	DECDU: decoBCD7s port map(uni2(0), uni2(1), uni2(2), uni2(3), uni_data_out);
	DECDD: decoBCD7s port map(dec2(0), dec2(1), dec2(2), dec2(3), dec_data_out);
	
end architecture ;