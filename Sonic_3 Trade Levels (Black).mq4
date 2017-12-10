//+-------------------------------------------------------------------------------------------+
//|                                                                                           |
//|                                 SonicR Trade Levels.mq4                                   | 
//|                                                                                           |
//+-------------------------------------------------------------------------------------------+
//|                                                                                           |
//|    This indicator is a re-implimentation of the Trade Levels work by traderathome and     |
//|    St3ve.  The look and feel should be the same.  However, everything is automatic.       |
//|                                                                                           |
//|    Changes from before:                                                                   |
//|    - All trade datum is automatically obtained from MT4 orders, no manual inputs are      |
//|      are provided for.                                                                    |
//|    - The same exacting line and label placements for all time frame charts is now         | 
//|      fully automated using new MQL4 "Chart_Scale" tracking.                               |
//|    - This upgrade permits variable size entries, a big advantage.  It permits entries     |
//|      to be closed at different times and at different prices, another huge advantage.     |
//|    - Open and closed trades can be displayed on the same chart concurrently.              |
//|    - Everything is based on the number of micro-lots traded, the smallest MT4 unit,       |
//|      making this applicable across the entire spectrum of forex traders.                  |
//|    - The user can choose to display unit sizes traded based on micro-lot units,           |
//|      mini-lot units or full lot units with a simple "1-2-3" input.                        |                                 
//|    - EP Levels lines/labels can be turned on/off for a cleaner chart when not needed.     |
//|      When displayed, they include the number of units traded at each EP.                  |
//|    - Price labels and/or Price Dots at trade entries and exits improve visibility.        |
//|    - Connecting lines can be shown between the EP and the current bid/ask price of        |
//|      open trades, and between the EP and close price of closed trades.  These lines       |
//|      are color coded to show if the specific trade is in profit or loss.                  |
//|    - A pips Profit/Loss label displays for both open & closed trades.  P/L Monies and     |
//|      P/L Account % can be included in the P/L label.                                      |
//|    - Closed trades can be precisely segregated for display with new "yyyy.mm.dd hh:mm"    |
//|      inputs for the start and end of the display.                                         | 
//|                                                                                           |
//|                                                                               - qFish     |
//+-------------------------------------------------------------------------------------------+
#property copyright "Copyright @ 2014 traderathome and qFish"
#property link      "email: traderathome@msn.com" 

/*---------------------------------------------------------------------------------------------
User Notes:

This indicator is coded to run on MT4 Build 600.

This indicator shows labeled lines on the chart at the average level (AV) of the various 
entries made, as well as the take profit level (TP) and the stop loss level (SL).  Everything
is based on MT4 entry orders executed.  Variable sized entries are accommodated.  This 
indicator is an upgrade to the initial SonicR Trade Levels indicator released 05-25-2013 and 
is greatly improved with many new features.   Summaries of these features are listed below.

Displaying EP Levels Lines and Labels
   You can select to show EP Levels lines and labels.  The Level lines span the chart to the 
   current candle, followed by the Level labels which include the EP number, price and 
   quantity of units of the lot type input.  Since price labels (see below) can be selected 
   to display at each entry candle, the EP Level Lines/Labels are simply an option, but which
   can be helpful on the lowest of TF charts so you can see where current price action is 
   relative to your nearest EPs.  If you display the EP Level Labels, the AV, TP and SL lines 
   will shift a little to the right to maintain good visibility. 

Displaying Price Dots, Price Labels and Lines to Current Price
   For open trades you can show lines connecting the EPs to the current appropriate bid/ask
   price, color coded to represent if the trade is in profit or loss.  You can show at each
   entry price a Dot and/or a Price Label, color coded to represent if the trade is long or
   is short.  When the trade is closed the Dot is ringed with the color selected for closed 
   Dots.  This enables you to easily see, if a number of trade components remain active but
   some have been closed, which are the closed ones.

Displaying the Average of EPs Line
   For open trades an AV Line is displayed.  It shows the rounded off average price for all 
   open orders (even if varying in size), the number of open orders (separate EP events), 
   and the number of open units of the type input. 
   
Displaying TP and SL Lines
   For open trades the TP and SL associated with the MT4 orders is displayed.  You can 
   override these values by putting other values into the External Inputs.  You might do
   this temporarily to help you decide the values to place in your MT4 orders.  The pips
   displayed at TP/SL are the rounded off total pips of all the open units of your EPs.
   When the TP/SL is reached and the trade closes, the closed trade P/L displayed might be
   different due to the rounding off of the average price line and of the TP/SL pips, as
   well as to any applied swaps and commissions, and also to possibly some units actually 
   closing at different (better) prices.
   
Displaying Current PL Label
   For open trades the current PL Label is displayed at the left edge of the chart at the
   bid line and changes as the bid price changes.  The pips displayed are based on the  
   total open units of your EPs.  You can also display monies PL and the percentage of 
   account PL.  The text in the PL label changes between green and red for profit/loss.  
   
Displaying a Closed Trade
   You can display closed trades two ways:
   1. Use the "__Simple_Lookback_Time_Span" which is set for a default of 60 minutes.  The 
      time span you input "looks back" from the current time and any trades closed within the 
      time span will be displayed.  
   2. Set the year/month/day/hour/minutes for the start or end, or both the start and end of 
      the period for which you want closed trades to display.  This method takes precedence 
      over any value entered for the "__Simple_Lookback_Time_Span".  These start/end inputs  
      must be in their default state (yyyy.mm.dd hh:mm) for the "__Simple_Lookback_Time_Span" 
      method to work.  You can copy & paste the "yyyy.mm.dd hh:mm", provided in the External 
      Inputs, into the start/end inputs to return them to the default state.  
      
   Using the same inputs selected for Open trades, the Closed trades can be shown with Price 
   Dots and/or Price Labels at both the entries and closes, and with connecting lines that 
   are colored differently if closed with profit or loss.  A PL Label is shown for the 
   closed trades.  The label displays the number of EPs closed, the number of closed units 
   of the type you input, the total pips PL, and (if you have selected them) PL monies and 
   PL account percent.
   
   When selecting to show closed trades encompassed by the time span selected to display 
   closed trades, you can have all the trades displayed as a single trade with a single PL
   Label.  Or, you can have the individual trades displayed with their individual PL Labels.
   PL Labels will appear above or below the last close price for the components of the trade, 
   based on whether the last component was closed below or above the entry price of the last 
   component.  You can raise or lower the label by increasing or decreasing the default "30"
   input for the closed trade PL Label.  There are three label height inputs providing for
   the adjustment of PL labels for three separate trades displayed.  The sequence 1-2-3 
   starts with the oldest trade first.  If more than three separate trades are to be shown
   the oldest three can be adjusted and the more recent ones will have the same height as
   the first/oldest trade shown.  So it is best to limit the display of closed trades to no
   more than three. 
   
Selecting the Unit Type Input
   The External Inputs includes a numerical input (1-3) for the unit type you are trading.
   Input "1" if you intend to trade in micro-lots, input "2" if in mini-lots, and input "3" 
   if in full lots (or fractions thereof).  Once you have made your selection it does not
   matter what size trades you make.  The unit type you select determines how the number of 
   units traded will be displayed in the AV, TP, SL and PL labels. 
       
   The core coding of this indicator is based on conversion of all order sizes to micro-lots 
   (the minimum size order available on MT4) and then reconversion using the unit type input.  
   Reconversion allows for more a more sensible display of unit quantities traded.  However,
   another reason for requiring the unit type input is to protect user privacy.  Units 
   displayed can only be viewed as generic units because they are not revealed as being 
   based on micro, mini or full lots traded.  The only way a viewer of the chart can know
   the basis of the units shown is for the user to also display PL monies in a PL Label.
   
Setting Time Frames for Display of Indicator   
   The indicator can be turned on/off without removing it from the chart.  Also, you can 
   select a chart TF above which this indicator will automatically not display.    

Changes from release 05-25-2013 to release 03-17-2014:  
01 - New coding permits unlimited number of EPs with all data automatically extracted from
     MT4 orders, which can vary in size. 
02 - Reduced TPs and SLs to just one each.  However, if you manually close trade parts at 
     different times/values, coding will track these various different closes.
03 - EP Level lines and labels can be displayed or not displayed.
04 - Added Profit/Loss pips to TP/SL labels.
05 - Added price labels and dots to mark EPs and CPs.
06 - Added connecting lines between EPs and the current/close price for open/closed trades.
07 - Added Current PL display on Bid Line with Background box to enhance legibility.  The 
     label can also display $ and % of account P/L.
08 - Added PL label for closed trades. 
09 - Added option to select closed trades to display by precise time coordinates.     
10 - Removed unnecessary price alert. 
     
                                                                    - Traderathome, 03-17-2014
-----------------------------------------------------------------------------------------------
Suggested Settings:           White Chart        Black Chart      

EP_Level_Line_and_Label       MediumBlue         C'091,142,236' 
AV_Level_Line_and_Label       DarkOrchid         MediumOrchid;
SL_Level_Line_and_Label       C'213,000,000'     C'226,035,035'  
TP_Level_Line_and_Label       C'040,123,078'     C'016,186,092'
Price_Dots_Ring_Size          14                 14
Price_Dots_Size               10                 10
Price_Dots_Center_Size        5                  5
Price_Dot_Center_Color        White              Black
Price_Label_Dot_Long          C'008,084,223'     C'118,160,239'
Price_Label_Dot_Short         C'232,000,000'     C'230,019,072'
Price_Label_Dot_Closed        Black              White
PL_Line_Positive_Trade        CornflowerBlue     CornflowerBlue
PL_Line_Negative_Trade        Salmon             Crimson
PL_Label_Background           C'255,255,185'     C'255,255,100'
PL_Label_Text_Positive        C'040,123,078'     ForestGreen
PL_Label_Text_Negative        C'213,000,000'     Crimson

----------------------------------------------------------------------------------------------
Acknowledgements:
               
St3ve -        For intiating the change from manually filled datum used in the initial 
               release to an MT4 orders driven product.  This was a milestone influence and 
               effort, which transitioned the indicator from a enhancement for educational 
               charts into a tool for traders.
                            
qFish -        For a complete overhaul of coding uesed to derive datum for open and closed 
               trades from MT4 orders, that added new and indispensible features.
               
traderathome - For initating the SonicR Trade Levels indicator as an aid to presenting clear
               trade charts for educational purposes, and for tailoring the upgrade work to
               maintain an easy to use, eye appealing product.                                
---------------------------------------------------------------------------------------------*/


