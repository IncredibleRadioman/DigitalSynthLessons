library IEEE; use IEEE.STD_LOGIC_1164.all;

entity inv is
    port(
        a : in STD_LOGIC_VECTOR(3 downto 0);
        y : out STD_LOGIC_VECTOR(3 downto 0)
    );
end;

architecture proc of inv is
begin
    --  performed when any signal is changed 
    process(all)
        y <= not a;
    end process;
end;