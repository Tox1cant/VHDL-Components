--------------------------------------------------------------------
-- SwitchCounter 
-- Goran Novakovic 
-- 
-- Counts the switches that are turned on and displays 
-- the count on the 7-segment display as well as
-- indicating active switches by turning on 
-- LEDs abowe the switches.
-- Date: 01/31/2022
--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SwitchCounter is
    Port ( switches : in STD_LOGIC_VECTOR (7 downto 0);
           leds :     out bit_vector (7 downto 0);
           segments : out STD_LOGIC_VECTOR (6 downto 0));
end SwitchCounter;

architecture SwitchCounter_ARCH of SwitchCounter is
--------------------------------------------------------------------
-------------------------CONSTANT BOYS------------------------------
--------------------------------------------------------------------
-------------7-SEGMENT DISPLAY, NORMAL (NON MIRRORED)---------------
--------------------------------------------------------------------
    constant ZERO_7SEG:  std_logic_vector(6 downto 0) := "1000000";
    constant ONE_7SEG:   std_logic_vector(6 downto 0) := "1111001";
    constant TWO_7SEG:   std_logic_vector(6 downto 0) := "0100100";
    constant THREE_7SEG: std_logic_vector(6 downto 0) := "0110000";
    constant FOUR_7SEG:  std_logic_vector(6 downto 0) := "0011001";
    constant FIVE_7SEG:  std_logic_vector(6 downto 0) := "0010010";
    constant SIX_7SEG:   std_logic_vector(6 downto 0) := "0000010";
    constant SEVEN_7SEG: std_logic_vector(6 downto 0) := "1111000";
    constant EIGHT_7SEG: std_logic_vector(6 downto 0) := "0000000";
    constant NINE_7SEG:  std_logic_vector(6 downto 0) := "0011000";
    constant A_7SEG:     std_logic_vector(6 downto 0) := "0001000";
    constant B_7SEG:     std_logic_vector(6 downto 0) := "1000010";
    constant C_7SEG:     std_logic_vector(6 downto 0) := "0000111";
    constant D_7SEG:     std_logic_vector(6 downto 0) := "1100000";
    constant E_7SEG:     std_logic_vector(6 downto 0) := "0000110";
    constant F_7SEG:     std_logic_vector(6 downto 0) := "0001110";
--------------------------------------------------------------------
------------------------LED BAR UP TO 8 ----------------------------
--------------------------------------------------------------------
    constant BAR_ZERO :  bit_vector (7 downto 0) := "00000000";
    constant BAR_ONE :   bit_vector (7 downto 0) := "00000001";
    constant BAR_TWO :   bit_vector (7 downto 0) := "00000011";
    constant BAR_THREE : bit_vector (7 downto 0) := "00000111";
    constant BAR_FOUR :  bit_vector (7 downto 0) := "00001111";
    constant BAR_FIVE :  bit_vector (7 downto 0) := "00011111";
    constant BAR_SIX :   bit_vector (7 downto 0) := "00111111";
    constant BAR_SEVEN : bit_vector (7 downto 0) := "01111111";
    constant BAR_EIGHT : bit_vector (7 downto 0) := "11111111";
--------------------------------------------------------------------
------------------SWITCH AND LED CONSTANTS--------------------------
--------------------------------------------------------------------
-------------------------CONSTANTS----------------------------------
--------------------------------------------------------------------
    constant LED_ON:    std_logic := '0' ;
    constant LED_OFF:   std_logic := '1' ;
    constant SWITCH_ON: std_logic := '0' ;
--------------------------------------------------------------------
-----------------------CONSTANTS END--------------------------------
--------------------------------------------------------------------
--------------------------SIGNALS-----------------------------------
--------------------------------------------------------------------
    signal switchCount: integer range 0 to 8;
--------------------------------------------------------------------
------------------------SIGNAL END----------------------------------
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
------------------------7-SEGMENT DISPLAY---------------------------
--------------------------------------------------------------------
        COUNT_TO_7SEG: with switchCount select
            segments <=  ZERO_7SEG  when 8, 
                         ONE_7SEG   when 7,
                         TWO_7SEG   when 6,
                         THREE_7SEG when 5,
                         FOUR_7SEG  when 4,
                         FIVE_7SEG  when 3,
                         SIX_7SEG   when 2,
                         SEVEN_7SEG when 1,
                         EIGHT_7SEG when 0,
                         -----ERROR CASE----
                         F_7SEG when others;
                         -------------------
--------------------------------------------------------------------
-----------------------------LED BAR--------------------------------
--------------------------------------------------------------------
        COUNT_TO_LED: with switchCount select
              leds <= BAR_ZERO  when 8,
                      BAR_ONE   when 7,
                      BAR_TWO   when 6,
                      BAR_THREE when 5,
                      BAR_FOUR  when 4,
                      BAR_FIVE  when 3,
                      BAR_SIX   when 2,
                      BAR_SEVEN when 1,
                      BAR_EIGHT when others;
--------------------------------------------------------------------
----------------------SWITCH COUNTER CHECK--------------------------
--------------------------------------------------------------------
    SWITCH_COUNTER:  process (switches)
        variable count: integer;
        
        begin
--------------------------------------------------------------------
----------------CHECK NUMBER OF ACTIVE SWITCHES---------------------
--------------------------------------------------------------------
            count := 0;
            if (switches(0) = SWITCH_ON ) then
                count := count + 1;
            end if;
            if (switches(1) = SWITCH_ON ) then
                count := count + 1;
            end if;
            if (switches(2) = SWITCH_ON ) then
                count := count + 1;
            end if;
            if (switches(3) = SWITCH_ON ) then
                count := count + 1;
            end if;
            if (switches(4) = SWITCH_ON ) then
                count := count + 1;
            end if;
            if (switches(5) = SWITCH_ON ) then
                count := count + 1;
            end if;
            if (switches(6) = SWITCH_ON ) then
                count := count + 1;
            end if;
            if (switches(7) = SWITCH_ON ) then
                count := count + 1;
            end if;
            
            switchCount <= count;
            
        end process;
--------------------------------------------------------------------
----------------END CHECK NUMBER OF ACTIVE SWITCHES-----------------
--------------------------------------------------------------------
end SwitchCounter_ARCH;
