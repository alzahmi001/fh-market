//+-------------------------------------------------------------------------------------------+
//|                                                                                           |
//|                                  SonicR Access Panel.mq4                                  | 
//|                                                                                           |
//+-------------------------------------------------------------------------------------------+ 
#property copyright "Copyright @ 2014 traderathome, caveman, pips4life"
#property link      "email: traderathome@msn.com" 

/*---------------------------------------------------------------------------------------------
User Notes:

This indicator is coded to run on MT4 Build 600.

This SonicR Access Panel indicator has important changes from the SonicR Control Panel last
released on 05/25/2013.  A list of the changes can be found at the bottom of this overview.  

Remarks On the "Preface" Inputs-
You only need to be concerned with this section if you have selected to display PivotsTz or 
vLines at a time when there is no live data feed from your broker server (weekends/holidays). 
Broker time is required by the code that features PivotsTz and vLines.  When data feed is live
the broker time is available.  When data feed is not live it is not available and manually
input correct information must be used to compensate, hence, the two inputs in this section.
Do the following to get the correct "Broker_GMT_Offset" value to input.  While data feed is
live, temporarily add "GMT" and "Broker" to the Clock if the display does not already show
"G" and "B" in the labels.  Compare the +/- hours time difference between GMT and Broker time.
For example, if GMT is 11pm and broker time is 2am, then the difference is "3" hours.  if GMT 
is 1am and broker time is 9pm, then the difference is "-4" hours.  Enter the time difference  
as the "Broker_GMT_Offset".  PivotsTz and vLines will now function properly without live data 
by setting "Apply_it_now_because_no_feed" to "true".  When the data feed is live the indicator 
adjusts for broker server DST changes when they actually occur twice yearly, so during normal 
operation that "Apply_it_because_no_data_feed" is kept "false".  You must check your manual 
"Broker_GMT_Offset" input twice yearly (DST chaneovers on the broker server) and correct the 
manual input if the value has changed (+1, -1).  The default manual input is set to "0" for a 
broker server that is at GMT all year.  For such a broker server, there are no DST changeovers 
and no change is needed when there is no data feed. In other words, if your broker is at GMT 
all year around, then this setting will never require change.

Preview of the Displayed Panel and Other Indicator Features-
This indicator places two colored panels in the upper left corner of the chart, consisting of
a Market Panel and a Clock Panel.  For proper display chart/Properites/Common/Show OHLC should
be unchecked.  
   1. A market section containing: 
      (1) Symbol & Period:  The symbol for the currency pair and the chart TF. 
      (2) Spread: The difference (cost to trade) between the Ask and the Bid price. 
      (3) LotPip: The value of a full lot pip.
      (4) Ranges: the daily average range, and the range achieved for the day, 
      (5) Swaps: the long and the short swap rates, or (See option in the External Inputs)          
          Candle: The time remaining for the chart current TF bar.
      (6) Price:  The bid price of either currency or non-currency items.  For currencies,
          the last (fractional) digit can be set to appear smaller than the other digits.  
          The price changes color when the last full size digit reverses.
      (7) The "SonicR" logo.
   2. The Clock Panel:
      The Time Zone Clock displays the location and time for seven different time zones that 
      can be selected out of a list of time zones available.  The clock panel display can be 
      turned on/off.  It is also used during a time of live feed to determine the difference 
      between the broker server time and GMT, which is an input that must be entered manually 
      in the "Preface" section of the External Inputs.  If a time zone displayed happens to
      coincide with the broker server time, your local time, GMT, or the time zone selected 
      for the calculation of pivots (if pivots are displayed), an extension to the label will 
      include the designators: "B", "L", "G" and "P" so you do not have to waste lines to also 
      separately display the Broker, Local and GMT time zones. 
   
In addition to the two panel sections, this multi-function indicator provides the following
services, which are listed here, and more fully described below: 
   1. A special bid line.
   2. A background of level lines dividing the distance between whole numbers into quarters. 
   3. Daily or Fibonacci pivots, including mid-pivot lines.
   4. Average Range H/L lines for both the day and week.
   5. Day Separators. 
   6. Vertical lines at the Asian Open, London Open, New York Open, and London Close. 

1. Special Bid Line-
You can select to place your own Bid Ray Line on the chart, which you can vary in thickness 
and color.  The Bid Ray Line ends just beyond the current candle.  It terminates with a 
Bid Dot that can be sized and that changes color(example: grn/red) as the bid price changes
(up/dn).  To display only your own Bid Ray Line, right click on the chart and select 
Chart Properties/Colors.  Make the Grid color = "None", otherwise the MT4 bid line is going
to be beneath your own, and will be visible from the end of your line to the chart edge.  

2. Background Level Lines-
This indicator places level lines on your chart at key levels between whole numbers (00, 25,
50, 75 and 00 again).  The number of "sets" of these Whole, Half, and Quarter lines is fixed
by hard code for each TF chart.  The lines can individually be of any available color, style 
and width.  With Levels "On", the half and quarter levels can be turned On/Off individually.
The whole, half and quarter levels also have separate "Max_TF" settings, which you can set so 
the less significant Levels automatically cease to be displayed as you go up in chart TF.  
For some pairs (examples: EURTRY, USDTRY, XAUUSD) that have exceptionally high daily ranges 
the code is factored so the levels repeat not every 100 pips, but every 1,000 pips.

3. Daily and Fibonacci Pivots -
   A. Main Pivot Line
      You can select to display the main pivot (PVT) for the day.  It can be constructed 
      using two ines.  One can be a wide background line of a highlighting color and the  
      other can be a narrow top line of a darker color (Examples: Yellow & Gray respectively).
   B. Support & Resistance Lines-
      You can select to display the support and resistance pivot lines (SR) using either the 
      Daily or Fibonacci formulas.  The Fibonacci displays five levels.  Normally, the Daily 
      displays only three levels, but is extended to include five levels.  
   C. Broker or Time Zone Shifted Pivots
      You can display your broker server pivots, or you can select to display pivots based   
      on a different time zone (PivotsTz).  New coding fully automates the complexities of 
      PivotsTz, such as timing the hour shift for DST twice yearly, depending on when your 
      broker does that.  Your choice to use PivotsTz requires only three simple inputs-
      I.   "PivotsTz_On" 
           Set this equal to "true".  If "false", then broker server pivots are displayed.
      II.  "__Use_Preferred_Offset" 
           Set to "true" if you wish pivots displayed to be based on the Frankfurt time zone.
           if set to "false" the input for "__Alternative_GMT_Offset" will be used. 
      III. "__Alternative_GMT_Offset"
           This is your alternative choice of time zone location relative to GMT in +/- hours 
           (examples: for GMT use "0", for one time zone east of GMT use "1", and for four 
           time zones west of GMT use "-4"). 
      When pivots are displayed, "P" will show in the appropriate Clock label matching the
      time zone the pivots are based on.  Realize that by choosing PivotsTz, when the next
      PivotsTz day occurs during the broker server day, the PivotsTz lines will suddenly 
      change.   PivotsTz will display either "^", "<", or ">" in the labels for the lines.  
      By default, PivotsTz are set to the preferred Frankfurt time zone and will display "^" 
      in the labels.  If you select a PivotsTZ time zone less than the default "<" appears
      in the labels.  If you select a PivotsTZ time zone greater than the default ">" appears 
      in the labels.  Broker pivots display nothing extra in the labels. 

4. Range High/Low Lines for the Day and Week-
You can display two horizontal lines, one for the computed range high target, and one for 
the computed range low target. The range is based on the averaging period you select 
(defaults: day=15, week=13).  The special range averaging process for the Day range lines
skips any brief Sunday sessions of some brokers, which would drag the average down.  The 
Week range lines use the standard ATR formula since brief Sunday sessions do not much affect
the results.  
   A. Two conditions determine where range lines appear....
      1. Condition #1 - the Day/Week range has not exceeded the computed average range. 
         * The RDH/RWH line is the computed average range distance above the session Low.
         * The RDL/RWL line is the computed average range distance below the session high.  
         * The lines will move as new highs/lows are achieved during the session.  
         * This display shows how far price can move in either direction before exceeding
           the computed average range.  
      2. Condition #2 - the Day/Week range has exceeded the computed average range. 
         * If price swings during the day/week TF cause the difference between the high and
           the low to equal the computed range, the range lines lock into place.
         * This display will clearly show any subsequent breakout of the range.        
   B. The purpose of the range lines is to provide a perspective on how far PA might move 
      during the trading day or week.  This can be of some guidance in selecting where to 
      exit a trade.  A swing trader might pay more attention to the RWH/RWL lines, and hold
      a trade into oncoming days.  However, a day trader looking for quick profits and 
      limited exposure to market price swings might pay more attention to the RDH/RDL lines.

5. Day Separators-
You can apply day separators to your chart with this option.  It lets you select color 
and line styles.  You can elect to show separators just for today and/or for any number 
of previous days.

6. Vertical Time Lines-
You can select to display vertical time lines for the London Open, New York Open, and the
London Close, with the option to also show the Asian/Sydney Open and the Frankfurt Open.
New coding in this release properly places these vLines without any special inputs required
from the user because it determines all year around the GMT offsets of the broker server,
Sydney, Frankfurt, London and NYC.  And the coding takes into account any changes at these
locations due to DST/nonDST changeovers when they are implemented, even if at different times 
at each location.  This information is required to always have the vLines displayed on your
broker server chart at the places representing the proper local times in both London and NYC.
Separate External Inputs exist for control of the vLines for the Asian Open and the Frankfurt
Open.  Broker servers on GMT have very short partial days when the market opens for the week
such that maybe only the "Ao" line appears, providing little in the way of time perspective.
By using the External Inputs for "Ao" for both the current and the previous sessions you can
display the "Ao" from the previous Friday to create the missing perspective. 
   
Addtitional Remarks On Displaying Horizontal Lines and Labels-
The horizontal line groups can be displayed differently, using display numbers "1" and "2" in 
the section "Horizontal Lines Position Settings:"  If the selection number is outside the 1-2 
range it will default to "2".  The line groups are: Levels, PVT (central pivot), SRM (support, 
resistance and mid-pivots), and Range H/L lines for DAY/WK.   
   "1" - Fullscreen: draws the lines across the chart and positions labels mid-chart.  
   "2" - Session: draws the lines only thru the current session and positions labels at 
         the start of current session until that moves off-chart.  Then labels are
         positioned mid-chart.
   "3" - This is not a selectable option, but it is hard coded so that if the lines are set
         to display for the current session and the chart is switched to the DAY TF or higher,
         the lines will display 7 TFs to the right from the current candle. 
         
Additional Remarks on Displaying Horizontal Lines and vLines for Brokers at GMT-
Note that brokers at GMT will have a very short "extra" trading day, a brief two hours on 
Sunday (from 5pm EST to 7pm EST).  During this time, horizontal lines selected to display
per "2", will appear as they were on the previous Friday and remain at the levels for Friday
until the short Sunday period ends.  The short Sunday period is actually the last two hours 
of the Friday trading day.  The same goes for vLines.  They will appear during the short 
Sunday period as they were on the previous Friday.     

Changes from Control Panel release 07/16/2011 to Control Panel release 04-04-2012:
01 - Added back the time zone shifted pivots, this time including mid-pivots and fibonacci
     pivots.  New coding automatically determines broker server time shifts, replaces 
     the previous DST coding, and eliminates the need to input a "DST_Zone".
02 - Added back the vlines for market open times (Lc, Ny, Lc).  New coding automatically 
     determines their proper placement all year around regardless of DST considerations.
     Included is the ability to choose whether or not to display the vLine labels.
03 - Fixed #3 line display choice "Current session to right" so that it now works on all 
     TFs, not just those below H4.
04 - Added Week range lines with Max/Min TF to show, minor label placement adjustment for 
     slightly wide week range labels, and reordered codes for Week range, Day range, and
     Pivots to construct in that order.
05 - Fixed code for the display of ranges lines so now the Day range lines are correct on 
     Weekly and Monthly charts, and the Week range lines are correct on Monthly charts.
06 - Added subordination control of horizontal lines/labels (Levels always subordinated).     
07 - Fixed levels to properly display for additional symbols.      
08 - Automated the adjustment of "Display_4_Shift_Line_Right" when changing chart zoom, 
     provided choice of five shift right positions that can be used for indenting the 
     different catagories of horizontal lines/labels when using the "4" display choice, and
     included automatic indent shifting left of range lines for when pivot S&R lines are 
     turned on while range lines are set to same shift right position.          
09 - Housekeeping changes to levels and pivots labels, including making central pivot label 
     the same for Daily & Fib formula, removal of MaxRight override label positioning, and
     faster execution of labeling code in general.
10 - Recoded display of symbol in panel to strip broker added characters.
11 - Incorporated the separate SonicR Clock Panel indicator into this indicator with new
     coding automatically highlighting time zones matching your Broker and Local time.
12 - Revised the External Inputs accordingly.     

Changes from Control Panel release 04-04-2012 to Control Panel release 05-01-2012:
01 - Revised the code using imported time zone information to get broker, London, and NYC
     offsets from GMT (used for PivotsTz and vLines placement) to fix errant vLines at
     transitions between AM and PM hours. 
02 - Revised code for current session vLines to preclude stacking of these lines at the
     beginning of "tail end" Sunday sessions that some brokers have.
03 - Improved coding of daily range value.
        
Changes from Control Panel release 05-01-2012 to Control Panel release 05-25-2013:
01 - Changes to Panel.....
     * Added option to display or not display the Clock.
     * Added Swap Rates.
     * Enhanced the Bid price display and simplified coding to remove the necessity to 
       choose between forex 5-digit and outdated 4-digit modes.
     * Improved coding so Panel and Clock will always be on top of drawn chart lines.       
02 - Improvements to Bid Line display.....
     * Corrected error in bid line draw on lowest zoom setting and revised Bid line/dot 
       termination to be based on chart zoom setting, which is derived from either the
       SonicR Filled Dragon indicator or the SonicR PVA Candles indicator.
03 - Changes to Pivots display.....
     * Added ability to limit the number of SR levels drawn.      
04 - Substantial rework/simplification of horizontal lines features and label coding.....
     * Removed test for "Display_Number" of horizontal lines at startup.
     * Removed all but two line positioning options.
     * Removed labels for Levels, the Line Sets Override feature, and the option to
       position differently the individual Levels catagories.
     * Removed feature to display prices in line labels.
     * Moved Session display of labels one position to the right.
05 - Additions and improvements to range lines.....
     * Simplified basic coding.       
     * Revised Day and Week Range line coding so that if chart TF is >240 with the display 
       is set to "0" or "1", then display "2" is used with "0" shift so the lines are 
       drawn from current candle to chart right. 
     * Added "Min TF" for showing Ranges for Day.  
     * Revised Range Week label coding so even if set to display, it can be set to not 
       display on lower TFs if the Range Day labels are also set to not display.
     * Removed unneeded specialized label coding for wide Week labels.
06 - Additions to vLines.....
     * Corrected code for Separators & vLines (to the minute exactness).
     * Added Max_TF to show vLines of prior days so their display can terminate on a 
       different TF than for the current day vLines.
     * Added option to show "Ao" (Asian Open).                
07 - Housekeeping changes for ease of use or enhanced speed.....
     * Re-structured External Inputs with phraseology changes.
     * Removed voided coding artifacts from previous releases.
     * Employed "nesting" coding for conditions testing.
     * Eliminated processing time zone information not needed for "active" services.
      
Changes from Control Panel release 05-25-2013 to Access Panel release 03-17-2014: 
01 - Panel.....
     * Automated the transition between showing the bid for currency and non-currency items,
       incorporating the display of a smaller fractional pip for currencies and providing a
       shift input to adjust the position of the fractional pip, if required.
     * Added display of the value of a full lot pip.  
     * Added option to display either the value of Swaps or the Candle Time.   
     * Corrected error in pips range display for XAUUSD. 
     * Added option for the display of pair ID & TF.
02 - Clock.....
     * Revised code to show "P" in a label of the same time zone that has been selected
       for the Pivots calculation when Pivots are displayed. 
     * Corrected "ObjectMove" function error.          
02 - Bid Line.....
     * Corrected coding that places dot on MONTH chart.
     * Revised coding so line and dot will be "on top" of most other charting, with the
       dot on top of the line. 
03 - Levels.....
     * Enabled Levels for WEEK and MONTH time frames.  Included "Max_TF" to show for each
       Levels catagory: whole, half and quarter.         
04 - Pivots.....
     * Corrected coding that caused vLines to not properly display unless "PivotsTz_On"  
       was set to "true".
     * Added External Input to select "Preferred Pivots" based on Frankfurt time zone.
     * Added "<" and ">" to labels of PivotsTz showing if selected offset is less than or
       greater than "Preferred Pivots" which displays "^".  Standard broker server pivots
       have nothing added to the display.            
05 - Ranges.....
     * Corrected coding so if and when the average range is exceeded, the range lines lock 
       in at the current levels. 
     * Revised code to base on close price of previous Day/Week when determining current
       Day/Week hi/lo data, to include gapping as part of current range calculations.         
06 - Levels, Pivots & Range Lines.....
     * Revised coding so when chart is set to DAY TF or higher, "Session Only" lines that
       are "on" will display just seven TFs to the right from the current candle.
     * Revised For GMT broker on short Sunday session the horizontal "2" lines/labels will 
       back track to start at Friday open.        
07 - vLines.....
     * Revised display of vLines for GMT brokers at during their short Sunday session,
       which now shows as the completion of the previous Friday session (which it is).
     * Added option to show "F" (Frankfurt Open).
08 - Miscellaneous.....
     * Restructured External Inputs for simplification. 
     * Added prefix to name of non-Level lines to better control "on top" positioning.
     * Adjusted Poin for XAUUSD, EURTRY, USDTRY to improve function of Levels feature for
       these pairs by increasing the spacing.
     * Clears all drawn objects at start of each tick to assure proper displays. 

                                                                  - Traderathome, 03-17-2014                                                                  
----------------------------------------------------------------------------------------------
Acknowlegements:
CaveMan - who generously devoted his time and programming skills to produce the PivotsTz time 
          zone shift coding, designed to handle any situation involving gaps between trading 
          days and/or partial trading days.         
Kent    - for his "pips4life" P4L clock code to import and use time zone information. 

----------------------------------------------------------------------------------------------
Suggested Settings:          White Chart              Black Chart 

Panel Section-        
Panel_Background_Color       C'238,238,242            C'025,025,025'
Symbol_And_TF_Color          Black                    C'208,208,208'
Spread_Color                 C'080,080,080'           C'120,120,120'
Range_Color                  C'080,080,080'           C'120,120,120'
Swaps_Color                  C'080,080,080'           C'120,120,120'
Candle_Time_Color            C'080,080,080'           C'120,120,120'
Bid_UP_Color                 C'026,132,039'           C'046,188,046'
Bid_DN_Color                 Crimson                  C'234,000,000'
Bid_Last_Digit_Normal        C'140,140,140'           C'100,100,100'
Bid_Last_Digit_Small         C'040,040,040'           C'160,160,160'
sonicS                       C'040,040,255'           C'004,162,255'
sonicO                       C'111,111,255'           C'000,115,183'
SonicN                       C'170,170,255'           C'000,075,121' 
SonicI                       C'252,154,156'           C'138,000,000'
sonicC                       C'239,061,105'           C'176,000,000'
sonicR                       C'227,015,068'           C'221,000,000' 
smiley1                      Black                    C'255,255,100'
smiley2                      Black                    White
Smiley_Back_with_Clock       C'255,255,100'           C'025,025,025'
Smiley_Back_without_Clock    White                    C'025,025,025'
ID_TF_Background_for_Smiley  White                    C'025,025,025'

Bid Line Section-
Bid_Ray_Color                DarkGray                 C'100,100,100' 
Bid_Dot_Up_Color             C'036,187,070'           Lime
Bid_Dot_Dn_Color             C'240,032,084'           Red 

Horizontal Line Labels Section-
Line_Labels_Color            MidnightBlue             DarkGray    

Levels Section-
Whole_Number_Color           C'235,235,252'           C'041,033,073'         
Half_Number_Color            C'199,250,199'           C'000,053,000'              
Quarter_Number_Color         C'239,235,222'           C'043,033,019'  

Pivots Section-                              
DPV1_Back_Color              C'255,255,155'           CLR_NONE   
DPV2_Top_Color               DarkGray                 C'230,216,000' 
R_Pivot_Color                C'255,053,017'           C'179,000,000'
S_Pivot_Color                C'064,064,255'           C'090,075,173' 
MidPivot_Color               Olive                    C'085,085,000' 

Range Lines Section-
RDH_Color                    C'255,090,062'           Red
RDL_Color                    C'106,106,255'           C'000,115,230'
RWH_Color                    C'255,090,062'           Red
RWL_Color                    C'106,106,255'           C'000,115,230' 

Separators Section-
Separators_Color             BlueViolet               C'085,085,085'

vLines Section-
vLines_Color                 Silver                   C'060,060,000' 
vLabels_Color                MidnightBlue             Olive  
                    
Clock Section-
Clock_MktClosed              C'080,080,080'           C'120,120,120'
Location_MktClosed           C'080,080,080'           C'120,120,120'
Clock_MktOpen                C'133,084,035'           C'174,111,047'  
Location_MktOpen             C'000,149,034'           C'036,157,036'                                                                                                                                                                           
---------------------------------------------------------------------------------------------*/


//+-------------------------------------------------------------------------------------------+
//| Indicator Global Inputs                                                                   |                                                        
//+-------------------------------------------------------------------------------------------+ 
#property indicator_chart_window

