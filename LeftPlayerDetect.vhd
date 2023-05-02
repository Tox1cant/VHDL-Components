--------------------------------------------------------------------
-- Component: LeftPlayerDetect
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

entity LeftPlayerDetect is
    port (
        clock :            in std_logic;
        reset :            in std_logic;
        startEn:           in std_logic;
        leftPlayer:        in std_logic;
        newRoundEn:        in std_logic;
        leftPlayerPressed: out std_logic
    );
end LeftPlayerDetect ;

architecture LeftPlayerDetect_ARCH of LeftPlayerDetect is
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
            unsafeOutput := leftPlayer;
        end if;
        end if;
        leftPlayerPressed <= safeOutput;
        end process SYNC_CHAIN;
--------------------------------------------------------------------
end LeftPlayerDetect_ARCH;
