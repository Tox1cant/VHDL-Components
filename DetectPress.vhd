--------------------------------------------------------------------
-- DetectPress
-- Goran Novakovic
--
-- DetectPress is used as a process that checks the state of a 
-- button press, it is synchronised to the clock and it controls
-- the ModeLogic process.
-- 
--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DetectPress is
    Port ( startStopCount : in STD_LOGIC;
           clock :          in STD_LOGIC;
           reset :          in STD_LOGIC;
           startStopEn :    out STD_LOGIC);
end DetectPress;

architecture DetectPress_ARCH of DetectPress is
--------------------------------------------------------------------
    -- constants ---------------------------------------------------
    constant ACTIVE: std_logic := '1';
    signal start: STD_LOGIC;
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    --process declaration ------------------------------------------
    --detection of the button press --------------------------------
    DETECT_PRESS: process(reset,clock)
        variable buttonPressed: std_logic;
        
        begin
        if(reset=ACTIVE) then
            buttonPressed := not ACTIVE;
            startstopEn <= not ACTIVE;
        elsif(rising_edge(clock)) then
            if(startstopCount = ACTIVE and 
                                buttonPressed = not ACTIVE) then
                startstopEn <= ACTIVE;
            else
                startStopEn <= not ACTIVE;
            end if;        
            if (startstopCount = ACTIVE) then
                buttonPressed := ACTIVE;
            else
                buttonPressed := not ACTIVE;
            end if;
        end if;
        end process DETECT_PRESS;

--------------------------------------------------------------------
end DetectPress_ARCH;