//+-------------------------------------------------------------------------------------------+
//| Indicator Global Inputs                                                                   |                                                        
//+-------------------------------------------------------------------------------------------+
#property indicator_chart_window

//User External Input Globals
extern bool    Indicator_On                  = true;
extern int     Show_Micro_Mini_Full_123      = 1;
extern bool    Show_Open_Trades              = true;
extern bool    Show_Closed_Trades            = true;
extern string  Show_in_PL_Labels_________    = "";
extern bool    _PL_Monies                    = false;
extern bool    _PL_Account_Percent           = false;
extern string  Show_for_Open_Trades______    = "";
extern bool    _EP_Levels_Lines              = true;
extern bool    _EP_Levels_Labels             = true;
extern bool    _EP_Price_Dots                = true;
extern bool    _EP_Price_Labels              = false;
extern bool    _EP_PL_Lines                  = true;
extern bool    __Subordinate_Lines           = false;
extern double  _Override_Trial_SL            = 0;   //if !=0, draw this instead of from orders
extern double  _Override_Trial_TP            = 0;   //if !=0, draw this instead of from orders
extern string  Show_for_Closed_Trades_____   = "";
extern bool    __Price_Dots                  = true;
extern bool    __Price_Labels                = false;
extern bool    __Price_Lines                 = true;
extern bool    ___Subordinate_Lines          = false;
extern bool    __Show_All_Trades_as_One      = false;
extern int     __PL_Label_1_Adjust_Height    = 30;
extern int     __PL_Label_2_Adjust_Height    = 30;
extern int     __PL_Label_3_Adjust_Height    = 30;
extern int     __Simple_Lookback_Time_Span   = 60;                 //if time not defined below
extern string  __Lookback_Exact_Start_Time   = "yyyy.mm.dd hh:mm"; //define trades closed 
extern string  __Lookback_Exact_End_Time     = "yyyy.mm.dd hh:mm"; //only used if populated
extern string  ___Reset_via_Copy_Paste       = "yyyy.mm.dd hh:mm"; //cut&paste to reset above
extern string  Colors_and_Sizes____________  = "";
extern color   EP_Level_Line_and_Label       = C'064,133,208';  
extern color   AV_Level_Line_and_Label       = MediumOrchid;     
extern color   SL_Level_Line_and_Label       = C'226,035,035';  
extern color   TP_Level_Line_and_Label       = C'016,186,092';
extern int     Price_Dots_Ring_Size          = 14;
extern int     Price_Dots_Size               = 10;
extern int     Price_Dots_Center_Size        = 5;
extern color   Price_Dot_Center_Color        = Black;
extern color   Price_Label_Dot_Long          = DodgerBlue;  
extern color   Price_Label_Dot_Short         = C'230,019,072'; 
extern color   Price_Label_Dot_Closed        = White;              
extern color   PL_Line_Positive_Trade        = CornflowerBlue; 
extern color   PL_Line_Negative_Trade        = C'209,016,065';           
extern color   PL_Label_Background           = C'255,255,111'; 
extern color   PL_Label_Text_Positive        = ForestGreen;
extern color   PL_Label_Text_Negative        = Crimson;
extern string  Display_TF_Limitation________ = "";
extern int     Display_Max_TF                = 1440;
extern string  TF_Choices                    = "1-5-15-30-60-240-1440-10080-43200";

