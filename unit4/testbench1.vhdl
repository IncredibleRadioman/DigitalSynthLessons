library IEEE; use IEEE.STD_LOGIC_1164.all;

entity testbench1 is
end;

architecture sim of testbench1 is
    component sillyfunction
        port(a,b,c : in STD_LOGIC;
            y : out STD_LOGIC);
    end component;

    signal a,b,c,y : STD_LOGIC;

begin
    --  DUT
    dut : sillyfunction port map(a,b,c,y);
    --  activate inputs step-by-step with intervals
    process begin
        a <= '0'; b <= '0'; c <='0';    wait for 10 ns;
        c <= '1';                       wait for 10 ns;
        b <= '1'; c <= '0'              wait for 10 ns;
        c <= '1';                       wait for 10 ns;
        a <= '1'; b <= '0'; c <= '0'    wait for 10 ns;
        c <= '1';                       wait for 10 ns;
        b <= '1'; c <= '0'              wait for 10 ns;
        c <= '1';                       wait for 10 ns;
        wait; --    wait forever else process would be repeated forever
    end process;
end;