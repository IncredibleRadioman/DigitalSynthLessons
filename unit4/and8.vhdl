library IEEE; use IEEE.STD_LOGIC_1164.all;

entity and8 is
	port(a : in STD_LOGIC_VECTOR(7 downto 0);
	y : out STD_LOGIC);
end;

architecture synth of and8 is
begin
	-- it's like y <= a(7) & a(6) & ... a(0)
	y <= and a;
end;
