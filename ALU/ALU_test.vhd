library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_test is
port (A, B : in std_logic_vector(7 downto 0);
		ALU_Sel : in std_logic_vector(2 downto 0);
		NZVC : out std_logic_vector(3 downto 0);
		DEC_Result, UNI_Result, DEC_B, UNI_B : out std_logic_vector(6 downto 0)
		);
end entity;

architecture arquitectura of ALU_test is
	
	component decoBCD7s
	port(
	A, B, C, D : in std_logic;
	abdce : out std_logic_vector(6 downto 0)
	);
	end component;
	
	component ALU
	port(ALU_Sel: in std_logic_vector(2 downto 0);
			A,B: in std_logic_vector( 7 downto 0);
			NZVC: out std_logic_vector(3 downto 0);
			Result: out std_logic_vector(7 downto 0));
	end component;
	
	signal B_dec : std_logic_vector(3 downto 0) := B(7 downto 4);
	signal B_uni : std_logic_vector(3 downto 0) := B(3 downto 0);
	signal Result_1 : std_logic_vector(7 downto 0);
	signal Result_1_dec : std_logic_vector(3 downto 0) := Result_1(7 downto 4);
	signal Result_1_uni : std_logic_vector(3 downto 0) := Result_1(3 downto 0);
	
begin
	
	A0: ALU port map(ALU_Sel, A, B, NZVC, Result_1);
	
	A1: decoBCD7s port map(B_dec(0), B_dec(1), B_dec(2), B_dec(3), DEC_B);
	A2: decoBCD7s port map(B_uni(0), B_uni(1), B_uni(2), B_uni(3), UNI_B);
	A3: decoBCD7s port map(Result_1_dec(0), Result_1_dec(1), Result_1_dec(2), Result_1_dec(3), DEC_Result);
	A4: decoBCD7s port map(Result_1_uni(0), Result_1_uni(1), Result_1_uni(2), Result_1_uni(3), UNI_Result);
	
end architecture;