//Private Globals
bool     Deinitialized;
int      ordersTotal          = -1; //-1 = indy start and guarantees drawing at least once
double   Poin;                      //defined in init() to accommodate varying Point digits
int      Price_Label          = 5;  //wingdings symbol code for the rectangle price label
string   Label_Style          = "Arial Narrow";
int      Label_Size           = 8;  
string   Label_Style2         = "Courier New"; 
int      Label_Size2          = 9;

//Global variables for Chart Scale       
int      Chart_Scale;
datetime T0,T1,T2,T3;
 
//Global variables for open trade sections
int      openEPs, orderType;
double   openAvgPrice;
double   openMicroLots;
double   openSize;
double   openDistancePips;
double   openTotalPips;
double   openProfit;
double   tpPrice,slPrice;
string   LOTstr,side;   

//+-------------------------------------------------------------------------------------------+
//| Indicator Initialization                                                                  |                                                        
//+-------------------------------------------------------------------------------------------+
int init()
{
   //Determine the current chart scale (chart scale number should be 0-5)
   Chart_Scale = ChartScaleGet();

   if(Show_Micro_Mini_Full_123 <1 || Show_Micro_Mini_Full_123 >3) 
   {Show_Micro_Mini_Full_123 = 1;}
        
   // determine "Poin" for proper prices taking into account unconventional encountered digits 
   if (Point == 0.00001) {Poin = 0.0001;} //5 digits     
   else {if (Point == 0.001) {Poin = 0.01;} //3 digits
   else {Poin = Point;}} //Normal 4 digits    
   if (StringSubstr(Symbol(),0,6) == "XAUUSD") {Poin = 1;}   
   else {if (StringSubstr(Symbol(),0,6) == "USDMXN") {Poin = 0.001;}
   else {if (StringSubstr(Symbol(),0,6) == "USDCZK") {Poin = 0.001;} }}
    
   Deinitialized = false;
        
   return(0);
}
  
//+-------------------------------------------------------------------------------------------+
//| Indicator De-initialization                                                               |                                                        
//+-------------------------------------------------------------------------------------------+  
int deinit()
{ 
   int obj_total= ObjectsTotal();  
   for(int k= obj_total; k>=0; k--)
   {
      string name= ObjectName(k);
      if(StringSubstr(name,0,7)=="[Trade]") {ObjectDelete(name);}
   }        
   //Comment("");     
   return(0);
}

//+-------------------------------------------------------------------------------------------+
//| Indicator Start                                                                           |                                                        
//+-------------------------------------------------------------------------------------------+ 
int start()
{
   // If indicator "Off" or chart TF out of range, deinitialize only once, not every tick.  
   if(!Indicator_On || Period() > Display_Max_TF)    
   {
      if (!Deinitialized) {deinit(); Deinitialized = true;} 
      return(0);
   }
   
   //If indicator is "ON" clear objects
   int obj_total= ObjectsTotal();  
   for(int k= obj_total; k>=0; k--)
   {
      string name= ObjectName(k);               
      if(StringSubstr(name,0,7)=="[Trade]") {ObjectDelete(name);}                
   }
    
   // calculate every tick here
   if(Show_Open_Trades)
   {
      if(selectOpenFirstOrder())
      {
         applyChartScale(); 
         drawOpenTradeEPs();       
         drawOpenTradeTPSL();
         drawOpenTradeAV();
         drawOpenTradePL();         
      }
      else
      {
         deinit();
      }           
   }
   if(Show_Closed_Trades)
   {
      drawClosedTradeEPs();
   }

   return(0);
}

//+-------------------------------------------------------------------------------------------+
//| Subroutine: Returns true/false that first trade order for symbol is found                 |                                                        
//+-------------------------------------------------------------------------------------------+
bool selectOpenFirstOrder()
{
   bool selected = false;
   
   // find the first order of this symbol
   for(int i=0; i<OrdersTotal(); i++)
   {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
      {
         if(Symbol()==OrderSymbol() && (OrderType()==OP_BUY || OrderType()==OP_SELL) 
         && OrderCloseTime()==0) 
         {
            selected = true;
            tpPrice = OrderTakeProfit();
            slPrice = OrderStopLoss(); 
            orderType = OrderType();   
            break;                             
         }                
      }       
   }
 
   return(selected);
}

