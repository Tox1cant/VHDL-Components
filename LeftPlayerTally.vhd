--------------------------------------------------------------------
-- Component: LeftPlayerTally
-- Designer: Goran Novakovic
--
-- Description: This component will tally the input (0 or 1) and 
-- convert to integer value to be passed thru the output.
-- 
-- 
--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity LeftPlayerTally is
    port (
        leftPlayerPressed : in std_logic;
        newRound :          in std_logic;
        reset:              in std_logic;
        newRoundEn:         in std_logic;
        leftPlayerTaly :    out integer
    );
end LeftPlayerTally ;

architecture LeftPlayerTally_ARCH of LeftPlayerTally is
    --declerations--------------------------------------------------
    constant ACTIVE: std_logic := '1';
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    --process declaration ------------------------------------------
    TALLY_INPUTS:process(leftPlayerPressed,newRound,reset,newRoundEn)
        --variable declaration--------------------------------------
        variable count : integer range 0 to 16; --internal counting
        ------------------------------------------------------------
        begin
            if (newRound = ACTIVE or reset = ACTIVE or newRoundEn = ACTIVE ) then
                count := 0;
            else 
                count := count + 1;
            end if;
            leftPlayerTaly <= count;
        end process TALLY_INPUTS;
--------------------------------------------------------------------
end LeftPlayerTally_ARCH;
