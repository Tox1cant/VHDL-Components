--------------------------------------------------------------------
-- Test Bench: StartDetect_tb
-- Designer: Goran Novakovic
--
-- Description: Tesing the capabilities of the presented component
-- and atempting to replicate real world situations that the 
-- component was designed for.
--                      TESTED & FUNCTIONAL
--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity StartDetect_tb is
end StartDetect_tb;

architecture StartDetect_tb_ARCH of StartDetect_tb is
--------------------------------------------------------------------
    --component declaration-----------------------------------------
    component StartDetect
        port (
            clock :     in std_logic;
            reset :     in std_logic;
            newRound:   in std_logic;
            resetWinEn: in std_logic;
            start:      in std_logic;
            startEn:    out std_logic
        );
    end component;
--------------------------------------------------------------------
    --decleration of signals----------------------------------------
    signal clock :     std_logic;
    signal reset :     std_logic;
    signal newRound:   std_logic;
    signal resetWinEn: std_logic;
    signal start:      std_logic;
    signal startEn:    std_logic;
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    --UUT-----------------------------------------------------------
    UUT: StartDetect port map( 
            clock      => clock,
            reset      => reset, 
            newRound   => newRound,
            resetWinEn => resetWinEn,
            start      => start,
            startEn    => startEn
            );
--------------------------------------------------------------------
    --signal driver-------------------------------------------------
    reset <= '1', '0' after 40ns ;
    newRound <= '0', '1' after 1000ns,'0' after 1020ns;
    resetWinEn <= '0', '1' after 2000ns, '0' after 2020ns;
    start <= '0', '1' after 60ns,'0' after 80ns;
    StartDetect_DRIVER: process
    begin
        clock <= '0'; wait for 20ns;
        clock <= '1'; wait for 20ns;        
    end process;
end StartDetect_tb_ARCH;
