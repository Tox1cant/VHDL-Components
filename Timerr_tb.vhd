--------------------------------------------------------------------
-- Timer
-- Goran Novakovic
--
-- This Test Bench will stress test the Timer Component.
--                      TESTED & FUNCTIONAL
--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Timerr_tb is
end Timerr_tb;

architecture Timerr_tb_ARCH of Timerr_tb is
--------------------------------------------------------------------
    --component declaration-----------------------------------------
    component Timer
        port (
            timerMode : in STD_LOGIC;
            clock :     in STD_LOGIC;
            reset :     in STD_LOGIC;
            countTime : out INTEGER RANGE 0 TO 99
        );
    end component;
--------------------------------------------------------------------
    signal  reset:      STD_LOGIC;
    signal  clock:      STD_LOGIC;
    signal  timerMode:  STD_LOGIC;
    signal  countTime:  INTEGER RANGE 0 TO 99;
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    --UUT-----------------------------------------------------------
    UUT: Timer port map( 
            clock  => clock,
            reset  => reset, 
            countTime => countTime,
            timerMode => timerMode
            );
--------------------------------------------------------------------
    --signal driver-------------------------------------------------
    
    reset <= '1', '0' after 40ns ;
    timerMode <= '0', '1' after 60ns;
    TIMERR: process
    begin
        clock <= '0'; wait for 20ns;
        clock <= '1'; wait for 20ns;        
    end process;
end Timerr_tb_ARCH;
