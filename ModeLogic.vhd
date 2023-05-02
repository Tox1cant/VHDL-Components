--------------------------------------------------------------------
-- ModeLogic
-- Goran Novakovic
--
-- This process tetermines when the time has reached its final
-- value to preform a automatic stopping of the process and 
-- activate the leds for the final patern to notify that the 
-- target value has been reached.
--
--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ModeLogic is
    Port ( clock :      in STD_LOGIC;
           reset :      in STD_LOGIC;
           startStopEn :in STD_LOGIC;
           endTarget :  in INTEGER RANGE 0 TO 99;
           countTime :  in INTEGER RANGE 0 TO 99;
           timerMode :  out STD_LOGIC;
           ledMode :    out STD_LOGIC);
end ModeLogic;

architecture ModeLogic_ARCH of ModeLogic is
--------------------------------------------------------------------
    --constant decleration------------------------------------------
    constant ACTIVE: std_logic := '1'; 
    signal enableCount: std_logic;
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    --process declaration ------------------------------------------
    --compare the target and count time inputs----------------------
    COMPARE: process(clock,reset)
        variable start: std_logic; -- variable used to latch input
        begin
            if (reset = ACTIVE) then  --sets the outputs to 0 state
                ledMode   <= not ACTIVE;
                timerMode <= not ACTIVE;
                start := not ACTIVE;
            end if;
            if (rising_edge(clock))then
                if (startStopEn = ACTIVE) then 
                start := not start; --latch and unlatch input
                end if;
                if (start = not ACTIVE) then -- checks for stopping
                    timerMode <= not ACTIVE;
                end if;
                if (start = ACTIVE)then -- checks for starting
                    if (endTarget /= countTime) then
                    timerMode <= ACTIVE;
                    end if;
                    if (endTarget = countTime) then
                    ledMode   <=  ACTIVE;
                    timerMode <= not ACTIVE;
                    end if;
                 end if;
            end if;
        end process COMPARE;
--------------------------------------------------------------------
end ModeLogic_ARCH;