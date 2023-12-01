library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Output_ports is
port(data_in, address: in std_logic_vector(7 downto 0);
		writee, clk, reset: in std_logic;
		port_out_00, port_out_01: out std_logic_vector(7 downto 0));
end entity;

architecture arquitectura of Output_ports is

begin
	U3 : process(clk,reset)
	begin
		if (reset='0')then
			port_out_00<=x"00";
		elsif (clk'event and clk='1')then
			if(address= x"E0" and writee= '1')then
				port_out_00 <= data_in;
			end if;
		end if;
	end process;
	
	U4 : process(clk,reset)
	begin
		if (reset='0')then
			port_out_01<=x"00";
		elsif (clk'event and clk='1')then
			if(address= x"E1" and writee= '1')then
				port_out_01 <= data_in;
			end if;
		end if;
	end process;
		
end architecture;

