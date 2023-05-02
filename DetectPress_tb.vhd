--------------------------------------------------------------------
-- DetectPress
-- Goran Novakovic
--
-- This Test Bench will stress test the Detect Press Component.
--                     TESTED & FUNCTIONAL
--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DetectPress_tb is
end DetectPress_tb;

architecture DetectPress_tb_ARCH of DetectPress_tb is
--------------------------------------------------------------------
    --component declaration-----------------------------------------
     component DetectPress
        port (
            startStopCount : in STD_LOGIC;
            clock :          in STD_LOGIC;
            reset :          in STD_LOGIC;
            startStopEn :    out STD_LOGIC
        );
    end component;
--------------------------------------------------------------------
    signal  reset:          STD_LOGIC;
    signal  clock:          STD_LOGIC;
    signal  startStopCount: STD_LOGIC;
    signal  startStopEn:    STD_LOGIC;
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    --UUT-----------------------------------------------------------
    UUT: DetectPress port map( 
            reset => reset, 
            clock => clock, 
            startStopCount => startStopCount,
            startStopEn => startStopEn
            );
--------------------------------------------------------------------
    --signal driver-------------------------------------------------
    reset <= '1', '0' after 40ns ;
    startStopCount <= '1','0' after 20ns, '1' after 40ns,
                      '0' after 60ns, '1' after 120ns,
                      '0' after 200ns;
    LED_DRIVER: process
    begin
        clock <= '0'; wait for 20ns;
        clock <= '1'; wait for 20ns;
    end process;
end DetectPress_tb_ARCH;
