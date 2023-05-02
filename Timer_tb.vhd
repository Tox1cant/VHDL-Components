--------------------------------------------------------------------
-- LedDriver
-- Goran Novakovic
--
-- This Led Driver is a process used to make a specific patern 
-- upon reciving an internal signal (Named- ledMode) driven 
-- by another process.
--
--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity LedDriver_tb is
end LedDriver_tb;

architecture LedDriver_tb_ARCH of LedDriver_tb is
--------------------------------------------------------------------
    --component declaration-----------------------------------------
    component LedDriver
        Port ( reset:   in STD_LOGIC;
               clock:   in STD_LOGIC;
               ledMode: in STD_LOGIC; -- signal used from ModeLogic
               leds :   out bit_vector (15 downto 0));
    end component;
--------------------------------------------------------------------
    signal  reset:  STD_LOGIC;
    signal  clock:  STD_LOGIC;
    signal  ledMode:STD_LOGIC;
    signal  leds:   bit_vector (15 downto 0);
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    --UUT-----------------------------------------------------------
    UUT: LedDriver port map( 
            reset => reset, 
            clock => clock, 
            ledMode => ledMode,
            leds => leds
            );
--------------------------------------------------------------------
    --signal driver-------------------------------------------------
    LED_DRIVER: process
    begin
    --testing reset response----------------------------------------
        reset <= '1';
        clock <= '1';
        ledMode <= '0';
        wait for 1ms;
        reset <= '1';
        clock <= '0';
        ledMode <= '1';
        wait for 1ms;
        reset <= '1';
        clock <= '1';
        ledMode <= '0';
        wait for 1ms;
        reset <= '1';
        clock <= '0';
        ledMode <= '1';
        wait for 1ms;
--------------------------------------------------------------------
    --testing clock response----------------------------------------
        reset <= '0';
        clock <= '1';
        ledMode <= '0';
        wait for 1ms;
        reset <= '0';
        clock <= '0';
        ledMode <= '0';
        wait for 1ms;
        reset <= '0';
        clock <= '1';
        ledMode <= '0';
        wait for 1ms;
        reset <= '0';
        clock <= '0';
        ledMode <= '0';
        wait for 1ms;
        reset <= '0';
        clock <= '1';
        ledMode <= '0';
        wait for 1ms;
        reset <= '0';
        clock <= '0';
        ledMode <= '0';
        wait for 1ms;
        --testing ledModeponse---------------------------------------       
        reset <= '0';
        clock <= '1';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '0';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '1';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '0';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '1';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '0';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '1';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '0';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '1';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '0';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '1';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '0';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '1';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '0';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '1';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '0';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '1';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '0';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '1';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '0';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '1';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '0';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '1';
        ledMode <= '1';
        wait for 1ms;
        reset <= '0';
        clock <= '0';
        ledMode <= '1';
        wait for 1ms;
        --reset activated
        reset <= '1';
        clock <= '1';
        ledMode <= '1';
        wait for 1ms;
        reset <= '1';
        clock <= '0';
        ledMode <= '1';
        wait for 1ms;
        reset <= '1';
        clock <= '1';
        ledMode <= '0';
        wait for 1ms;
        
    end process;

end LedDriver_tb_ARCH;
