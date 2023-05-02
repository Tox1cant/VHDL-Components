--------------------------------------------------------------------
-- Component: BcdConvertor
-- Designer: Goran Novakovic
--
-- Description: This process will convert an integer value into a
-- binary value for the seven segment display.
-- 
--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BcdConvertor is
    Port ( 
            leftPlayerScore : in INTEGER RANGE 0 TO 21;
            rightPlayerScore: in INTEGER RANGE 0 TO 21;
            leftPlayerOnes :  out STD_LOGIC_VECTOR (3 downto 0);
            leftPlayerTens :  out STD_LOGIC_VECTOR (3 downto 0);
            rightPlayerOnes:  out STD_LOGIC_VECTOR (3 downto 0);
            rightPlayerTens:  out STD_LOGIC_VECTOR (3 downto 0)
        );
end BcdConvertor;

architecture BcdConvertor_ARCH of BcdConvertor is

    signal tensLeft:  integer range 0 to 2;
    signal onesLeft:  integer range 0 to 9;
    signal tensRight: integer range 0 to 2;
    signal onesRight: integer range 0 to 9;
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    --process declaration ------------------------------------------
    --bcd convertor-------------------------------------------------
    BCD_CONVERT: process 
                        (tensLeft,onesLeft,tensRight,onesRight,
                        leftPlayerScore,rightPlayerScore)
        begin
            --left player score-------------------------------------
            tensLeft <= leftPlayerScore / 10;
            onesLeft <= leftPlayerScore mod 10;
            --right player score------------------------------------
            tensRight <= rightPlayerScore / 10;
            onesRight <= rightPlayerScore mod 10;
            -- converting integer into std_logic_vector-------------
            --left player 7 segment score---------------------------           
            leftPlayerOnes  <= STD_LOGIC_VECTOR 
                        (to_unsigned(onesLeft, 
                                            leftPlayerOnes'length));
            leftPlayerTens  <= STD_LOGIC_VECTOR 
                        (to_unsigned(tensLeft, 
                                            leftPlayerTens'length)); 
            --right player 7 segment score--------------------------
            rightPlayerOnes <= STD_LOGIC_VECTOR 
                        (to_unsigned(onesRight, 
                                            rightPlayerOnes'length));
            rightPlayerTens <= STD_LOGIC_VECTOR 
                        (to_unsigned(tensRight, 
                                            rightPlayerTens'length)); 
        end process BCD_CONVERT;
--------------------------------------------------------------------
end BcdConvertor_ARCH;
