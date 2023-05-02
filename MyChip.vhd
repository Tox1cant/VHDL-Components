library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
--******************************************************************
--* Name: MyChip
--* Designer: Scott Tippens
--*
--*This design represents a top level hardware evaluation of the
--*seven segment driver component named SevenSegmentDriver.
--*This implementation targets the Digilent Basys3 development
--*board.
--*The 16 slide switches will be used to input the 4 digits for 
--*the display and the down push button will be utilized for
--*the system reset input.The 4-digit seven-segment display
--*will be used for displaying the resultant value.
--*
--******************************************************************
--------------------------------------------------------------------
-- MyChip-Edit
-- Editors: Goran Novakovic and Mahmoud Abusaid
--
-- The Original code provided by designer Scott Tippens has been
-- edited for the design written by Goran Novakovic and
-- Mahmoud Abusaid. Every code commented out and below the Seven
-- Segment Driver was added by editors.
-- The VHDL code inside the MyChip file is just port mapping for
-- all of the components to be integrated together.
--
--------------------------------------------------------------------
entity MyChip is
    port(
        clk: in std_logic;
        sw: in std_logic_vector(6 downto 0);
        
        seg: out std_logic_vector(6 downto 0);
        an:  out std_logic_vector(3 downto 0);

        btnC: in std_logic;
       -- btnU: in std_logic;
        btnD: in std_logic;
       -- btnL: in std_logic;
       -- btnR: in std_logic;
        led : out bit_vector (15 downto 0)-- Led Driver
    );
end MyChip;


architecture MyChip_ARCH of MyChip is
--------------------------------------------------------------------
    component SevenSegmentDriver
        port (
            reset: in std_logic;
            clock: in std_logic;
        
            digit3:in std_logic_vector(3 downto 0);--leftmost digit
            digit2:in std_logic_vector(3 downto 0);--2nd from left 
            digit1:in std_logic_vector(3 downto 0);--3rd from left 
            digit0:in std_logic_vector(3 downto 0);--rightmost digit
        
            blank3:in std_logic;--leftmost digit
            blank2:in std_logic;--2nd from left digit
            blank1:in std_logic;--3rd from left digit
            blank0:in std_logic;--rightmost digit
        
            sevenSegs:out std_logic_vector(6 downto 0);--MSB=a,LSB=g
            anodes:  out std_logic_vector(3 downto 0) --MSB=leftmost 
        );
    end component;
--------------------------------------------------------------------
     component BcdConvertor
        port (
            countTime : in INTEGER RANGE 0 TO 99;
            onesDigit : out STD_LOGIC_VECTOR (3 downto 0);
            tensDigit : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;
--------------------------------------------------------------------
    component Timer
        port (
            timerMode : in STD_LOGIC;
            clock :     in STD_LOGIC;
            reset :     in STD_LOGIC;
            countTime : out INTEGER RANGE 0 TO 99
        );
    end component;
--------------------------------------------------------------------
    component ModeLogic
        port (
            clock :      in STD_LOGIC;
            reset :      in STD_LOGIC;
            startStopEn :in STD_LOGIC;
            endTarget :  in INTEGER RANGE 0 TO 99;
            countTime :  in INTEGER RANGE 0 TO 99;
            timerMode :  out STD_LOGIC;
            ledMode :    out STD_LOGIC
        );
    end component;
--------------------------------------------------------------------
    component DetectPress
        port (
            startStopCount : in STD_LOGIC;
            clock :          in STD_LOGIC;
            reset :          in STD_LOGIC;
            startStopEn :    out STD_LOGIC
        );
    end component;
--------------------------------------------------------------------
    component LedDriver
        port (
            reset:   in STD_LOGIC;
            clock:   in STD_LOGIC;
            ledMode: in STD_LOGIC;
            leds :   out bit_vector (15 downto 0)
        );
    end component;
--------------------------------------------------------------------
    component ConvertToInt
        port (
            switches :  in STD_LOGIC_VECTOR (6 downto 0);
            endTarget : out INTEGER RANGE 0 TO 99
        );
    end component;
--------------------------------------------------------------------
    signal countTime :   INTEGER RANGE 0 TO 99;
    signal timerMode :   STD_LOGIC;
    signal tensDigit:    std_logic_vector(3 downto 0);
    signal onesDigit:    std_logic_vector(3 downto 0);
    signal digit1 :      std_logic_vector(3 downto 0);
    signal digit0 :      std_logic_vector(3 downto 0);
    signal startStopEn : STD_LOGIC;
    signal endTarget :   INTEGER RANGE 0 TO 99;
    signal ledMode:      STD_LOGIC;
--------------------------------------------------------------------
begin
--------------------------------------------------------------------
    MY_SEGMENTS: SevenSegmentDriver port map (
        reset  => btnD,
        clock  => clk,
        digit3 => "0000",
        digit2 => "0000",
        digit1 => tensDigit,
        digit0 => onesDigit,
        blank3 => '1',
        blank2 => '1',
        blank1 => '0',
        blank0 => '0',
        sevenSegs => seg,
        anodes    => an
    );
--------------------------------------------------------------------
    BCD_CONVERTOR: BcdConvertor port map (
        tensDigit => tensDigit,
        onesDigit => onesDigit,
        countTime => countTime
    );
--------------------------------------------------------------------
    TIMERR: Timer port map (
        reset  => btnD,
        clock  => clk,
        timerMode => timerMode,
        countTime => countTime
    );
--------------------------------------------------------------------
    MODE_LOGIC: ModeLogic port map (
        reset  => btnD,
        clock  => clk,
        startStopEn => startStopEn,
        endTarget => endTarget,
        countTime => countTime,
        timerMode => timerMode,
        ledMode => ledMode
    );
--------------------------------------------------------------------
    DETECT_PRESS: DetectPress port map (
        reset  => btnD,
        clock  => clk,
        startStopCount  => btnC,
        startStopEn  => startStopEn
    );
--------------------------------------------------------------------
    LED_DRIVER: LedDriver port map (
        reset  => btnD,
        clock  => clk,
        ledMode  => ledMode,
        leds  => led
    );
--------------------------------------------------------------------
    CONVERT_TO_INT: ConvertToInt port map (
        switches  => sw,
        endTarget  => endTarget
    );
--------------------------------------------------------------------
end MyChip_ARCH;