//+-------------------------------------------------------------------------------------------+
//| Subroutine: Set line parameters based on Chart_Scale                                      |                                                        
//+-------------------------------------------------------------------------------------------+
void applyChartScale()
{ 
   //Set stop/start values for trade lines     
   //With EP Levels lines & labels displayed
   //T1= EP lines stop/labels start   
   //T2= TP/SL/AV lines stop/labels start (shifted right)      
   //Without EP Levels lines & labels displayed
   //T3= TP/SL/AV lines stop/labels start (no right shift)
   
   T0=Time[0]; //all lines (anchor point)              
   if(Chart_Scale == 0) 
   {
      T1=Time[0]+(Period()*60*14);
      T2=Time[0]+(Period()*60*100);               
      T3=Time[0]+(Period()*60*14);   
   }     
   else if(Chart_Scale == 1) 
   {
      T1=Time[0]+(Period()*60*7);   
      T2=Time[0]+(Period()*60*50);
      T3=Time[0]+(Period()*60*7);            
   }   
   else if(Chart_Scale == 2) 
   {
      T1=Time[0]+(Period()*60*3);              
      T2=Time[0]+(Period()*60*25);
      T3=Time[0]+(Period()*60*3);          
   }
   else if(Chart_Scale == 3) 
   {
      T1=Time[0]+(Period()*60*2);       
      T2=Time[0]+(Period()*60*13);
      T3=Time[0]+(Period()*60*2);           
   }
   else if(Chart_Scale == 4) 
   {
      T1=Time[0]+(Period()*60*2);          
      T2=Time[0]+(Period()*60*8);
      T3=Time[0]+(Period()*60*2);      
   }
   else if(Chart_Scale == 5) 
   {
      T1=Time[0]+(Period()*60*2);       
      T2=Time[0]+(Period()*60*5); 
      T3=Time[0]+(Period()*60*2);         
   }   

   return;   
}
//+-------------------------------------------------------------------------------------------+
//| Subroutine: Draws open trades entry point (EP) lines, arrows, and labels.                 |                                                        
//+-------------------------------------------------------------------------------------------+  
void drawOpenTradeEPs()
{      
   openEPs = 0;  
   string EPstr;
   int epNum = 1;
   
   for(int i=0; i<OrdersTotal(); i++)
   {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
      {
         if(Symbol()==OrderSymbol() && (OrderType()==OP_BUY || OrderType()==OP_SELL)) 
         {
            // define text for labels based on trade side
            if(OrderType()==OP_BUY) {side = " Long ";}          
            else  {side = " Short";}          
                    
            // variables to be used
            double lots = 100* OrderLots(); 
            string size;           
            if(Show_Micro_Mini_Full_123 == 1) 
            {
               size = DoubleToStr(lots,2);
            }
            else if(Show_Micro_Mini_Full_123 == 2) 
            {
               size = DoubleToStr(lots/10,2);            
            }
            else if(Show_Micro_Mini_Full_123 == 3) 
            {
               size = DoubleToStr(lots/100,2);          
            }
            if(StringLen(size)<5){size = "0"+size;}                                                                                                               
            double openPrice = OrderOpenPrice();
            string zeroPad = ternaryStr(epNum<10,"0",""); 
                                              
            // EP Levels Lines
            string epLine = StringConcatenate("[Trade] EP ",zeroPad,epNum," Level Line");  
            if(_EP_Levels_Lines) {                      
            ObjectCreate(epLine,OBJ_TREND,0,T1,openPrice,T0,openPrice);
            ObjectSet(epLine,OBJPROP_COLOR,EP_Level_Line_and_Label);}
         
            // EP Levels Labels            
            if(_EP_Levels_Labels) {
            string epLabel = StringConcatenate("[Trade] EP ",zeroPad,epNum," Level Label");                                                            
            EPstr = DoubleToStr(openPrice,Digits);
            if(StringLen(EPstr)==6) {EPstr= "0"+ EPstr;}            
            EPstr = StringConcatenate(zeroPad,epNum+": ",EPstr,",  ",size);
            EPstr = StringConcatenate(strRepeat(" ",29),EPstr,strRepeat(" ",18-StringLen(EPstr)));                           
            ObjectCreate(epLabel,OBJ_TEXT,0,T1,openPrice);
            ObjectSetText(epLabel,EPstr,Label_Size,Label_Style,EP_Level_Line_and_Label);} 

            // EP PL lines             
            if(_EP_PL_Lines) {            
            string EPtargetLine = StringConcatenate("[Trade] EP ",epNum,
               " line from ",DoubleToStr(openPrice,Digits)); 
            double closePrice = OrderClosePrice();            
            ObjectCreate(EPtargetLine,OBJ_TREND,0,OrderOpenTime(),
               openPrice,Time[0],closePrice);
            ObjectSet(EPtargetLine,OBJPROP_COLOR,ternaryColor(OrderProfit()<0,
               PL_Line_Negative_Trade,PL_Line_Positive_Trade));
            ObjectSet(EPtargetLine,OBJPROP_STYLE,STYLE_DOT);
            if(__Subordinate_Lines) {ObjectSet(EPtargetLine, OBJPROP_BACK, true);}
            else {ObjectSet(EPtargetLine,OBJPROP_BACK,false);}  
            ObjectSet(EPtargetLine,OBJPROP_RAY,false); } 
                      
            // EP Price Dots 
            if(_EP_Price_Dots) { 
            // Dots                                                         
            string epPriceDot1 = StringConcatenate("[Trade] EP ",epNum," dot");                                    
            ObjectCreate(epPriceDot1,OBJ_TREND,0,OrderOpenTime(),openPrice,
               OrderOpenTime(),openPrice);     
            ObjectSet(epPriceDot1,OBJPROP_STYLE,0);
            ObjectSet(epPriceDot1,OBJPROP_COLOR,ternaryInt(OrderType()==OP_BUY,
               Price_Label_Dot_Long,Price_Label_Dot_Short));
            ObjectSet(epPriceDot1,OBJPROP_WIDTH, Price_Dots_Size);                                                                               
            // Centers
            string epPriceDot2 = StringConcatenate("[Trade] EP ",epNum," center");                 
            ObjectCreate(epPriceDot2, OBJ_TREND,0,OrderOpenTime(),openPrice, 
               OrderOpenTime(),openPrice);     
            ObjectSet(epPriceDot2, OBJPROP_STYLE, 0);
            ObjectSet(epPriceDot2, OBJPROP_WIDTH, Price_Dots_Center_Size);             
            ObjectSet(epPriceDot2, OBJPROP_COLOR, Price_Dot_Center_Color); }  
                          
            // EP Price Labels
            if(_EP_Price_Labels) {
             string epPriceLabel = StringConcatenate("[Trade] EP ",epNum," Label");            
            ObjectCreate(epPriceLabel,OBJ_ARROW,0,OrderOpenTime(),openPrice);                        
            ObjectSet(epPriceLabel,OBJPROP_ARROWCODE, ternaryInt(OrderType()==OP_BUY,
               Price_Label,Price_Label));
            ObjectSet(epPriceLabel,OBJPROP_COLOR,ternaryColor(OrderType()==OP_BUY,
               Price_Label_Dot_Long,Price_Label_Dot_Short)); }
            
            // bump counters                       
            epNum++;
            openEPs++;                                
         }
      }          
   }

   return;   
}

