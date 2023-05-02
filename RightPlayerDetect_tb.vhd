--------------------------------------------------------------------
-- Test Bench: RightPlayerDetect_tb
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

entity RightPlayerDetect_tb is
end RightPlayerDetect_tb;

architecture RightPlayerDetect_tb_ARCH of RightPlayerDetect_tb is
--------------------------------------------------------------------
    --component declaration-----------------------------------------
    component RightPlayerDetect
        port (
            clock :             in std_logic;
            reset :             in std_logic;
            startEn:            in std_logic;
            rightPlayer:        in std_logic;
            rightPlayerPressed: out std_logic
        );
    end component;
--------------------------------------------------------------------
    --decleration of signals----------------------------------------
    signal clock :              std_logic;
    signal reset :              std_logic;
    signal startEn:             std_logic;
    signal rightPlayer:         std_logic;
    signal rightPlayerPressed:  std_logic;
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    --UUT-----------------------------------------------------------
    UUT: RightPlayerDetect port map( 
            clock              => clock,
            reset              => reset, 
            startEn            => startEn,
            rightPlayer        => rightPlayer,
            rightPlayerPressed => rightPlayerPressed
            );
--------------------------------------------------------------------
    --signal driver-------------------------------------------------
    reset      <= '1', '0' after 40ns ;
    startEn    <= '1', '0' after 10ns,'1' after 50ns;
    --rightPlayer <= '0', '1' after 60ns;
    LeftPlayerDetect_DRIVER: process
    begin
        clock <= '0'; wait for 20ns;
        clock <= '1'; wait for 20ns; 
        rightPlayer <= '0' wait for 60ns;
        rightPlayer <= '1' wait for 60ns;       
    end process;
end RightPlayerDetect_tb_ARCH;
