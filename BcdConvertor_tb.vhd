--------------------------------------------------------------------
-- Test Bench: BcdConvertor_tb
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

entity BcdConvertor_tb is
end BcdConvertor_tb;

architecture BcdConvertor_tb_ARCH of BcdConvertor_tb is
--------------------------------------------------------------------
    --component declaration-----------------------------------------
    component BcdConvertor
        port (
            leftPlayerScore :     in INTEGER RANGE 0 TO 21;
            rightPlayerScore:     in INTEGER RANGE 0 TO 21;
            leftPlayerOnes : out STD_LOGIC_VECTOR (3 downto 0);
            leftPlayerTens : out STD_LOGIC_VECTOR (3 downto 0);
            rightPlayerOnes: out STD_LOGIC_VECTOR (3 downto 0);
            rightPlayerTens: out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;
--------------------------------------------------------------------
    --decleration of signals----------------------------------------
    signal leftPlayerScore  :  INTEGER RANGE 0 TO 21;
    signal rightPlayerScore :  INTEGER RANGE 0 TO 21;
    signal leftPlayerOnes   :  STD_LOGIC_VECTOR (3 downto 0);
    signal leftPlayerTens   :  STD_LOGIC_VECTOR (3 downto 0);
    signal rightPlayerOnes  :  STD_LOGIC_VECTOR (3 downto 0);
    signal rightPlayerTens  :  STD_LOGIC_VECTOR (3 downto 0);
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    --UUT-----------------------------------------------------------
    UUT: BcdConvertor port map( 
            leftPlayerScore   => leftPlayerScore,
            rightPlayerScore  => rightPlayerScore,
            leftPlayerOnes    => leftPlayerOnes,
            leftPlayerTens    => leftPlayerTens,
            rightPlayerOnes   => rightPlayerOnes,
            rightPlayerTens   => rightPlayerTens            
            );
--------------------------------------------------------------------
    --signal driver-------------------------------------------------
    leftPlayerScore  <= 1,2 after 10ns ,9 after 40ns,21 after 50ns;
    rightPlayerScore <= 0,2 after 10ns ,9 after 40ns,19 after 50ns;
    BcdConvertor_DRIVER: process
    begin
        --clock <= '0'; wait for 20ns;
        --clock <= '1'; wait for 20ns;        
    end process;
end BcdConvertor_tb_ARCH;