//+-------------------------------------------------------------------------------------------+
//| Subroutine: Draws open trade tp and sl                                                    |                                                        
//+-------------------------------------------------------------------------------------------+ 
void drawOpenTradeTPSL()
{
   // draw TP
   double tpPips;
   string TPstr1;
   string TPstr2;
   string TPstr3;   
   string tpLine = "[Trade] TP Level";
   string tpLabel = "[Trade] TP Label";
   
   if(_Override_Trial_TP!=0) {tpPrice = _Override_Trial_TP;}
   
   if(tpPrice > 0)
   {
      tpPips= ((getAvgPriceOfOpenOrders()-tpPrice)/Poin)*openSize;
      tpPips= ternaryDbl(orderType==OP_BUY,-tpPips,tpPips);
            
      // draw TP line     
      if(_EP_Levels_Labels) 
      {   
         ObjectCreate(tpLine,OBJ_TREND,0,T2,tpPrice,T0,tpPrice);
         ObjectSet(tpLine,OBJPROP_COLOR,TP_Level_Line_and_Label);
      }
      else       
      {
         ObjectCreate(tpLine,OBJ_TREND,0,T3,tpPrice,T0,tpPrice);
         ObjectSet(tpLine,OBJPROP_COLOR,TP_Level_Line_and_Label);
      }
      
      // draw TP label
      TPstr1 = DoubleToStr(tpPrice,Digits);
      if(StringLen(TPstr1)==6) {TPstr1= "0"+ TPstr1;}      
      TPstr2 = DoubleToStr(tpPips,0);
      if(tpPips>=0) {TPstr2= "+"+TPstr2;} 
                              
      if(_EP_Levels_Labels) 
      {
         ObjectCreate(tpLabel,OBJ_TEXT,0,T2,tpPrice);  
         TPstr3 = StringConcatenate("TP: ",TPstr1,", p",TPstr2);       
         TPstr3 = StringConcatenate(strRepeat(" ",28),TPstr3,strRepeat(" ",27-StringLen(TPstr3)));          
         ObjectSetText(tpLabel,TPstr3,Label_Size2,Label_Style2,TP_Level_Line_and_Label);   
      }  
      else 
      {
         ObjectCreate(tpLabel,OBJ_TEXT,0,T3,tpPrice);  
         TPstr3 = StringConcatenate("TP: ",TPstr1,", p",TPstr2);
         TPstr3 = StringConcatenate(strRepeat(" ",28),TPstr3,strRepeat(" ",27-StringLen(TPstr3)));          
         ObjectSetText(tpLabel,TPstr3,Label_Size2,Label_Style2,TP_Level_Line_and_Label);     
      }      
   }
   
   // draw SL
   double slPips;
   string SLstr1;
   string SLstr2;
   string SLstr3;   
   string slLine = "[Trade] SL Level";
   string slLabel = "[Trade] SL Label";
   
   if(_Override_Trial_SL!=0) {slPrice = _Override_Trial_SL;}
   
   if(slPrice > 0)
   {
      slPips= ((getAvgPriceOfOpenOrders()-slPrice)/Poin)*openSize;
      slPips= ternaryDbl(orderType==OP_BUY,-slPips,slPips);
            
      // draw SL line
      if(_EP_Levels_Labels) 
      {
         ObjectCreate(slLine,OBJ_TREND,0,T2,slPrice,T0,slPrice);
         ObjectSet(slLine,OBJPROP_COLOR,SL_Level_Line_and_Label);
      }
      else       
      {
         ObjectCreate(slLine,OBJ_TREND,0,T3,slPrice,T0,slPrice);
         ObjectSet(slLine,OBJPROP_COLOR,SL_Level_Line_and_Label);
      }
      
      // draw SL label
      SLstr1 = DoubleToStr(slPrice,Digits);
      if(StringLen(SLstr1)==6) {SLstr1= "0"+ SLstr1;}
      SLstr2 = DoubleToStr(slPips,0);
               
      if(_EP_Levels_Labels) 
      {
         ObjectCreate(slLabel,OBJ_TEXT,0,T2,slPrice);    
         SLstr3 = StringConcatenate("S: ",SLstr1,", p",SLstr2);      
         SLstr3 = StringConcatenate(strRepeat(" ",28),SLstr3,strRepeat(" ",27-StringLen(SLstr3)));          
         ObjectSetText(slLabel,SLstr3,Label_Size2,Label_Style2,SL_Level_Line_and_Label);      
      }
      else 
      {
         ObjectCreate(slLabel,OBJ_TEXT,0,T3,slPrice); 
         SLstr3 = StringConcatenate("SL: ",SLstr1,", p",SLstr2);
         SLstr3 = StringConcatenate(strRepeat(" ",28),SLstr3,strRepeat(" ",27-StringLen(SLstr3)));          
         ObjectSetText(slLabel,SLstr3,Label_Size2,Label_Style2,SL_Level_Line_and_Label);         
      }
   }
   
   return;   
}

//+-------------------------------------------------------------------------------------------+
//| Subroutine: Draws the average line and label positioned to the right of the ep labels     |                                                        
//+-------------------------------------------------------------------------------------------+
void drawOpenTradeAV()
{  
   string AVstr1;
   string AVstr2;
   string AVstr3;
   double Avg_Price = getAvgPriceOfOpenOrders();           
   string avLine = "[Trade] Av Level"; 
   string avLabel = "[Trade] Av Label";
   string fix = ", ";
   
   // draw AV line      
   if(_EP_Levels_Labels) 
   { 
      ObjectCreate(avLine,OBJ_TREND,0,T2,Avg_Price,T0,Avg_Price);
      ObjectSet(avLine,OBJPROP_COLOR,AV_Level_Line_and_Label);
   }
   else      
   {
      ObjectCreate(avLine,OBJ_TREND,0,T3,Avg_Price,T0,Avg_Price);
      ObjectSet(avLine,OBJPROP_COLOR,AV_Level_Line_and_Label);
   }
      
   // draw AV label
   AVstr1 = DoubleToStr(Avg_Price,Digits);
   AVstr1 = strRepeat("0",7-StringLen(AVstr1))+ AVstr1;   
   AVstr2 = StringConcatenate(openEPs,"<",LOTstr); 

   if(_EP_Levels_Labels) 
   {
      ObjectCreate(avLabel,OBJ_TEXT,0,T2,Avg_Price);    
      AVstr3 = StringConcatenate("AV: ",AVstr1,fix,openEPs,"<",LOTstr,side);          
      AVstr3 = StringConcatenate(strRepeat(" ",28),AVstr3,strRepeat(" ",27-StringLen(AVstr3)));  
      ObjectSetText(avLabel,AVstr3,Label_Size2,Label_Style2,AV_Level_Line_and_Label);             
   }
   else//Show Without EP_Labels             
   {
      ObjectCreate(avLabel,OBJ_TEXT,0,T3,Avg_Price);     
      AVstr3 = StringConcatenate("AV: ",AVstr1,fix,openEPs,"<",LOTstr,side);
      AVstr3 = StringConcatenate(strRepeat(" ",28),AVstr3,strRepeat(" ",27-StringLen(AVstr3)));  
      ObjectSetText(avLabel,AVstr3,Label_Size2,Label_Style2,AV_Level_Line_and_Label);                                            
   }
   
   return;   
}

