--------------------------------------------------------------------
-- Test Bench: LedDriver_tb
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

entity LedDriver_tb is
end LedDriver_tb;

architecture LedDriver_tb_ARCH of LedDriver_tb is
--------------------------------------------------------------------
    --component declaration-----------------------------------------
    component LedDriver
        port (
            clock :              in std_logic;
            reset :              in std_logic;
            newRound :           in std_logic;
            newRoundEn :         in std_logic;
            leftPlayerPressed :  in std_logic;
            rightPlayerPressed : in std_logic;
            leds :               out bit_vector (15 downto 0)
        );
    end component;
--------------------------------------------------------------------
    --decleration of signals----------------------------------------
    signal clock :               std_logic;
    signal reset :               std_logic;
    signal newRound :            std_logic;
    signal newRoundEn :          std_logic;
    signal leftPlayerPressed :   std_logic;
    signal rightPlayerPressed :  std_logic;
    signal leds :                bit_vector (15 downto 0);
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    --UUT-----------------------------------------------------------
    UUT: LedDriver port map( 
            clock               => clock,
            reset               => reset, 
            newRound            => newRound,
            newRoundEn          => newRoundEn,
            leftPlayerPressed   => leftPlayerPressed,
            rightPlayerPressed  => rightPlayerPressed,
            leds                => leds
            );
--------------------------------------------------------------------
    --signal driver-------------------------------------------------
    reset              <='1','0'after 40ns;
    newRound           <='0';--,'1'after 100ns,'0'after 120ns;
    newRoundEn         <='0';--,'1'after 120ns,'0'after 150ns;
    LedDriver_DRIVER: process
    begin
        clock<='0';leftPlayerPressed<='0';rightPlayerPressed<='0';
        wait for 20ns;
        clock<='1';leftPlayerPressed<='1';rightPlayerPressed<='1';
        wait for 20ns; 
    end process;
end LedDriver_tb_ARCH;
