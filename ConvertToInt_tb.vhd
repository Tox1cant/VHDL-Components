--------------------------------------------------------------------
-- ConvertToInt
-- Goran Novakovic
--
-- This Test Bench will stress test the Intiger Convertor Component.
--                      TESTED & FUNCTIONAL
--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ConvertToInt_tb is
end ConvertToInt_tb;

architecture ConvertToInt_tb_ARCH of ConvertToInt_tb is
--------------------------------------------------------------------
    --component declaration-----------------------------------------
    component ConvertToInt
        port (
            switches :  in STD_LOGIC_VECTOR (6 downto 0);
            endTarget : out INTEGER RANGE 0 TO 99
        );
    end component;
--------------------------------------------------------------------
    signal  switches:          STD_LOGIC_VECTOR (6 downto 0);
    signal  endTarget:         INTEGER RANGE 0 TO 99;
begin
--------------------------------------------------------------------
    --UUT-----------------------------------------------------------
    UUT: ConvertToInt port map( 
            switches => switches, 
            endTarget => endTarget 
            );
--------------------------------------------------------------------
    --signal driver-------------------------------------------------
    LED_DRIVER: process
    begin
    --testing switch response---------------------------------------
    switches <= "0000000";
    wait for 1ms;
    switches <= "0000001";
    wait for 1ms;
    switches <= "0000010";
    wait for 1ms;
    switches <= "0000011";
    wait for 1ms;
    switches <= "0000111";
    wait for 1ms;
    switches <= "0000100";
    wait for 1ms;
    switches <= "0000110";
    wait for 1ms;
    switches <= "0000101";
    wait for 1ms;
    switches <= "0001000";
    wait for 1ms;
    switches <= "0001001";
    wait for 1ms;
    switches <= "0001010";
    wait for 1ms;
    switches <= "0001100";
    wait for 1ms;
    switches <= "0001101";
    wait for 1ms;
    switches <= "0001110";
    wait for 1ms;
    switches <= "0001111";
    wait for 1ms;
    switches <= "0010000";
    wait for 1ms;
    switches <= "0010001";
    wait for 1ms;
    switches <= "0010010";
    wait for 1ms;
    switches <= "0010011";
    wait for 1ms;
    switches <= "0010100";
    wait for 1ms;
    switches <= "0010101";
    wait for 1ms;
    switches <= "0010110";
    wait for 1ms;
    switches <= "0010111";
    wait for 1ms;
    switches <= "0011000";
    wait for 1ms;
    switches <= "1111111";
    wait for 1ms;
    
    
    end process;
end ConvertToInt_tb_ARCH;