//+-------------------------------------------------------------------------------------------+
//| Subroutine: Draws open trade current P/L (with monies & percentage options)               |                                                        
//+-------------------------------------------------------------------------------------------+
void drawOpenTradePL ()
{
   // preclude "zero divide" error for closed trade
   if(AccountBalance() == 0) return;

   string PD=DoubleToStr(openDistancePips,1);  
   string PT=DoubleToStr(openTotalPips,1);
   string PLstr;

   if(!_PL_Monies && !_PL_Account_Percent)
   {
      // show EPs, lot factored units, "Distance" pips, & resultant P/L pips         
      PLstr = StringConcatenate("PL: ",openEPs,"<",LOTstr," @ ",
      DoubleToStr(openDistancePips,1)," = p",PT);                  
   }
   else
   {
      string A = StringConcatenate("PL: p",DoubleToStr(openTotalPips,1));         
      string B = StringConcatenate(", $",DoubleToStr(openProfit,2)); 
      string C;
      double pct = (openProfit/AccountBalance())*100;   
      if(pct < 10) {C = StringConcatenate(", ",DoubleToStr(pct,2),"%");}     
      else {C = StringConcatenate(", ",DoubleToStr(pct,1),"%");}          
      if(_PL_Monies && !_PL_Account_Percent) {PLstr = A+B;}
      else if(!_PL_Monies && _PL_Account_Percent) {PLstr = A+C;}
      else if(_PL_Monies && _PL_Account_Percent) {PLstr = A+B+C;}        
   }

   // display P/L background  
   string open_BG = "[Trade] Open PL Label";
   ObjectCreate(open_BG,OBJ_TEXT,0,Time[WindowFirstVisibleBar()], Bid);
   ObjectSetText(open_BG,strRepeat("g",StringLen(PLstr)),11,
      "Webdings",PL_Label_Background);
               
   // display P/L text 
   string open_TX = "[Trade] Open PL Text";               
   ObjectCreate(open_TX,OBJ_TEXT,0,Time[WindowFirstVisibleBar()], Bid);
   ObjectSetText(open_TX,strRepeat(" ",StringLen(PLstr))+PLstr,Label_Size2,Label_Style2,
      ternaryColor(openTotalPips<0,PL_Label_Text_Negative,PL_Label_Text_Positive));  
             
   return;       
}

//+-------------------------------------------------------------------------------------------+
//| Subroutine: Returns the average price of all buy/sell entries, factoring in variable sizes|                                                        
//+-------------------------------------------------------------------------------------------+ 
// Takes into account the micro-lot size of each trade of all executed open buy/sell orders. 
// Trade orders for the pair must be either all buy or all sell.
double getAvgPriceOfOpenOrders()
{
   openSize = 0;
   openMicroLots = 0;
   openDistancePips = 0;
   openTotalPips = 0;
   openAvgPrice = 0;
   double pipValue = 0;  
   double openpriceLotProduct;
   
   for(int i=0; i<OrdersTotal(); i++) 
   {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
      {
         if (Symbol() == OrderSymbol() && (OrderType() == OP_BUY || OrderType() == OP_SELL)) 
         {
            openMicroLots += OrderLots()*100;
            openpriceLotProduct += OrderOpenPrice()*(OrderLots()*100); 
         }
      }
   }

   // get average price for "Distance" and "Total" modes
   openAvgPrice = openpriceLotProduct/openMicroLots;
      
   // get MT4 mini-lot reference pip value, convert to micro-lot value & factor for Digits
   pipValue = (MarketInfo(Symbol(),MODE_TICKVALUE)/10);  
   if(Digits == 2 || Digits == 4) {pipValue = pipValue/10;}
 
   // use the input lot type to convert pip value and trade size from micro-lots
   if(Show_Micro_Mini_Full_123 == 1) 
   {
      openSize= openMicroLots;     
      LOTstr=DoubleToStr(openSize,0);  
   }
   else if(Show_Micro_Mini_Full_123 == 2) 
   {
      openSize= openMicroLots/10;
      LOTstr=DoubleToStr(openSize,2);
      pipValue= pipValue*10;
   }
   else if(Show_Micro_Mini_Full_123 == 3) 
   {
      openSize= openMicroLots/100;
      LOTstr=DoubleToStr(openSize,2); 
      pipValue= pipValue*100;
   } 
      
   // get "Distance" pips for "Distance" mode & for conversion for "Total" mode
   if(orderType ==OP_BUY) {openDistancePips= (Bid - openAvgPrice)/Poin;}
   else {openDistancePips= (openAvgPrice - Ask)/Poin;}   
   
   // get "Total" pips for "Total" mode   
   openTotalPips= openDistancePips*openSize; 

   // get open trade profit 
   openProfit = openTotalPips*pipValue;
   
   // return the avg. price of the open trade
   if(openSize >0) {return(NormalizeDouble(openAvgPrice, Digits));}
      
   else {return(0);}
}

