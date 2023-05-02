--------------------------------------------------------------------
-- Test Bench: Score_tb
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

entity Score_tb is
end Score_tb;

architecture Score_tb_ARCH of Score_tb is
--------------------------------------------------------------------
    --component declaration-----------------------------------------
    component Score
        port (
            --clock :             in std_logic;
            reset :             in std_logic;
            leftPlayerTotal :   in integer;
            rightPlayerTotal :  in integer;
            leftPlayerScore :   out integer;
            rightPlayerScore :  out integer;
            winnerLeft :        out std_logic;
            winnerRight :       out std_logic;
            resetWinEn :        out std_logic
        );
    end component;
--------------------------------------------------------------------
    --decleration of signals----------------------------------------
    --signal clock :              std_logic;
    signal reset :              std_logic;
    signal leftPlayerTotal :    integer;
    signal rightPlayerTotal :   integer;
    signal leftPlayerScore :    integer;
    signal rightPlayerScore :   integer;
    signal winnerLeft :         std_logic;
    signal winnerRight :        std_logic;
    signal resetWinEn :         std_logic;

--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    --UUT-----------------------------------------------------------
    UUT: Score port map( 
            --clock            => clock,
            reset            => reset, 
            leftPlayerTotal  => leftPlayerTotal,
            rightPlayerTotal => rightPlayerTotal,
            leftPlayerScore  => leftPlayerScore,
            rightPlayerScore => rightPlayerScore,
            winnerLeft       => winnerLeft,
            winnerRight      => winnerRight,
            resetWinEn       => resetWinEn
            );
--------------------------------------------------------------------
    --signal driver-------------------------------------------------
    reset            <='1', '0' after 40ns;
    leftPlayerTotal  <=0,0 after 40ns, 15 after 60ns,21 after 100ns;
    rightPlayerTotal <=21,0 after 40ns, 10 after 60ns,16 after 80ns;
    Score_DRIVER: process
    begin
        --clock <= '0'; wait for 20ns;
        --clock <= '1'; wait for 20ns;        
    end process;
end Score_tb_ARCH;
