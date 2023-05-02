--------------------------------------------------------------------
-- ConvertToInt
-- Goran Novakovic
--
-- This process recives inputs with switches and converts them into 
-- the apropriate intiger value up to 99. Using 7 switches.
-- There is no capabilities of error checking for the digit reaching
-- numbers above 99, it just sets max value as 99.
--
--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ConvertToInt is
    Port ( switches :  in STD_LOGIC_VECTOR (6 downto 0);-- error
           endTarget : out INTEGER RANGE 0 TO 99);
end ConvertToInt;

architecture ConvertToInt_ARCH of ConvertToInt is
--------------------------------------------------------------------
    --constants-----------------------------------------------------
    constant SWITCH_ON: std_logic := '1';--switch in up position    
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    --process declaration ------------------------------------------
    SWITCH_POSITION: process (switches)
        --variable decleration--------------------------------------
        variable switchNumb : integer RANGE 0 TO 99;--user set value
        begin        
            --adds up switches from binary to intiger number--------
            switchNumb := 0;
            if (switches(0) = SWITCH_ON) then
                switchNumb := switchNumb + 1;
            end if;
--------------------------------------------------------------------                
            if (switches(1) = SWITCH_ON) then
                switchNumb := switchNumb + 2;
            end if;
--------------------------------------------------------------------                    
            if (switches(2) = SWITCH_ON) then
                switchNumb := switchNumb + 4;
            end if;
--------------------------------------------------------------------                    
            if (switches(3) = SWITCH_ON) then
                switchNumb := switchNumb + 8;
            end if;
--------------------------------------------------------------------                    
            if (switches(4) = SWITCH_ON) then
                switchNumb := switchNumb + 16;
            end if;
--------------------------------------------------------------------                    
            if (switches(5) = SWITCH_ON) then
                switchNumb := switchNumb + 32;
            end if;
--------------------------------------------------------------------                    
            if (switches(6) = SWITCH_ON) then
                switchNumb := switchNumb + 64;
            end if;
-------------------------------------------------------------------- 
            if (switchNumb >= 99)then --if 99 exedes then set to 99
                switchNumb := 99;
            end if;
-------------------------------------------------------------------- 
            endTarget <= switchNumb; 
--------------------------------------------------------------------                
        end process SWITCH_POSITION;   
--------------------------------------------------------------------
end ConvertToInt_ARCH;