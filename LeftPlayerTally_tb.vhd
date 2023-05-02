--------------------------------------------------------------------
-- Test Bench: LeftPlayerTally_tb
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

entity LeftPlayerTally_tb is
end LeftPlayerTally_tb;

architecture LeftPlayerTally_tb_ARCH of LeftPlayerTally_tb is
--------------------------------------------------------------------
    --component declaration-----------------------------------------
    component LeftPlayerTally
        port (
            leftPlayerPressed : in std_logic;
            newRound :          in std_logic;
            leftPlayerTally :   out integer
        );
    end component;
--------------------------------------------------------------------
    --decleration of signals----------------------------------------
    signal leftPlayerPressed : std_logic;
    signal newRound :          std_logic;
    signal leftPlayerTally :   integer;
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    --UUT-----------------------------------------------------------
    UUT: LeftPlayerTally port map( 
            leftPlayerPressed  => leftPlayerPressed,
            newRound           => newRound, 
            leftPlayerTally    => leftPlayerTally
            );
--------------------------------------------------------------------
    --signal driver-------------------------------------------------
    newRound <= '1', '0' after 40ns, '1' after 980ns;
    --leftPlayerPressed <= '0', '1' after 60ns;
    LeftPlayerTally_DRIVER: process
    begin
        --clock <= '0'; wait for 20ns;
        --clock <= '1'; wait for 20ns; 
        leftPlayerPressed <= '0' wait for 60ns;
        leftPlayerPressed <= '1' wait for 60ns;       
    end process;
end LeftPlayerTally_tb_ARCH;