//+-------------------------------------------------------------------------------------------+
//| Subroutine: Draws closed trade lines connecting EPs to closed bid/ask price               |                                                        
//+-------------------------------------------------------------------------------------------+ 
void drawClosedTradeEPs()
{
   int epNum = 1;
   int trNum = 0;
   int closedEPs = 0;
   double closedTotalPips = 0;
   double closedProfit = 0; 
   double closedMicroLots = 0; 
   double closedDistancePips = 0;     
   datetime lastClosedTime = -1;
   double lastClosedPrice = -1;
   double openPrice;
   double closePrice;
   double openTime;
   double closeTime;
   
   for(int i=0; i<OrdersHistoryTotal(); i++)  
   {
      if(OrderSelect(i, SELECT_BY_POS, MODE_HISTORY))
      {
         // calculate the time flag algorithm to display depending on what's filled
         bool tradeHistoryTimeFlag;
         bool cst = StringFind(__Lookback_Exact_Start_Time,"yyyy.mm.dd hh:mm")>=0;
         bool cet = StringFind(__Lookback_Exact_End_Time,"yyyy.mm.dd hh:mm")>=0;
         if(cst && cet)    // if they are both not used
            tradeHistoryTimeFlag = ((Time[0]-OrderCloseTime())/60)<__Simple_Lookback_Time_Span;
         if(!cst && cet)   // if start only is used
            tradeHistoryTimeFlag = OrderCloseTime()>StrToTime(__Lookback_Exact_Start_Time);
         if(!cst && !cet)  // if start and end is used
            tradeHistoryTimeFlag = OrderCloseTime()>StrToTime(__Lookback_Exact_Start_Time) 
            && OrderCloseTime()<StrToTime(__Lookback_Exact_End_Time);            
         if(Symbol()==OrderSymbol() && (OrderType()==OP_BUY || OrderType()==OP_SELL) 
            && tradeHistoryTimeFlag) 
         {
            // start the draw of a trade (group of components)
            orderType = OrderType();            
            openPrice = OrderOpenPrice();
            closePrice = OrderClosePrice();
            openTime = OrderOpenTime();
            closeTime = OrderCloseTime();
            // determine if all trades to be displayed within the selected Lookback time 
            // are to be displayed as one single trade of various components closed at 
            // various times, but with one P/L label encompassing all
            if(__Show_All_Trades_as_One)
            {
               lastClosedTime = closeTime;
               lastClosedPrice = closePrice;
               trNum = 1;              
            }
            // determine if all trades to be displayed within the selected Lookback time 
            // are to be displayed as the individual trades (groups of components) with 
            // the appropriate individual P/L labels
            else
            {
               // if the close time for the trade is more than an hour after the previous
               // trade, or if the trade side is opposite from the previous trade, start 
               // the draw as a new trade (group of components)                     
               if(lastClosedTime < closeTime - 360 || orderType != OrderType())
               {
                  // draw the P/L label for the preceding trade (group of components)
                  drawClosedTradePL(lastClosedTime,lastClosedPrice,openPrice,closedEPs,  
                     closedMicroLots,closedTotalPips,closedProfit,closedDistancePips,trNum);
                  // reset variables for new trade draw   
                  lastClosedTime = closeTime;
                  lastClosedPrice = closePrice;
                  closedEPs = 0;
                  closedTotalPips = 0;
                  closedProfit = 0;
                  closedMicroLots = 0;
                  closedDistancePips = 0;
                  epNum=1;
                  trNum++;               
               }             
            }
                     
            // configure "zeroPad" for use in string names                                                                 
            string zeroPad = ternaryStr(epNum<10,"0","");  
                       
            // Price Dots 
            if(__Price_Dots) {
            // EP Rings
            string epDot3 = StringConcatenate("[Trade] EP ",zeroPad,epNum, 
               ", ring, trade ",trNum);               
            ObjectCreate(epDot3, OBJ_TREND,0,OrderOpenTime(),openPrice, 
               OrderOpenTime(),openPrice);     
            ObjectSet(epDot3, OBJPROP_STYLE, 0);
            ObjectSet(epDot3, OBJPROP_WIDTH, Price_Dots_Ring_Size);             
            ObjectSet(epDot3, OBJPROP_COLOR, Price_Label_Dot_Closed); 
            // EP Dots                           
            string epDot2 = StringConcatenate("[Trade] EP ",zeroPad,epNum,            
               ", Dot, trade ", trNum);                              
            ObjectCreate(epDot2, OBJ_TREND, 0, OrderOpenTime(), openPrice, 
               OrderOpenTime(), openPrice);     
            ObjectSet(epDot2, OBJPROP_STYLE, 0);
            ObjectSet(epDot2, OBJPROP_WIDTH, Price_Dots_Size); 
            ObjectSet(epDot2, OBJPROP_COLOR, ternaryInt(OrderType()==OP_BUY,
               Price_Label_Dot_Long,Price_Label_Dot_Short));
            // EP Centers
            string epDot1 = StringConcatenate("[Trade] EP ",zeroPad,epNum, 
               ", ",DoubleToStr(openPrice,Digits),", trade ",trNum);               
            ObjectCreate(epDot1, OBJ_TREND,0,OrderOpenTime(),openPrice, 
               OrderOpenTime(),openPrice);     
            ObjectSet(epDot1, OBJPROP_STYLE, 0);
            ObjectSet(epDot1, OBJPROP_WIDTH, Price_Dots_Center_Size);             
            ObjectSet(epDot1, OBJPROP_COLOR, Price_Dot_Center_Color);                         
            // CP Dots             
            string cpDot1 = StringConcatenate("[Trade] CP ",zeroPad,epNum,
               ", Dot, trade ", trNum);                                
            ObjectCreate(cpDot1, OBJ_TREND,0,closeTime,closePrice, 
               closeTime, closePrice);  
            ObjectSet(cpDot1,OBJPROP_STYLE, 0);            
            ObjectSet(cpDot1,OBJPROP_COLOR,Price_Label_Dot_Closed);           
            ObjectSet(cpDot1, OBJPROP_WIDTH, Price_Dots_Ring_Size);  
            // CP_Centers
            string cpDot2 = StringConcatenate("[Trade] CP ",zeroPad,epNum, 
               ", ",DoubleToStr(closePrice,Digits),", trade ", trNum);               
            ObjectCreate(cpDot2, OBJ_TREND,0,closeTime,closePrice, 
               closeTime,closePrice);     
            ObjectSet(cpDot2, OBJPROP_STYLE, 0);
            ObjectSet(cpDot2, OBJPROP_WIDTH, Price_Dots_Center_Size);             
            ObjectSet(cpDot2, OBJPROP_COLOR, Price_Dot_Center_Color); }  
            
            // Price Labels
            if(__Price_Labels) { 
            // EP Price Labels 
            string epLabel = StringConcatenate("[Trade] EP ",zeroPad,epNum,
               " Price Label, trade ",trNum);                                      
            ObjectCreate(epLabel,OBJ_ARROW,0,openTime,openPrice);
            ObjectSet(epLabel,OBJPROP_ARROWCODE, Price_Label);
            ObjectSet(epLabel,OBJPROP_COLOR,ternaryColor(OrderType()==OP_BUY,
               Price_Label_Dot_Long,Price_Label_Dot_Short));
            // CP Price Labels                                   
            string cpLabel = StringConcatenate("[Trade] CP ",zeroPad,epNum,
               " Price Label, trade ",trNum);                                
            ObjectCreate(cpLabel,OBJ_ARROW,0,closeTime,closePrice);
            ObjectSet(cpLabel,OBJPROP_ARROWCODE, Price_Label);
            ObjectSet(cpLabel,OBJPROP_COLOR,Price_Label_Dot_Closed); }  
            
            // Price Lines
            if(__Price_Lines) {            
            string cpLine = StringConcatenate("[Trade] EP ",zeroPad,epNum,
               " line begins ",DoubleToStr(openPrice,Digits),
               ", line ends ",DoubleToStr(closePrice,Digits),", trade ",trNum);     
            ObjectCreate(cpLine,OBJ_TREND,0,openTime,openPrice,closeTime,closePrice);
            ObjectSet(cpLine,OBJPROP_COLOR,ternaryColor(OrderProfit()<0,
               PL_Line_Negative_Trade,PL_Line_Positive_Trade));
            ObjectSet(cpLine,OBJPROP_STYLE,STYLE_DOT);
            if(___Subordinate_Lines) {ObjectSet(cpLine, OBJPROP_BACK, true);}
            else {ObjectSet(cpLine, OBJPROP_BACK, false);}
            ObjectSet(cpLine,OBJPROP_RAY,false); }  
            
            // bump counters                                        
            epNum++;
            closedEPs++;
            closedMicroLots += OrderLots()*100;
            if(closedMicroLots == 0) {return;} 
            if(OrderType()==OP_BUY) 
            {
               closedTotalPips +=((OrderClosePrice()-OrderOpenPrice())/Poin)*(OrderLots()*100);
               closedDistancePips += (OrderClosePrice()-OrderOpenPrice())/Poin;            
            }
            else
            {       
               closedTotalPips +=((OrderOpenPrice()-OrderClosePrice())/Poin)*(OrderLots()*100);
               closedDistancePips += (OrderOpenPrice()-OrderClosePrice())/Poin;       
            }         
            closedProfit += OrderProfit()-OrderCommission()-OrderSwap();              
         }
      }          
   }
   if(closedMicroLots == 0) {return;} 
      
   // since there are no more orders in history to parse, draw PL for current trade drawn
   drawClosedTradePL(lastClosedTime, lastClosedPrice, openPrice, closedEPs, closedMicroLots,
      closedTotalPips, closedProfit, closedDistancePips, trNum);
      
   return;   
}

