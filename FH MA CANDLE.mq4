//+------------------------------------------------------------------+
//|                                                   MA Candles.mq4 |
//|                                              Code adapted by cja |
//+------------------------------------------------------------------+

#property copyright      "Code adapted by cja"

//---- indicator settings
#property  indicator_chart_window

#property indicator_buffers 4
#property indicator_color1 C'0,111,0'//wicks
#property indicator_color2 C'111,0,0'//wicks
#property indicator_color3 C'0,111,0'
#property indicator_color4 C'111,0,0'

#property indicator_width1 1
#property indicator_width2 1
#property indicator_width3 3
#property indicator_width4 3
//MODE_SMA 0 Simple moving average, 
//MODE_EMA 1 Exponential moving average, 
//MODE_SMMA 2 Smoothed moving average, 
//MODE_LWMA 3 Linear weighted moving average. 

//PRICE_CLOSE 0 Close price. 
//PRICE_OPEN 1 Open price. 
//PRICE_HIGH 2 High price. 
//PRICE_LOW 3 Low price. 
//PRICE_MEDIAN 4 Median price, (high+low)/2. 
//PRICE_TYPICAL 5 Typical price, (high+low+close)/3. 
//PRICE_WEIGHTED 6 Weighted close price, (high+low+close+close)/4. 


//---- indicator parameters
extern string IIIIIIIIIIIIIIIIIIIII=">>> MA Settings >>>>>>>>>>>>>>>>>";
extern int	    MA1		= 3;
extern int      MA2		= 20;
extern int      MA1_MODE		= 0;
extern int      MA2_MODE		= 0;
extern int      MA1_PRICE		= 0;
extern int      MA2_PRICE		= 0;
extern int      MA1_SHIFT     = 0;
extern int      MA2_SHIFT     = 0;

extern string IIIIIIIIIIIIIIIIIIIIIIIII=">>> Candle/Wick Display Settings >>>>>>>>>>>>>>>>>";		 
extern int		BarWidth			= 1,
					CandleWidth		= 3;
					
extern bool Show_Comment = False;						


//---- indicator buffers
double Bar1[],
		 Bar2[],
		 Candle1[],
		 Candle2[],
		 Candle3[],
		 Candle4[],
		 Candle5[],
		 Candle6[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {


   IndicatorShortName("MA Candles");
	IndicatorBuffers(4);
	
	SetIndexBuffer(0,Bar1);
	SetIndexBuffer(1,Bar2);
	SetIndexBuffer(2,Candle1);
	SetIndexBuffer(3,Candle2);				
	
	SetIndexStyle(0,DRAW_HISTOGRAM,0,BarWidth);
	SetIndexStyle(1,DRAW_HISTOGRAM,0,BarWidth);
	SetIndexStyle(2,DRAW_HISTOGRAM,0,CandleWidth);
	SetIndexStyle(3,DRAW_HISTOGRAM,0,CandleWidth);
	
	SetIndexLabel(0, "MA"+MA1+" + MA"+MA2);
   SetIndexLabel(1, "MA"+MA1+" + MA"+MA2);
   SetIndexLabel(2, "MA"+MA1+" + MA"+MA2);
   SetIndexLabel(3, "MA"+MA1+" + MA"+MA2);
   return(0);
  }
  
  int deinit()
  {
//----
 Comment("");
//----
   return(0);
  }
 
   double MA_1 (int i = 0){return(iMA(NULL,0,MA1,MA1_SHIFT,MA1_MODE, MA1_PRICE,i));}
   double MA_2 (int i = 0){return(iMA(NULL,0,MA2,MA2_SHIFT,MA2_MODE, MA2_PRICE,i));}
  
   
     void SetCandleColor(int col, int i)
{
	double high,low,bodyHigh,bodyLow;

	
	
		bodyHigh = MathMax(Open[i],Close[i]);
		bodyLow  = MathMin(Open[i],Close[i]);
		high		= High[i];
		low		= Low[i];
	

	Bar1[i] = low;	Candle1[i] = bodyLow;
	Bar2[i] = low;	Candle2[i] = bodyLow;
	Bar1[i] = low;	Candle3[i] = bodyLow;
	Bar2[i] = low;	Candle4[i] = bodyLow;
	Bar1[i] = low;	Candle5[i] = bodyLow;
	Bar2[i] = low;	Candle6[i] = bodyLow;

	switch(col)
	{
		case 1: 	Bar1[i] = high;	Candle1[i] = bodyHigh;	break;
		case 2: 	Bar2[i] = high;	Candle2[i] = bodyHigh;	break;
		case 3: 	Bar1[i] = high;	Candle3[i] = bodyHigh;	break;
		case 4: 	Bar2[i] = high;	Candle4[i] = bodyHigh;	break;
		case 5: 	Bar1[i] = high;	Candle5[i] = bodyHigh;	break;
		case 6: 	Bar2[i] = high;	Candle6[i] = bodyHigh;	break;
	}
}

     
   int start()
{
	for(int i = MathMax(Bars-1-IndicatorCounted(),1); i>=0; i--)
	{
		double	Ma1	= MA_1(i);
		double	Ma2	= MA_2(i);
	  

	
		if(Ma1 > Ma2)	SetCandleColor(1,i);
	   else	if(Ma1 < Ma2) SetCandleColor(2,i);


string Label1="",Label2="";      
if(MA1_MODE==0)Label1="MA";if(MA2_MODE==0)Label2="MA";
if(MA1_MODE==1)Label1="EMA";if(MA2_MODE==1)Label2="EMA";
if(MA1_MODE==2)Label1="SMMA";if(MA2_MODE==2)Label2="SMMA";
if(MA1_MODE==3)Label1="LWMA";if(MA2_MODE==3)Label2="LWMA";

     if(Show_Comment==true){
	   Comment("\n","MA Candles  "+Label1+" "+MA1+"  &  "+Label2+ " "+MA2+""); 
	   }	
  }
      	
   return(0);
  }