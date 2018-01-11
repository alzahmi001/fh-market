//+-------------------------------------------------------------------+
//|                                               F41Q_Day_candle.mq4 |
//|                                   Copyright © 2015, Faiq Alzahmi  |
//|                                           hilyaalzahmita@gmail.com|
//+-------------------------------------------------------------------+
#property copyright "Copyright © 2015, Faiq Alzahmi"
#property link      "faiqalzahmi@ymail.com"

#property indicator_chart_window
#property indicator_buffers 4
#property indicator_color1 clrNONE  //  C'0,33,0'
#property indicator_color2 clrNONE
#property indicator_color3 clrNONE
#property indicator_color4 clrNONE//Biru
#property indicator_style1 2
#property indicator_style2 2
#property indicator_width3 0
#property indicator_width4 0
//

extern int       MA1Period=3;
extern int       MA1Method=MODE_SMA;
extern int       MA1Price =PRICE_CLOSE;
extern int       MA2Period=200;
extern int       MA2Method=MODE_SMA;
extern int       MA2Price =PRICE_CLOSE;
extern bool   AlertOn = false,
              EmailOn = false,
              AlertOnClosedCandle = false;
extern bool    ShowArrows = true;
extern int     ArrowWidth = 1;
extern color   ArrowsUpColor = clrWheat;
               ArrowsDnColor = clrOrangeRed;
extern int    Corner = 3; 
              

//
//
//
//
//

double buffer1[];
double buffer2[];
double buffer3[];
double buffer4[];
int Trend=0,SignalCandle=0;
datetime LastAlert=0;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//
//
//
//
//

int init()
{
   SetIndexBuffer(0,buffer3); SetIndexStyle(0,DRAW_HISTOGRAM);
   SetIndexBuffer(1,buffer4); SetIndexStyle(1,DRAW_HISTOGRAM);
   SetIndexBuffer(2,buffer1);
   SetIndexBuffer(3,buffer2);
   if (AlertOnClosedCandle) SignalCandle=1;
   return(0);
}
int deinit() {
   Comment("");
   if (ShowArrows) {
      for (int i=ObjectsTotal()-1;i>=0;i--) {
         if (StringFind(ObjectName(i),"MARibbon")>-1) ObjectDelete(ObjectName(i));
         }
      }
   ObjectDelete("Trade");
   return(0);
} 

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//
//
//
//
//

int start()
{
   int counted_bars=IndicatorCounted();
   int limit,i;
   
   if(counted_bars<0) return(-1);
   if(counted_bars>0) counted_bars--;
           limit=Bars-counted_bars;

   //
   //
   //
   //
   //

   for(i=limit; i>=0; i--)
   {
      buffer1[i] = iMA(NULL,0,MA1Period,0,MA1Method,MA1Price,i);
      buffer2[i] = iMA(NULL,0,MA2Period,0,MA2Method,MA2Price,i);
      buffer3[i] = buffer1[i];
      buffer4[i] = buffer2[i];
      if (buffer1[i+SignalCandle]>buffer2[i+SignalCandle] && buffer1[i+1+SignalCandle]<=buffer2[i+1+SignalCandle] && Trend<1) {
         Trend=1;
	      if (ShowArrows) DrawArrow(i+SignalCandle,buffer2[i+SignalCandle],ArrowsUpColor,173,false);
	      }
      else if (buffer1[i+SignalCandle]<buffer2[i+SignalCandle] && buffer1[i+1+SignalCandle]>=buffer2[i+1+SignalCandle] && Trend>-1) {
      	Trend=-1;
      	if (ShowArrows) DrawArrow(i+SignalCandle,buffer2[i+SignalCandle],ArrowsDnColor,173,true);
         }
   }
   if (buffer1[SignalCandle]>buffer2[SignalCandle] && buffer1[SignalCandle+1]<=buffer2[SignalCandle+1] && LastAlert!=Time[0]) {
      LastAlert=Time[0];
      if (AlertOn) Alert("MA Ribbon Buy Alert! - "+Symbol()+"["+Period()+"m]");
      if (EmailOn) SendMail("MA Ribbon Buy Alert!","Buy alert on "+Symbol()+"["+Period()+"m]");
      }
   else if (buffer1[SignalCandle]<buffer2[SignalCandle] && buffer1[SignalCandle+1]>=buffer2[SignalCandle+1] && LastAlert!=Time[0]) {
      LastAlert=Time[0];
      if (AlertOn) Alert("MA Ribbon Sell Alert! - "+Symbol()+"["+Period()+"m]");
      if (EmailOn) SendMail("MA Ribbon Sell Alert!","Sell alert on "+Symbol()+"["+Period()+"m]");
      }
   string OPstr;
   color OPclr;
   if (Trend>0) {
      OPstr = "BUY";
      OPclr = C'0,0,255';
      }
   else if (Trend<0) {
      OPstr = "SELL";
      OPclr = C'255,0,0';
      }
   else {
      OPstr = "NO Trade";
      OPclr = White;
      }
   ObjectCreate("Trade", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("Trade", OPstr, 11, "Arial Bold", OPclr);
   ObjectSet("Trade", OBJPROP_CORNER, Corner);
   ObjectSet("Trade", OBJPROP_XDISTANCE, 126);
   ObjectSet("Trade", OBJPROP_YDISTANCE, -3);
   return(0);
}
void DrawArrow(int i, double ma, color theColor,int theCode,bool up) {
   string name = "Trend:"+Time[i];
   double gap  = 3.0*iATR(NULL,0,10,i)/4.0;   
   ObjectCreate(name,OBJ_ARROW,0,Time[i],0);
      ObjectSet(name,OBJPROP_ARROWCODE,theCode);
      ObjectSet(name,OBJPROP_COLOR,theColor);
      ObjectSet(name,OBJPROP_WIDTH,ArrowWidth);
      if (up)
            ObjectSet(name,OBJPROP_PRICE1,ma+gap);
      else  ObjectSet(name,OBJPROP_PRICE1,ma-gap);
   return;
}