//+-------------------------------------------------------------------------------------------+
//| Subroutine: Draws closed trade P/L (with monies & percentage options)                     |                                                        
//+-------------------------------------------------------------------------------------------+
void drawClosedTradePL (datetime t, double priceClosed, double priceOpened, int closedEPs, 
   double closedMicroLots, double closedTotalPips, double closedProfit, 
   double closedDistancePips, int trNum)
{   
   // preclude "zero divide" error for closed trade
   if(AccountBalance() == 0) return; 
   
   // requirements for label      
   double closedSize;
   string closedLOT;
   string PT;
   
   
   if(Show_Micro_Mini_Full_123 == 1) 
   {
      closedSize = closedMicroLots;
      closedLOT = DoubleToStr(closedSize,0);
      PT=DoubleToStr(closedTotalPips,1);
   }
   if(Show_Micro_Mini_Full_123 == 2) 
   {
      closedSize = closedMicroLots/10;
      closedLOT = DoubleToStr(closedSize,1);
      PT=DoubleToStr(closedTotalPips/10,1);
   }
   else if(Show_Micro_Mini_Full_123 == 3) 
   {
      closedSize = closedMicroLots/100;
      closedLOT = DoubleToStr(closedSize,2);
      PT=DoubleToStr(closedTotalPips/100,1);
   }    
   string PD=DoubleToStr(closedDistancePips,1);  
   //string PT=DoubleToStr(closedTotalPips,1);
   string PLstr;
   string TOTL;
   string COMP;
   string EPCP;
  
   if(closedEPs<2) 
   { 
      TOTL= " EP totaling ";
      COMP= " unit for p"; 
      EPCP= ", EP to CP";
   } 
   else
   {
      TOTL= " EPs totaling ";
      COMP= " units for p";   
      EPCP= ", EPs to CPs";
   }

   if(!_PL_Monies && !_PL_Account_Percent)
   {
      //Show number of trades, lot factored units, & resultant P/L pips 
      PLstr= StringConcatenate("PL: ",closedEPs,TOTL,closedSize,COMP,DoubleToStr(closedTotalPips,1),EPCP);                            
   }
   else //show pips together with $ or % or both
   { 
      string A = StringConcatenate("PL(",closedEPs,">",closedSize,"): p",PT);     
      string B = StringConcatenate(", $",DoubleToStr(closedProfit,2));
      string C = StringConcatenate(", ",DoubleToStr(closedProfit/AccountBalance()*100,2),"%");   
      if(_PL_Monies && !_PL_Account_Percent) {PLstr = A+B;}
      else if(!_PL_Monies && _PL_Account_Percent) {PLstr = A+C;}
      else if(_PL_Monies && _PL_Account_Percent) {PLstr = A+B+C;}
   }     
   
   // shift label up/dn based on "Adjust_Label" input 
   double labelprice;
   double adjustHeight;  
   if(trNum<2 || trNum>3) {adjustHeight = __PL_Label_1_Adjust_Height;}
   else if(trNum == 2) {adjustHeight = __PL_Label_2_Adjust_Height;}
   else if(trNum == 3) {adjustHeight = __PL_Label_3_Adjust_Height;}
   if(Digits == 2) {adjustHeight= __PL_Label_1_Adjust_Height/10;}           
   if(priceClosed > priceOpened) 
      {labelprice = priceClosed + (adjustHeight*10*Point);}
   else {labelprice = priceClosed - (adjustHeight*10*Point);}

   // set P/L background to accomdate length of P/L text
   string closed_BG = StringConcatenate("[Trade] Closed PL Label ",priceClosed);
   ObjectCreate(closed_BG,OBJ_TEXT,0,t,labelprice);
   ObjectSetText(closed_BG,strRepeat("g",StringLen(PLstr)/2),11,
      "Webdings",PL_Label_Background);           
              
   // display P/L text 
   string closed_TX = StringConcatenate("[Trade] Closed PL Text ",priceClosed);              
   ObjectCreate(closed_TX,OBJ_TEXT,0,t,labelprice); 
   ObjectSetText(closed_TX,PLstr,Label_Size2,Label_Style2,
      ternaryColor(closedTotalPips<0,PL_Label_Text_Negative,PL_Label_Text_Positive));
   
   return;    
}

//+-------------------------------------------------------------------------------------------+
//| Subroutine: Returns decided upon string expression (2 or 3) to use                        |                                                        
//+-------------------------------------------------------------------------------------------+
string ternaryStr(bool expression1, string expression2, string expression3)
{
   string result = expression2;
   if(!expression1) {result = expression3;}
   
   return(result);
}

//+-------------------------------------------------------------------------------------------+
//| Subroutine: Returns decided upon integer expression (2 or 3) to use                       |                                                        
//+-------------------------------------------------------------------------------------------+
int ternaryInt(bool expression1, int expression2, int expression3)
{
   int result = expression2;
   if(!expression1) {result = expression3;}
   
   return(result);
}

//+-------------------------------------------------------------------------------------------+
//| Subroutine: Returns decided upon double expression (2 or 3) to use                        |                                                        
//+-------------------------------------------------------------------------------------------+
double ternaryDbl(bool expression1, double expression2, double expression3)
{
   double result = expression2;
   if(!expression1) {result = expression3;}
   
   return(result);
}

//+-------------------------------------------------------------------------------------------+
//| Subroutine: Returns decided upon color expression (2 or 3) to use                         |                                                        
//+-------------------------------------------------------------------------------------------+
double ternaryColor(bool expression1, color expression2, color expression3)
{
   color result = expression2;
   if(!expression1) {result = expression3;}
   
   return(result);
}

//+-------------------------------------------------------------------------------------------+
//| Subroutine: Returns string expression (s) repeated (n) times                              |                                                        
//+-------------------------------------------------------------------------------------------+
string strRepeat(string s, int n)
{
   string result = "";
   for(int i=0; i<n; i++) {result = result + s;} 
     
   return(result);
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