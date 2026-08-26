library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RISC_DESIGN_tb is
end RISC_DESIGN_tb;

architecture Behavioral of RISC_DESIGN_tb is

    ----------------------------------------------------------------
    -- DUT signals
    ----------------------------------------------------------------
    signal CLK        : std_logic := '0';
    signal RST        : std_logic := '1';
    signal Start      : std_logic := '0';

    signal MEM_IN     : std_logic_vector(1 downto 0) := "00";
    signal bus_sel    : std_logic_vector(2 downto 0) := "000";

    signal MEM_OUT    : std_logic_vector(1 downto 0);
    signal ADDRESS_OUT: std_logic_vector(1 downto 0);
    signal Stop       : std_logic;

    ----------------------------------------------------------------
    -- Clock period
    ----------------------------------------------------------------
    constant CLK_PERIOD : time := 20 ns;

begin

    ----------------------------------------------------------------
    -- DUT
    ----------------------------------------------------------------
    DUT : entity work.RISC_DESIGN
        port map (
            CLK         => CLK,
            RST         => RST,
            Start       => Start,
            MEM_IN      => MEM_IN,
            bus_sel     => bus_sel,
            MEM_OUT     => MEM_OUT,
            ADDRESS_OUT => ADDRESS_OUT,
            Stop        => Stop
        );

    ----------------------------------------------------------------
    -- Clock generation
    ----------------------------------------------------------------
    clk_process : process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;

            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    ----------------------------------------------------------------
    -- Main stimulus
    ----------------------------------------------------------------
    stimulus : process
    begin

        ----------------------------------------------------------------
        -- 1. RESET
        ----------------------------------------------------------------
        RST   <= '1';
        Start <= '0';
        MEM_IN <= "00";
        bus_sel <= "000";

        wait for 3 * CLK_PERIOD;

        RST <= '0';

        wait for CLK_PERIOD;

        ----------------------------------------------------------------
        -- 2. START OPERATION
        ----------------------------------------------------------------
        Start <= '1';

        wait for CLK_PERIOD;

        Start <= '0';

        ----------------------------------------------------------------
        -- 3. PC -> BUS
        --    bus_sel = 010 selects Program Counter
        ----------------------------------------------------------------
        bus_sel <= "010";

        wait for 2 * CLK_PERIOD;

        ----------------------------------------------------------------
        -- 4. MEMORY READ
        --
        --    First memory value = 01
        --    Represents instruction / first value
        ----------------------------------------------------------------
        MEM_IN <= "01";

        ----------------------------------------------------------------
        -- MDR -> BUS
        -- bus_sel = 001 selects MDR
        ----------------------------------------------------------------
        bus_sel <= "001";

        wait for 3 * CLK_PERIOD;

        ----------------------------------------------------------------
        -- 5. SECOND MEMORY READ
        --
        --    Second operand = 11
        ----------------------------------------------------------------
        MEM_IN <= "11";

        bus_sel <= "001";

        wait for 3 * CLK_PERIOD;

        ----------------------------------------------------------------
        -- 6. REGISTER OUTPUT
        --
        -- Register-file output selected onto BUS
        -- bus_sel = 000
        ----------------------------------------------------------------
        bus_sel <= "000";

        wait for 3 * CLK_PERIOD;

        ----------------------------------------------------------------
        -- 7. Wait for processor to finish
        ----------------------------------------------------------------
        wait until Stop = '1';

        wait for 2 * CLK_PERIOD;

        ----------------------------------------------------------------
        -- 8. Simulation completed
        ----------------------------------------------------------------
        report "RISC processor simulation completed."
            severity note;

        wait;

    end process;

end Behavioral;