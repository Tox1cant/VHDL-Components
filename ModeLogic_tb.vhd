--------------------------------------------------------------------
-- ModeLogic
-- Goran Novakovic
--
-- This Test Bench will stress test the Mode Logic Component.
--                      TESTED & FUNCTIONAL
--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ModeLogic_tb is
end ModeLogic_tb;

architecture ModeLogic_tb_ARCH of ModeLogic_tb is
--------------------------------------------------------------------
    --component declaration-----------------------------------------
    component ModeLogic
        port (
            clock :      in STD_LOGIC;
            reset :      in STD_LOGIC;
            startStopEn :in STD_LOGIC;
            endTarget :  in INTEGER RANGE 0 TO 99;
            countTime :  in INTEGER RANGE 0 TO 99;
            timerMode :  out STD_LOGIC;
            ledMode :    out STD_LOGIC
        );
    end component;
--------------------------------------------------------------------
    signal  reset:      STD_LOGIC;
    signal  clock:      STD_LOGIC;
    signal  startStopEn:STD_LOGIC;
    signal  endTarget:  INTEGER RANGE 0 TO 99;
    signal  countTime:  INTEGER RANGE 0 TO 99;
    signal  ledMode:    STD_LOGIC;
    signal  timerMode:  STD_LOGIC;
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    --UUT-----------------------------------------------------------
    UUT: ModeLogic port map( 
            clock  => clock,
            reset  => reset, 
            startStopEn => startStopEn,
            endTarget => endTarget,
            countTime => countTime,
            timerMode => timerMode,
            ledMode => ledMode
            );
--------------------------------------------------------------------
    --signal driver-------------------------------------------------
    reset <= '1', '0' after 40ns ;
    startStopEn <= '0', '1' after 20ns, '0' after 40ns, 
                   '1' after 60ns;
    endTarget<= 10;
    countTime<= 1 , 5 after 1ms, 6 after 20ms, 10 after 50ms ;
    MODE_LOGIC: process 
    begin
        clock <= '0'; wait for 20ns;
        clock <= '1'; wait for 20ns;
    end process;
end ModeLogic_tb_ARCH;