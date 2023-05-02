--------------------------------------------------------------------
-- Component: BlankControl
-- Designer: Goran Novakovic
--
-- Description: Controls the blanking of the tens digits and also 
-- preforms a flashing patern once a cetrain state has been reached.
-- 
-- 
--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BlankControl is
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
end BlankControl ;

architecture BlankControl_ARCH of BlankControl is
    --declerations--------------------------------------------------
    constant ACTIVE:    std_logic := '1';
    constant COUNT_1HZ: integer := (100000000/1)-1;--about 1s clock
    --signal leftBlank:   std_logic := '0';
    --signal rightBlank:  std_logic := '0';
    signal rEnableBlink:std_logic := '0';
    signal lEnableBlink:std_logic := '0';
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    --clock speed initialisation------------------------------------
    CLOCK_SPEED_RIGHT: process(winnerRight, clock, reset)        
        variable count: integer range 0 to COUNT_1HZ;
        begin
            if (reset = ACTIVE) then
                 count := 0;
            elsif (rising_edge(clock)) then
                 if (count = COUNT_1HZ and winnerRight=ACTIVE)then
                     count := 0;
                 elsif(count/=COUNT_1HZ and winnerRight=ACTIVE)then
                     count := count + 1;
                 end if;
            end if;
            rEnableBlink <= not ACTIVE;
            if (count = COUNT_1HZ) then
                rEnableBlink <= ACTIVE;
            end if;
        end process CLOCK_SPEED_RIGHT;
    -----------------------------------------------------------------
    CLOCK_SPEED_LEFT: process(winnerLeft, clock, reset)        
        variable count: integer range 0 to COUNT_1HZ;
        begin
            if (reset = ACTIVE) then
                 count := 0;
            elsif (rising_edge(clock)) then
                 if (count = COUNT_1HZ and winnerLeft=ACTIVE) then
                     count := 0;
                 elsif(count/=COUNT_1HZ and winnerLeft=ACTIVE)then
                     count := count + 1;
                 end if;
            end if;
            lEnableBlink <= not ACTIVE;
            if (count = COUNT_1HZ) then
                lEnableBlink <= ACTIVE;
            end if;
        end process CLOCK_SPEED_LEFT;
    --blanking winner------------------------------------------------
    LEFT_BLANKING: process(lEnableBlink,clock,reset)    
     variable leftBlank : std_logic := '0';
     begin
         if (reset = ACTIVE) then 
         leftBlank <= not ACTIVE;
         elsif (rising_edge(clock)) then
             if (lEnableBlink = ACTIVE) then
                leftBlank <= not leftBlank;
             end if;
          end if;
          lBlankTens <= leftBlank;
          lBlankOnes <= leftBlank;
      end process LEFT_BLANKING;
    -----------------------------------------------------------------
    RIGHT_BLANKING: process(rEnableBlink,clock,reset)    
     variable rightBlank : std_logic := '0';
     begin
        if (reset = ACTIVE) then 
        rightBlank <= not ACTIVE;
        elsif (rising_edge(clock)) then
            if (rEnableBlink = ACTIVE) then
                rightBlank <= not rightBlank;
            end if;
         end if;
         rBlankTens <= rightBlank;
         rBlankOnes <= rightBlank;
      end process RIGHT_BLANKING;
    ---------------------------------------------------------------
    --blanking tens------------------------------------------------
    LEFT_TENS: process(leftPlayerTens,clock,reset)    
     variable leftTens : std_logic := '0';
     begin
         if (reset = ACTIVE) then 
         leftTens <=  ACTIVE;
         elsif (rising_edge(clock)) then
             if (leftPlayerTens /= "0000") then
                leftTens <= not ACTIVE;
             end if;
          end if;
          lBlankTens <= leftTens;
      end process LEFT_TENS;
    -----------------------------------------------------------------
    RIGHT_TENS: process(rightPlayerTens,clock,reset)    
     variable rightTens : std_logic := '0';
     begin
        if (reset = ACTIVE) then 
        rightTens <=  ACTIVE;
        elsif (rising_edge(clock)) then
            if (rightPlayerTens /= "0000") then
                rightTens <= not ACTIVE;
            end if;
         end if;
         rBlankTens <= rightTens;
      end process RIGHT_TENS;
--------------------------------------------------------------------
end BlankControl_ARCH;
