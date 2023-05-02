--------------------------------------------------------------------
-- Component: RightPlayerDetect
-- Designer: Goran Novakovic
--
-- Description: The component will recive a button press input and
-- stabilize it for the next component that will process the inputs
-- 
-- 
--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RightPlayerDetect is
    port (
        clock :             in std_logic;
        reset :             in std_logic;
        startEn:            in std_logic;
        rightPlayer:        in std_logic;
        newRoundEn:        in std_logic;
        rightPlayerPressed: out std_logic
    );
end RightPlayerDetect ;

architecture RightPlayerDetect_ARCH of RightPlayerDetect is
    --declerations--------------------------------------------------
    constant ACTIVE: std_logic := '1';
    signal safeOutput: STD_LOGIC;
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    --process declaration ------------------------------------------
     SYNC_CHAIN: process(reset, clock,safeOutput)
        variable unsafeOutput: std_logic;
        variable start: std_logic; -- variable used to latch input
        begin
        if (reset = ACTIVE) then
            safeOutput   <= not ACTIVE;
            unsafeOutput := not ACTIVE;
            start := not ACTIVE;
        elsif (rising_edge(clock)) then
         if (startEn = ACTIVE or newRoundEn = ACTIVE) then 
               start := not start; --latch and unlatch input
         end if;
         if(start = ACTIVE)then
            safeOutput   <= unsafeOutput;
            unsafeOutput := rightPlayer;
        end if;
        end if;
        rightPlayerPressed <= safeOutput;
        end process SYNC_CHAIN;
--------------------------------------------------------------------
end RightPlayerDetect_ARCH;
