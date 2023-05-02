--------------------------------------------------------------------
-- Component: LedDriver
-- Designer: Goran Novakovic
--
-- Description: The LedDriver will controll the necesary LED outputs
-- dependent on the user inputs using buttons. the LEDs will be 
-- directional, if left button pressed then patter is left to right
-- and if right button pressed then from right to left the LEDs will
-- turn on. Bouth buttons are independant and light can rutn on only
-- on the press of the button. Reset will restore the LEDs to OFF 
-- state.  IF PLAYERS COLIDE/ CROSS INTO THE OTHER PLAYERS LED THE
--         LED WILL TURN OF DUE TO XOR GATE BEING USED.
-- 
-- 
--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity LedDriver is
    port (
        clock :              in std_logic;
        reset :              in std_logic;
        newRound :           in std_logic;
        newRoundEn :         in std_logic;
        leftPlayerPressed :  in std_logic;
        rightPlayerPressed : in std_logic;
        leds :               out bit_vector (15 downto 0)
    );
end LedDriver ;

architecture LedDriver_ARCH of LedDriver is
    --declerations--------------------------------------------------
    signal scoreRight: integer range 0 to 16;
    signal scoreLeft:  integer range 0 to 16;
    signal ledRight:   bit_vector (15 downto 0);
    signal ledLeft:    bit_vector (15 downto 0);
    -- general constants--------------------------------------------
    constant ACTIVE: std_logic := '1';
    constant BAR_0 :bit_vector (15 downto 0) := "0000000000000000";    
    --right to left LEDs--------------------------------------------
    constant BAR_1L :bit_vector (15 downto 0) := "0000000000000001";
    constant BAR_2L :bit_vector (15 downto 0) := "0000000000000011";
    constant BAR_3L :bit_vector (15 downto 0) := "0000000000000111";
    constant BAR_4L :bit_vector (15 downto 0) := "0000000000001111";
    constant BAR_5L :bit_vector (15 downto 0) := "0000000000011111";
    constant BAR_6L :bit_vector (15 downto 0) := "0000000000111111";
    constant BAR_7L :bit_vector (15 downto 0) := "0000000001111111";
    constant BAR_8L :bit_vector (15 downto 0) := "0000000011111111";
    constant BAR_9L :bit_vector (15 downto 0) := "0000000111111111";
    constant BAR_10L:bit_vector (15 downto 0) := "0000001111111111";
    constant BAR_11L:bit_vector (15 downto 0) := "0000011111111111";
    constant BAR_12L:bit_vector (15 downto 0) := "0000111111111111";
    constant BAR_13L:bit_vector (15 downto 0) := "0001111111111111";
    constant BAR_14L:bit_vector (15 downto 0) := "0011111111111111";
    constant BAR_15L:bit_vector (15 downto 0) := "0111111111111111";
    constant BAR_16L:bit_vector (15 downto 0) := "1111111111111111";
    --left to right LEDs--------------------------------------------
    constant BAR_1R :bit_vector (15 downto 0) := "1000000000000000";
    constant BAR_2R :bit_vector (15 downto 0) := "1100000000000000";
    constant BAR_3R :bit_vector (15 downto 0) := "1110000000000000";
    constant BAR_4R :bit_vector (15 downto 0) := "1111000000000000";
    constant BAR_5R :bit_vector (15 downto 0) := "1111100000000000";
    constant BAR_6R :bit_vector (15 downto 0) := "1111110000000000";
    constant BAR_7R :bit_vector (15 downto 0) := "1111111000000000";
    constant BAR_8R :bit_vector (15 downto 0) := "1111111100000000";
    constant BAR_9R :bit_vector (15 downto 0) := "1111111110000000";
    constant BAR_10R:bit_vector (15 downto 0) := "1111111111000000";
    constant BAR_11R:bit_vector (15 downto 0) := "1111111111100000";
    constant BAR_12R:bit_vector (15 downto 0) := "1111111111110000";
    constant BAR_13R:bit_vector (15 downto 0) := "1111111111111000";
    constant BAR_14R:bit_vector (15 downto 0) := "1111111111111100";
    constant BAR_15R:bit_vector (15 downto 0) := "1111111111111110";
    constant BAR_16R:bit_vector (15 downto 0) := "1111111111111111";
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    --selected signal assignment------------------------------------
    LEFT_TO_RIGHT_LED:  with scoreLeft select
        ledLeft <=  BAR_0   when 16,
                    BAR_1L  when 15,
                    BAR_2L  when 14,
                    BAR_3L  when 13,
                    BAR_4L  when 12,
                    BAR_5L  when 11,
                    BAR_6L  when 10,
                    BAR_7L  when 9,
                    BAR_8L  when 8,
                    BAR_9L  when 7,
                    BAR_10L when 6,
                    BAR_11L when 5,
                    BAR_12L when 4,
                    BAR_13L when 3,
                    BAR_14L when 2,
                    BAR_15L when 1,
                    BAR_16L when others;

    RIGHT_TO_LEFT_LED:  with scoreRight select
        ledRight <= BAR_0   when 0,
                    BAR_1R  when 1,
                    BAR_2R  when 2,
                    BAR_3R  when 3,
                    BAR_4R  when 4,
                    BAR_5R  when 5,
                    BAR_6R  when 6,
                    BAR_7R  when 7,
                    BAR_8R  when 8,
                    BAR_9R  when 9,
                    BAR_10R when 10,
                    BAR_11R when 11,
                    BAR_12R when 12,
                    BAR_13R when 13,
                    BAR_14R when 14,
                    BAR_15R when 15,
                    BAR_16R when others;
    --process declaration ------------------------------------------
    LED_CONTROL: process (clock,reset,newRound,newRoundEn,ledLeft,ledRight)
        --variable declaration--------------------------------------
        variable left:  integer range 0 to 16;
        variable right: integer range 0 to 16;
        ------------------------------------------------------------
        begin
            if (newRound = ACTIVE or newRoundEn = ACTIVE
                                             or reset = ACTIVE) then
                left  := 16;
                right := 0;
            elsif (rising_edge (clock)) then
                if (leftPlayerPressed = ACTIVE) then
                    left := left - 1;
                end if;
                if (rightPlayerPressed = ACTIVE) then
                    right := right + 1;
                end if;
            end if;
            scoreLeft  <= left;
            scoreRight <= right;
            leds       <= ledLeft xor ledRight;
        end process LED_CONTROL;
--------------------------------------------------------------------
end LedDriver_ARCH;