#include <stdlib.mqh>
//See function documentation at http://msdn.microsoft.com/en-us/library/ms725473(VS.85).aspx
#import "kernel32.dll"
void GetLocalTime(int& LocalTimeArray[]);
void GetSystemTime(int& systemTimeArray[]);
int  GetTimeZoneInformation(int& LocalTZInfoArray[]);
bool SystemTimeToTzSpecificLocalTime(int& targetTZinfoArray[], 
     int& systemTimeArray[], int& targetTimeArray[]);
#import

//Global External Inputs-----------------------------------------------------------------------
extern bool   Indicator_On                          = true;
extern string Preface____________                   = "Get Broker_GMT_Offset w/Clock & live feed.";
extern int    Broker_GMT_Offset                     = 0;  
extern bool   Apply_it_now_because_feed_is_not_live = false;
extern string End_Preface________                   = "";
extern string _                               = "";
extern string Part_1                          = "Indicator Master Controls:";
extern bool   Show_Clock_in_Panel             = true; 
extern bool   Bid_Line_On                     = true;
extern bool   Levels_On                       = true;
extern bool   __Show_Half_Lines               = true;
extern bool   __Show_Quarter_Lines            = true;
extern int    __Levels_Whole_Max_TF           = 10080;
extern int    __Levels_Half_Max_TF            = 1440;
extern int    __Levels_Quarter_Max_TF         = 240;
extern bool   Pivots_PVT_On                   = true;
extern int    __PVT_Max_TF                    = 60;  
extern bool   Pivots_SR_On                    = true;
extern int    __Show_Levels_Thru_2345         = 5;
extern bool   __Show_MidPivots                = true; 
extern int    __SR_Max_TF                     = 60;  
extern bool   Pivots_Fibonacci                = false;
extern bool   PivotsTz_On                     = true;
extern bool   __Use_Preferred_Offset          = true;
extern int    __Alternative_GMT_Offset        = 0;
extern bool   Range_Day_On                    = true;
extern int    __Day_Min_TF                    = 1;
extern int    __Day_Max_TF                    = 240;
extern bool   Range_Week_On                   = true; 
extern int    __Week_Min_TF                   = 15; 
extern int    __Week_Max_TF                   = 240;
extern bool   Separators_On                   = false;
extern int    __Prior_Days_To_Show            = 5;
extern int    __Separators_Max_TF             = 60;
extern bool   vLines_On                       = true;
extern int    __Current_Session_Max_TF        = 60;
extern int    __Prior_Sessions_To_Show        = 0;
extern int    __Prior_Sessions_Max_TF         = 60;
extern bool   __Current_Session_Ao            = false;
extern bool   __Current_Session_Fo            = false;
extern string TF_Choices                      = "1-5-15-30-60-240-1440-10080-43200";
 
extern string __                              = "";
extern string Part_2                          = "Panel Settings:";
extern bool   Show_Chart_ID_and_TF            = true;
extern bool   Show_Forex_Fractional_Pip       = true;  
extern int    __Shift_Fractional_Pip          = 0; 
extern int    Digits_To_Show_In_Spread        = 2;
extern int    Days_In_Range_Day_Avg           = 15; 
extern int    Weeks_In_Week_ATR               = 13;
extern bool   Show_Swaps_vs_Candle_Time       = true;  
extern color  Panel_Background_Color          = C'025,025,025';
extern color  Symbol_And_TF_Color             = C'208,208,208';  
extern color  Spread_Color                    = C'120,120,120'; 
extern color  PipVal_Color                    = C'120,120,120'; 
extern color  Range_Color                     = C'120,120,120'; 
extern color  Swaps_Time_Color                = C'120,120,120'; 
extern color  Bid_UP_Color                    = C'046,188,046';
extern color  Bid_DN_Color                    = C'234,000,000';
extern color  Bid_Last_Digit_Normal           = C'100,100,100';
extern color  Bid_Last_Digit_Small            = C'160,160,160';  
extern color  sonicS                          = C'004,162,255';
extern color  sonicO                          = C'000,115,183';
extern color  sonicN                          = C'000,075,121';
extern color  sonicI                          = C'138,000,000';  
extern color  sonicC                          = C'176,000,000';    
extern color  sonicR                          = C'221,000,000'; 
extern color  smiley1                         = C'255,255,100';
extern color  smiley2                         = White;
extern color  Smiley_Back_with_Clock          = C'025,025,025'; 
extern color  Smiley_Back_without_Clock       = C'025,025,025'; 
extern color  ID_TF_Background_for_Smiley     = C'025,025,025'; 

extern string ___                             = "";
extern string Part_3                          = "Bid Line Settings:";
extern color  Bid_Ray_Color                   = C'100,100,100';
extern int    Bid_Ray_LineStyle_01234         = 0;  
extern int    Bid_Ray_Thickness               = 1;
extern color  Bid_Dot_Up_Color                = Lime;
extern color  Bid_Dot_Dn_Color                = Red;     
extern int    Bid_Dot_Size                    = 6;

extern string ____                            = "";
extern string Part_4                          = "Horizontal Lines Position Settings:";
extern string note_4_0                        = "Choose line display number.";
extern string note_4_1                        = "1 = Fullscreen";
extern string note_4_2                        = "2 = Session";
extern int    Levels_Display_Number           = 1;
extern int    Pivots_Display_Number           = 2;
extern int    Ranges_Display_Number           = 2;
extern bool   Subordinate_Lines               = true;

extern string _____                           = "";
extern string Part_5                          = "Horizontal Lines Labels Settings:";
extern bool   Pivot_PVT_Label_On              = true;
extern bool   Pivot_SRM_Labels_On             = true;
extern bool   Range_Labels_On                 = true;
extern color  Labels_Color                    = DarkGray;
extern string FontStyle                       = "Verdana";
extern int    FontSize                        = 7;
extern bool   Subordinate_Labels              = true;

extern string ______                          = "";
extern string Part_6                          = "Levels Settings:"; 
extern color  Level_Whole_Color               = C'041,033,073';   
extern int    Level_Whole_Style_01234         = 0;
extern int    Level_Whole_Width_12345         = 1;
extern color  Level_Half_Color                = C'000,053,000'; 
extern int    Level_Half_Style_01234          = 0;
extern int    Level_Half_Width_12345          = 1;
extern color  Level_Quarter_Color             = C'043,033,019'; 
extern int    Level_Quarter_Style_01234       = 0;
extern int    Level_Quarter_Width_12345       = 1;

extern string _______                         = "";
extern string Part_7                          = "Pivots Settings:"; 
extern color  PVT1_Back_Color                 = CLR_NONE;
extern int    PVT1_Style_01234                = 0;
extern int    PVT1_Width_12345                = 3; 
extern color  PVT2_Top_Color                  = C'230,216,000';
extern int    PVT2_Style_01234                = 0;
extern int    PVT2_Width_12345                = 1; 
extern color  R_Pivot_Color                   = C'179,000,000'; 
extern int    R_Style_01234                   = 2;
extern int    R_Width_12345                   = 1; 
extern color  S_Pivot_Color                   = C'090,075,173';
extern int    S_Style_01234                   = 2;
extern int    S_Width_12345                   = 1;
extern color  MidPivots_Color                 = C'085,085,000';
extern int    mP_Style_01234                  = 2;
extern int    mP_Width_12345                  = 1;

extern string ________                        = "";
extern string Part_8                          = "Range Day Settings:";
extern color  RDH_Color                       = Red;
extern color  RDL_Color                       = C'000,115,230';
extern int    RD_Style_01234                  = 0;    
extern int    RD_Width_12345                  = 1;

extern string _________                       = "";
extern string Part_9                          = "Range Week Settings:";
extern color  RWH_Color                       = Red;
extern color  RWL_Color                       = C'000,115,230';
extern int    RW_Style_01234                  = 0;    
extern int    RW_Width_12345                  = 2;

extern string __________                      = "";
extern string Part_10                         = "Separators Settings:";
extern color  Separators_Color                = C'085,085,085';  
extern int    Separators_Style_01234          = 2;    
extern int    Separators_Width_12345          = 1;
extern bool   Separators_Thru_SubWindows      = true;

extern string ___________                     = "";
extern string Part_11                         = "vLines & Labels Settings:";
extern color  vLines_Color                    = C'060,060,000';  
extern int    vLines_Style_01234              = 2;    
extern int    vLines_Width_12345              = 1;
extern bool   vLines_Thru_SubWindows          = false;
extern color  vLabels_Color                   = Olive;
extern bool   vLabels_On                      = true;
extern string vFontStyle                      = "Verdana";
extern int    vFontSize                       = 7; 

extern string ____________                    = "";
extern string Part_12                         = "Clock Settings:";
extern color  Clock_MktClosed                 = C'120,120,120';  
extern color  Location_MktClosed              = C'120,120,120';        
extern color  Clock_MktOpen                   = C'174,111,047';   
extern color  Location_MktOpen                = C'036,157,036';    
extern bool   Show_AMPM_Time                  = false;
extern string Note_12_1                       = "Choosing Locations to Display:";
extern string Note_12_2                       = "Select 7 maximum from list,";
extern string Note_12_3                       = "0 = display off.";
extern string Note_12_4                       = "1 = Display on.";
extern int    Broker                          = 0;
extern int    Local                           = 0; //Your computer's time.
extern int    Auckland                        = 0;
extern int    Sydney                          = 1;
extern int    Tokyo                           = 1;
extern int    HongKong                        = 1;
extern int    Jakarta                         = 0;
extern int    India                           = 0;
extern int    Dubai                           = 0;
extern int    Moscow                          = 0;
extern int    Israel                          = 0;
extern int    Helsinki                        = 1;
extern int    Frankfurt                       = 1;
extern int 	  London                          = 1; //DST London=GMT+1, NonDST London=GMT
extern int    GMT                             = 0; //No change btwn DST/summer & NonDST/winter
extern int    Brazil                          = 0;
extern int    NewYork                         = 1;
extern int    Central                         = 0;
extern int    Mexico                          = 0;
extern int    Mountain                        = 0;
extern int    Pacific                         = 0;

//Buffers, Constants and Variables-------------------------------------------------------------
bool          Deinitialized;

//Deinit
int           obj_total,k;
string        name;

//Panel
color         Static_Price_Color, Static_Bid_Color, Bid_Dot_Color, Static_Bid_Dot_Color;
double        Poin, Poin2,New_Price,Old_Price,level,Spread,ARg,RangeAchieved,dRG,dRange,wRange;
double        pipValue;
int           Chart_Scale,modifier,Color,Factor,G,h,i,l,m,s,t,LP,LS,T1,T2; 
string        item01 = "z[CP Panel] Box 1";  
string        item02 = "y[CP Panel] Box 2"; 
string        item03 = "z[CP Text] ID&TF";
string        item04 = "z[CP Text] Spread";
string        item05 = "z[CP Text] Spread2";
string        item06 = "z[CP Text] Pip";
string        item07 = "z[CP Text] Pip2";
string        item08 = "z[CP Text] Range";
string        item09 = "z[CP Text] Range2";
string        item10 = "z[CP Text] Swap";
string        item11 = "z[CP Text] Swap2"; 
string        item12 = "z[CP Text] Price1";
string        item13 = "z[CP Text] Price2";
string        item14 = "z[CP Text] Logo1 S"; 
string        item15 = "z[CP Text] Logo1 o"; 
string        item16 = "z[CP Text] Logo1 n";     
string        item17 = "z[CP Text] Logo1 i"; 
string        item18 = "z[CP Text] Logo1 c";
string        item19 = "z[CP Text] Logo1 R"; 
string        item20 = "d[CP Bid] Bid Line";
string        item21 = "e[CP Bid] Bid Dot";
string        item22 = "z[CP Text] Smiley1";
string        item23 = "z[CP Text] Smiley2";
string        ID,Price,C,tab,tab1,timeleft; 

//Levels
color         linecolor;
double        linelevel, linestyle, linewidth, BL;
int           j,Line1_Color, Line2_Color, Line3_Color; 
int           u1=00, u2=50, u3=25, u4=75;        
int           v1, ssp, ssp1, NumberOfRanges;
string        linename;

//Pivots
datetime      pvtDT;
double        p,d,q,r1,r2,r3,r4,r5,s1,s2,s3,s4,s5;   
double        today_high, today_low, yesterday_high, yesterday_open, 
              yesterday_low, yesterday_close; 
int           Pdisplay,idxfirstbaryesterday,idxlastbaryesterday,idxfirstbartoday,idxbar,
              tzdiff,tzdiffsec,barsperday,dayofweektoday,dayofweektofind,Pivots_GMT_Offset;                                       
string        prefix;

//Range Day
datetime      d1, d2;
double        dRangeHigh,dRangeLow,HiToday,LoToday,dRH,dRL;
int           ii,iii,x,xx,r,dtf,Hbarshift,Lbarshift,rdc,rwc,Rdisplay,RDshift;

//Range Week
datetime      w1, w2;
double        HiWeek, LoWeek;
double        wRangeAvg, wRangeHigh, wRangeLow, wRH, wRL;
int           wtf, wHbarshift, wLbarshift, RWdisplay, RWshift;

//Horizontal Lines Placement
datetime      startline, stopline;
int           a,b,c,R2,T,T4;  
string        line, dt;

//Horizontal Labels Placement
datetime      startlabel; 
string        label, spc;

//vLines & Labels
bool          vLabels_Chart_Top      = true; 
datetime      shift, T3;
double        top, bottom, scale,YadjustTop,YadjustBot,vLabels_Dist_Above_Border,time2,time4;
int           bps, MF,time3;
int           vLabels_Dist_To_Border   = 1;
string        vline,vlabel;
string        vLabels_Asian_Open       = "      Ao ";
string        vLabels_Berlin_Open      = "     F  ";
string        vLabels_London_Open      = "      Lo";
string        vLabels_NewYork_Open     = "     Ny";
string        vLabels_London_Close     = "      Lc ";
string        Label_Day_Separator      = "day";       

//Get GMT Offsets in Support of PivotsTz and Market vLines                    
int           GMT_Ref_Time, Sydney_GMT_Offset, Berlin_GMT_Offset, London_GMT_Offset, 
              NYC_GMT_Offset, GMT_At_Lo, GMT_At_NYo, GMT_At_Lc, GMT_At_Ao, GMT_At_Fo; 

//Import Time Zone Data in Support of Clock, PivotsTz and Market vLines
bool          BKR_UTC_Match, FLAG_static_broker, Displaying_Pivots;
datetime      Local_Time,BrokerDT,AucklandDT,SydneyDT,TokyoDT,ChinaDT,JakartaDT,IndiaDT,
              DubaiDT,MoscowDT,IsraelDT,HelsinkiDT,BerlinDT,LondonDT,UTC,BrazilDT,NewYorkDT,
              CentralDT,MexicoDT,MountainDT,PacificDT,StaticBrokerDT;
int           ClockFontSize, TimezoneFontSize, LineSpacing, z, time, place, offset;              
int           AucklandTZInfoArray[43],SydneyTZInfoArray[43],TokyoTZInfoArray[43],
              ChinaTZInfoArray[43],JakartaTZInfoArray[43],IndiaTZInfoArray[43],
              DubaiTZInfoArray[43],MoscowTZInfoArray[43],IsraelTZInfoArray[43],
              HelsinkiTZInfoArray[43],BerlinTZInfoArray[43],LondonTZInfoArray[43],
              BrazilTZInfoArray[43],NewYorkTZInfoArray[43],CentralTZInfoArray[43],
              MexicoTZInfoArray[43],MountainTZInfoArray[43],PacificTZInfoArray[43],
              LocalTZInfoArray[43];          
int           LocalTimeArray[4],systemTimeArray[4],AucklandTimeArray[4],SydneyTimeArray[4],
              TokyoTimeArray[4],ChinaTimeArray[4],JakartaTimeArray[4],IndiaTimeArray[4],
              DubaiTimeArray[4],MoscowTimeArray[4],IsraelTimeArray[4],HelsinkiTimeArray[4],
              BerlinTimeArray[4],LondonTimeArray[4],BrazilTimeArray[4],NewYorkTimeArray[4],
              CentralTimeArray[4],MexicoTimeArray[4],MountainTimeArray[4],PacificTimeArray[4];         
string        Locals,Brokers,Aucklands,Sydneys,Tokyos,Chinas,Jakartas,Indias,Dubais,
              Moscows,Israels,Helsinkis,Berlins,Londons,UTCs,Brazils,NewYorks,Centrals,
              Mexicos,Mountains,Pacifics;           
string        Brokerp, Localp, Aucklandp, Sydneyp, Tokyop, Chinap, Jakartap,  
              Indiap, Dubaip, Moscowp, Israelp, Helsinkip, Berlinp, Londonp, UTCp, 
              Brazilp, NYp, Centralp, Mexicop, Mountainp, Pacificp, FontName; 
string        timeStr,LocalTimeS,sMonth,sDay,sHour,sMin,sSec;
int           hour,nYear,nMonth,nDay,nHour,nMin,nSec,nMilliSec;  
                      
//Clock - Normal hrs 8-17 (9 hrs), Sydney 9-18 (9 hrs) and Tokyo 9-18 (9 hrs)   
int           LocalOpenHour        =  8;    
int           LocalCloseHour       = 17;
int           SydneyLocalOpenHour  =  9;       
int           SydneyLocalCloseHour = 18;
int           TokyoLocalOpenHour   =  9;        
int           TokyoLocalCloseHour  = 18; 
         
//+-------------------------------------------------------------------------------------------+
//| Indicator Initialization                                                                  |                                                        
//+-------------------------------------------------------------------------------------------+      
int init()
  {
  //With the first DLL call below, the program will exit (and stop) automatically after one alert. 
  if(!IsDllsAllowed() ) 
    { 
    Alert(Symbol()," ",Period(),": Access Panel: Allow DLL Imports"); return(false);  
    }
  //Determine the current chart scale (chart scale number should be 0-5)
  Chart_Scale = ChartScaleGet();
  
  //Reset to Signal State of Non-deinitialization 
  Deinitialized = false;
       
  //Panel - determine display of Market Price            
  if(Digits == 5 || Digits == 3) {Factor = 10;} 
  else {Factor = 1;} //cater for 5 digits 

  //Panel and Levels - Check for unconventional Point digits number. 
  Poin2 = Point; 
  if (Point == 0.00001) {Poin = 0.0001;} //5 digits     
  else {if (Point == 0.001) {Poin = 0.01;} //3 digits
  else {Poin = Point;}} //Normal 4 digits       
  if (StringSubstr(Symbol(),0,6) == "XAUUSD") {Poin = 0.1;} 
  else {if (StringSubstr(Symbol(),0,6) == "EURTRY") {Poin = 0.001;}  
  else {if (StringSubstr(Symbol(),0,6) == "USDTRY") {Poin = 0.001;}     
  else {if (StringSubstr(Symbol(),0,6) == "USDMXN") {Poin = 0.001;}
  else {if (StringSubstr(Symbol(),0,6) == "USDCZK") {Poin = 0.001;} }}}}  

  //Levels - set ranges for chart TFs 
        if(Period() == 1) {NumberOfRanges = 4;}
  else {if(Period() == 5) {NumberOfRanges = 7;}
  else {if(Period() == 15) {NumberOfRanges = 15;}
  else {if(Period() == 30) {NumberOfRanges = 15;}   
  else {if(Period() == 60) {NumberOfRanges = 20;}  
  else {if(Period() == 240) {NumberOfRanges = 30;}  
  else {if(Period() == 1440) {NumberOfRanges = 60;} 
  else {if(Period() == 10080) {NumberOfRanges = 70;}
  else {if(Period() == 43200) {NumberOfRanges = 60;} }}}}}}}}

  //Import Time Zone Data  required for PivotsTZ and vLines      
  StaticBrokerDT = TimeCurrent();           
  Get04TimeZoneInfo(SydneyTZInfoArray, BerlinTZInfoArray, 
    LondonTZInfoArray, NewYorkTZInfoArray); 
   
  //Clock - Import rest of Time Zone Data required, and make Clock Labels   
  if(Show_Clock_in_Panel) 
    {   
    Get14TimeZoneInfo(AucklandTZInfoArray, TokyoTZInfoArray, 
    ChinaTZInfoArray, JakartaTZInfoArray, IndiaTZInfoArray, 
    DubaiTZInfoArray, MoscowTZInfoArray, IsraelTZInfoArray, 
    HelsinkiTZInfoArray, BrazilTZInfoArray, CentralTZInfoArray, 
    MexicoTZInfoArray, MountainTZInfoArray, PacificTZInfoArray);      
    }
    
  return(0);
  }

//+-------------------------------------------------------------------------------------------+
//| Indicator De-initialization                                                               |                                                        
//+-------------------------------------------------------------------------------------------+       
int deinit()
  {   
  obj_total= ObjectsTotal();  
  for(k= obj_total; k>=0; k--)
    {
    name= ObjectName(k);
    if(StringSubstr(name,0,3)=="[CP" || StringSubstr(name,1,3)=="[CP") {ObjectDelete(name);} 
    }
  //Comment("");
  return(0);
  }

