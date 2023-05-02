--------------------------------------------------------------------
-- Test Bench: LeftPlayerDetect_tb
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

entity LeftPlayerDetect_tb is
end LeftPlayerDetect_tb;

architecture LeftPlayerDetect_tb_ARCH of LeftPlayerDetect_tb is
--------------------------------------------------------------------
    --component declaration-----------------------------------------
    component LeftPlayerDetect
        port (
            clock :            in std_logic;
            reset :            in std_logic;
            startEn:           in std_logic;
            leftPlayer:        in std_logic;
            leftPlayerPressed: out std_logic
        );
    end component;
--------------------------------------------------------------------
    --decleration of signals----------------------------------------
    signal clock :            std_logic;
    signal reset :            std_logic;
    signal startEn:           std_logic;
    signal leftPlayer:        std_logic;
    signal leftPlayerPressed: std_logic;
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    --UUT-----------------------------------------------------------
    UUT: LeftPlayerDetect port map( 
            clock             => clock,
            reset             => reset, 
            startEn           => startEn,
            leftPlayer        => leftPlayer,
            leftPlayerPressed => leftPlayerPressed
            );
--------------------------------------------------------------------
    --signal driver-------------------------------------------------
    reset      <= '1', '0' after 40ns ;
    startEn    <= '1', '0' after 10ns,'1' after 50ns;
    --leftPlayer <= '0', '1' after 60ns;
    LeftPlayerDetect_DRIVER: process
    begin
        clock <= '0'; wait for 20ns;
        clock <= '1'; wait for 20ns; 
        leftPlayer <= '0' wait for 60ns;
        leftPlayer <= '1' wait for 60ns;
    end process;
end LeftPlayerDetect_tb_ARCH;
