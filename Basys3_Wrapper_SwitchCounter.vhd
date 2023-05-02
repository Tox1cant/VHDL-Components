-----------------------------------------------------------------
-- Basys 3 wrapper for SwitchCounter sorce code 
-- Goran Novakovic  
--
-- Wrapper file for SwitchCounter component using the Basys 3
-- board uses the last (lower) 8 LEDs and Switches and the 
-- far right 7 segment display to show switch count active.
-----------------------------------------------------------------
library ieee;
use IEEE.STD_LOGIC_1164.ALL;
-----------------------------------------------------------------
-----------------------PORTING-----------------------------------
-----------------------------------------------------------------
entity SwitchCounter_basys3 is
    Port ( sw :  in STD_LOGIC_VECTOR (7 downto 0);
           led : out bit_vector (7 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an :  out STD_LOGIC_VECTOR (3 downto 0));
end SwitchCounter_basys3;
-----------------------------------------------------------------
-----------------------END PORTING-------------------------------
-----------------------------------------------------------------
architecture SwitchCounter_basys3_ARCH of SwitchCounter_basys3 is
-----------------------------------------------------------------
-----------------------COMPONENT---------------------------------
-----------------------------------------------------------------
    component SwitchCounter
        port
        (
            switches : in STD_LOGIC_VECTOR (7 downto 0);
            leds :     out bit_vector (7 downto 0);
            segments : out STD_LOGIC_VECTOR (6 downto 0)
         );
        end component;
-----------------------------------------------------------------
---------------------COMPONENT END-------------------------------
-----------------------------------------------------------------
begin
    MY_DESIGN: SwitchCounter port map  
    (
        switches => sw,
        leds     => led,
        segments => seg 
    );

    an <= "1110";

end SwitchCounter_basys3_ARCH;
