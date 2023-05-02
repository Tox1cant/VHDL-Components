--------------------------------------------------------------------
-- Test Bench: BlankControl_tb
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

entity BlankControl_tb is
end BlankControl_tb;

architecture BlankControl_tb_ARCH of BlankControl_tb is
--------------------------------------------------------------------
    --component declaration-----------------------------------------
    component BlankControl
        port (
            clock :          in std_logic;
            reset :          in std_logic;
            leftPlayerTens:  in std_logic_vector (3 downto 0);
            rightPlayerTens: in std_logic_vector (3 downto 0);
            winnerLeft:      in std_logic;
            winnerRight:     in std_logic;
            lBlankOnes:      out std_logic;
            rBlankOnes:      out std_logic;
            lBlankTens:      out std_logic;
            rBlankTens:      out std_logic
        );
    end component;
--------------------------------------------------------------------
    --decleration of signals----------------------------------------
    signal clock :           std_logic;
    signal reset :           std_logic;
    signal leftPlayerTens:   std_logic_vector (3 downto 0);
    signal rightPlayerTens:  std_logic_vector (3 downto 0);
    signal winnerLeft:       std_logic;
    signal winnerRight:      std_logic;
    signal lBlankOnes:       std_logic;
    signal rBlankOnes:       std_logic;
    signal lBlankTens:       std_logic;
    signal rBlankTens:       std_logic;
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    --UUT-----------------------------------------------------------
    UUT: BlankControl port map( 
            clock           => clock,
            reset           => reset, 
            leftPlayerTens  => leftPlayerTens,
            rightPlayerTens => rightPlayerTens,
            winnerLeft      => winnerLeft,
            winnerRight     => winnerRight,
            lBlankOnes      => lBlankOnes,
            rBlankOnes      => rBlankOnes,
            lBlankTens      => lBlankTens,
            rBlankTens      => rBlankTens
            );
--------------------------------------------------------------------
    --signal driver-------------------------------------------------
    reset <= '1', '0' after 40ns ;
    leftPlayerTens <= "0000", "0001" after 120ns, "0010" after 160ns;
    rightPlayerTens<= "0000", "0001" after 120ns, "0010" after 160ns;
    winnerLeft <= '0';--, '1' after 160ns;
    winnerRight<= '0', '1' after 160ns;
    BlankControl_DRIVER: process
    begin
        clock <= '0'; wait for 20ns;
        clock <= '1'; wait for 20ns;        
    end process;
end BlankControl_tb_ARCH;