//+-------------------------------------------------------------------------------------------+
//| Indicator Start                                                                           |                                                        
//+-------------------------------------------------------------------------------------------+         
int start()
  {
  //If Indicator is "Off" deinitialize only once, not every tick-------------------------------  
  if(!Indicator_On) 
    {
    if (!Deinitialized) {deinit(); Deinitialized = true;}
    return(0);
    }
            
  //If indicator is "ON" delete all objects----------------------------------------------------
  obj_total= ObjectsTotal();  
  for(k= obj_total; k>=0; k--)
    {
    name= ObjectName(k);    
    if(StringSubstr(name,0,3)=="[CP" || StringSubstr(name,1,3)=="[CP") {ObjectDelete(name);} 
    }
      
  //Levels-------------------------------------------------------------------------------------
  if(Levels_On && Period()<= __Levels_Whole_Max_TF)
    {
    if(Period()>240 && Levels_Display_Number== 2) {Levels_Display_Number= 3;}       
    //define needed variables
    ssp1= Bid/Poin;  //bid w/o the decimal 
    v1=ssp1%100; //last two significant digits   
    BL=v1; //last two significant digits of starting/reference bid line  
       
    //calculate line levels bottom to top
    for(j= -(100-(100-BL))-(100*NumberOfRanges); j<= (100-BL)+(100*NumberOfRanges); j++)       
      {
      ssp=ssp1+j; 
      v1=ssp%100;        
      if(v1==u1)
        {           
        linelevel = ssp*Poin;
        DrawLines("LVL", Levels_Display_Number, linelevel, Level_Whole_Color, 
        Level_Whole_Style_01234, Level_Whole_Width_12345);
        }
      else {if((__Show_Half_Lines && Period()<= __Levels_Half_Max_TF) && (v1==u2))
        {              
        linelevel = ssp*Poin;
        DrawLines("LVL", Levels_Display_Number, linelevel, Level_Half_Color, 
        Level_Half_Style_01234, Level_Half_Width_12345);
        } 
      else {if((__Show_Quarter_Lines && Period()<= __Levels_Quarter_Max_TF) && ((v1==u3) || (v1==u4)))
        {           
        linelevel = ssp*Poin;                        
        DrawLines("LVL", Levels_Display_Number, linelevel, Level_Quarter_Color, 
        Level_Quarter_Style_01234, Level_Quarter_Width_12345);
        } }}
      }
    }//End Levels         
                         
  //Daily Pivot Lines--------------------------------------------------------------------------  
  if((Pivots_PVT_On && Period()<= __PVT_Max_TF ) || 
    (Pivots_SR_On && Period()<= __SR_Max_TF))             
    {   
    //CaveMan's sophisticated Tz shift code finds out which hour bars start "today" and 
    //"yesterday" in the time zone selected for the pivots calculations.  The Tz code needs 
    //"tzdiff", which is the direction and number of hours offset from "Broker_GMT_Offset",
    //to start the process.  Unless the broker server is permanently at GMT, it will vary in
    //offset to GMT depending if it is the DST or non-DST time of the year.  Getting the 
    //proper DST/non-DST "Broker_GMT_Offset" is already handled by other coding. Specifically, 
    //the "tzdiff", is used by the Tz shift code to shift away from the broker server hour bar
    //that starts the current day, thus defining the start of the current time zone shifted
    //day.  Then this time zone shifted start of day is used to find the start and end of the 
    //previous time zone shifted day, which is the day used for the TzPivots calculations.
    
    //Define tzdiff
    if(!PivotsTz_On) {tzdiff = 0;}     
    else {tzdiff = Broker_GMT_Offset-Pivots_GMT_Offset;}

    //Send Items to the PivotsTz coding subroutine                       
    TzShift(tzdiff,idxfirstbartoday, idxfirstbaryesterday,idxlastbaryesterday);

    //Walk forward through yestday's start and collect high/lows within the same day
    yesterday_high= -99999;  // not high enough to remain alltime high
    yesterday_low=  +99999;  // not low enough to remain alltime low 
    for(idxbar= idxfirstbaryesterday; idxbar>=idxlastbaryesterday; idxbar--)
      {
      // grab first value for open
      if (yesterday_open==0) yesterday_open= iOpen(NULL, PERIOD_H1, idxbar);      
      yesterday_high= MathMax(iHigh(NULL, PERIOD_H1, idxbar), yesterday_high);
      yesterday_low= MathMin(iLow(NULL, PERIOD_H1, idxbar), yesterday_low);      
      yesterday_close= iClose(NULL, PERIOD_H1, idxbar);
      }
         
    d = (today_high - today_low);
    q = (yesterday_high - yesterday_low);
    p = (yesterday_high + yesterday_low + yesterday_close) / 3;                          
     
    if (Pivots_Fibonacci) {prefix = "F";}
    else {prefix = "D";} 
               
    if(Pivots_SR_On)
      {       
      if(Pivots_Fibonacci)
        {
        r5 = p+ (q * 2.618);
        r4 = p+ (q * 1.618);
  	     r3 = p+q;  
        r2 = p+ (q * 0.618); 
        r1 = p+ (q * 0.382); 
        s1 = p- (q * 0.382);     
        s2 = p- (q * 0.618);    
  	     s3 = p-q; 
        s4 = p- (q * 1.618);
        s5 = p- (q * 2.618);  
        }
      else   
        {
        r5 = (4*p)+(yesterday_high-(4*yesterday_low));
        r4 = (3*p)+(yesterday_high-(3*yesterday_low));
        r3 = (2*p)+(yesterday_high-(2*yesterday_low));
        r2 = p+(yesterday_high - yesterday_low);  //r2 = p-s1+r1;
        r1 = (2*p)-yesterday_low;  
        s1 = (2*p)-yesterday_high;
        s2 = p-(yesterday_high - yesterday_low);  //s2 = p-r1+s1;
        s3 = (2*p)-((2* yesterday_high)-yesterday_low);
        s4 = (3*p)-((3* yesterday_high)-yesterday_low);
        s5 = (4*p)-((4* yesterday_high)-yesterday_low);
        }                
      }
                 
    //Daily Central Pivot Line 
    if(Pivots_PVT_On && Period()<= __PVT_Max_TF )
      {
      if(Period()>240 && Pivots_Display_Number== 2) {Pdisplay = 3;} 
      else {Pdisplay= Pivots_Display_Number;}              
      //Pivot Line data to subroutine                                                               
      DrawLines("PVT1", Pdisplay, p, PVT1_Back_Color, 
      PVT1_Style_01234, PVT1_Width_12345);
      DrawLines("PVT2", Pdisplay, p, PVT2_Top_Color, 
      PVT2_Style_01234, PVT2_Width_12345);         
      }
      
    //Daily Support & Resistance Lines   
    if(Pivots_SR_On && Period()<= __SR_Max_TF)
      {
      if(Period()>240 && Pivots_Display_Number== 2) {Pdisplay= 3;} 
      else {Pdisplay= Pivots_Display_Number;}    
      DrawLines(prefix+"R1", Pdisplay, r1, R_Pivot_Color, 
      R_Style_01234, R_Width_12345);   
      DrawLines(prefix+"R2", Pdisplay, r2, R_Pivot_Color, 
      R_Style_01234, R_Width_12345); 
      DrawLines(prefix+"S1", Pdisplay, s1, S_Pivot_Color, 
      S_Style_01234, S_Width_12345);
      DrawLines(prefix+"S2", Pdisplay, s2, S_Pivot_Color, 
      S_Style_01234, S_Width_12345);          
      if(__Show_Levels_Thru_2345 >= 3) {
      DrawLines(prefix+"R3", Pdisplay, r3, R_Pivot_Color, 
      R_Style_01234, R_Width_12345);         
      DrawLines(prefix+"S3", Pdisplay, s3, S_Pivot_Color, 
      S_Style_01234, S_Width_12345); }
      if(__Show_Levels_Thru_2345 >= 4) {
      DrawLines(prefix+"R4", Pdisplay, r4, R_Pivot_Color, 
      R_Style_01234, R_Width_12345);          
      DrawLines(prefix+"S4", Pdisplay, s4, S_Pivot_Color, 
      S_Style_01234, S_Width_12345); }
      if(__Show_Levels_Thru_2345 == 5) {           
      DrawLines(prefix+"R5", Pdisplay, r5, R_Pivot_Color, 
      R_Style_01234, R_Width_12345);        
      DrawLines(prefix+"S5", Pdisplay, s5, S_Pivot_Color, 
      S_Style_01234, S_Width_12345); }             
      }
    //Mid-Pivots
    if(__Show_MidPivots && Period()<= __SR_Max_TF) 
      {
      if(Period()>240 && Pivots_Display_Number== 2) {Pdisplay= 3;}
      else {Pdisplay= Pivots_Display_Number;}        
      DrawLines("MR1", Pdisplay, (p+r1)/2,  MidPivots_Color, 
      mP_Style_01234, mP_Width_12345);
      DrawLines("MR2", Pdisplay, (r1+r2)/2, MidPivots_Color, 
      mP_Style_01234, mP_Width_12345);
      DrawLines("MS1", Pdisplay, (p+s1)/2,  MidPivots_Color, 
      mP_Style_01234, mP_Width_12345);
      DrawLines("MS2", Pdisplay, (s1+s2)/2, MidPivots_Color, 
      mP_Style_01234, mP_Width_12345);
      if(__Show_Levels_Thru_2345 >= 3) {
      DrawLines("MR3", Pdisplay, (r2+r3)/2, MidPivots_Color, 
      mP_Style_01234, mP_Width_12345);     
      DrawLines("MS3", Pdisplay, (s2+s3)/2, MidPivots_Color, 
      mP_Style_01234, mP_Width_12345); }  
      if(__Show_Levels_Thru_2345 >= 4) {      
      DrawLines("MR4", Pdisplay, (r3+r4)/2, MidPivots_Color, 
      mP_Style_01234, mP_Width_12345);             
      DrawLines("MR4", Pdisplay, (s3+s4)/2, MidPivots_Color, 
      mP_Style_01234, mP_Width_12345); }
      if(__Show_Levels_Thru_2345 == 5) {       
      DrawLines("MR5", Pdisplay, (r4+r5)/2, MidPivots_Color, 
      mP_Style_01234, mP_Width_12345);
      DrawLines("MS5", Pdisplay, (s4+s5)/2, MidPivots_Color, 
      mP_Style_01234, mP_Width_12345); }
      }                             
    }//End Daily Pivots
    
  //Range Day High/Low lines-------------------------------------------------------------------        
 if(Range_Day_On && Period()<= __Day_Max_TF && Period()>= __Day_Min_TF)
    {       
    //Calculate level of RDH/RDL lines when current range has not exceeded the average range
    //Note: Day range hi/lo/range data is calculated in Panel section. 
    if(HiToday - LoToday <= dRange) 
      {       
      dRangeHigh = LoToday + dRange;  
      dRangeLow  = HiToday - dRange; 
      }
    //Calculate position of RDH/RDL lines when current range exceeds average.  If LOD comes
    //first (higher shift#), LOD is RDL and RDH is at the average range above it.  If HOD
    //comes first (higher shift#), HOD is RDH and RDL is the average range below it.       
    else
      {               
      //Define start of day (d1), current time (d2) and time span difference (in chart bars)
      d1 = iTime(NULL,1440,0);
      d2 = Time[0];
      dtf = (d2-d1)/Period()/60; 
      //Search back the number of minute bars for the shift numbers of the day H/L bars
      Hbarshift  = iHighest(NULL,0,MODE_HIGH,dtf,0); 
      Lbarshift  = iLowest(NULL,0,MODE_LOW,dtf,0); 
      if(Lbarshift > Hbarshift) 
        {
        dRangeLow= LoToday; 
        dRangeHigh= LoToday + dRange;
        }
      else
        {
        dRangeHigh= HiToday; 
        dRangeLow= HiToday - dRange;
        }             
      }                         
    //Range Lines data to subroutine      
    if(Period()>240 && Ranges_Display_Number== 2) {Rdisplay= 3;} 
    else {Rdisplay= Ranges_Display_Number;}                                                                                    
    DrawLines("RDH", Rdisplay, dRangeHigh, RDH_Color, 
    RD_Style_01234, RD_Width_12345);   
    DrawLines("RDL", Rdisplay, dRangeLow,  RDL_Color, 
    RD_Style_01234, RD_Width_12345);         
    }//End Range Day
    
  //Range Week High/Low lines-----------------------------------------------------------------
  if(Range_Week_On && Period()<= __Week_Max_TF && Period()>= __Week_Min_TF)
    {  
    //Define Week ATR
    wRange = iATR(NULL, 10080, Weeks_In_Week_ATR, 0);
    //Define Week bar H/L data, which includes the close price of previous week
    if(iClose(NULL,10080,1) > iHigh(NULL,10080,0)) {HiWeek = iClose(NULL,10080,1);}
    else {HiWeek = iHigh(NULL,10080,0);}
    if(iClose(NULL,10080,1) < iLow(NULL,10080,0)) {LoWeek = iClose(NULL,10080,1);}
    else {LoWeek = iLow (NULL,10080,0);} 
	 //Calculate position of RWH/RWL lines when current range has not exceeded the average
	 if(HiWeek - LoWeek <= wRange)
      {      
      wRangeHigh = LoWeek + wRange;  
      wRangeLow  = HiWeek - wRange; 
      }    
    //Calculate position of RWH/RWL lines when current range exceeds average.  If Low of Week
    //comes first (higher shift#), Low of Week is RWL and RWH is at the average range above it.  
    //If High of Week comes first (higher shift#), High of Week is RWH and RWL is the average 
    //range below it.          
    else //if(HiWeek - LoWeek > wRange)
      {         
      //Define start of week (w1), current time (w2) and time span difference (in chart bars)        
	   w1 = iTime(NULL,10080,0);  
      w2 = Time[0];     
      wtf = (w2-w1)/(Period()*60);      
      //Search back the number of minute bars for the shift numbers of the week H/L bars	 
      wHbarshift = iHighest(NULL,0,MODE_HIGH,wtf,0); 
	   wLbarshift = iLowest(NULL,0,MODE_LOW,wtf,0); 	
      if(wLbarshift > wHbarshift){wRangeLow= LoWeek; wRangeHigh= LoWeek + wRange;}
      else {wRangeHigh = HiWeek; wRangeLow = HiWeek - wRange;}        
      }                
    //Range Lines data to subroutine    
    if(Period()>240 && Ranges_Display_Number== 2) {Rdisplay= 3;}
    else {Rdisplay= Ranges_Display_Number;}                                                               
    DrawLines("RWH", Rdisplay, wRangeHigh, RWH_Color, 
    RW_Style_01234, RW_Width_12345);   
    DrawLines("RWL", Rdisplay, wRangeLow,  RWL_Color, 
    RW_Style_01234, RW_Width_12345);
    }//End Range Week
           
  //Bid Line----------------------------------------------------------------------------------- 
  if(Bid_Line_On)
    {                                
    //Set T2                    
    T2=Time[0];
    //Set T1                     
          if(Chart_Scale == 0) {T1=Time[0]+(Period()*60*8);}              
    else {if(Chart_Scale == 1) {T1=Time[0]+(Period()*60*4);}   
    else {if(Chart_Scale == 2) {T1=Time[0]+(Period()*60*2);}
    else {if(Chart_Scale == 3) {T1=Time[0]+(Period()*60*1);}
    else {if(Chart_Scale == 4) {T1=Time[0]+(Period()*60*1);}
    else {if(Chart_Scale == 5) {T1=Time[0]+(Period()*60*1);} }}}}}    
    if(Period() == 43200) {T1=T1+(Period()*60*1);}
    //Bid line   
    ObjectCreate(item20, OBJ_TREND, 0, T1, Bid, T2, Bid);     
    ObjectSet(item20, OBJPROP_STYLE, Bid_Ray_LineStyle_01234 );
    ObjectSet(item20, OBJPROP_COLOR, Bid_Ray_Color);
    ObjectSet(item20, OBJPROP_WIDTH, Bid_Ray_Thickness);               
    //Bid dot                   
    ObjectCreate(item21, OBJ_TREND, 0, T1, Bid, T1, Bid);     
    ObjectSet(item21, OBJPROP_STYLE, 0);
    ObjectSet(item21, OBJPROP_COLOR, Bid_Dot_Color);
    ObjectSet(item21, OBJPROP_WIDTH, Bid_Dot_Size);                      
    }//End Bid Line
        
  //Up/down color selection when bid price changes--------------------------------------------- 
  //"Price" is the full-digits in all applications, and is the Bid price displayed. 
  //"New_Price" is the full-digits minus the last digit for forex application and is the full
  //digits for non-forex applications, and controls when the displayed Bid price changes color.      
  if(Digits > 2) 
    {
    New_Price = MathFloor(Bid/Poin)*Poin;  
    }         
  else 
    {
    New_Price = Bid;
    }                  
  if(New_Price > Old_Price) 
    {
    Color = Bid_UP_Color;
    Static_Price_Color = Color;     
    Bid_Dot_Color = Bid_Dot_Up_Color;       
    Static_Bid_Dot_Color = Bid_Dot_Up_Color;   
    }
  else {if (New_Price < Old_Price) 
    {      
    Color = Bid_DN_Color; 
    Static_Price_Color = Color;  
    Bid_Dot_Color = Bid_Dot_Dn_Color;  
    Static_Bid_Dot_Color = Bid_Dot_Dn_Color;  
    }   
  else //if (New_Price == Old_Price)  
    {
    Color = Static_Price_Color;       
    Bid_Dot_Color = Static_Bid_Dot_Color;
    } }
  Old_Price = New_Price;
      
  //Panel--------------------------------------------------------------------------------------
  if(Show_Clock_in_Panel) 
    {
    G = 124; //setting background width
    if(Show_AMPM_Time) //shift to right to accomodate extra time characters
      {                
      place= 232; //shift location right, 196
      G= 142;
      }   
    //Background box 2  
    MakeLabel( item02, G, 0);    
    ObjectSetText(item02, "gg", 64, "Webdings", Panel_Background_Color);
    }  
      
  //Background box 1 
  MakeLabel( item01, 0, 0); 
  ObjectSetText(item01, "gg", 64, "Webdings", Panel_Background_Color); 

  //Symbol and Time Frame
  if(Show_Chart_ID_and_TF) 
    {
    MakeLabel( item03, 0,2); 
    ID = StringSubstr(Symbol(), 0, 6);        	 	         
    C = " "; if (Period()== 1)     C =C +  "    "+ID+"   M1";
       else {if (Period()== 5)     C =C +  "    "+ID+"   M5";
       else {if (Period()== 15)    C =C +  "   " +ID+"   M15";
       else {if (Period()== 30)    C =C +  "   " +ID+"   M30";
       else {if (Period()== 60)    C =C +  "    "+ID+"   H1";
       else {if (Period()== 240)   C =C +  "    "+ID+"   H4";
       else {if (Period()== 1440)  C =C +  "    "+ID+"   Day";
       else {if (Period()== 10080) C =C +  "   " +ID+"   Week";
       else {if (Period()== 43200) C =C +  "  "  +ID+"   Month"; }}}}}}}} 
    ObjectSetText(item03, C, 11, "Arial Bold", Symbol_And_TF_Color); 
    }   
  else
    {
    //Background of MT4 Pair ID & TF Label    
    MakeLabel( item03, 13,0);
    ObjectSetText(item03, "gggggggggggg", 7, "Webdings", ID_TF_Background_for_Smiley);
    //Background of "smiley"
    color Smiley_Background= Smiley_Back_with_Clock; 
    if(!Show_Clock_in_Panel) {Smiley_Background= Smiley_Back_without_Clock;}
    MakeLabel( item22, 110,0);
    ObjectSetText(item22, "g", 7, "Webdings", Smiley_Background);
    //Smiley
    color clr= smiley1; if(!Show_Clock_in_Panel) {clr= smiley2;}    
    MakeLabel( item23, 111,2);
    ObjectSetText(item23, "J", 8, "Wingdings", clr);    
    }     
                          
  //Spread
  MakeLabel( item04, 27,19);
  MakeLabel( item05, 66,19);
  Spread = MarketInfo(Symbol(), MODE_SPREAD);
  Spread = Spread/Factor;                                        
  ObjectSetText(item04, "Spread    ", 7, "Arial", Spread_Color); 
  ObjectSetText(item05,DoubleToStr(Spread,Digits_To_Show_In_Spread), 7, "Arial", Spread_Color); 
     
  //Show value of full lot pip
  MakeLabel( item06, 27,29);
  MakeLabel( item07, 66,29); 
  pipValue = (MarketInfo(Symbol(),MODE_TICKVALUE)*10);  
  if(Digits == 2 || Digits == 4) {pipValue = pipValue/10;}      
  ObjectSetText(item06, "LotPip    ",7, "Arial", PipVal_Color);
  ObjectSetText(item07, DoubleToStr(pipValue,2),7, "Arial", PipVal_Color);  
          
  //Show Range data on one line
  MakeLabel( item08, 27,39);
  MakeLabel( item09, 66,39);      
  Ranges(Days_In_Range_Day_Avg);
  dRange = ARg/Days_In_Range_Day_Avg; 
  dRG    = (dRange/Poin2)/Factor;
  if(iClose(NULL,1440,1) > iHigh(NULL,1440,0)) {HiToday = iClose(NULL,1440,1);}
  else {HiToday = iHigh(NULL,1440,0);}
  if(iClose(NULL,1440,1) < iLow(NULL,1440,0)) {LoToday = iClose(NULL,1440,1);}
  else {LoToday = iLow (NULL,1440,0);}   	
  RangeAchieved = ((HiToday - LoToday)/Poin2)/Factor;   
  ObjectSetText(item08, "Range    ", 7, "Arial", Range_Color);  
  ObjectSetText(item09, DoubleToStr(dRG,0)+", "
     +DoubleToStr(RangeAchieved,0), 7, "Arial", Range_Color);
                  
  //Select to show either /Swaps or Candle Time
  MakeLabel( item10, 27,49);  
  MakeLabel( item11, 66,49);	
  if(Show_Swaps_vs_Candle_Time)
    {
    //Show Swaps L/S 
    ObjectSetText(item10, "Swaps     ",7, "Arial", Swaps_Time_Color);
    ObjectSetText(item11, DoubleToStr(MarketInfo(Symbol(),MODE_SWAPLONG),2)+
      ", "+DoubleToStr(MarketInfo(Symbol(),MODE_SWAPSHORT),2),7, "Arial", Swaps_Time_Color);        
    }
  else
    {   
    if(Period()>1440) {timeleft = " (OFF)";}
    else {timeleft =TimeToStr(Time[0]+Period()*60-TimeCurrent(),TIME_MINUTES|TIME_SECONDS);}                  
    ObjectSetText(item10, "Candle    ", 7, "Arial", Swaps_Time_Color);
    ObjectSetText(item11,  timeleft, 7, "Arial", Swaps_Time_Color);              
    }
    
  //Market Price
  if(Digits > 2 && Show_Forex_Fractional_Pip)  {MakeLabel( item12, 7,65);}
  else {MakeLabel( item12, 7,60);} 
  MakeLabel( item13, 7,60); 
  Price=DoubleToStr(Bid, Digits); 
  LP = StringLen(Price); 
  if(Digits != 3)    
    {                
	 tab= "    ";	 
	 if(LP<8) {tab=tab + " ";}
	 if(LP==5) {tab=tab + "  ";}
	 }      
  else 
    {
    tab= "     ";
    if(LP==6) {tab=tab + " ";} 	  		   	 	     	        
    }    
  //Show final Price digit as subordinate           
  if(Digits > 2 && Show_Forex_Fractional_Pip)  
    {   
    tab1="";
          if(LP<=5) {for(i=0; i<= __Shift_Fractional_Pip+ 2.4*LP-1; i++) {tab1= tab1 + " ";} }
    else {if(LP==6) {for(i=0; i<= __Shift_Fractional_Pip+ 2.4*LP-1; i++) {tab1= tab1 + " ";} }
    else {if(LP==7) {for(i=0; i<= __Shift_Fractional_Pip+ 2.5*LP-1; i++) {tab1= tab1 + " ";} }
    else {if(LP>=8) {for(i=0; i<= __Shift_Fractional_Pip+ 2.4*LP-1; i++) {tab1= tab1 + " ";} } }}}  
           
    ObjectSetText(item12,tab+tab1+StringSubstr(Price,LP-1,1),10,"Arial Bold",Bid_Last_Digit_Small); 
    ObjectSetText(item13,tab+StringSubstr(Price,0,LP-1),14,"Arial Bold",Color);    
    }
  //Show all Price digits uniformly         
  else if(Digits > 2)        
    {
    ObjectSetText(item12,tab+Price,14,"Arial Bold",Bid_Last_Digit_Normal);
    ObjectSetText(item13,tab+StringSubstr(Price,0,LP-1),14,"Arial Bold",Color); 
    }
  else if(Digits == 2)
    {    
    ObjectSetText(item12,tab+Price,14,"Arial Bold",Color);
    ObjectSetText(item13,tab+StringSubstr(Price,0,LP-1),14,"Arial Bold",Color);
    }

  //Clock, PivotsTZ and vLines-----------------------------------------------------------------
  //Go to subroutine to get TZ info needed for Clock, PivotsTZ and vLines
  if(Show_Clock_in_Panel || PivotsTz_On || vLines_On)
    {
    GetSystemTime(systemTimeArray);
    UTC = TimeArrayToTime(systemTimeArray);     
    BrokerDT = TimeCurrent();
    }    
  if(Show_Clock_in_Panel || vLines_On)
    {
    SystemTimeToTzSpecificLocalTime(SydneyTZInfoArray, systemTimeArray, SydneyTimeArray);
    SydneyDT   = TimeArrayToTime(SydneyTimeArray);
    SystemTimeToTzSpecificLocalTime(BerlinTZInfoArray, systemTimeArray, BerlinTimeArray);
    BerlinDT   = TimeArrayToTime(BerlinTimeArray);        
    SystemTimeToTzSpecificLocalTime(LondonTZInfoArray, systemTimeArray, LondonTimeArray);
    LondonDT   = TimeArrayToTime(LondonTimeArray);   
    SystemTimeToTzSpecificLocalTime(NewYorkTZInfoArray, systemTimeArray, NewYorkTimeArray);
    NewYorkDT  = TimeArrayToTime(NewYorkTimeArray);
    }
  if(Show_Clock_in_Panel && (Pivots_PVT_On || Pivots_SR_On))
    {
    pvtDT = UTC + Broker_GMT_Offset*3600;
    }  
        
  //PivotsTZ and vLines------------------------------------------------------------------------    
  //With required time zone data imported, define parameters for PivotsTZ and vLines  
  //if vLines is "on", then calculate GMT at Lo, Ny and Lc, and   
  if(vLines_On && Period()<= __Current_Session_Max_TF)
    {
    //Make 8am the "reference time" at GMT for London Open
    GMT_Ref_Time = 8;  
     
    //Find GMT At Ao (when Sydney is at 9am local)
    Sydney_GMT_Offset = (SydneyDT/3600 - UTC/3600);
    GMT_At_Ao = GMT_Ref_Time-Sydney_GMT_Offset+1; //+1 because Syndey opens 9am local, not 8am
    //if(GMT_At_Ao < 0) {GMT_At_Ao = GMT_At_Ao +24;}
    
    //Find GMT At Fo (when Berlin is at 8am local)             
    Berlin_GMT_Offset = BerlinDT/3600 - UTC/3600;      
    GMT_At_Fo = GMT_Ref_Time-Berlin_GMT_Offset;    
         
    //Find GMT At Lo (when London is at 8am local)             
    London_GMT_Offset = LondonDT/3600 - UTC/3600;      
    GMT_At_Lo = GMT_Ref_Time-London_GMT_Offset;
                         
    //Find GMT At Ny (when New York is at 8am local)
    NYC_GMT_Offset = NewYorkDT/3600 - UTC/3600;
    GMT_At_NYo = GMT_Ref_Time-NYC_GMT_Offset; 
                           
    //Find GMT At Lc (nine hours after London Open)
    GMT_At_Lc = GMT_At_Lo + 9;
    }
          
  //if vLines is "on", or if PivotsTz is "on", then calculate "Broker_GMT_Offset".    
  if((vLines_On && Period()<= __Current_Session_Max_TF) ||
    (PivotsTz_On && Period()<= __PVT_Max_TF ))
    {
    //Compute "Broker_GMT_Offset" only when the data feed is live.  When the data feed 
    //is not live, then set "Apply_it_now" to "true" so that the manually input value
    //for "Broker_GMT_Offset" is used instead of computing it. 
    if(!Apply_it_now_because_feed_is_not_live) 
      {
      Broker_GMT_Offset = BrokerDT/3600 - UTC/3600;
      }
     }
      
  //Only if PivotsTZ is on will these calculations be done    
  if(PivotsTz_On && (Pivots_PVT_On || Pivots_SR_On) && Period()<= __PVT_Max_TF)
    {    
    //For selected pivotTZ time zone, recalculate pvtDT (datetime) for Clock label and
    //the new Pivots_GMT_Offset for use in the TZ pivots coding
    if(__Use_Preferred_Offset) 
      {
      pvtDT = UTC + Berlin_GMT_Offset*3600; 
      Pivots_GMT_Offset = Berlin_GMT_Offset;
      }
    else       
      {
      pvtDT = UTC + __Alternative_GMT_Offset*3600;
      Pivots_GMT_Offset = __Alternative_GMT_Offset;
      }                       
    }   
    
  //Clock--------------------------------------------------------------------------------------    
  //Go to subroutine for rest of TZ info needed for Clock
  if(Show_Clock_in_Panel) 
    {     
    SystemTimeToTzSpecificLocalTime(AucklandTZInfoArray, systemTimeArray, AucklandTimeArray);
    AucklandDT = TimeArrayToTime(AucklandTimeArray);      
    //Sydney  
    SystemTimeToTzSpecificLocalTime(TokyoTZInfoArray, systemTimeArray, TokyoTimeArray);
    TokyoDT    = TimeArrayToTime(TokyoTimeArray);      
    SystemTimeToTzSpecificLocalTime(ChinaTZInfoArray, systemTimeArray, ChinaTimeArray);
    ChinaDT    = TimeArrayToTime(ChinaTimeArray);      
    SystemTimeToTzSpecificLocalTime(JakartaTZInfoArray, systemTimeArray, JakartaTimeArray);
    JakartaDT  = TimeArrayToTime(JakartaTimeArray);      
    SystemTimeToTzSpecificLocalTime(IndiaTZInfoArray, systemTimeArray, IndiaTimeArray);
    IndiaDT    = TimeArrayToTime(IndiaTimeArray);      
    SystemTimeToTzSpecificLocalTime(DubaiTZInfoArray, systemTimeArray, DubaiTimeArray);
    DubaiDT    = TimeArrayToTime(DubaiTimeArray);      
    SystemTimeToTzSpecificLocalTime(MoscowTZInfoArray, systemTimeArray, MoscowTimeArray);
    MoscowDT   = TimeArrayToTime(MoscowTimeArray);      
    SystemTimeToTzSpecificLocalTime(IsraelTZInfoArray, systemTimeArray, IsraelTimeArray);
    IsraelDT   = TimeArrayToTime(IsraelTimeArray);      
    SystemTimeToTzSpecificLocalTime(HelsinkiTZInfoArray, systemTimeArray, HelsinkiTimeArray);
    HelsinkiDT = TimeArrayToTime(HelsinkiTimeArray); 
    //Berlin          
    //London  
    SystemTimeToTzSpecificLocalTime(BrazilTZInfoArray, systemTimeArray, BrazilTimeArray);
    BrazilDT   = TimeArrayToTime(BrazilTimeArray);   
    //NewYork  
    SystemTimeToTzSpecificLocalTime(CentralTZInfoArray, systemTimeArray, CentralTimeArray);
    CentralDT  = TimeArrayToTime(CentralTimeArray);      
    SystemTimeToTzSpecificLocalTime(MexicoTZInfoArray, systemTimeArray, MexicoTimeArray);
    MexicoDT   = TimeArrayToTime(MexicoTimeArray);      
    SystemTimeToTzSpecificLocalTime(MountainTZInfoArray, systemTimeArray, MountainTimeArray);
    MountainDT = TimeArrayToTime(MountainTimeArray);      
    SystemTimeToTzSpecificLocalTime(PacificTZInfoArray, systemTimeArray, PacificTimeArray);
    PacificDT  = TimeArrayToTime(PacificTimeArray);      
    GetLocalTime(LocalTimeArray);
    Local_Time = TimeArrayToTime(LocalTimeArray);
      
    //Go to subroutine to convert time data to string format for use in clock labels
    Brokers   = TimeToStrings( TimeCurrent() );   
    Aucklands = TimeToStrings( AucklandDT  );
    Sydneys   = TimeToStrings( SydneyDT  );
    Tokyos    = TimeToStrings( TokyoDT  );
    Chinas    = TimeToStrings( ChinaDT  );
    Jakartas  = TimeToStrings( JakartaDT  );
    Indias    = TimeToStrings( IndiaDT  );
    Dubais    = TimeToStrings( DubaiDT  );
    Moscows   = TimeToStrings( MoscowDT  );
    Israels   = TimeToStrings( IsraelDT  );
    Helsinkis = TimeToStrings( HelsinkiDT  );
    Berlins   = TimeToStrings( BerlinDT  );
    Londons   = TimeToStrings( LondonDT  );
    UTCs      = TimeToStrings( UTC );
    Brazils   = TimeToStrings( BrazilDT  );
    NewYorks  = TimeToStrings( NewYorkDT  );
    Centrals  = TimeToStrings( CentralDT  );
    Mexicos   = TimeToStrings( MexicoDT  );
    Mountains = TimeToStrings( MountainDT  );
    Pacifics  = TimeToStrings( PacificDT  );
    Locals    = TimeToStrings( Local_Time  ); 
    if(UTC <= BrokerDT+600 && UTC >= BrokerDT-600) {BKR_UTC_Match = true;}   
            
    //Formating clock labels 
    FontName = "Arial";
    ClockFontSize = 7;
    TimezoneFontSize = 7;        
        
    BKR_UTC_Match = false; 
    LineSpacing = 11;//12 
    top   = 3;   //vertical start text
    offset= 0;   //vertical "LineSpacing" additions to "top" per line of text
    time  = 180; //horizontal start time (same for 24hr and am/pm times)
    place = 215; //horizontal start location (if using 24hr format)
    if(Show_AMPM_Time) //shift to right to accomodate extra time characters
      {                
      place= 232; //shift location right
      }  
  	 //Begin world timezones, listed IN ORDER!
    if(Broker == 1)    	  	
      {
      MakeLabel( "z[CP Time] Brokert", time, top+offset );
      MakeLabel( "z[CP Time] Brokerl", place, top+offset );
     	offset+=LineSpacing;
      } 
    if(Auckland == 1)         	
      {                  	     	       	        
   	MakeLabel( "z[CP Time] Aucklandt", time, top+offset );         
   	MakeLabel( "z[CP Time] Aucklandl", place, top+offset );
   	offset+=LineSpacing;    
      }
    if(Sydney == 1)      
      {          
   	MakeLabel( "z[CP Time] Sydneyt", time, top+offset );
   	MakeLabel( "z[CP Time] Sydneyl", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Tokyo == 1)
      {
   	MakeLabel( "z[CP Time] Tokyot", time, top+offset );
   	MakeLabel( "z[CP Time] Tokyol", place, top+offset );
   	offset+=LineSpacing;
      }
    if(HongKong == 1)       
      {
   	MakeLabel( "z[CP Time] Chinat", time, top+offset );
   	MakeLabel( "z[CP Time] Chinal", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Jakarta == 1)        
      {
   	MakeLabel( "z[CP Time] Jakartat", time, top+offset );
   	MakeLabel( "z[CP Time] Jakartal", place, top+offset );
   	offset+=LineSpacing;
      }
    if(India == 1)      
      {
   	MakeLabel( "z[CP Time] Indiat", time, top+offset );
   	MakeLabel( "z[CP Time] Indial", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Dubai == 1)        
      {
   	MakeLabel( "z[CP Time] Dubait", time, top+offset );
   	MakeLabel( "z[CP Time] Dubail", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Moscow == 1)       
      {
   	MakeLabel( "z[CP Time] Moscowt", time, top+offset );
   	MakeLabel( "z[CP Time] Moscowl", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Israel == 1)       
      {
   	MakeLabel( "z[CP Time] Israelt", time, top+offset );
   	MakeLabel( "z[CP Time] Israell", place, top+offset );
   	offset+=LineSpacing;
      }      
    if(Helsinki == 1)        
      {                          	       
   	MakeLabel( "z[CP Time] Helsinkit", time, top+offset );
   	MakeLabel( "z[CP Time] Helsinkil", place, top+offset );
   	offset+=LineSpacing; 	
      }      
    if(Frankfurt == 1)        
      {
   	MakeLabel( "z[CP Time] Berlint", time, top+offset );
   	MakeLabel( "z[CP Time] Berlinl", place, top+offset );
   	offset+=LineSpacing;
      }      
    if(London == 1)
      {       
	   MakeLabel( "z[CP Time] Londont", time, top+offset );
   	MakeLabel( "z[CP Time] Londonl", place, top+offset );
   	offset+=LineSpacing;
      }      
    if(GMT == 1)        
      {
   	MakeLabel( "z[CP Time] utct", time, top+offset );
   	MakeLabel( "z[CP Time] utcl", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Brazil == 1)      
      {
   	MakeLabel( "z[CP Time] Brazilt", time, top+offset );
   	MakeLabel( "z[CP Time] Brazill", place, top+offset );
   	offset+=LineSpacing;
      }
    if(NewYork == 1)       
      {
	   MakeLabel( "z[CP Time] NewYorkt", time, top+offset );
   	MakeLabel( "z[CP Time] NewYorkl", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Central == 1)        
      {
   	MakeLabel( "z[CP Time] Centralt", time, top+offset );
   	MakeLabel( "z[CP Time] Centrall", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Mexico == 1)        
      {
   	MakeLabel( "z[CP Time] Mexicot", time, top+offset );
   	MakeLabel( "z[CP Time] Mexicol", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Mountain == 1)        
      {
   	MakeLabel( "z[CP Time] Mountaint", time, top+offset );
   	MakeLabel( "z[CP Time] Mountainl", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Pacific == 1)        
      {
	   MakeLabel( "z[CP Time] Pacifict", time, top+offset );
   	MakeLabel( "z[CP Time] Pacificl", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Local == 1)        
      {
      MakeLabel( "z[CP Time] Localt", time, top+offset );
      MakeLabel( "z[CP Time] Locall", place, top+offset );
      offset+=LineSpacing;
      }    
    //Set condition for showing "P" location in Clock labels                                                           
    if( (Pivots_PVT_On && Period()<=__PVT_Max_TF) ||
      (Pivots_SR_On && Period()<=__SR_Max_TF) ) {Displaying_Pivots = true;} 
    
    //Populate Clock Labels                  
    if(Broker == 1)  
      {
      Brokerp= "Broker";
      //Show time zone is same as local
      if(BrokerDT <= Local_Time+600 && BrokerDT >= Local_Time-600)
        {           
        Brokerp= Brokerp + "  (L)";           
        }
      //Show time zone is same as GMT   
      if(BrokerDT == UTC)
        {
        if(StringLen(Brokerp) == 6)
          {          
          Brokerp= Brokerp + "  (G)";           
          }
        else
          {
          Brokerp= StringSubstr(Brokerp,0,StringLen(Brokerp)-1) + ",G)";          
          }   
        }                
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (BrokerDT <= pvtDT+600 && BrokerDT >= pvtDT-600))
        {
        if(StringLen(Brokerp) == 6)
          {
          Brokerp= Brokerp + "  (P)";    
          }
        else
          {
          Brokerp= StringSubstr(Brokerp,0,StringLen(Brokerp)-1) + ",P)";  
          }               
        }                                                    
	   ObjectSetText( "z[CP Time] Brokert", Brokers, ClockFontSize, FontName, Clock_MktClosed );
      ObjectSetText( "z[CP Time] Brokerl", Brokerp, TimezoneFontSize, FontName, Location_MktClosed );
      }      
    if(Auckland == 1)                   
      {
      Aucklandp= "Auckland";
      //Show if time zone is same as for broker server
      if(AucklandDT <= BrokerDT+600 && AucklandDT >= BrokerDT-600)
        { 
        if(StringLen(Aucklandp) == 8)
          {          
          Aucklandp= Aucklandp + "  (B)";           
          }
        else
          {
          Aucklandp= StringSubstr(Aucklandp,0,StringLen(Aucklandp)-1) + ",B)";          
          }   
        }
      //Show if time zone is same as local time   
      if(AucklandDT <= Local_Time+600 && AucklandDT >= Local_Time-600)
        { 
        if(StringLen(Aucklandp) == 8)
          {          
          Aucklandp= Aucklandp + "  (L)";           
          }
        else
          {
          Aucklandp= StringSubstr(Aucklandp,0,StringLen(Aucklandp)-1) + ",L)";          
          }   
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (AucklandDT <= pvtDT+600 && AucklandDT >= pvtDT-600))
        {
        if(StringLen(Aucklandp) == 8)
          {
          Aucklandp= Aucklandp + "  (P)";    
          }
        else
          {
          Aucklandp= StringSubstr(Aucklandp,0,StringLen(Aucklandp)-1) + ",P)";  
          }               
        }                             
   	if(TimeDayOfWeek(AucklandDT) != 0 && TimeDayOfWeek(AucklandDT) != 6 
   	  && TimeHour(AucklandDT) >= LocalOpenHour && TimeHour(AucklandDT) < LocalCloseHour)
        {
   	  ObjectSetText( "z[CP Time] Aucklandt", Aucklands, ClockFontSize, FontName, Clock_MktOpen );      	
   	  ObjectSetText( "z[CP Time] Aucklandl", Aucklandp, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
      else
   	  {
   	  ObjectSetText( "z[CP Time] Aucklandt", Aucklands, ClockFontSize, FontName, Clock_MktClosed );   	   
   	  ObjectSetText( "z[CP Time] Aucklandl", Aucklandp, TimezoneFontSize, FontName, Location_MktClosed );
        }
      }
    if(Sydney == 1)        
      {
      Sydneyp= "Sydney";
      //Show if time zone is same as for broker server
      if(SydneyDT <= BrokerDT+600 && SydneyDT >= BrokerDT-600)
        { 
        if(StringLen(Sydneyp) == 6)
          {          
          Sydneyp= Sydneyp + "  (B)";           
          }
        else
          {
          Sydneyp= StringSubstr(Sydneyp,0,StringLen(Sydneyp)-1) + ",B)";          
          }   
        }
      //Show if time zone is same as local time   
      if(SydneyDT <= Local_Time+600 && SydneyDT >= Local_Time-600)
        { 
        if(StringLen(Sydneyp) == 6)
          {          
          Sydneyp= Sydneyp + "  (L)";           
          }
        else
          {
          Sydneyp= StringSubstr(Sydneyp,0,StringLen(Sydneyp)-1) + ",L)";          
          }   
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (SydneyDT <= pvtDT+600 && SydneyDT >= pvtDT-600))
        {
        if(StringLen(Sydneyp) == 6)
          {
          Sydneyp= Sydneyp + "  (P)";    
          }
        else
          {
          Sydneyp= StringSubstr(Sydneyp,0,StringLen(Sydneyp)-1) + ",P)";  
          }               
        }                                         	     	      	     
   	if(TimeDayOfWeek(SydneyDT) != 0 && TimeDayOfWeek(SydneyDT) != 6 
   	  && TimeHour(SydneyDT) >= SydneyLocalOpenHour && TimeHour(SydneyDT) < SydneyLocalCloseHour)
   	  {
   	  ObjectSetText( "z[CP Time] Sydneyt", Sydneys, ClockFontSize, FontName, Clock_MktOpen );   	   
   	  ObjectSetText( "z[CP Time] Sydneyl", Sydneyp, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
   	  {
   	  ObjectSetText( "z[CP Time] Sydneyt", Sydneys, ClockFontSize, FontName, Clock_MktClosed );   	   
   	  ObjectSetText( "z[CP Time] Sydneyl", Sydneyp, TimezoneFontSize, FontName, Location_MktClosed );
        }
      }
    if(Tokyo == 1)           
      {
      Tokyop= "Tokyo";
      //Show if time zone is same as for broker server
      if(TokyoDT <= BrokerDT+600 && TokyoDT >= BrokerDT-600)
        { 
        if(StringLen(Tokyop) == 5)
          {          
          Tokyop= Tokyop + "  (B)";           
          }
        else
          {
          Tokyop= StringSubstr(Tokyop,0,StringLen(Tokyop)-1) + ",B)";          
          }   
        }
      //Show if time zone is same as local time   
      if(TokyoDT <= Local_Time+600 && TokyoDT >= Local_Time-600)
        { 
        if(StringLen(Tokyop) == 5)
          {          
          Tokyop= Tokyop + "  (L)";           
          }
        else
          {
          Tokyop= StringSubstr(Tokyop,0,StringLen(Tokyop)-1) + ",L)";          
          }   
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (TokyoDT <= pvtDT+600 && TokyoDT >= pvtDT-600))
        {
        if(StringLen(Tokyop) == 5)
          {
          Tokyop= Tokyop + "  (P)";    
          }
        else
          {
          Tokyop= StringSubstr(Tokyop,0,StringLen(Tokyop)-1) + ",P)";  
          }               
        }                                                	      	         	         
   	if(TimeDayOfWeek(TokyoDT) != 0 && TimeDayOfWeek(TokyoDT) != 6 
   	  && TimeHour(TokyoDT) >= TokyoLocalOpenHour && TimeHour(TokyoDT) < TokyoLocalCloseHour)
   	  {
   	  ObjectSetText( "z[CP Time] Tokyot", Tokyos, ClockFontSize, FontName, Clock_MktOpen );   	   
   	  ObjectSetText( "z[CP Time] Tokyol", Tokyop, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
   	  {
   	  ObjectSetText( "z[CP Time] Tokyot", Tokyos, ClockFontSize, FontName, Clock_MktClosed );   	   
   	  ObjectSetText( "z[CP Time] Tokyol", Tokyop, TimezoneFontSize, FontName, Location_MktClosed );
   	  }
      }
    if(HongKong == 1)        
      { 
      Chinap= "HongKong";
      //Show if time zone is same as for broker server
      if(ChinaDT <= BrokerDT+600 && ChinaDT >= BrokerDT-600)
        { 
        if(StringLen(Chinap) == 8)
          {          
          Chinap= Chinap + "  (B)";           
          }
        else
          {
          Chinap= StringSubstr(Chinap,0,StringLen(Chinap)-1) + ",B)";          
          }   
        }
      //Show if time zone is same as local time   
      if(ChinaDT <= Local_Time+600 && ChinaDT >= Local_Time-600)
        { 
        if(StringLen(Chinap) == 8)
          {          
          Chinap= Chinap + "  (L)";           
          }
        else
          {
          Chinap= StringSubstr(Chinap,0,StringLen(Chinap)-1) + ",L)";          
          }   
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (ChinaDT <= pvtDT+600 && ChinaDT >= pvtDT-600))
        {
        if(StringLen(Chinap) == 8)
          {
          Chinap= Chinap + "  (P)";    
          }
        else
          {
          Chinap= StringSubstr(Chinap,0,StringLen(Chinap)-1) + ",P)";  
          }               
        }                                                      	     	           
   	if(TimeDayOfWeek(ChinaDT) != 0 && TimeDayOfWeek(ChinaDT) != 6 
   	  && TimeHour(ChinaDT) >= LocalOpenHour && TimeHour(ChinaDT) < LocalCloseHour)
   	  {
    	  ObjectSetText( "z[CP Time] Chinat", Chinas, ClockFontSize, FontName, Clock_MktOpen );  	   
   	  ObjectSetText( "z[CP Time] Chinal", Chinap, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
   	  {
   	  ObjectSetText( "z[CP Time] Chinat", Chinas, ClockFontSize, FontName, Clock_MktClosed );   	   
   	  ObjectSetText( "z[CP Time] Chinal", Chinap, TimezoneFontSize, FontName, Location_MktClosed );
   	  }
      }      
    if(Jakarta == 1)   
      { 
      Jakartap= "Jakarta";
      //Show if time zone is same as for broker server
      if(JakartaDT <= BrokerDT+600 && JakartaDT >= BrokerDT-600)
        { 
        if(StringLen(Jakartap) == 7)
          {          
          Jakartap= Jakartap + "  (B)";           
          }
        else
          {
          Jakartap= StringSubstr(Jakartap,0,StringLen(Jakartap)-1) + ",B)";          
          }   
        }
      //Show if time zone is same as local time   
      if(JakartaDT <= Local_Time+600 && JakartaDT >= Local_Time-600)
        { 
        if(StringLen(Jakartap) == 7)
          {          
          Jakartap= Jakartap + "  (L)";           
          }
        else
          {
          Jakartap= StringSubstr(Jakartap,0,StringLen(Jakartap)-1) + ",L)";          
          }   
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (JakartaDT <= pvtDT+600 && JakartaDT >= pvtDT-600))
        {
        if(StringLen(Jakartap) == 7)
          {
          Jakartap= Jakartap + "  (P)";    
          }
        else
          {
          Jakartap= StringSubstr(Jakartap,0,StringLen(Jakartap)-1) + ",P)";  
          }               
        }                                                               	     	         	     
   	if(TimeDayOfWeek(JakartaDT) != 0 && TimeDayOfWeek(JakartaDT) != 6
   	  && TimeHour(JakartaDT) >= LocalOpenHour && TimeHour(JakartaDT) < LocalCloseHour)
   	  {
   	  ObjectSetText( "z[CP Time] Jakartat", Jakartas, ClockFontSize, FontName, Clock_MktOpen );   	   
   	  ObjectSetText( "z[CP Time] Jakartal", Jakartap, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
   	  {
   	  ObjectSetText( "z[CP Time] Jakartat", Jakartas, ClockFontSize, FontName, Clock_MktClosed );   	   
   	  ObjectSetText( "z[CP Time] Jakartal", Jakartap, TimezoneFontSize, FontName, Location_MktClosed );
   	  }
      }
    if(India == 1)      
      {   
      Indiap= "India";
      //Show if time zone is same as for broker server
      if(IndiaDT <= BrokerDT+600 && IndiaDT >= BrokerDT-600)
        { 
        if(StringLen(Indiap) == 5)
          {          
          Indiap= Indiap + "  (B)";           
          }
        else
          {
          Indiap= StringSubstr(Indiap,0,StringLen(Indiap)-1) + ",B)";          
          }   
        }
      //Show if time zone is same as local time   
      if(IndiaDT <= Local_Time+600 && IndiaDT >= Local_Time-600)
        { 
        if(StringLen(Indiap) == 5)
          {          
          Indiap= Indiap + "  (L)";           
          }
        else
          {
          Indiap= StringSubstr(Indiap,0,StringLen(Indiap)-1) + ",L)";          
          }   
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (IndiaDT <= pvtDT+600 && IndiaDT >= pvtDT-600))
        {
        if(StringLen(Indiap) == 5)
          {
          Indiap= Indiap + "  (P)";    
          }
        else
          {
          Indiap= StringSubstr(Indiap,0,StringLen(Indiap)-1) + ",P)";  
          }               
        }                                           	     	         	              	     	      	       	                           	       	     
   	if(TimeDayOfWeek(IndiaDT) != 0 && TimeDayOfWeek(IndiaDT) != 6 
   	  && TimeHour(IndiaDT) >= LocalOpenHour && TimeHour(IndiaDT) < LocalCloseHour)
   	  {
    	  ObjectSetText( "z[CP Time] Indiat", Indias, ClockFontSize, FontName, Clock_MktOpen );  	   
   	  ObjectSetText( "z[CP Time] Indial", Indiap, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
      else
        {
    	  ObjectSetText( "z[CP Time] Indiat", Indias, ClockFontSize, FontName, Clock_MktClosed );     	
   	  ObjectSetText( "z[CP Time] Indial", Indiap, TimezoneFontSize, FontName, Location_MktClosed );
        }
      }
    if(Dubai == 1)   
      { 
      Dubaip= "Dubai";
      //Show if time zone is same as for broker server
      if(DubaiDT <= BrokerDT+600 && DubaiDT >= BrokerDT-600)
        { 
        if(StringLen(Dubaip) == 5)
          {          
          Dubaip= Dubaip + "  (B)";           
          }
        else
          {
          Dubaip= StringSubstr(Dubaip,0,StringLen(Dubaip)-1) + ",B)";          
          }   
        }
      //Show if time zone is same as local time   
      if(DubaiDT <= Local_Time+600 && DubaiDT >= Local_Time-600)
        { 
        if(StringLen(Dubaip) == 5)
          {          
          Dubaip= Dubaip + "  (L)";           
          }
        else
          {
          Dubaip= StringSubstr(Dubaip,0,StringLen(Dubaip)-1) + ",L)";          
          }   
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (DubaiDT <= pvtDT+600 && DubaiDT >= pvtDT-600))
        {
        if(StringLen(Dubaip) == 5)
          {
          Dubaip= Dubaip + "  (P)";    
          }
        else
          {
          Dubaip= StringSubstr(Dubaip,0,StringLen(Dubaip)-1) + ",P)";  
          }               
        }                                           	     	         	              	     	      	       	     
   	if(TimeDayOfWeek(DubaiDT) != 0 && TimeDayOfWeek(DubaiDT) != 6 
   	  && TimeHour(DubaiDT) >= LocalOpenHour && TimeHour(DubaiDT) < LocalCloseHour)
        {
   	  ObjectSetText( "z[CP Time] Dubait", Dubais, ClockFontSize, FontName, Clock_MktOpen );     	
   	  ObjectSetText( "z[CP Time] Dubail", Dubaip, TimezoneFontSize, FontName, Location_MktOpen ); 
   	  }
   	else
   	  {
   	  ObjectSetText( "z[CP Time] Dubait", Dubais, ClockFontSize, FontName, Clock_MktClosed );  	   
   	  ObjectSetText( "z[CP Time] Dubail", Dubaip, TimezoneFontSize, FontName, Location_MktClosed );
        }
      }
    if(Moscow == 1)              
      { 
      Moscowp= "Moscow";
      //Show if time zone is same as for broker server 
      if(MoscowDT <= BrokerDT+600 && MoscowDT >= BrokerDT-600)
        { 
        if(StringLen(Moscowp) == 6)
          {          
          Moscowp= Moscowp + "  (B)";           
          }
        else
          {
          Moscowp= StringSubstr(Moscowp,0,StringLen(Moscowp)-1) + ",B)";          
          }   
        }
      //Show if time zone is same as local time   
      if(MoscowDT <= Local_Time+600 && MoscowDT >= Local_Time-600)
        { 
        if(StringLen(Moscowp) == 6)
          {          
          Moscowp= Moscowp + "  (L)";           
          }
        else
          {
          Moscowp= StringSubstr(Moscowp,0,StringLen(Moscowp)-1) + ",L)";          
          }   
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (MoscowDT <= pvtDT+600 && MoscowDT >= pvtDT-600))
        {
        if(StringLen(Moscowp) == 6)
          {
          Moscowp= Moscowp + "  (P)";    
          }
        else
          {
          Moscowp= StringSubstr(Moscowp,0,StringLen(Moscowp)-1) + ",P)";  
          }               
        }                                           	     	         	                  	           	      	        	       
   	if(TimeDayOfWeek(MoscowDT) != 0 && TimeDayOfWeek(MoscowDT) != 6 
   	  && TimeHour(MoscowDT) >= LocalOpenHour && TimeHour(MoscowDT) < LocalCloseHour)
   	  {
   	  ObjectSetText( "z[CP Time] Moscowt", Moscows, ClockFontSize, FontName, Clock_MktOpen );  	   
   	  ObjectSetText( "z[CP Time] Moscowl", Moscowp, TimezoneFontSize, FontName, Location_MktOpen ); 
        }
   	else
   	  {
    	  ObjectSetText( "z[CP Time] Moscowt", Moscows, ClockFontSize, FontName, Clock_MktClosed );  	   
   	  ObjectSetText( "z[CP Time] Moscowl", Moscowp, TimezoneFontSize, FontName, Location_MktClosed );
   	  }
      }
    if(Israel == 1)                          
      {
      Israelp= "Israel"; 
      //Show if time zone is same as for broker server
      if(IsraelDT <= BrokerDT+600 && IsraelDT >= BrokerDT-600)
        { 
        if(StringLen(Israelp) == 6)
          {          
          Israelp= Israelp + "  (B)";           
          }
        else
          {
          Israelp= StringSubstr(Israelp,0,StringLen(Israelp)-1) + ",B)";          
          }   
        }
      //Show if time zone is same as local time   
      if(IsraelDT <= Local_Time+600 && IsraelDT >= Local_Time-600)
        { 
        if(StringLen(Israelp) == 6)
          {          
          Israelp= Israelp + "  (L)";           
          }
        else
          {
          Israelp= StringSubstr(Israelp,0,StringLen(Israelp)-1) + ",L)";          
          }   
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (IsraelDT <= pvtDT+600 && IsraelDT >= pvtDT-600))
        {
        if(StringLen(Israelp) == 6)
          {
          Israelp= Israelp + "  (P)";    
          }
        else
          {
          Israelp= StringSubstr(Israelp,0,StringLen(Israelp)-1) + ",P)";  
          }               
        }                                           	     	         	    
   	if(TimeDayOfWeek(IsraelDT) != 0 && TimeDayOfWeek(IsraelDT) != 6
   	  && TimeHour(IsraelDT) >= LocalOpenHour && TimeHour(IsraelDT) < LocalCloseHour)
        {
   	  ObjectSetText( "z[CP Time] Israelt", Israels, ClockFontSize, FontName, Clock_MktOpen );      	
   	  ObjectSetText( "z[CP Time] Israell", Israelp, TimezoneFontSize, FontName, Location_MktOpen );
        }
   	else
        {
  	     ObjectSetText( "z[CP Time] Israelt", Israels, ClockFontSize, FontName, Clock_MktClosed );       	
   	  ObjectSetText( "z[CP Time] Israell", Israelp, TimezoneFontSize, FontName, Location_MktClosed );
   	  }
      }                  
    if(Helsinki == 1)
      {        
      Helsinkip= "Helsinki";
      //Show if time zone is same as for broker server 
      if(HelsinkiDT <= BrokerDT+600 && HelsinkiDT >= BrokerDT-600)
        { 
        if(StringLen(Helsinkip) == 8)
          {          
          Helsinkip= Helsinkip + "  (B)";           
          }
        else
          {
          Helsinkip= StringSubstr(Helsinkip,0,StringLen(Helsinkip)-1) + ",B)";          
          }   
        }
      //Show if time zone is same as local time   
      if(HelsinkiDT <= Local_Time+600 && HelsinkiDT >= Local_Time-600)
        { 
        if(StringLen(Helsinkip) == 8)
          {          
          Helsinkip= Helsinkip + "  (L)";           
          }
        else
          {
          Helsinkip= StringSubstr(Helsinkip,0,StringLen(Helsinkip)-1) + ",L)";          
          }   
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (HelsinkiDT <= pvtDT+600 && HelsinkiDT >= pvtDT-600))
        {
        if(StringLen(Helsinkip) == 8)
          {
          Helsinkip= Helsinkip + "  (P)";    
          }
        else
          {
          Helsinkip= StringSubstr(Helsinkip,0,StringLen(Helsinkip)-1) + ",P)";  
          }               
        }                               	                             	       	                         	                             	                 
   	if(TimeDayOfWeek(HelsinkiDT) != 0 && TimeDayOfWeek(HelsinkiDT) != 6 
   	  && TimeHour(HelsinkiDT) >= LocalOpenHour && TimeHour(HelsinkiDT) < LocalCloseHour)
        {
   	  ObjectSetText( "z[CP Time] Helsinkit", Helsinkis, ClockFontSize, FontName, Clock_MktOpen );      	
   	  ObjectSetText( "z[CP Time] Helsinkil", Helsinkip, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
   	  {
    	  ObjectSetText( "z[CP Time] Helsinkit", Helsinkis, ClockFontSize, FontName, Clock_MktClosed );  	   
   	  ObjectSetText( "z[CP Time] Helsinkil", Helsinkip, TimezoneFontSize, FontName, Location_MktClosed );
   	  }
      }
    if(Frankfurt == 1)                         
      {       
      Berlinp= "Frankfurt";
      //Show if time zone is same as for broker server 
      if(BerlinDT <= BrokerDT+600 && BerlinDT >= BrokerDT-600)
        { 
        if(StringLen(Berlinp) == 9)
          {          
          Berlinp= Berlinp + "  (B)";           
          }
        else
          {
          Berlinp= StringSubstr(Berlinp,0,StringLen(Berlinp)-1) + ",B)";          
          }   
        }        
      //Show if time zone is same as local time  
      if(BerlinDT <= Local_Time+600 && BerlinDT >= Local_Time-600)
        { 
        if(StringLen(Berlinp) == 9)
          {          
          Berlinp= Berlinp + "  (L)";           
          }
        else
          {
          Berlinp= StringSubstr(Berlinp,0,StringLen(Berlinp)-1) + ",L)";          
          }
        }           
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (BerlinDT <= pvtDT+600 && BerlinDT >= pvtDT-600))
        {
        if(StringLen(Berlinp) == 9)
          {
          Berlinp= Berlinp + "  (P)";    
          }
        else
          {
          Berlinp= StringSubstr(Berlinp,0,StringLen(Berlinp)-1) + ",P)";  
          }               
        }                                                   
   	if(TimeDayOfWeek(BerlinDT) != 0 && TimeDayOfWeek(BerlinDT) != 6 
   	  && TimeHour(BerlinDT) >= LocalOpenHour && TimeHour(BerlinDT) < LocalCloseHour)
        {
   	  ObjectSetText( "z[CP Time] Berlint", Berlins, ClockFontSize, FontName, Clock_MktOpen );      	
   	  ObjectSetText( "z[CP Time] Berlinl", Berlinp, TimezoneFontSize, FontName, Location_MktOpen );
        }
   	else
        {
   	  ObjectSetText( "z[CP Time] Berlint", Berlins, ClockFontSize, FontName, Clock_MktClosed );     	
   	  ObjectSetText( "z[CP Time] Berlinl", Berlinp, TimezoneFontSize, FontName, Location_MktClosed ); 
        }
      }                 
    if(London == 1)            
      {      
      //Test summer display during winter: change values to summer values relationships
      //UTC = LondonDT-3600;
      //BKR_UTC_Match =true;  //means BrokerDT = UTC
      //BKR_UTC_Match =false;  //means BrokerDT != UTC       
      Londonp= "London";
      //Show if time zone is same as for broker server  
      if(LondonDT <= BrokerDT+600 && LondonDT >= BrokerDT-600)
        { 
        if(StringLen(Londonp) == 6)
          {          
          Londonp= Londonp + "  (B)";           
          }
        else
          {
          Londonp= StringSubstr(Londonp,0,StringLen(Londonp)-1) + ",B)";          
          }   
        }
      //Show if time zone is same as local time   
      if(LondonDT <= Local_Time+600 && LondonDT >= Local_Time-600)
        { 
        if(StringLen(Londonp) == 6)
          {          
          Londonp= Londonp + "  (L)";           
          }
        else
          {
          Londonp= StringSubstr(Londonp,0,StringLen(Londonp)-1) + ",L)";          
          }   
        }
      //Show time zone is same as GMT                    
      if(LondonDT == UTC)
        {
        if(StringLen(Londonp) == 6)
          {          
          Londonp= Londonp + "  (G)";           
          }
        else
          {
          Londonp= StringSubstr(Londonp,0,StringLen(Londonp)-1) + ",G)";          
          }   
        }
      //Show time zone is B+1 if broker is at GMT
      if((GMT == 0) && (LondonDT != UTC) && (BKR_UTC_Match))
        {
        if(StringLen(Londonp) == 6)
          {          
          Londonp= Londonp + "  (B/G+1)";          
          }
        else
          {
          Londonp= StringSubstr(Londonp,0,StringLen(Londonp)-1) + ",B/G+1)";           
          }   
        }          
      //Show time zone is G+1 if Broker is not at GMT
      if((GMT == 0) && (LondonDT != UTC) && (!BKR_UTC_Match))
        {
        if(StringLen(Londonp) == 6)
          {          
          Londonp= Londonp + "  (G+1)";          
          }
        else
          {
          Londonp= StringSubstr(Londonp,0,StringLen(Londonp)-1) + ",G+1)";           
          }   
        }                      
      //Show time zone is same as for pivots
       if(Displaying_Pivots && (LondonDT <= pvtDT+600 && LondonDT >= pvtDT-600))
        {
        if(StringLen(Londonp) == 6)
          {
          Londonp= Londonp + " (P)";    
          }
        else
          {
          Londonp= StringSubstr(Londonp,0,StringLen(Londonp)-1) + ",P)";  
          }  
        }                                                         
   	if(TimeDayOfWeek(LondonDT) != 0 && TimeDayOfWeek(LondonDT) != 6 
   	  && TimeHour(LondonDT) >= LocalOpenHour && TimeHour(LondonDT) < LocalCloseHour)
   	  {
        ObjectSetText( "z[CP Time] Londont", Londons, ClockFontSize, FontName, Clock_MktOpen );   	   
        ObjectSetText( "z[CP Time] Londonl", Londonp, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
   	  {
   	  ObjectSetText( "z[CP Time] Londont", Londons, ClockFontSize, FontName, Clock_MktClosed );   	   
   	  ObjectSetText( "z[CP Time] Londonl", Londonp, TimezoneFontSize, FontName, Location_MktClosed );
   	  }
      }           
    if(GMT == 1)                
      {       
      UTCp= "GMT";
      //Show if time zone is same as for broker server
      if(UTC <= BrokerDT+600 && UTC >= BrokerDT-600)
        { 
        if(StringLen(UTCp) == 3)
          {          
          UTCp= UTCp + "  (B)";           
          }
        else
          {
          UTCp= StringSubstr(UTCp,0,StringLen(UTCp)-1) + ",B)";          
          }   
        }
      //Show if time zone is same as local time   
      if(UTC <= Local_Time+600 && UTC >= Local_Time-600)
        { 
        if(StringLen(UTCp) == 3)
          {          
          UTCp= UTCp + "  (L)";           
          }
        else
          {
          UTCp= StringSubstr(UTCp,0,StringLen(UTCp)-1) + ",L)";          
          }   
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (UTC <= pvtDT+600 && UTC >= pvtDT-600))
        {
        if(StringLen(UTCp) == 3)
          {
          UTCp= UTCp + "  (P)";    
          }
        else
          {
          UTCp= StringSubstr(UTCp,0,StringLen(UTCp)-1) + ",P)";  
          }               
        }                            	              
   	if(TimeDayOfWeek(UTC) != 0 && TimeDayOfWeek(UTC) != 6 
   	  && TimeHour(UTC) >= LocalOpenHour && TimeHour(UTC) < LocalCloseHour)
   	  {
        ObjectSetText( "z[CP Time] utct", UTCs, ClockFontSize, FontName, Clock_MktOpen );   	   
        ObjectSetText( "z[CP Time] utcl", UTCp, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
   	  {         
   	  ObjectSetText( "z[CP Time] utct", UTCs, ClockFontSize, FontName, Clock_MktClosed );                    	         
   	  ObjectSetText( "z[CP Time] utcl", UTCp, TimezoneFontSize, FontName, Location_MktClosed );
   	  }
      }
    if(Brazil == 1)           
      {  
      Brazilp= "Brazil";
      //Show if time zone is same as for broker server
      if(BrazilDT <= BrokerDT+600 && BrazilDT >= BrokerDT-600)
        { 
        if(StringLen(Brazilp) == 6)
          {          
          Brazilp= Brazilp + "  (B)";           
          }
        else
          {
          Brazilp= StringSubstr(Brazilp,0,StringLen(Brazilp)-1) + ",B)";          
          }   
        }
      //Show if time zone is same as local time   
      if(BrazilDT <= Local_Time+600 && BrazilDT >= Local_Time-600)
        { 
        if(StringLen(Brazilp) == 6)
          {          
          Brazilp= Brazilp + "  (L)";           
          }
        else
          {
          Brazilp= StringSubstr(Brazilp,0,StringLen(Brazilp)-1) + ",L)";          
          }   
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (BrazilDT <= pvtDT+600 && BrazilDT >= pvtDT-600))
        {
        if(StringLen(Brazilp) == 6)
          {
          Brazilp= Brazilp + "  (P)";    
          }
        else
          {
          Brazilp= StringSubstr(Brazilp,0,StringLen(Brazilp)-1) + ",P)";  
          }               
        }                                               	     
   	if(TimeDayOfWeek(BrazilDT) != 0 && TimeDayOfWeek(BrazilDT) != 6 
   	  && TimeHour(BrazilDT) >= LocalOpenHour && TimeHour(BrazilDT) < LocalCloseHour)
   	  {
    	  ObjectSetText( "z[CP Time] Brazilt", Brazils, ClockFontSize, FontName, Clock_MktOpen );  	   
   	  ObjectSetText( "z[CP Time] Brazill", Brazilp, TimezoneFontSize, FontName, Location_MktOpen );
        }
   	else
        {
   	  ObjectSetText( "z[CP Time] Brazilt", Brazils, ClockFontSize, FontName, Clock_MktClosed );      	
   	  ObjectSetText( "z[CP Time] Brazill", Brazilp, TimezoneFontSize, FontName, Location_MktClosed );
        }
      }
    if(NewYork == 1)     
      {      
      NYp= "NewYork";
      //Show if time zone is same as for broker server
      if(NewYorkDT <= BrokerDT+600 && NewYorkDT >= BrokerDT-600)
        { 
        if(StringLen(NYp) == 7)
          {          
          NYp= NYp + "  (B)";           
          }
        else
          {
          NYp= StringSubstr(NYp,0,StringLen(NYp)-1) + ",B)";          
          }   
        }
      //Show if time zone is same as local time   
      if(NewYorkDT <= Local_Time+600 && NewYorkDT >= Local_Time-600)
        { 
        if(StringLen(NYp) == 7)
          {          
          NYp= NYp + "  (L)";           
          }
        else
          {
          NYp= StringSubstr(NYp,0,StringLen(NYp)-1) + ",L)";          
          }   
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (NewYorkDT <= pvtDT+600 && NewYorkDT >= pvtDT-600))
        {
        if(StringLen(NYp) == 7)
          {
          NYp= NYp + "  (P)";    
          }
        else
          {
          NYp= StringSubstr(NYp,0,StringLen(NYp)-1) + ",P)";  
          }               
        }                                                                
   	if(TimeDayOfWeek(NewYorkDT) != 0 && TimeDayOfWeek(NewYorkDT) != 6 
   	  && TimeHour(NewYorkDT) >= LocalOpenHour && TimeHour(NewYorkDT) < LocalCloseHour)
   	  {
        ObjectSetText( "z[CP Time] NewYorkt", NewYorks, ClockFontSize, FontName, Clock_MktOpen );   	   
   	  ObjectSetText( "z[CP Time] NewYorkl", NYp, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
   	  {
        ObjectSetText( "z[CP Time] NewYorkt", NewYorks, ClockFontSize, FontName, Clock_MktClosed );  	   
        ObjectSetText( "z[CP Time] NewYorkl", NYp, TimezoneFontSize, FontName, Location_MktClosed ); 
        }
      }
    if(Central == 1)
      {             
      Centralp= "Central";
      //Show if time zone is same as for broker server
      if(CentralDT <= BrokerDT+600 && CentralDT >= BrokerDT-600)
        { 
        if(StringLen(Centralp) == 7)
          {          
          Centralp= Centralp + "  (B)";           
          }
        else
          {
          Centralp= StringSubstr(Centralp,0,StringLen(Centralp)-1) + ",B)";          
          }   
        }
      //Show if time zone is same as local time   
      if(CentralDT <= Local_Time+600 && CentralDT >= Local_Time-600)
        { 
        if(StringLen(Centralp) == 7)
          {          
          Centralp= Centralp + "  (L)";           
          }
        else
          {
          Centralp= StringSubstr(Centralp,0,StringLen(Centralp)-1) + ",L)";          
          }   
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (CentralDT <= pvtDT+600 && CentralDT >= pvtDT-600))
        {
        if(StringLen(Centralp) == 7)
          {
          Centralp= Centralp + "  (P)";    
          }
        else
          {
          Centralp= StringSubstr(Centralp,0,StringLen(Centralp)-1) + ",P)";  
          }               
        }                                                                    	      
   	if(TimeDayOfWeek(CentralDT) != 0 && TimeDayOfWeek(CentralDT) != 6 
   	 && TimeHour(CentralDT) >= LocalOpenHour && TimeHour(CentralDT) < LocalCloseHour)
   	  {
  	     ObjectSetText( "z[CP Time] Centralt", Centrals, ClockFontSize, FontName, Clock_MktOpen );   	   
   	  ObjectSetText( "z[CP Time] Centrall", Centralp, TimezoneFontSize, FontName, Location_MktOpen ); 
   	  }
   	else
   	  {
  	     ObjectSetText( "z[CP Time] Centralt", Centrals, ClockFontSize, FontName, Clock_MktClosed );   	   
   	  ObjectSetText( "z[CP Time] Centrall", Centralp, TimezoneFontSize, FontName, Location_MktClosed ); 
   	  }
      }
    if(Mexico == 1)             
      {
      Mexicop= "Mexico";
      //Show if time zone is same as for broker server
      if(MexicoDT <= BrokerDT+600 && MexicoDT >= BrokerDT-600)
        { 
        if(StringLen(Mexicop) == 6)
          {          
          Mexicop= Mexicop + "  (B)";           
          }
        else
          {
          Mexicop= StringSubstr(Mexicop,0,StringLen(Mexicop)-1) + ",B)";          
          }   
        }
      //Show if time zone is same as local time   
      if(MexicoDT <= Local_Time+600 && MexicoDT >= Local_Time-600)
        { 
        if(StringLen(Mexicop) == 6)
          {          
          Mexicop= Mexicop + "  (L)";           
          }
        else
          {
          Mexicop= StringSubstr(Mexicop,0,StringLen(Mexicop)-1) + ",L)";          
          }   
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (MexicoDT <= pvtDT+600 && MexicoDT >= pvtDT-600))
        {
        if(StringLen(Mexicop) == 6)
          {
          Mexicop= Mexicop + "  (P)";    
          }
        else
          {
          Mexicop= StringSubstr(Mexicop,0,StringLen(Mexicop)-1) + ",P)";  
          }               
        }                                                            	     
   	if(TimeDayOfWeek(MexicoDT) != 0 && TimeDayOfWeek(MexicoDT) != 6 
   	  && TimeHour(MexicoDT) >= LocalOpenHour && TimeHour(MexicoDT) < LocalCloseHour)
   	  {
   	  ObjectSetText( "z[CP Time] Mexicot", Mexicos, ClockFontSize, FontName, Clock_MktOpen );   	   
   	  ObjectSetText( "z[CP Time] Mexicol", Mexicop, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
   	  {
   	  ObjectSetText( "z[CP Time] Mexicot", Mexicos, ClockFontSize, FontName, Clock_MktClosed );   	   
   	  ObjectSetText( "z[CP Time] Mexicol", Mexicop, TimezoneFontSize, FontName, Location_MktClosed );
   	  }
      }
    if(Mountain == 1)         
      { 
      Mountainp= "Mountain";
      //Show if time zone is same as for broker server
      if(MountainDT <= BrokerDT+600 && MountainDT >= BrokerDT-600)
        { 
        if(StringLen(Mountainp) == 8)
          {          
          Mountainp= Mountainp + "  (B)";           
          }
        else
          {
          Mountainp= StringSubstr(Mountainp,0,StringLen(Mountainp)-1) + ",B)";          
          }   
        }
      //Show if time zone is same as local time   
      if(MountainDT <= Local_Time+600 && MountainDT >= Local_Time-600)
        { 
        if(StringLen(Mountainp) == 8)
          {          
          Mountainp= Mountainp + "  (L)";           
          }
        else
          {
          Mountainp= StringSubstr(Mountainp,0,StringLen(Mountainp)-1) + ",L)";          
          }   
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (MountainDT <= pvtDT+600 && MountainDT >= pvtDT-600))
        {
        if(StringLen(Mountainp) == 8)
          {
          Mountainp= Mountainp + "  (P)";    
          }
        else
          {
          Mountainp= StringSubstr(Mountainp,0,StringLen(Mountainp)-1) + ",P)";  
          }               
        }                                             	                 	      
   	if(TimeDayOfWeek(MountainDT) != 0 && TimeDayOfWeek(MountainDT) != 6 
   	  && TimeHour(MountainDT) >= LocalOpenHour && TimeHour(MountainDT) < LocalCloseHour)
        {
  	     ObjectSetText( "z[CP Time] Mountaint", Mountains, ClockFontSize, FontName, Clock_MktOpen );      	
   	  ObjectSetText( "z[CP Time] Mountainl", Mountainp, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
   	  {
   	  ObjectSetText( "z[CP Time] Mountaint", Mountains, ClockFontSize, FontName, Clock_MktClosed );   	   
   	  ObjectSetText( "z[CP Time] Mountainl", Mountainp, TimezoneFontSize, FontName, Location_MktClosed );
   	  }
      }
    if(Pacific == 1)                
      { 
      Pacificp= "Pacific";
      //Show if time zone is same as for broker server
      if(PacificDT <= BrokerDT+600 && PacificDT >= BrokerDT-600)
        { 
        if(StringLen(Pacificp) == 7)
          {          
          Pacificp= Pacificp + "  (B)";           
          }
        else
          {
          Pacificp= StringSubstr(Pacificp,0,StringLen(Pacificp)-1) + ",B)";          
          }   
        }
      //Show if time zone is same as local time   
      if(PacificDT <= Local_Time+600 && PacificDT >= Local_Time-600)
        { 
        if(StringLen(Pacificp) == 7)
          {          
          Pacificp= Pacificp + "  (L)";           
          }
        else
          {
          Pacificp= StringSubstr(Pacificp,0,StringLen(Pacificp)-1) + ",L)";          
          }   
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (PacificDT <= pvtDT+600 && PacificDT >= pvtDT-600))
        {
        if(StringLen(Pacificp) == 7)
          {
          Pacificp= Pacificp + "  (P)";    
          }
        else
          {
          Pacificp= StringSubstr(Pacificp,0,StringLen(Pacificp)-1) + ",P)";  
          }               
        }                                                                 	     
   	if(TimeDayOfWeek(PacificDT) != 0 && TimeDayOfWeek(PacificDT) != 6 
   	  && TimeHour(PacificDT) >= LocalOpenHour && TimeHour(PacificDT) < LocalCloseHour)
   	  {
   	  ObjectSetText( "z[CP Time] Pacifict", Pacifics, ClockFontSize, FontName, Clock_MktOpen );  	   
   	  ObjectSetText( "z[CP Time] Pacificl", Pacificp, TimezoneFontSize, FontName, Location_MktOpen ); 
   	  }
   	else
        {
    	  ObjectSetText( "z[CP Time] Pacifict", Pacifics, ClockFontSize, FontName, Clock_MktClosed );     	
   	  ObjectSetText( "z[CP Time] Pacificl", Pacificp, TimezoneFontSize, FontName, Location_MktClosed );
        }
      }
    if(Local == 1)        
      {
      Localp= "Local";
      //Show if time zone is same as for broker server
      if(Local_Time == BrokerDT) 
        { 
        Localp= "Local  (B)";
        }
      //Show time zone is same as GMT   
      if(Local_Time == UTC)
        {
        if(StringLen(Localp) == 5)
          {          
          Localp= Localp + "  (G)";           
          }
        else
          {
          Localp= StringSubstr(Localp,0,StringLen(Localp)-1) + ",G)";          
          }   
        }                
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (Local_Time <= pvtDT+600 && Local_Time >= pvtDT-600))
        {
        if(StringLen(Localp) == 5)
          {
          Localp= Localp + "  (P)";    
          }
        else
          {
          Localp= StringSubstr(Localp,0,StringLen(Localp)-1) + ",P)";  
          }               
        }                                
      ObjectSetText( "z[CP Time] Localt", Locals, ClockFontSize, FontName,Clock_MktClosed );      
      ObjectSetText( "z[CP Time] Locall", Localp, TimezoneFontSize, FontName, Location_MktClosed ); 
      }
    }//End Clock               

  //Create SonicR Logo
  MakeLabel( item14, 147,2);   
  MakeLabel( item15, 148,15); 
  MakeLabel( item16, 148,26); 
  MakeLabel( item17, 149,40);
  MakeLabel( item18, 148,50); 
  MakeLabel( item19, 147,64);             
  ObjectSetText(item14, "S", 11, "Arial Bold",sonicS);      
  ObjectSetText(item15, "o", 10, "Arial Bold",sonicO);      
  ObjectSetText(item16, "n", 10, "Arial Bold",sonicN);   
  ObjectSetText(item17, "i", 10, "Arial Bold",sonicI);           
  ObjectSetText(item18, "c", 10, "Arial Bold",sonicC);       
  ObjectSetText(item19, "R", 11, "Arial Bold",sonicR); 

  //Separators---------------------------------------------------------------------------------   
  if(Separators_On && Period() <= __Separators_Max_TF) 
    {
    //Separators for Today and Tomorrow           
    CurrentSeparators("Today", Separators_Color, Separators_Style_01234, 
    Separators_Width_12345); 
             
    CurrentSeparators("Tomorrow", Separators_Color, Separators_Style_01234, 
    Separators_Width_12345);  
              
    //Separators for prior sessions 
    if(__Prior_Days_To_Show > 0)
      {     
      //Calculate bars per session        
           if (Period()==1) {bps = 1440;}   
      else {if (Period()==5) {bps = 288;}  
      else {if (Period()==15){bps = 96;}    
      else {if (Period()==30){bps = 48;}
      else {if (Period()==60){bps = 24;}
      else {if (Period()==240){bps = 6;} }}}}}        
      //Define bar starting prior sessions display      
      shift = iBarShift(NULL,NULL,iTime(NULL,PERIOD_D1,0));                       
      //Execute loop for bars per session X number of prior sessions to show   
      for(i= shift; i<=(shift+(bps*(__Prior_Days_To_Show))); i++)   
        {    
        if(TimeHour(Time[i]) == 0 && TimeMinute(Time[i]) == 0)         
          {                     
          PriorSeparators(i, Separators_Color, 
          Separators_Style_01234, Separators_Width_12345);                             
          }         
        }               
      }
    }//End Separators   

  //vLines-------------------------------------------------------------------------------------
  if(vLines_On && Period()<= __Current_Session_Max_TF)
    {                 
    //Calculate position for vline labels------------------------------------------------------
    if(vLabels_On)
      {  
      if (vLabels_Dist_To_Border < 1) {vLabels_Dist_To_Border = 1;}           
      top = WindowPriceMax();
      bottom = WindowPriceMin();
      scale = top - bottom; 
      if(vLabels_Chart_Top) 
        {           
        YadjustTop = scale/(13000/FontSize);     
        YadjustTop = YadjustTop + (vLabels_Dist_To_Border * YadjustTop);                          	      	
        level = top - YadjustTop;
        }                 
      else if(!vLabels_Chart_Top) 
        {
        vLabels_Dist_Above_Border = vLabels_Dist_To_Border + 3;
        YadjustBot = scale/(500/FontSize); 
        YadjustBot = YadjustBot + ((vLabels_Dist_Above_Border * YadjustBot)/20);   
        level = bottom + YadjustBot;
        }  
      }
                  
    //Do vlines for current session------------------------------------------------------------       
    if(Broker_GMT_Offset==0 && DayOfWeek()==0)
      {      
      if(__Current_Session_Ao)
        {
        OpenToday(vLabels_Asian_Open, GMT_At_Ao + Broker_GMT_Offset, 
        vLines_Color, vLines_Style_01234, vLines_Width_12345, level); 
        }
      //Calculate bars per session        
           if (Period()==1) {bps = 1440;}   
      else {if (Period()==5) {bps = 288;}  
      else {if (Period()==15){bps = 96;}    
      else {if (Period()==30){bps = 48;}
      else {if (Period()==60){bps = 24;} }}}}        
      //Define bar starting prior sessions display      
      shift = iBarShift(NULL,NULL,iTime(NULL,PERIOD_D1,0));               
      //Execute loop for bars per session X number of prior sessions to show    
      for(i= shift; i<=(shift+bps); i++)       
        {  
        h=TimeHour(Time[i]); 
        m=TimeMinute(Time[i]);

        //London Open vLine
        if(GMT_At_Lo+Broker_GMT_Offset<0) {GMT_At_Lo=GMT_At_Lo+24;}                
        MF = MathFloor(GMT_At_Lo); 
        if((Period() > 30) && (h == MF + Broker_GMT_Offset) && (m == 0))                
          {
          OpenPrior(i, vLabels_London_Open, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          }               
        else {if((GMT_At_Lo != MF) && (h == MF + Broker_GMT_Offset) && (m == 30)) 
          {                    
          OpenPrior(i, vLabels_London_Open, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          }                   
        else {if((GMT_At_Lo == MF) && (h == MF + Broker_GMT_Offset) && (m == 0))
          {
          OpenPrior(i, vLabels_London_Open, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          } }}   
         
        //NewYork Open vLine             
        if(GMT_At_NYo+Broker_GMT_Offset<0) {GMT_At_NYo=GMT_At_NYo+24;}                
        MF = MathFloor(GMT_At_NYo); 
        if((Period() > 30) && (h == MF + Broker_GMT_Offset) && (m == 0))                
          {
          OpenPrior(i, vLabels_NewYork_Open, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          }                  
        else {if((GMT_At_NYo != MF) && (h == MF + Broker_GMT_Offset) && (m == 30)) 
          {                    
          OpenPrior(i, vLabels_NewYork_Open, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          }                   
        else {if((GMT_At_NYo == MF) && (h == MF + Broker_GMT_Offset) && (m == 0))               
          {
          OpenPrior(i, vLabels_NewYork_Open, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          } }}            
               
        //London Close vLine           
        if(GMT_At_Lc+Broker_GMT_Offset<0) {GMT_At_Lc=GMT_At_Lc+24;}                                                      
        MF = MathFloor(GMT_At_Lc); 
        if((Period() > 30) && (h == MF + Broker_GMT_Offset) && (m == 0))                
          {
          OpenPrior(i, vLabels_London_Close, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          }                   
        else {if((GMT_At_Lc != MF) && (h == MF + Broker_GMT_Offset) && (m == 30)) 
          {                    
          OpenPrior(i, vLabels_London_Close, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          }                   
        else {if((GMT_At_Lc == MF) && (h == MF + Broker_GMT_Offset) && (m == 0))               
          {
          OpenPrior(i, vLabels_London_Close, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          } }}

        //Berlin Open vLine
        if(__Current_Session_Fo) {           
        if(GMT_At_Fo+Broker_GMT_Offset<0) {GMT_At_Fo=GMT_At_Fo+24;}                                                      
        MF = MathFloor(GMT_At_Fo); 
        if((Period() > 30) && (h == MF + Broker_GMT_Offset) && (m == 0))                
          {
          OpenPrior(i, vLabels_Berlin_Open, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          }                   
        else {if((GMT_At_Fo != MF) && (h == MF + Broker_GMT_Offset) && (m == 30)) 
          {                    
          OpenPrior(i, vLabels_Berlin_Open, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          }                   
        else {if((GMT_At_Fo == MF) && (h == MF + Broker_GMT_Offset) && (m == 0))               
          {
          OpenPrior(i, vLabels_Berlin_Open, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          } }}}                                                                                                        
        }//End prior sessions shift loop                                
      }//End Short Sunday loop for broker at GMT 
        
    else //for all brokers Monday thru Friday 
      {
      if(__Current_Session_Ao)
        {
        OpenToday(vLabels_Asian_Open, GMT_At_Ao + Broker_GMT_Offset, 
        vLines_Color, vLines_Style_01234, vLines_Width_12345, level); 
        }
      if(__Current_Session_Fo)
        {
        OpenToday(vLabels_Berlin_Open, GMT_At_Fo + Broker_GMT_Offset, 
        vLines_Color, vLines_Style_01234, vLines_Width_12345, level); 
        }                        
      OpenToday(vLabels_London_Open, GMT_At_Lo + Broker_GMT_Offset, 
      vLines_Color, vLines_Style_01234, vLines_Width_12345, level);
      OpenToday(vLabels_NewYork_Open, GMT_At_NYo + Broker_GMT_Offset,  
      vLines_Color,vLines_Style_01234, vLines_Width_12345, level);
      OpenToday(vLabels_London_Close, GMT_At_Lc + Broker_GMT_Offset, 
      vLines_Color, vLines_Style_01234, vLines_Width_12345, level);                         
      }                      
                                                                      
    //Do vlines for previous sessions----------------------------------------------------------
    if(__Prior_Sessions_To_Show >0 && Period() <= __Prior_Sessions_Max_TF)   
      {   
      //Calculate bars per session        
           if (Period()==1) {bps = 1440;}   
      else {if (Period()==5) {bps = 288;}  
      else {if (Period()==15){bps = 96;}    
      else {if (Period()==30){bps = 48;}
      else {if (Period()==60){bps = 24;} }}}}        
      //Define bar starting prior sessions display      
      shift = iBarShift(NULL,NULL,iTime(NULL,PERIOD_D1,0));               
      //Execute loop for bars per session X number of prior sessions to show    
      for(i= shift; i<=(shift+(bps*(__Prior_Sessions_To_Show))); i++)       
        {  
        h=TimeHour(Time[i]); 
        m=TimeMinute(Time[i]);
        
        //London Open vLine
        if(GMT_At_Lo+Broker_GMT_Offset<0) {GMT_At_Lo=GMT_At_Lo+24;}                
        MF = MathFloor(GMT_At_Lo); 
        if((Period() > 30) && (h == MF + Broker_GMT_Offset) && (m == 0))                
          {
          OpenPrior(i, vLabels_London_Open, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          }               
        else {if((GMT_At_Lo != MF) && (h == MF + Broker_GMT_Offset) && (m == 30)) 
          {                    
          OpenPrior(i, vLabels_London_Open, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          }                   
        else {if((GMT_At_Lo == MF) && (h == MF + Broker_GMT_Offset) && (m == 0))
          {
          OpenPrior(i, vLabels_London_Open, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          } }}   
         
        //NewYork Open vLine             
        if(GMT_At_NYo+Broker_GMT_Offset<0) {GMT_At_NYo=GMT_At_NYo+24;}                
        MF = MathFloor(GMT_At_NYo); 
        if((Period() > 30) && (h == MF + Broker_GMT_Offset) && (m == 0))                
          {
          OpenPrior(i, vLabels_NewYork_Open, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          }                  
        else {if((GMT_At_NYo != MF) && (h == MF + Broker_GMT_Offset) && (m == 30)) 
          {                    
          OpenPrior(i, vLabels_NewYork_Open, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          }                   
        else {if((GMT_At_NYo == MF) && (h == MF + Broker_GMT_Offset) && (m == 0))               
          {
          OpenPrior(i, vLabels_NewYork_Open, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          } }}            
               
        //London Close vLine           
        if(GMT_At_Lc+Broker_GMT_Offset<0) {GMT_At_Lc=GMT_At_Lc+24;}                                                      
        MF = MathFloor(GMT_At_Lc); 
        if((Period() > 30) && (h == MF + Broker_GMT_Offset) && (m == 0))                
          {
          OpenPrior(i, vLabels_London_Close, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          }                   
        else {if((GMT_At_Lc != MF) && (h == MF + Broker_GMT_Offset) && (m == 30)) 
          {                    
          OpenPrior(i, vLabels_London_Close, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          }                   
        else {if((GMT_At_Lc == MF) && (h == MF + Broker_GMT_Offset) && (m == 0))               
          {
          OpenPrior(i, vLabels_London_Close, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          } }}
          
        //Asian Open vLine
        if(__Current_Session_Ao) {           
        if(GMT_At_Ao+Broker_GMT_Offset<0) {GMT_At_Ao=GMT_At_Ao+24;}                                                      
        MF = MathFloor(GMT_At_Ao); 
        if((Period() > 30) && (h == MF + Broker_GMT_Offset) && (m == 0))                
          {
          OpenPrior(i, vLabels_Asian_Open, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          }                   
        else {if((GMT_At_Ao != MF) && (h == MF + Broker_GMT_Offset) && (m == 30)) 
          {                    
          OpenPrior(i, vLabels_Asian_Open, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          }                   
        else {if((GMT_At_Ao == MF) && (h == MF + Broker_GMT_Offset) && (m == 0))               
          {
          OpenPrior(i, vLabels_Asian_Open, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          } }}}
          
        //Berlin Open vLine
        if(__Current_Session_Fo) {           
        if(GMT_At_Fo+Broker_GMT_Offset<0) {GMT_At_Fo=GMT_At_Fo+24;}                                                      
        MF = MathFloor(GMT_At_Fo); 
        if((Period() > 30) && (h == MF + Broker_GMT_Offset) && (m == 0))                
          {
          OpenPrior(i, vLabels_Berlin_Open, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          }                   
        else {if((GMT_At_Fo != MF) && (h == MF + Broker_GMT_Offset) && (m == 30)) 
          {                    
          OpenPrior(i, vLabels_Berlin_Open, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          }                   
        else {if((GMT_At_Fo == MF) && (h == MF + Broker_GMT_Offset) && (m == 0))               
          {
          OpenPrior(i, vLabels_Berlin_Open, vLines_Color, vLines_Style_01234, 
          vLines_Width_12345, level);
          } }}}          
                                                                                              
        }//End prior sessions shift loop                            
      }//End prior sessions routine                        
    }//End vLines routine
  
   //End of program computations---------------------------------------------------------------        
  return(0);
  }

//+-------------------------------------------------------------------------------------------+
//| Indicator Subroutine To Compute Average Ranges                                            |                                                 
//+-------------------------------------------------------------------------------------------+ 
void Ranges (int period)
  {  
  int lx, lxx;
  ARg = 0;
  
  //Add ranges over period.  Count number of Sundays and exclude Sunday ranges.             
  for(i=1; i<=period; i++)
    {
    if (TimeDayOfWeek(iTime(NULL,PERIOD_D1,i))!=0) {
    ARg = ARg + iHigh(NULL,PERIOD_D1,i)- iLow(NULL,PERIOD_D1,i);}
    else {lx=lx+1;}
    }

  //For number of Sundays, add additional days of range
  for(ii=i; ii<=i-1+lx; ii++) 
    { 
    if (TimeDayOfWeek(iTime(NULL,PERIOD_D1,ii))!=0) 
      {       
      ARg = ARg + iHigh(NULL,PERIOD_D1,ii)- iLow(NULL,PERIOD_D1,ii);
      }
    else {lxx=lxx+1;} 
    }
   
  //If a Sunday reduced added days above, add additional day of range
  for(iii=ii; iii<=ii-1+lxx; iii++)
    {
    ARg = ARg + iHigh(NULL,PERIOD_D1,iii)- iLow(NULL,PERIOD_D1,iii);
    }
                        
  return;   
  }
  
//+-------------------------------------------------------------------------------------------+
//| Subroutine To name and draw Daily Pivot and Range HL lines and line labels                |                                                                                  |
//+-------------------------------------------------------------------------------------------+
void DrawLines(string text, int Line_Selection_Number, double Level, color Clr, 
  int style, int thickness)
  {
  //Lines====================================================================================== 
  if(Line_Selection_Number < 1 || Line_Selection_Number > 3) {Line_Selection_Number = 2;}

  //Name lines: lines with "a" make them subordinate to lines with "b" or "c".  Lines with 
  //"b" are subordinate to lines with "c".  Lines with "c" always on top. 
  if(StringSubstr(text, 0, 2) == "LV") //Levels lines
    {
    line = "a[CP Draw] " + text + " Line " + DoubleToStr(Level,Digits);      
    }
  else if(StringSubstr(text, 0, 1) == "R")//Range lines
    {
    line = "c[CP Draw] " +text + " Line " + DoubleToStr(Level,Digits);  
    }
  else //all pivots lines
    {
    line = "b[CP Draw] " + text + " Line " + DoubleToStr(Level,Digits);  
    }    
    
  //Define variables  
  a = style; b = thickness; c =1; if (a==0)c=b;  
  int Shift;
   
  //Where to Start lines
  //start chart left
  if(Line_Selection_Number == 1) 
    {startline = WindowFirstVisibleBar();}
  //start at day separator 
  else if(Line_Selection_Number == 2 || Line_Selection_Number == 3) 
    {
    Shift = 0;  if(Broker_GMT_Offset==0 && DayOfWeek()==0) {Shift = 1;}  
    startline = iTime(NULL, PERIOD_D1, Shift);
    }
                                                                              
  //Where to Stop Lines   
  //stop at chart right border
  if(Line_Selection_Number == 1) 
    {stopline = iTime(NULL,PERIOD_D1,0)+18748800; R2 = true;}
  //stop at end of current session
  else {if (Line_Selection_Number == 2) 
    {stopline = iTime(NULL,PERIOD_D1,0)+86400; R2 = false;}
  //stop seven TFs right of current bar
  else {if (Line_Selection_Number == 3) {stopline = startline+ 7*(Period()*60); R2 = false;} }} 
                             
  //Draw lines   
  ObjectCreate(line, OBJ_TREND, 0, startline, Level, stopline, Level);    
  ObjectSet(line, OBJPROP_STYLE, a);
  ObjectSet(line, OBJPROP_COLOR, Clr);
  ObjectSet(line, OBJPROP_WIDTH, c);
  if(Subordinate_Lines || StringSubstr(text,0,4) == "LVL") ObjectSet(line,OBJPROP_BACK,true); 
  else ObjectSet(line, OBJPROP_BACK, false);       
  ObjectSet(line, OBJPROP_RAY, R2);
   
  //Labels=====================================================================================
  //Exit if label not to be shown 
  if (StringSubstr(text, 0, 2) == "LV") {return;}        
  else {if ((!Pivot_PVT_Label_On) && (StringSubstr(text, 0, 2) == "PV")) {return;}
  else {if ((!Pivot_SRM_Labels_On) && ((StringSubstr(text, 1, 1) == "R") || 
       (StringSubstr(text, 1, 1) == "S") || (StringSubstr(text, 0, 1) == "M"))) {return;}
  else {if ((!Range_Labels_On) && ((StringSubstr(text, 0, 2) == "RD")
       || (StringSubstr(text, 0, 2) == "RW"))) {return;}  
  else 
    {      
    //Name label  
    if(StringSubstr(text, 0, 2) == "LV") //Levels lines
      {
      label = "a[CP Draw] " + text + " Label " + DoubleToStr(Level,Digits);      
      }
    else if(StringSubstr(text, 0, 1) == "R")//Range lines
      {
      label = "c[CP Draw] " +text + " Label " + DoubleToStr(Level,Digits);  
      }
    else //all pivots lines
      {
      label = "b[CP Draw] " + text + " Label " + DoubleToStr(Level,Digits);  
      }          
              
    //Pivots: Remove main pivot number
    if(StringSubstr(text, 0, 1) == "P") 
      {
      text = StringSubstr(text, 0, 3); 
      }
            
    //Pivot Labels: adjust for inclusion of "type" tags     
    if((StringSubstr(text, 0, 1) == "D") || (StringSubstr(text, 0, 1) == "F") || 
      (StringSubstr(text, 0, 1) == "M") || (StringSubstr(text, 0, 1) == "P"))
      {
      //Do this if PivotsTZ are displayed      
      if((PivotsTz_On) && (Pivots_PVT_On || Pivots_SR_On)) 
        {
        //Append "Preferred Pivots" tag
        if(__Use_Preferred_Offset || __Alternative_GMT_Offset == Berlin_GMT_Offset) 
          {
          text = "   " + text + "^";
          }
        //Append less than "Preferred Pivots" tag  
        else if(__Alternative_GMT_Offset < Berlin_GMT_Offset) {text = "   " + text + "<";}
        //Append greater than "Preferred Pivots" tag 
        else if(__Alternative_GMT_Offset > Berlin_GMT_Offset) {text = "   " + text + ">";}
        }
      //Otherwise Broker pivots are displayed and append no tag 
      else {text = "   " + text + "  ";}  
      }
                 
    //All other labels 
    else 
      {        
      text = "  " + text + " ";
      }     

    //Where to put labels
    if (Line_Selection_Number == 1)
      { 
      //start at mid-chart
      spc = ""; //00 
      startlabel = Time[WindowFirstVisibleBar()/2];           
      }
    else {if (Line_Selection_Number == 2)
      {
      Shift = 0;  if(Broker_GMT_Offset==0 && DayOfWeek()==0) {Shift = 1;}          
      if(Time[WindowFirstVisibleBar()] < iTime(NULL, PERIOD_D1, 0)) 
        {        
        //start at day separator if it is in chart window
        spc="        "; //08                           
        startlabel= iTime(NULL, PERIOD_D1, Shift); 
        }          
      else      
        {
        //start at mid-chart
        spc = ""; //00 
        startlabel = Time[WindowFirstVisibleBar()/2];                                
        } 
      }                       
    else {if (Line_Selection_Number == 3)   
      {
      //start at current candle + Scale Shift to right 
      spc="         "; //09                   
      startlabel = Time[0] + T4; 
      } }}
                                
    //Draw labels                              
    ObjectCreate(label, OBJ_TEXT, 0, startlabel, Level);     
    ObjectSetText(label, spc + text, FontSize, FontStyle, Labels_Color);
    if(Subordinate_Labels) ObjectSet(label,OBJPROP_BACK,true);   
    else ObjectSet(label, OBJPROP_BACK, false);
    } }}}  
  }
   
//+-------------------------------------------------------------------------------------------+
//| Subroutine to Create Today and Tomorrow Separators                                        |          
//+-------------------------------------------------------------------------------------------+   
void CurrentSeparators(string text, color Clr, int style, int thickness) 
  {
  a = style;
  b = thickness;
  c =1; if (a==0)c=b; 
      
  //Define datetime for start of current session vline separator
  if(text == "Today")       
    { 
    dt= TimeYear(iTime(NULL,0,0))+ "." +TimeMonth(iTime(NULL,0,0))+ "." + 
        TimeDay(iTime(NULL,PERIOD_D1,0))+ "." + 0 + ":" + "0";                                        
    T3 = StrToTime(dt);           
    vline  = "[CP Draw] Current Session Line";     
    } 
      
  //Define datetime for end of current session vline separator
  else                
    {
    dt= TimeYear(iTime(NULL,0,0))+ "." +TimeMonth(iTime(NULL,0,0))+ "." + 
        TimeDay(iTime(NULL,PERIOD_D1,0))+ "." + 24 + ":" + "60";                                        
    T3 = StrToTime(dt)+60;                
    vline  = "[CP Draw] Tomorrow Session Line";            
    }
  
  //Draw vLines                       
  if(!Separators_Thru_SubWindows) {ObjectCreate(vline, OBJ_TREND, 0, T3, 0, T3, 100);}  
  else {ObjectCreate(vline, OBJ_VLINE, 0, T3, 0);}
  ObjectSet(vline, OBJPROP_STYLE, a);    
  ObjectSet(vline, OBJPROP_WIDTH, c);
  ObjectSet(vline, OBJPROP_COLOR, Clr);
  ObjectSet(vline, OBJPROP_BACK, true); 
  }
      
//+-------------------------------------------------------------------------------------------+
//| Subroutine to Create Prior Sessions Separators                                            |          
//+-------------------------------------------------------------------------------------------+   
void PriorSeparators(int si, color Clr, int style, int thickness)
  {
  a = style;
  b = thickness;
  c =1; if (a==0)c=b;   
  vline  = "[CP Draw] Prior Session Line " + (si-1);       
  
  //Draw Separator                               
  if(!Separators_Thru_SubWindows) 
    {ObjectCreate(vline, OBJ_TREND, 0, Time[i], 0, Time[i], 100);} 
  else {ObjectCreate(vline, OBJ_VLINE, 0, Time[i], 0);}     
  ObjectSet(vline, OBJPROP_STYLE, a);    
  ObjectSet(vline, OBJPROP_WIDTH, c);
  ObjectSet(vline, OBJPROP_COLOR, Clr);
  ObjectSet(vline, OBJPROP_BACK, true);  
  } 

//+-------------------------------------------------------------------------------------------+
//| Subroutine to Create Market Open Lines And Labels For Current Session                     |          
//+-------------------------------------------------------------------------------------------+   
void OpenToday(string text,int time1,color Clr,int style,int thickness,double Level) 
  {
  a = style;
  b = thickness;
  c =1; if (a==0)c=b;

  vline  = "[CP Draw]  " + StringTrimLeft(text) + " Current Session Line";    
  vlabel = "[CP Draw]  " + StringTrimLeft(text) + " Current Session Label";   
  time2 = time1;  
  if(time2<0) {time2 = time2 + 24;}
  time3 = MathFloor(time2); 
  dt= TimeYear(iTime(NULL,0,0))+ "." +TimeMonth(iTime(NULL,0,0))+ "." + 
      TimeDay(iTime(NULL,PERIOD_D1,0))+ "." +time3+":"+"0";               
  time4 = StrToTime(dt);      
  if(time2 != time3) {time4 = time4 + 1800;}  //add half hour  
   
  //Draw vLines                          
  if(!vLines_Thru_SubWindows) {ObjectCreate(vline, OBJ_TREND, 0, time4, 0, time4, 100);}  
  else {ObjectCreate(vline, OBJ_VLINE, 0, time4, 0);}
  ObjectSet(vline, OBJPROP_STYLE, a);    
  ObjectSet(vline, OBJPROP_WIDTH, c);
  ObjectSet(vline, OBJPROP_COLOR, Clr);
  ObjectSet(vline, OBJPROP_BACK, true); 

  //Draw labels   
  if(vLabels_On)  
    {                                     
    ObjectCreate (vlabel, OBJ_TEXT, 0, time4, Level);
    ObjectSetText(vlabel, text, vFontSize, vFontStyle, vLabels_Color);
    ObjectSet(vlabel, OBJPROP_BACK, true);      
    }
  }

//+-------------------------------------------------------------------------------------------+
//| Subroutine to Create Market Open Lines And Labels For Prior Sessions                      |          
//+-------------------------------------------------------------------------------------------+   
void OpenPrior(int mi, string text, color Clr, int style, int thickness, double Level) 
  {   
  a = style;
  b = thickness;
  c =1; if (a==0)c=b;
  
  vline  = "[CP Draw]  " + StringTrimLeft(text) + " Prior Session Line " + (mi-1);    
  vlabel = "[CP Draw]  " + StringTrimLeft(text) + " Prior Session Label " + (mi-1); 

  //Draw vLine                 
  if(!vLines_Thru_SubWindows) {ObjectCreate(vline, OBJ_TREND, 0, Time[mi], 0, Time[mi], 100);} 
  else {ObjectCreate(vline, OBJ_VLINE, 0, Time[mi], 0);}     
  ObjectSet(vline, OBJPROP_STYLE, a);    
  ObjectSet(vline, OBJPROP_WIDTH, c);
  ObjectSet(vline, OBJPROP_COLOR, Clr);
  ObjectSet(vline, OBJPROP_BACK, true); 
  
  //Draw labels  
  if(vLabels_On) 
    {                                           
    ObjectCreate (vlabel, OBJ_TEXT, 0, Time[mi], Level);
    ObjectSetText(vlabel, text, vFontSize, vFontStyle, vLabels_Color);
    ObjectSet(vlabel, OBJPROP_BACK, true);         
    }    
  }

//+-------------------------------------------------------------------------------------------+
//| TzShift sub-routine computes index of first/last bars of yesterday & first bar  of today  |
//+-------------------------------------------------------------------------------------------+
void TzShift(int &ltzdiff,int &lidxfirstbartoday,int &lidxfirstbaryesterday,int &lidxlastbaryesterday)              
  {      
  tzdiffsec            = ltzdiff*3600; 
  barsperday           = (1440/PERIOD_H1);      
  dayofweektoday       = TimeDayOfWeek(iTime(NULL, PERIOD_H1, 0) - tzdiffsec);
  dayofweektofind      = -1;     
  datetime timet, timey, timey2;
          
  //Due to gaps in the data, and shift of time around weekends (due to time zone)
  //it is not as easy as to just look back for a bar with 00:00 time  
  lidxfirstbartoday= 0; lidxfirstbaryesterday= 0;  lidxlastbaryesterday= 0;     
  switch (dayofweektoday) { 
     case 0: dayofweektofind = 5; break; // Sun (Sunday considered as short trading day)
     default: dayofweektofind = dayofweektoday -1; break;}                    

  //Search backwards for the last occurence of a "today's first bar"
  for(i=1; i<=barsperday + 1; i++){
    timet = iTime(NULL, PERIOD_H1, i) - tzdiffsec;
      if(TimeDayOfWeek(timet) != dayofweektoday) {lidxfirstbartoday = i-1;break;}}
  for(j= 0; j<=2*barsperday + 1; j++) {
    timey = iTime(NULL, PERIOD_H1, i+j) - tzdiffsec;
    if(TimeDayOfWeek(timey) == dayofweektofind) {lidxlastbaryesterday = i+j; break;}}
  for(j= 1; j<=barsperday; j++) {
    timey2 = iTime(NULL, PERIOD_H1, lidxlastbaryesterday+j) - tzdiffsec;
    if(TimeDayOfWeek(timey2) != dayofweektofind) 
      {lidxfirstbaryesterday = lidxlastbaryesterday+j-1; break;}}
      
//Start - Added by CaveMan to cater for missing/partial previous day's data        
  //Search for Friday's data range if yesterday is a Sunday  
  if(dayofweektofind == 0)
    {
    //Search backwards for the last occurence of a "today's first bar"
    for(i=1; i<=barsperday + 1; i++){
       timet = iTime(NULL, PERIOD_H1, i) - tzdiffsec;
       if(TimeDayOfWeek(timet) != dayofweektoday) {lidxfirstbartoday = i-1;break;}}
    for(j= 0; j<=2*barsperday + 1; j++) {
       timey = iTime(NULL, PERIOD_H1, i+j) - tzdiffsec;
       if(TimeDayOfWeek(timey) == 5) {lidxlastbaryesterday = i+j; break;}}
    for(j= 1; j<=barsperday; j++) {
       timey2 = iTime(NULL, PERIOD_H1, lidxlastbaryesterday+j) - tzdiffsec;
       if(TimeDayOfWeek(timey2) != 5){lidxfirstbaryesterday = lidxlastbaryesterday+j-1;break;}}
    } 
                      
  //This section takes care of the Christmas and New Year Day problem where there is a day 
  //of partial data on the eve of these holidays followed by an entire day without any data  
  //at all. The workaround to handle this on market open after the holiday is to use data 
  //from the day before the eve of the holiday right up to the end of the eve of the holiday 
  //for pivot computation. E.g. On the 26 December market opens after Christmas. Use full 
  //day data of 23rd plus partial data of 24th Dec to compute the pivots. Same applies to 
  //New Year Day.
  int YesterdayBarsTotal = lidxfirstbaryesterday - lidxlastbaryesterday;
  if(YesterdayBarsTotal == 0)   
    {
    if (dayofweektofind == 0) {dayofweektofind = 4;} 
    else if (dayofweektofind == 1) {dayofweektofind = 5;} 
    else {dayofweektofind = dayofweektofind - 1;}

    //Repeat this search with the new dayofweektofind information
    for(i=1; i<=barsperday + 1; i++) {
       timet = iTime(NULL, PERIOD_H1, i) - tzdiffsec;
       if(TimeDayOfWeek(timet) != dayofweektoday) {lidxfirstbartoday = i-1;break;}}
    for(j= 0; j<=2*barsperday + 1; j++) {
       timey = iTime(NULL, PERIOD_H1, i+j) - tzdiffsec;
       if(TimeDayOfWeek(timey) == dayofweektofind) {lidxlastbaryesterday = i+j; break;}}
    for(j= 1; j<=3*barsperday; j++) {
       timey2 = iTime(NULL, PERIOD_H1, lidxlastbaryesterday+j) - tzdiffsec;
       if(TimeDayOfWeek(timey2) != dayofweektofind) 
         {lidxfirstbaryesterday = lidxlastbaryesterday+j-1;break;}}
    YesterdayBarsTotal = lidxfirstbaryesterday - lidxlastbaryesterday;
    }            
  //Standard codes to handle days of partial data (including Fridays and Sundays)
  //If one hour bars < 24, use additional data from one more day back 
  if(YesterdayBarsTotal < 23)
    {
    //for Sunday, search Thursday and found Thursday partial data, then search Wednesday. 
    if (dayofweektoday == 0 && dayofweektofind == 4) {dayofweektofind = 3;} 
    //for Monday, Friday no data then include Thursday and Sunday data.
    else if (dayofweektoday == 1 && dayofweektofind == 4) {dayofweektofind = 4;} 
    else if (dayofweektofind == 0 || dayofweektofind == 1) { dayofweektofind = 5;} 
    else {dayofweektofind = dayofweektofind - 1;}
    //Search backwards for the last occurence of a "today's first bar"
    for(i=1; i<=barsperday + 1; i++) {
      timet = iTime(NULL, PERIOD_H1, i) - tzdiffsec;
      if(TimeDayOfWeek(timet) != dayofweektoday) {lidxfirstbartoday = i-1;break;}}
    for(j= 0; j<=3*barsperday + 1; j++) { // Need to increase another 24 hours to search
      timey = iTime(NULL, PERIOD_H1, i+j) - tzdiffsec;
      if(TimeDayOfWeek(timey) == dayofweektofind) {lidxlastbaryesterday = i+j; break;}}
    for(j= 1; j<=4*barsperday; j++) {
      timey2 = iTime(NULL, PERIOD_H1, lidxlastbaryesterday+j) - tzdiffsec;
      if(TimeDayOfWeek(timey2) != dayofweektofind)
        {lidxfirstbaryesterday = lidxlastbaryesterday+j-1;break;}}                             
    //This small section handles a very unique combination of events that coincide during the 
    //short opening trading hours of the Sunday following Christmas Day and New Year Day if 
    //both of these holidays happen to fall on a Thursday.  This occured on the short Sunday 
    //trading hours before Monday kicks in. For those few hours, pivot used on Friday are 
    //extended into Sunday. These pivot levels are calculated using full Thursday's data. In 
    //this unique situation, Thursday was New Year Day (major public holiday)with no data at 
    //all. This will cause TzPivot to malfunction in similar situation in the future. As a 
    //workaround, for those short few hours of Sunday, if a similar situation should occur,
    //partial data of Wednesday and Friday will be used for pivot computation.  
    YesterdayBarsTotal = lidxfirstbaryesterday - lidxlastbaryesterday;
    if(YesterdayBarsTotal == 0)   
      {
      if(dayofweektofind == 1) {dayofweektofind = 5;}
      else{dayofweektofind = dayofweektofind - 1;}
      //Repeat this search with the new dayofweektofind information
      for(i=1; i<=barsperday + 1; i++) {
        timet = iTime(NULL, PERIOD_H1, i) - tzdiffsec;
        if(TimeDayOfWeek(timet) != dayofweektoday) {lidxfirstbartoday = i-1;break;}}
      for(j= 0; j<=2*barsperday + 1; j++) {
        timey = iTime(NULL, PERIOD_H1, i+j) - tzdiffsec;
        if(TimeDayOfWeek(timey) == dayofweektofind) {lidxlastbaryesterday = i+j; break;}}
      for(j= 1; j<=3*barsperday; j++) {
        timey2 = iTime(NULL, PERIOD_H1, lidxlastbaryesterday+j) - tzdiffsec;
        if(TimeDayOfWeek(timey2) != dayofweektofind)
          {lidxfirstbaryesterday = lidxlastbaryesterday+j-1;break;}}
      lidxlastbaryesterday = lidxfirstbartoday + 1;
         }                     
    //Include partial day's data and combine with previous day's data for pivot computation. 
    //Do not include for Sundays as Sunday short trading hours uses Friday's pivots that are 
    //computed from full Thursday's data.  This is more for handling of holidays including 
    //Christmas and New Year Day. . 
    if (dayofweektoday != 0) lidxlastbaryesterday = lidxfirstbartoday + 1; 
    }          
//End - Added by CaveMan to cater for missing/partial previous day's data 
  }                                

//+-------------------------------------------------------------------------------------------+
//| Subroutine to make city and time labels                                                   |
//+-------------------------------------------------------------------------------------------+
void MakeLabel( string n, int xoff, int yoff )
  {
  if(ObjectFind(n) != 0)
    {    
    ObjectCreate( n, OBJ_LABEL, 0, 0, 0 );
    ObjectSet( n, OBJPROP_CORNER, 0 );
    ObjectSet( n, OBJPROP_XDISTANCE, xoff );
    ObjectSet( n, OBJPROP_YDISTANCE, yoff );
    ObjectSet( n, OBJPROP_BACK, false ); 
    }
  else{ObjectMove(n, 0, xoff, yoff);}       
  } 
  
//+-------------------------------------------------------------------------------------------+
//| Subroutine to convert time to a string for time labels                                    |
//+-------------------------------------------------------------------------------------------+
string TimeToStrings( datetime when )
   {
   hour = TimeHour( when );
   if ( !Show_AMPM_Time ) 
      {
      timeStr = (TimeToStr( when, TIME_MINUTES));
      }

   // User wants 12HourTime format with "AM" or "PM".   
   // FYI, if >12:00, subtract 12 hours in seconds which is 12*60*60=43200
   else
      {
      if ( hour > 12 || hour == 0) timeStr = TimeToStr( (when - 43200), TIME_MINUTES);
      else timeStr = TimeToStr( when, TIME_MINUTES);
      if ( hour >= 12) timeStr = StringConcatenate(timeStr, " PM");
      else timeStr = StringConcatenate(timeStr, " AM");
      }
   return (timeStr);
   }
   
//+-------------------------------------------------------------------------------------------+
//| Subroutine to retrieve date and time from time array                                      |
//+-------------------------------------------------------------------------------------------+
datetime TimeArrayToTime(int& lLocalTimeArray[])
  {  
  nYear=lLocalTimeArray[0]&0x0000FFFF;
  nMonth=lLocalTimeArray[0]>>16;
  nDay=lLocalTimeArray[1]>>16;
  nHour=lLocalTimeArray[2]&0x0000FFFF;
  nMin=lLocalTimeArray[2]>>16;
  nSec=lLocalTimeArray[3]&0x0000FFFF;
  nMilliSec=lLocalTimeArray[3]>>16;
  LocalTimeS = FormatDateTime(nYear,nMonth,nDay,nHour,nMin,nSec);
  Local_Time = StrToTime( LocalTimeS );
  return(Local_Time);
  }   

//+-------------------------------------------------------------------------------------------+
//| Subroutine to format time labels                                                          |
//+-------------------------------------------------------------------------------------------+
string FormatDateTime(int lnYear,int lnMonth,int lnDay,int lnHour,int lnMin,int lnSec)
  {
  sMonth=100+lnMonth;
  sMonth=StringSubstr(sMonth,1);
  sDay=100+lnDay;
  sDay=StringSubstr(sDay,1);
  sHour=100+lnHour;
  sHour=StringSubstr(sHour,1);
  sMin=100+lnMin;
  sMin=StringSubstr(sMin,1);
  sSec=100+lnSec;
  sSec=StringSubstr(sSec,1);
  return(StringConcatenate(lnYear,".",sMonth,".",sDay," ",sHour,":",sMin,":",sSec));
  }    
//+-------------------------------------------------------------------------------------------+
//| Subroutine to get time zone information for each city                                     |
//+-------------------------------------------------------------------------------------------+
void Get04TimeZoneInfo(int& lSydneyTZInfoArray[], int& lBerlinTZInfoArray[],
     int& lLondonTZInfoArray[], int& lNewYorkTZInfoArray[])
  
   {
   lSydneyTZInfoArray[0]  = -600;
   lSydneyTZInfoArray[17] = 262144; //4<<16 == 262144  April
   lSydneyTZInfoArray[18] = 65536;  //1<<16 == 65536   1st Sunday
   lSydneyTZInfoArray[19] = 3;
   lSydneyTZInfoArray[20] = 0;
   lSydneyTZInfoArray[21] = 0;
   lSydneyTZInfoArray[38] = 655360; //10<<16 == 655360  October
   lSydneyTZInfoArray[39] = 65536;  //1<<16 == 65536    1st Sunday
   lSydneyTZInfoArray[40] = 2;
   lSydneyTZInfoArray[41] = 0;
   lSydneyTZInfoArray[42] = -60;

   lLondonTZInfoArray[0]  = 0;
   lLondonTZInfoArray[17] = 655360; //10<<16 == 655360  October
   lLondonTZInfoArray[18] = 327680; //5<<16 == 327680.  5th/Last Sunday. 
   lLondonTZInfoArray[19] = 2;
   lLondonTZInfoArray[20] = 0;
   lLondonTZInfoArray[21] = 0;
   lLondonTZInfoArray[38] = 196608; //3<<16 == 196608  March
   lLondonTZInfoArray[39] = 327680; //5<<16 == 327680  5th/Last Sunday
   lLondonTZInfoArray[40] = 1;
   lLondonTZInfoArray[41] = 0;
   lLondonTZInfoArray[42] = -60;
   
   // FYI, Berlin = Belgrade, Brussels, Paris, Sarajevo
   ArrayCopy(lBerlinTZInfoArray, lLondonTZInfoArray);
   lBerlinTZInfoArray[0] = -60;
        
   lNewYorkTZInfoArray[0]  = 300;
   lNewYorkTZInfoArray[17] = 720896; //wYear = 0. wMonth = 11, and 11<<16 == 720896
   lNewYorkTZInfoArray[18] = 65536;  //wDOW = 0 = Sunday. nDay = 1 and 1<<16 == 65536 
   lNewYorkTZInfoArray[19] = 2;
   lNewYorkTZInfoArray[20] = 0;
   lNewYorkTZInfoArray[21] = 0;
   lNewYorkTZInfoArray[38] = 196608; //3<<16 == 196608  March
   lNewYorkTZInfoArray[39] = 131072; //2<<16 == 131072  2nd Sunday
   lNewYorkTZInfoArray[40] = 2;
   lNewYorkTZInfoArray[41] = 0;
   lNewYorkTZInfoArray[42] = -60;
   }
   
//+-------------------------------------------------------------------------------------------+
//| Subroutine to get time zone information for each city                                     |
//+-------------------------------------------------------------------------------------------+
void Get14TimeZoneInfo(int& lAucklandTZInfoArray[], int& lTokyoTZInfoArray[], 
   int& lChinaTZInfoArray[], int& lJakartaTZInfoArray[], int& lIndiaTZInfoArray[], 
   int& lDubaiTZInfoArray[], int& lMoscowTZInfoArray[], int& lIsraelTZInfoArray[], 
   int& lHelsinkiTZInfoArray[], int& lBrazilTZInfoArray[], int& lCentralTZInfoArray[], 
   int& lMexicoTZInfoArray[], int& lMountainTZInfoArray[], int& lPacificTZInfoArray[])
   
   {
   lAucklandTZInfoArray[0]  = -720;
   lAucklandTZInfoArray[17] = 262144; //4<<16 == 262144  April
   lAucklandTZInfoArray[18] = 65536;  //1<<16 == 65536   l1st Sunday
   lAucklandTZInfoArray[19] = 3;
   lAucklandTZInfoArray[20] = 0;
   lAucklandTZInfoArray[21] = 0;
   lAucklandTZInfoArray[38] = 589824; //9<<16 == 589824  September
   lAucklandTZInfoArray[39] = 327680; //5<<16 == 327680  5th/Last Sunday
   lAucklandTZInfoArray[40] = 2;
   lAucklandTZInfoArray[41] = 0;
   lAucklandTZInfoArray[42] = -60;
   
   // FYI Tokyo = Seoul
   lTokyoTZInfoArray[0]  = -540;
   lTokyoTZInfoArray[17] = 0; 
   lTokyoTZInfoArray[18] = 0;
   lTokyoTZInfoArray[19] = 0;
   lTokyoTZInfoArray[20] = 0;
   lTokyoTZInfoArray[21] = 0;
   lTokyoTZInfoArray[38] = 0;
   lTokyoTZInfoArray[39] = 0;
   lTokyoTZInfoArray[40] = 0;
   lTokyoTZInfoArray[41] = 0;
   lTokyoTZInfoArray[42] = 0;
   
   // FYI, Beijing = Perth, Singapore, Taipei, Hong Kong
   ArrayCopy(lChinaTZInfoArray, lTokyoTZInfoArray);
   lChinaTZInfoArray[0] = -480;
   
   // FYI, Jakarta = Bangkok
   ArrayCopy(lJakartaTZInfoArray, lTokyoTZInfoArray);
   lJakartaTZInfoArray[0] = -420;
   
   ArrayCopy(lIndiaTZInfoArray, lTokyoTZInfoArray);
   lIndiaTZInfoArray[0]   = -330;  // NOTE! Top of the hour is 30 min off most world timezones.
   
   ArrayCopy(lDubaiTZInfoArray, lTokyoTZInfoArray);
   lDubaiTZInfoArray[0]   = -240;
 
   lIsraelTZInfoArray[0]  = -120;
   lIsraelTZInfoArray[17] = 589824;  //9<<16 == 589824  September
   lIsraelTZInfoArray[18] = 131072;  //2<<16  = 131072
   lIsraelTZInfoArray[19] = 2;
   lIsraelTZInfoArray[20] = 0;
   lIsraelTZInfoArray[21] = 0;
   lIsraelTZInfoArray[38] = 196608; //3<<16 == 196608  March
   lIsraelTZInfoArray[39] = 327685; //5<<16  = 327680 AND "5" (*IF* Sunday is "0", is "5" Friday??)
   lIsraelTZInfoArray[40] = 2;
   lIsraelTZInfoArray[41] = 0;
   lIsraelTZInfoArray[42] = -60;
   
   ArrayCopy(lMoscowTZInfoArray, LondonTZInfoArray);
   lMoscowTZInfoArray[0]  = -180;
   lMoscowTZInfoArray[19] = 3;
   lMoscowTZInfoArray[40] = 2;
   
   // FYI, Helsinki = Athens
   ArrayCopy(lHelsinkiTZInfoArray, LondonTZInfoArray);
   lHelsinkiTZInfoArray[0]  = -120;
   lHelsinkiTZInfoArray[19] = 4;
   lHelsinkiTZInfoArray[40] = 3;
   
   // FYI, Berlin = Belgrade, Brussels, Paris, Sarajevo
   //ArrayCopy(lBerlinTZInfoArray, lMoscowTZInfoArray);
   //lBerlinTZInfoArray[0] = -60;
   
   // NOTE! Brazil's ST/DST is likely a hardcoded date which will need updating EVERY YEAR!
   lBrazilTZInfoArray[0]  = 180;
   lBrazilTZInfoArray[17] = 131072;   //2<<16  = 131072
   lBrazilTZInfoArray[18] = 196614;   //3<<16 == 196608 AND 6, so, Saturday?? or Mar 6?
   lBrazilTZInfoArray[19] = 3866647;
   lBrazilTZInfoArray[20] = 65470523;
   lBrazilTZInfoArray[21] = 0;
   lBrazilTZInfoArray[38] = 655360;   //10<<16 == 655360
   lBrazilTZInfoArray[39] = 196614;
   lBrazilTZInfoArray[40] = 3866647;
   lBrazilTZInfoArray[41] = 65470523;
   lBrazilTZInfoArray[42] = -60;
   
   //ArrayCopy(BuenasAriesTZInfoArray, BuenasAriesTZInfoArray);
   //BuenasAriesTZInfoArray[0] = 180;
   
   ArrayCopy(lCentralTZInfoArray, NewYorkTZInfoArray);
   lCentralTZInfoArray[0] = 360;
 
   lMexicoTZInfoArray[0]  = 360;
   lMexicoTZInfoArray[17] = 655360; //10<<16 == 655360  October
   lMexicoTZInfoArray[18] = 327680; //5<<16 == 327680  5th/Last Sunday
   lMexicoTZInfoArray[19] = 2;
   lMexicoTZInfoArray[20] = 0;
   lMexicoTZInfoArray[21] = 0;
   lMexicoTZInfoArray[38] = 262144; //4<<16 == 262144  April
   lMexicoTZInfoArray[39] = 65536;  //1<<16 == 65536   l1st Sunday
   lMexicoTZInfoArray[40] = 2;
   lMexicoTZInfoArray[41] = 0;
   lMexicoTZInfoArray[42] = -60;
   
   ArrayCopy(lMountainTZInfoArray, NewYorkTZInfoArray);
   MountainTZInfoArray[0] = 420;
   
   ArrayCopy(lPacificTZInfoArray, NewYorkTZInfoArray);
   lPacificTZInfoArray[0] = 480;   
   } 
   
//+-------------------------------------------------------------------------------------------+
//| Subroutine:  Set up to get the chart scale number                                         |
//+-------------------------------------------------------------------------------------------+
void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)                                                    
  {
  Chart_Scale = ChartScaleGet();
  init();  
  }

//+-------------------------------------------------------------------------------------------+
//| Subroutine:  Get the chart scale number                                                   |
//+-------------------------------------------------------------------------------------------+
int ChartScaleGet()
  {
  long result = -1;
  ChartGetInteger(0,CHART_SCALE,0,result);
  return((int)result);
  }
       
//+-------------------------------------------------------------------------------------------+
//| Indicator End                                                                             |                                                        
//+-------------------------------------------------------------------------------------------+      

