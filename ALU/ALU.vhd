library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is 
port(ALU_Sel: in std_logic_vector(2 downto 0);
		A,B: in std_logic_vector( 7 downto 0);
		NZVC: out std_logic_vector(3 downto 0);
		Result: out std_logic_vector(7 downto 0));
end entity;

architecture arquitectura of ALU is 
begin

	ALU_PROCESS : process (A, B, ALU_Sel)

		variable Sum_uns, Rest_uns, num : unsigned(8 downto 0);
		variable result_1 : unsigned(8 downto 0);
		
	begin
		if (ALU_Sel = "000") then 
		
--- Sum Calculation ---------------------------------–
			Sum_uns := unsigned('0' & A) + unsigned('0' & B);
			Result <= std_logic_vector(Sum_uns(7 downto 0));
			
--- Negative Flag (N) -------------------------------
			NZVC(3) <= Sum_uns(7);
			
--- Zero Flag (Z) ---------------------------------–
			if (Sum_uns(7 downto 0) = x"00") then
				NZVC(2) <= '1';
			else
				NZVC(2) <= '0';
			end if;
			
--- Overflow Flag (V) -------------------------------
			if ((A(7)='0' and B(7)='0' and Sum_uns(7)='1') or (A(7)='1' and B(7)='1' and Sum_uns(7)='0')) then
				NZVC(1) <= '1';
			else
				NZVC(1) <= '0';
			end if;
			
--- Carry Flag (C) ------------------------------------
			NZVC(0) <= Sum_uns(8);
			
			
			
		elsif (ALU_Sel = "001") then 
--- Rest Calculation ---------------------------------–
			if A < B then
				Rest_uns := unsigned('0' & A) - unsigned('0' & B);
				num := "000000001";
				result_1 := (not Rest_uns) + unsigned(num);
				Result <= std_logic_vector(result_1 (7 downto 0));
			else
				Rest_uns := unsigned('0' & A) - unsigned('0' & B);
				Result <= std_logic_vector(Rest_uns(7 downto 0));
			end if;
			
			
--- Negative Flag (N) -------------------------------
			NZVC(3) <= Rest_uns(7);
			
--- Zero Flag (Z) ---------------------------------–
			if (Rest_uns(7 downto 0) = x"00") then
				NZVC(2) <= '1';
			else
				NZVC(2) <= '0';
			end if;
			
--- Overflow Flag (V) -------------------------------
			if ((A(7)='0' and B(7)='0' and Rest_uns(7)='1') or (A(7)='1' and B(7)='1' and Rest_uns(7)='0')) then
				NZVC(1) <= '1';
			else
				NZVC(1) <= '0';
			end if;
			
--- Borrow Flag (C) ------------------------------------
			if A < B then 
				NZVC(0)<= '1';
			else
				NZVC(0)<= '0';
			end if;
		end if;
	end process;
		
end architecture; 