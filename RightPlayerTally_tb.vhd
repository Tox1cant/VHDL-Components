--------------------------------------------------------------------
-- Test Bench: RightPlayerTally_tb
-- Designer: Goran Novakovic
--
-- Description: Tesing the capabilities of the presented component
-- and atempting to replicate real world situations that the 
-- component was designed for.
--               *NOT*       TESTED & FUNCTIONAL
--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RightPlayerTally_tb is
end RightPlayerTally_tb;

architecture RightPlayerTally_tb_ARCH of RightPlayerTally_tb is
--------------------------------------------------------------------
    --component declaration-----------------------------------------
    component RightPlayerTally
        port (
            rightPlayerPressed : in std_logic;
            newRound :           in std_logic;
            rightPlayerTally :   out integer
        );
    end component;
--------------------------------------------------------------------
    --decleration of signals----------------------------------------
    signal rightPlayerPressed :  std_logic;
    signal newRound :            std_logic;
    signal rightPlayerTally :    integer;
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    --UUT-----------------------------------------------------------
    UUT: RightPlayerTally port map( 
            rightPlayerPressed  => rightPlayerPressed,
            newRound            => newRound, 
            rightPlayerTally    => rightPlayerTally
            );
--------------------------------------------------------------------
    --signal driver-------------------------------------------------
    newRound <= '1', '0' after 40ns, '1' after 980ns;
    --leftPlayerPressed <= '0', '1' after 60ns;
    LeftPlayerTally_DRIVER: process
    begin
        clock <= '0'; wait for 20ns;
        clock <= '1'; wait for 20ns; 
        rightPlayerPressed <= '0' wait for 60ns;
        rightPlayerPressed <= '1' wait for 60ns;       
    end process;
end RightPlayerTally_tb_ARCH;
