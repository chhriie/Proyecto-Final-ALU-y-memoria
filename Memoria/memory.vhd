library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
port(clock, reset, writee: in std_logic;
			data_in, address: in std_logic_vector(7 downto 0);
			port_in_00, port_in_01 : in std_logic_vector(7 downto 0);
			port_out_00, port_out_01 : out std_logic_vector(7 downto 0);
			data_out: out std_logic_vector(7 downto 0));
end entity;

architecture arquitectura of memory is
	
	component Output_ports
		port(data_in, address: in std_logic_vector(7 downto 0);
		writee, clk, reset: in std_logic;
		port_out_00, port_out_01: out std_logic_vector(7 downto 0));
	end component;
	
	component rw_96x8_sync
		port	(address, data_in : in std_logic_vector(7 downto 0);
		 writee, clk : in std_logic;
		 data_out : out std_logic_vector(7 downto 0));
	end component;
	
	component rom_128x8_sync
		port( address: in std_logic_vector(7 downto 0);
		clk: in std_logic;
		data_out: out std_logic_vector(7 downto 0));
	end component;
	
	signal rom_data_out, rw_data_out: std_logic_vector(7 downto 0);
	 
	begin
		
		A0 : rom_128x8_sync port map(address, clock, rom_data_out);
		A1 : rw_96x8_sync port map(address, data_in, writee, clock, rw_data_out);
		A2 : Output_ports port map(data_in, address, writee, clock, reset, port_out_00, port_out_01);
		
		MUX1 : process (address, rom_data_out, rw_data_out,
						port_in_00, port_in_01)
			begin
				if ((to_integer(unsigned(address)) >= 0) and (to_integer(unsigned(address)) <= 127)) then
					data_out <= rom_data_out;
				elsif ( (to_integer(unsigned(address)) >= 128) and (to_integer(unsigned(address)) <= 223)) then
					data_out <= rw_data_out;
				elsif (address = x"F0") then data_out <= port_in_00;
				elsif (address = x"F1") then data_out <= port_in_01;
				else data_out <= x"00";
				end if;
		
		end process;
	
end architecture ;