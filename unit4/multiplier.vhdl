--  unsigned multiplier - a
library IEEE; use IEEE.STD_LOGIC_1164.all;

entity multiplier_unsigned is
    port (a, b : in STD_LOGIC_VECTOR(3 downto 0);
            y: out STD_LOGIC_VECTOR(7 downto 0));
end;

architecture synth of multiplier is
begin
    y <= a * b;
end;