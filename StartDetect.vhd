--------------------------------------------------------------------
-- Component: StartDetect
-- Designer: Goran Novakovic
--
-- Description: Detects if the round/game has started with the press
-- of a button. Sending a live signal for the other detect press 
-- componnets. Metastability is used to correct the input press.
-- 
-- 
--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity StartDetect is
    port (
        clock :     in std_logic;
        reset :     in std_logic;
        newRound:   in std_logic;
        resetWinEn: in std_logic;
        start:      in std_logic;
        startEn:    out std_logic
    );
end StartDetect ;

architecture StartDetect_ARCH of StartDetect is
    --declerations--------------------------------------------------
    constant ACTIVE: std_logic := '1';
    signal safeOutput: std_logic;
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    --process declaration ------------------------------------------
    DETECT_PRESS: process (reset, clock,newRound,resetWinEn)
        --variable declaration--------------------------------------
        variable buttonPressed: std_logic;
        ------------------------------------------------------------
        begin
        if(reset = ACTIVE or newRound = ACTIVE or
                                           resetWinEn = ACTIVE) then
                buttonPressed := not ACTIVE;
                startEn       <= not ACTIVE;
        elsif(rising_edge(clock)) then
            if(safeOutput = ACTIVE and 
                                buttonPressed = not ACTIVE) then
               startEn <= ACTIVE;
            else
                startEn <= not ACTIVE;
            end if;        
            if (safeOutput = ACTIVE) then
                buttonPressed := ACTIVE;
            else
                buttonPressed := not ACTIVE;
            end if;
        end if;            
        end process DETECT_PRESS;
    -----------------------------------------------------------------
    SYNC_CHAIN: process(reset, clock, newRound, resetWinEn,start)
        variable unsafeOutput: std_logic;
        begin
        if (reset = ACTIVE or newRound = ACTIVE or
                                            resetWinEn = ACTIVE) then
            safeOutput   <= not ACTIVE;
            unsafeOutput := not ACTIVE;
        elsif (rising_edge(clock)) then
            safeOutput   <= unsafeOutput;
            unsafeOutput := start; --asyncInput input,button press
        end if;
        end process SYNC_CHAIN;
--------------------------------------------------------------------
end StartDetect_ARCH;
