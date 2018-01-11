//+------------------------------------------------------------------+
//|                                        #Signal_Bars_v3_Daily.mq4 |
//|                      Copyright © 2006, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2006, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"
#property link      " cja "
#property indicator_chart_window

extern bool Corner_of_Chart_RIGHT_TOP = true;
extern bool Show_Price = false;
extern bool Show_Xtra_Details = false;
extern bool Show_Smaller_Size = true;
extern int Shift_UP_DN =133; 
extern int Adjust_Side_to_side  = -5;
extern color BarLabel_color = LightSteelBlue;
extern color CommentLabel_color = LightSteelBlue;
int      NormalSpread;
color    warna;
string   text,simbol;
double   PrevBid, PrevAsk;


//****************************************

extern int MA_Fast = 8;
extern int MA_Slow = 21;
extern int MA_MODE = 1;
extern int MA_PRICE_TYPE = 0;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   ObjectsDeleteAll(0,OBJ_LABEL); 
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {    
   //***********************************************************************************************************************
   //MACD Signals
   int    counted_bars=IndicatorCounted();
//----
     
    if (Corner_of_Chart_RIGHT_TOP == true)
    {  
   }
    if (Corner_of_Chart_RIGHT_TOP == false)
    { 
           
    } 
          
    
   //*************************************************************************************************************** 
   //STR Signals 
   
       
   //******************************************************************************************************************
   //EMA Signals
   
   
    double EMA_M1 = iMA(Symbol(),1,MA_Fast,0,MA_MODE,MA_PRICE_TYPE,0);
    double ema_m1 = iMA(Symbol(),1,MA_Slow,0,MA_MODE,MA_PRICE_TYPE,0);
    double EMA_M5 = iMA(Symbol(),5,MA_Fast,0,MA_MODE,MA_PRICE_TYPE,0);
    double ema_m5 = iMA(Symbol(),5,MA_Slow,0,MA_MODE,MA_PRICE_TYPE,0);
    double EMA_M15 = iMA(Symbol(),15,MA_Fast,0,MA_MODE,MA_PRICE_TYPE,0);
    double ema_m15 = iMA(Symbol(),15,MA_Slow,0,MA_MODE,MA_PRICE_TYPE,0);
    double EMA_M30 = iMA(Symbol(),30,MA_Fast,0,MA_MODE,MA_PRICE_TYPE,0);
    double ema_m30 = iMA(Symbol(),30,MA_Slow,0,MA_MODE,MA_PRICE_TYPE,0);
    double EMA_H1 = iMA(Symbol(),60,MA_Fast,0,MA_MODE,MA_PRICE_TYPE,0);
    double ema_h1 = iMA(Symbol(),60,MA_Slow,0,MA_MODE,MA_PRICE_TYPE,0);
    double EMA_H4 = iMA(Symbol(),240,MA_Fast,0,MA_MODE,MA_PRICE_TYPE,0);
    double ema_h4 = iMA(Symbol(),240,MA_Slow,0,MA_MODE,MA_PRICE_TYPE,0);
    double EMA_D1 = iMA(Symbol(),1440,MA_Fast,0,MA_MODE,MA_PRICE_TYPE,0);
    double ema_d1 = iMA(Symbol(),1440,MA_Slow,0,MA_MODE,MA_PRICE_TYPE,0);
   // double EMA_W1 = iMA(Symbol(),10080,MA_Fast,0,MA_MODE,MA_PRICE_TYPE,0);
   // double ema_w1 = iMA(Symbol(),10080,MA_Slow,0,MA_MODE,MA_PRICE_TYPE,0);
    
    string M1_EMA= "",M5_EMA= "", M15_EMA= "", M30_EMA= "", H1_EMA= "", H4_EMA= "", D1_EMA= "";
    color  color_EMAm1,color_EMAm5,color_EMAm15,color_EMAm30,color_EMAm60,color_EMAm240,color_EMAm1440;     
         
    
    if (EMA_M1 > ema_m1) {M1_EMA= "-";color_EMAm1 = Lime; }
    if (EMA_M1 <= ema_m1) {M1_EMA= "-";color_EMAm1 = Red; }
    
    if (EMA_M5 > ema_m5) {M5_EMA= "-";color_EMAm5 = Lime; }
    if (EMA_M5 <= ema_m5) {M5_EMA= "-";color_EMAm5 = Red; }
    
    if (EMA_M15 > ema_m15) {M15_EMA= "-";color_EMAm15 = Lime; }
    if (EMA_M15 <= ema_m15) {M15_EMA= "-";color_EMAm15 = Red; }
    
    if (EMA_M30 > ema_m30) {M30_EMA= "-";color_EMAm30 = Lime; }
    if (EMA_M30 <= ema_m30) {M30_EMA= "-";color_EMAm30 = Red; }
    
    if (EMA_H1 > ema_h1) {H1_EMA= "-";color_EMAm60 = Lime; }
    if (EMA_H1 <= ema_h1) {H1_EMA= "-";color_EMAm60 = Red; }
    
    if (EMA_H4 > ema_h4) {H4_EMA= "-";color_EMAm240 = Lime; }
    if (EMA_H4 <= ema_h4) {H4_EMA= "-";color_EMAm240 = Red; }
         
    if (EMA_D1 > ema_d1) {D1_EMA= "-";color_EMAm1440 = Lime; }
    if (EMA_D1 <= ema_d1) {D1_EMA= "-";color_EMAm1440 = Red; }
    
          
          
           ObjectCreate("SignalEMAM1", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("SignalEMAM1", M1_EMA, 45, "Tahoma Narrow",  color_EMAm1);
   ObjectSet("SignalEMAM1", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
   ObjectSet("SignalEMAM1", OBJPROP_XDISTANCE, 130+Adjust_Side_to_side);
   ObjectSet("SignalEMAM1", OBJPROP_YDISTANCE, 18+Shift_UP_DN); 
        
           ObjectCreate("SignalEMAM5", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("SignalEMAM5", M5_EMA, 45, "Tahoma Narrow",  color_EMAm5);
   ObjectSet("SignalEMAM5", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
   ObjectSet("SignalEMAM5", OBJPROP_XDISTANCE, 110+Adjust_Side_to_side);
   ObjectSet("SignalEMAM5", OBJPROP_YDISTANCE, 18+Shift_UP_DN); 
      
           ObjectCreate("SignalEMAM15", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("SignalEMAM15", M15_EMA, 45, "Tahoma Narrow",  color_EMAm15);
   ObjectSet("SignalEMAM15", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
   ObjectSet("SignalEMAM15", OBJPROP_XDISTANCE, 90+Adjust_Side_to_side);
   ObjectSet("SignalEMAM15", OBJPROP_YDISTANCE, 18+Shift_UP_DN); 
      
           ObjectCreate("SignalEMAM30", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("SignalEMAM30", M30_EMA, 45, "Tahoma Narrow",  color_EMAm30);
   ObjectSet("SignalEMAM30", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
   ObjectSet("SignalEMAM30", OBJPROP_XDISTANCE, 70+Adjust_Side_to_side);
   ObjectSet("SignalEMAM30", OBJPROP_YDISTANCE, 18+Shift_UP_DN); 
      
           ObjectCreate("SignalEMAM60", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("SignalEMAM60", H1_EMA, 45, "Tahoma Narrow",  color_EMAm60);
   ObjectSet("SignalEMAM60", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
   ObjectSet("SignalEMAM60", OBJPROP_XDISTANCE, 50+Adjust_Side_to_side);
   ObjectSet("SignalEMAM60", OBJPROP_YDISTANCE, 18+Shift_UP_DN); 
         
           ObjectCreate("SignalEMAM240", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("SignalEMAM240", H4_EMA, 45, "Tahoma Narrow",  color_EMAm240);
   ObjectSet("SignalEMAM240", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
   ObjectSet("SignalEMAM240", OBJPROP_XDISTANCE, 30+Adjust_Side_to_side);
   ObjectSet("SignalEMAM240", OBJPROP_YDISTANCE, 18+Shift_UP_DN);
   
           ObjectCreate("SignalEMAM1440", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("SignalEMAM1440", D1_EMA, 45, "Tahoma Narrow",  color_EMAm1440);
   ObjectSet("SignalEMAM1440", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
   ObjectSet("SignalEMAM1440", OBJPROP_XDISTANCE, 10+Adjust_Side_to_side);
   ObjectSet("SignalEMAM1440", OBJPROP_YDISTANCE, 18+Shift_UP_DN);
    
   //*****************************************************************************************************
   //Info
   
  
        
    if (Show_Smaller_Size  == false)
    {  
      
    if (Show_Price  == true)
    {     ; 
   }}
          
    if (Show_Smaller_Size  == true)
    {  
     if (Show_Price  == true)
    {       
   }}
   int R1=0,R5=0,R10=0,R20=0,RAvg=0,i=0;
   R1 =  (iHigh(NULL,PERIOD_D1,1)-iLow(NULL,PERIOD_D1,1))/Point;
   for(i=1;i<=5;i++)
      R5    =    R5  +  (iHigh(NULL,PERIOD_D1,i)-iLow(NULL,PERIOD_D1,i))/Point;
   for(i=1;i<=10;i++)
      R10   =    R10 +  (iHigh(NULL,PERIOD_D1,i)-iLow(NULL,PERIOD_D1,i))/Point;
   for(i=1;i<=20;i++)
      R20   =    R20 +  (iHigh(NULL,PERIOD_D1,i)-iLow(NULL,PERIOD_D1,i))/Point;

   R5 = R5/5;
   R10 = R10/10;
   R20 = R20/20;
   RAvg  =  (R1+R5+R10+R20)/4;    
   
   string HI="",LO="",SPREAD="",PIPS="",DAV="",HILO="",Pips="",Av="",AV_Yest="";
   color color_pip,color_av;
   double OPEN = iOpen(NULL,1440,0);
   double CLOSE = iClose(NULL,1440,0);
   double SPRD = (Ask - Bid)/Point;
   double High_Today = iHigh(NULL,1440,0);
   double Low_Today = iLow(NULL,1440,0);
   PIPS =  DoubleToStr((CLOSE-OPEN)/Point,0);
   SPREAD = (DoubleToStr(SPRD,Digits-5));
   DAV = (DoubleToStr(RAvg,Digits-5));
   AV_Yest =  (iHigh(NULL,PERIOD_D1,1)-iLow(NULL,PERIOD_D1,1))/Point;
   HILO = DoubleToStr((High_Today-Low_Today)/Point,0);
  
     if (CLOSE >= OPEN) {Pips= "-";color_pip = Lime; }
     if (CLOSE < OPEN) {Pips= "-";color_pip = Red; }
      if (DAV > AV_Yest) {Av= "-";color_av = Lime; }
     if (DAV < AV_Yest) {Av= "-";color_av = Red; }
     
        
    if (Show_Smaller_Size  == false)
    {     
    if (Show_Xtra_Details == true)
    {
     if (Show_Price  == true)
    {  
    
 }}}
 //*****************************************************************
 //Shift if price not wanted
  if (Show_Smaller_Size  == false)
    {     
    if (Show_Xtra_Details == true)
    {
     if (Show_Price  == false)
    {  
    
 }}}
 
  //***********************************************************************
  //Smaller type option     
    if (Show_Smaller_Size  == true)
    {     
    if (Show_Xtra_Details == true)
    {
     if (Show_Price  == true)
    {  
    
                
 }}}
 
 // ==================================================================================== //
        //                           S E C O N D   C O L O U M B                                //
        // ==================================================================================== //
        
        // MH
        // ====
      
        ObjectCreate("MMLEVELS15", OBJ_LABEL,0, 0, 0);
        ObjectSetText("MMLEVELS15","",10, "Arial Bold", LightSteelBlue);
        ObjectSet("MMLEVELS15", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
        ObjectSet("MMLEVELS15", OBJPROP_XDISTANCE, 43+Adjust_Side_to_side);
        ObjectSet("MMLEVELS15", OBJPROP_YDISTANCE, 100+Shift_UP_DN);

        double SMA3close, SMA3open;

        SMA3close   = iMA(NULL,PERIOD_M15,3,0,MODE_SMA,PRICE_CLOSE,0);
        SMA3open    = iMA(NULL,PERIOD_M15,20,0,MODE_SMA,PRICE_CLOSE,0);
        if (SMA3close>=SMA3open)     { warna = C'0,205,0'; simbol = "\xF3"; }
        else                         { warna = C'205,0,0';  simbol = "\xF3"; }
        ObjectCreate ("MHT", OBJ_LABEL, 0, 0, 0);
        ObjectSetText("MHT",simbol,20, "Wingdings 2", warna);
        ObjectSet("MHT", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
        ObjectSet("MHT", OBJPROP_XDISTANCE, 140+Adjust_Side_to_side);
        ObjectSet("MHT", OBJPROP_YDISTANCE, 296+Shift_UP_DN);
         
        SMA3close   = iMA(NULL,PERIOD_M15,20,0,MODE_SMA,PRICE_CLOSE,0);
        SMA3open    = iMA(NULL,PERIOD_M15,100,0,MODE_SMA,PRICE_CLOSE,0);
        if (SMA3close>=SMA3open)     { warna = C'0,230,0'; simbol = "\xF3"; }
        else                         { warna = C'230,0,0';  simbol = "\xF3"; }
        ObjectCreate ("MHM", OBJ_LABEL, 0, 0, 0);
        ObjectSetText("MHM",simbol,20, "Wingdings 2", warna);
        ObjectSet("MHM", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
        ObjectSet("MHM", OBJPROP_XDISTANCE, 140+Adjust_Side_to_side);
        ObjectSet("MHM", OBJPROP_YDISTANCE, 330+Shift_UP_DN);

        SMA3close   = iMA(NULL,PERIOD_M15,100,0,MODE_SMA,PRICE_CLOSE,0);
        SMA3open    = iMA(NULL,PERIOD_M15,200,0,MODE_SMA,PRICE_CLOSE,0);
        if (SMA3close>=SMA3open)     { warna = Lime; simbol = "\xF3"; }
        else                         { warna = Red;  simbol = "\xF3"; }
        ObjectCreate ("MHG", OBJ_LABEL, 0, 0, 0);
        ObjectSetText("MHG",simbol,20, "Wingdings 2", warna);
        ObjectSet("MHG", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
        ObjectSet("MHG", OBJPROP_XDISTANCE, 140+Adjust_Side_to_side);
        ObjectSet("MHG", OBJPROP_YDISTANCE, 370+Shift_UP_DN);

        SMA3close   = iMA(NULL,PERIOD_M15,3,0,MODE_SMA,PRICE_CLOSE,0);
        SMA3open    = iMA(NULL,PERIOD_M15,20,0,MODE_SMA,PRICE_CLOSE,0);
        if (SMA3close>=SMA3open)   { warna = Lime; simbol = "\xF3"; }
        else                         { warna = Red;  simbol = "\xF3"; }
        ObjectCreate ("TREND", OBJ_LABEL, WindowFind("TrixEMAboard"), 0, 0);
        ObjectSetText("TREND",simbol,19, "Wingdings 2", warna);
        ObjectSet("TREND", OBJPROP_XDISTANCE, 1200);
        ObjectSet("TREND", OBJPROP_YDISTANCE, 11);

        
 
 //****************************************************************
 // Shift if Price not needed
  if (Show_Smaller_Size  == true)
    {     
    if (Show_Xtra_Details == true)
    {
     if (Show_Price  == false)
    {  
    
                ObjectCreate("MMLEVELS7", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("MMLEVELS7","", 9, "Arial", CommentLabel_color);
   ObjectSet("MMLEVELS7", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
   ObjectSet("MMLEVELS7", OBJPROP_XDISTANCE, 40+Adjust_Side_to_side);
   ObjectSet("MMLEVELS7", OBJPROP_YDISTANCE, 60+Shift_UP_DN); 
   
               ObjectCreate("MMLEVELS8", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("MMLEVELS8",""+SPREAD+"", 9, "Arial Bold", Yellow);
   ObjectSet("MMLEVELS8", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
   ObjectSet("MMLEVELS8", OBJPROP_XDISTANCE, 10+Adjust_Side_to_side);
   ObjectSet("MMLEVELS8", OBJPROP_YDISTANCE, 60+Shift_UP_DN);  
   
     
                ObjectCreate("MMLEVELS9", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("MMLEVELS9","", 9, "Arial", CommentLabel_color);
   ObjectSet("MMLEVELS9", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
   ObjectSet("MMLEVELS9", OBJPROP_XDISTANCE, 40+Adjust_Side_to_side);
   ObjectSet("MMLEVELS9", OBJPROP_YDISTANCE, 75+Shift_UP_DN); 
   
               ObjectCreate("MMLEVELS10", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("MMLEVELS10",""+PIPS+"", 9, "Arial Bold", color_pip);
   ObjectSet("MMLEVELS10", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
   ObjectSet("MMLEVELS10", OBJPROP_XDISTANCE, 10+Adjust_Side_to_side);
   ObjectSet("MMLEVELS10", OBJPROP_YDISTANCE, 75+Shift_UP_DN);  
      
                ObjectCreate("MMLEVELS11", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("MMLEVELS11","", 9, "Arial", CommentLabel_color);
   ObjectSet("MMLEVELS11", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
   ObjectSet("MMLEVELS11", OBJPROP_XDISTANCE, 40+Adjust_Side_to_side);
   ObjectSet("MMLEVELS11", OBJPROP_YDISTANCE, 90+Shift_UP_DN); 
   
               ObjectCreate("MMLEVELS12", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("MMLEVELS12",""+HILO+"", 9, "Arial Bold", Yellow);
   ObjectSet("MMLEVELS12", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
   ObjectSet("MMLEVELS12", OBJPROP_XDISTANCE, 10+Adjust_Side_to_side);
   ObjectSet("MMLEVELS12", OBJPROP_YDISTANCE, 90+Shift_UP_DN);  
   
                 ObjectCreate("MMLEVELS13", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("MMLEVELS13","", 9, "Arial",CommentLabel_color);
   ObjectSet("MMLEVELS13", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
   ObjectSet("MMLEVELS13", OBJPROP_XDISTANCE, 40+Adjust_Side_to_side);
   ObjectSet("MMLEVELS13", OBJPROP_YDISTANCE, 105+Shift_UP_DN); 
   
               ObjectCreate("MMLEVELS14", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("MMLEVELS14",""+DAV+"", 9, "Arial Narrow", color_av);
   ObjectSet("MMLEVELS14", OBJPROP_CORNER, Corner_of_Chart_RIGHT_TOP);
   ObjectSet("MMLEVELS14", OBJPROP_XDISTANCE, 10+Adjust_Side_to_side);
   ObjectSet("MMLEVELS14", OBJPROP_YDISTANCE, 105+Shift_UP_DN); 
 }}}
 //----
   return(0);
  }
//+------------------------------------------------------------------+