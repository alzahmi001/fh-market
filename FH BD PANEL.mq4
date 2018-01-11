
// +----------------------------------------------------------------------------------------+ //
// |    .-._______                           XARD777                          _______.-.    | //
// |---( )_)______)                 Knowledge of the ancients                (______(_( )---| //
// |  (    ()___)                              \¦/                             (___()    )  | //
// |       ()__)                              (o o)                             (__()       | //
// |--(___()_)__________________________oOOo___(_)___oOOo_________________________(_()___)--| //
// |_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|____|_____| //
// |                                                                                   2011 | //
// |----------------------------------------------------------------------------------------| //
// |                 File:     !BDP PANEL.mq4                                               | //
// | Programming language:     MQL4                                                         | //
// | Development platform:     MetaTrader 4                                                 | //
// |          End product:     Indicator for MetaTrader 4 designed                          | //
// |                           for Build 229 (current version)                              | //
// |                                                               [BILLION DOLLAR PROJECT] | //
// +----------------------------------------------------------------------------------------+ //

#property indicator_chart_window

color    color1      = LimeGreen;
color    color2      = SlateGray;
color    color3      = White;
color    color4      = DodgerBlue;

color    TextColor2  = C'192,192,192';
color    TextColor3  = C'50,160,50';
color    TextColor4  = SlateGray;
color    BoxColor    = C'13,13,63';
color    BoxColor1   = C'15,15,15';
color    BoxColor2   = C'00,00,00';
color    BoxColor3   = C'10,20,30';
color    BoxColor4   = C'20,30,40';
color    BoxColor5   = C'30,40,50';
color    BoxColor6   = C'85, 109, 116';
color    BoxColor7   = C'68,87,93';
color    BoxColor8   = C'51,65,70';
color    BoxColor9   = C'34,44,47';

// ------------------------------------------------------------------------------------------ //
//                            E X T E R N A L   V A R I A B L E S                             //
// ------------------------------------------------------------------------------------------ //

extern bool   showpanel      = true;
extern string FiboStart       = "02:00";
extern string FiboEnd         = "02:00"; 

// ------------------------------------------------------------------------------------------ //
//                            I N T E R N A L   V A R I A B L E S                             //
// ------------------------------------------------------------------------------------------ //

int         OpenBar;
double      LastHigh,
            LastLow,
            LastClose;
int         WhatWindow        = 0;
int         WhatWindow1       = 1;
int         WhatCorner0       = 0;
int         WhatCorner1       = 1;
int         WhatCorner2       = 2;
int         WhatCorner3       = 3;
int         Shiftupdown     = 0;
int         Shiftsideway     = 0;
bool        showtimer        =  true;
bool        showextradigit  =  false;  
int         BidFontSize       =  30;
string      BidFontType       =  "Arial Bold";
int         FontSize          =  11;
string      FontType          =  "Arial";
string      FontType2         =  "Arial Bold";
double      DecNos;
double      myPoint;
double      fibo;

double      AUTOSELECT;
double      col               =  White;

double      SetPoint() 

   { 
   double mPoint; 
   
   if (Digits < 4) 
   mPoint = 0.01; 
   else 
   mPoint = 0.0001; 
   
   return(mPoint); 
   }

// ------------------------------------------------------------------------------------------ //
//                             I N I T I A L I S A T I O N                                    //
// ------------------------------------------------------------------------------------------ //

   int init()
   {
   IndicatorShortName("Price-Info");  
    myPoint = SetPoint(); 
    
   return(0);
   }

// ------------------------------------------------------------------------------------------ //
//                            D E - I N I T I A L I S A T I O N                               //
// ------------------------------------------------------------------------------------------ //

   int deinit()
   {
   deleteObjects();
   return(0);
   }

// ------------------------------------------------------------------------------------------ //
//                                M A I N   P R O C E D U R E                                 //
// ------------------------------------------------------------------------------------------ //

   int start()
   {
   
    if(showextradigit){int digit=1;int digitshift=-3;int digitshift1=-5;int digitshift2=3;int fontsize=4;int sprd=1;}
    else{ digitshift=0;digitshift1=0;digitshift2=0;fontsize=0;sprd=0;}

    if (StringFind (Symbol(),"JPY", 0) != -1){ DecNos = 2+digit;}
        else { DecNos = 4+digit; }
     
   int    counted_bars=IndicatorCounted();
        
// ------------------------------------------------------------------------------------------ // 

   if(showpanel){
   
   CreateFX1_Labels( "Panel001",6, 6); 
   ObjectSetText("Panel001", "g", 96, "Webdings", BoxColor2);
   
   CreateFX1_Labels( "Panel002",0,233); 
   ObjectSetText("Panel002", "g", 96, "Webdings", BoxColor2);
   
   CreateFX1_Labels( "Panel003",65,247); 
   ObjectSetText("Panel003", "g", 87, "Webdings", BoxColor2);
   
   CreateFX1_Labels( "Panel004",0,0); 
   ObjectSetText("Panel004", "g", 0, "Webdings", BoxColor2);
   
   CreateFX1_Labels( "Panel005",0,416); 
   ObjectSetText("Panel005", "g", 133, "Webdings", C'40,40,40');

// ------------------------------------------------------------------------------------------ //  
   
   CreateFX3_Labels( "Panel006",3,0); 
   ObjectSetText("Panel006", "g", 61, "Webdings", BoxColor1);
   
   CreateFX3_Labels( "Panel007",83,0); 
   ObjectSetText("Panel007", "g", 24, "Webdings", BoxColor1);
   
   CreateFX3_Labels( "Panel008",6,292); 
   ObjectSetText("Panel008", "g", 133, "Webdings", BoxColor1);
   
   CreateFX3_Labels( "Panel009",6,380); 
   ObjectSetText("Panel009", "g", 133, "Webdings", BoxColor1);
   
   CreateFX1_Labels( "Panel010",98,73); 
   ObjectSetText("Panel010", "FAIQ", 7, "Arial Bold", color4);
     
   }//End show.panel
 
// ------------------------------------------------------------------------------------------ // 
      
   CreateFX1_Labels( "Panel011",16,80); 
   ObjectSetText("Panel011", "HILYA", 11, "Arial Bold", color1);
      
// ------------------------------------------------------------------------------------------ //      

   double spread = (Ask-Bid)/myPoint;
   
   if(spread>1 && spread<=10)
   
   int sprdshift=4;
   
   CreateFX3_Labels( "Panel012",117,-3); 
   ObjectSetText("Panel012", "ggggg", 9, "Webdings", C'20,30,40');
   
   CreateFX3_Labels( "Panel013",150,220); 
   ObjectSetText("Panel013", ""+DoubleToStr(spread,1)+"", FontSize, "Arial", color3);

// ------------------------------------------------------------------------------------------ //     

   string symbol="";
   
        if (Symbol()=="EURUSD" || Symbol()=="EURUSDm") {symbol="EURUSD";}
   else if (Symbol()=="GBPUSD" || Symbol()=="GBPUSDm") {symbol="GBPUSD";}
   else if (Symbol()=="USDCHF" || Symbol()=="USDCHFm") {symbol="USDCHF";}
   else if (Symbol()=="USDJPY" || Symbol()=="USDJPYm") {symbol="USDJPY";}
   else if (Symbol()=="EURJPY" || Symbol()=="EURJPYm") {symbol="EURJPY";}
   else if (Symbol()=="EURCHF" || Symbol()=="EURCHFm") {symbol="EURCHF";}
   else if (Symbol()=="EURGBP" || Symbol()=="EURGBPm") {symbol="EURGBP";}
   else if (Symbol()=="USDCAD" || Symbol()=="USDCADm") {symbol="USDCAD";}
   else if (Symbol()=="AUDUSD" || Symbol()=="AUDUSDm") {symbol="AUDUSD";}
   else if (Symbol()=="GBPCHF" || Symbol()=="GBPCHFm") {symbol="GBPCHF";}
   else if (Symbol()=="GBPJPY" || Symbol()=="GBPJPYm") {symbol="GBPJPY";}
   else if (Symbol()=="CHFJPY" || Symbol()=="CHFJPYm") {symbol="CHFJPY";}
   else if (Symbol()=="NZDUSD" || Symbol()=="NZDUSDm") {symbol="NZDUSD";}
   else if (Symbol()=="EURCAD" || Symbol()=="EURCADm") {symbol="EURCAD";}
   else if (Symbol()=="AUDJPY" || Symbol()=="AUDJPYm") {symbol="AUDJPY";}
   else if (Symbol()=="EURAUD" || Symbol()=="EURAUDm") {symbol="EURAUD";}
   else if (Symbol()=="AUDCAD" || Symbol()=="AUDCADm") {symbol="AUDCAD";}
   else if (Symbol()=="AUDNZD" || Symbol()=="AUDNZDm") {symbol="AUDNZD";}
   else if (Symbol()=="NZDJPY" || Symbol()=="NZDJPYm") {symbol="NZDJPY";}
   else if (Symbol()=="CADJPY" || Symbol()=="CADJPYm") {symbol="CADJPY";}
   else if (Symbol()=="XAUUSD" || Symbol()=="XAUUSDm") {symbol="XAUUSD";}
   else if (Symbol()=="XAGUSD" || Symbol()=="XAGUSDm") {symbol="XAGUSD";}
   else if (Symbol()=="GBPAUD" || Symbol()=="GBPAUDm") {symbol="GBPAUD";}
   else if (Symbol()=="GBPCAD" || Symbol()=="GBPCADm") {symbol="GBPCAD";}
   else if (Symbol()=="AUFCHF" || Symbol()=="AUFCHFm") {symbol="AUFCHF";}
   else if (Symbol()=="CADCHF" || Symbol()=="CADCHFm") {symbol="CADCHF";}
   else if (Symbol()=="NZDCHF" || Symbol()=="NZDCHFm") {symbol="NZDCHF";}
   else if (Symbol()=="GBPNZD" || Symbol()=="GBPNZDm") {symbol="GBPNZD";}
   else if (Symbol()=="AUDCHF" || Symbol()=="AUDCHFm") {symbol="AUDCHF";}
   else if (Symbol()=="EURNZD" || Symbol()=="EURNZDm") {symbol="EURNZD";}
   else{symbol=Symbol();int syblsize = 5;int syblshift=2;}
   
       
// ------------------------------------------------------------------------------------------ //

   CreateFX3_Labels( "Panel015",41,220); 
   ObjectSetText("Panel015", "gggg", 20, "Webdings", BoxColor1);
   CreateFX3_Labels( "Panel016",3,75); 
   ObjectSetText("Panel016", "gggg", 21, "Webdings", C'13,13,13');
   CreateFX3_Labels( "Panel017",3,99); 
   ObjectSetText("Panel017", "gggg", 21, "Webdings", C'11,11,11');
   CreateFX3_Labels( "box",3,49); 
   ObjectSetText("box", "gggg", 21, "Webdings", C'9,9,9');
   CreateFX3_Labels( "box1",3,25); 
   ObjectSetText("box1", "gggg", 21, "Webdings", C'7,7,7');
   
   CreateFX3_Labels( "Panel018",86+digitshift+Shiftupdown,470); 
   ObjectSetText("Panel018", "======", 11, FontType2, color2);

   CreateFX3_Labels( "Panel019",2+Shiftupdown,240); 
   ObjectSetText("Panel019", DoubleToStr(AccountBalance(),0) , FontSize, FontType2, Silver);
   
   CreateFX3_Labels( "Panel020",0+Shiftupdown,235); 
   ObjectSetText("Panel020", "-----------------------", 8, FontType2, color2);
   
   CreateFX3_Labels( "Panel021",2+Shiftupdown,220); 
   ObjectSetText("Panel021", DoubleToStr(AccountEquity(),0) , FontSize, FontType2, SlateGray);
   
   CreateFX3_Labels( "Panel022",90+Shiftupdown,235); 
   ObjectSetText("Panel022", "----------------------", 8, FontType2, color2);
      
   if (AccountProfit() >0) col = C'0,150,0';
   if (AccountProfit() <0) col = Crimson;
  
   CreateFX3_Labels( "Panel023",90+Shiftupdown,220); 
   ObjectSetText("Panel023", DoubleToStr(AccountProfit(),1) , FontSize, FontType2, col);
       
// ------------------------------------------------------------------------------------------ //

   
   
// ------------------------------------------------------------------------------------------ //

   int BarHour = Time[0] + 60 * Period() - TimeCurrent();
   double ld_0 = BarHour / 60.0;
   int BarSec = BarHour % 60;
   BarHour = (BarHour - BarHour % 60) / 60;
   
   if(BarSec<=9)string zero="0";
   if(BarHour>=1 && BarHour<=9)int shift=-1;
   else if(BarHour>=10 && BarHour<=99)shift=-6;
   else if(BarHour>=100 && BarHour<=999)shift=-15;
   else if(BarHour>=1000 && BarHour<=9999)shift=-16;
   else if(BarHour>=10000 && BarHour<=99999)shift=-19;
   
   CreateFX3_Labels( "Panel025",145+shift,200); 
   ObjectSetText("Panel025", "" + BarHour + ":"+zero+"" + BarSec, 11, "Arial Bold", Orange);
   
// ------------------------------------------------------------------------------------------ //      
      
   {  string BarTime="", LastBarTime="";         
   string BarDay="", LastBarDay="";
   int CloseBar;
          
   for(int i=Bars; i>=0; i--)
   {  if (Period() > 60) return(0);		//Chart cannot be higher than H4
   BarTime = TimeToStr(Time[i], TIME_MINUTES);
   LastBarTime = TimeToStr(Time[i+1], TIME_MINUTES);
   BarDay = TimeToStr(Time[i],TIME_DATE);
   LastBarDay = TimeToStr(Time[i+1],TIME_DATE); 
      
   if ((FiboEnd == "02:00" && BarTime>=FiboEnd && BarDay>LastBarDay) || (BarTime>=FiboEnd && LastBarTime<FiboEnd))
   {  CloseBar = i + 1;
         
   if (OpenBar>0)
   {  calculatePivotRangeValues(OpenBar, CloseBar);  }  }
      
   if ((FiboStart == "02:00" && BarTime>=FiboStart && BarDay>LastBarDay) || (BarTime>=FiboStart && LastBarTime<FiboStart))
   { OpenBar = i; }   
   }   
      
   CreateFX3_Labels( "Panel026",118,108); 
   ObjectSetText("Panel026", "ggggg", 9, "Webdings", C'70,70,70');//C'7,20,40');
   CreateFX3_Labels( "Panel027",117,71); 
   ObjectSetText("Panel027", "ggggg", 9, "Webdings", C'70,70,70');
   CreateFX3_Labels( "Panel032",117,35); 
   ObjectSetText("Panel032", "ggggg", 9, "Webdings", C'66,66,66');
   CreateFX3_Labels( "box2",124,99); 
   ObjectSetText("box2", "gggg", 8, "Webdings", C'3,15,15');
   CreateFX3_Labels( "box3",124,89); 
   ObjectSetText("box3", "gggg", 8, "Webdings", C'5,10,10');
   CreateFX3_Labels( "box4",124,85); 
   ObjectSetText("box4", "gggg", 8, "Webdings", C'7,5,5');
   CreateFX3_Labels( "box5",124,62); 
   ObjectSetText("box5", "gggg", 8, "Webdings", C'3,3,3');
   CreateFX3_Labels( "box6",124,53); 
   ObjectSetText("box6", "gggg", 8, "Webdings", C'5,5,5');
  
   
   CreateFX3_Labels( "Trend",132+digitshift+Shiftupdown,112); 
   ObjectSetText("Trend", "TREND", 7, "Verdana Bold", color2);
   CreateFX3_Labels( "Market",125+digitshift+Shiftupdown,75); 
   ObjectSetText("Market", "MARKET", 7, "Verdana Bold", color2);
    CreateFX3_Labels( "Global",125+digitshift+Shiftupdown,40); 
   ObjectSetText("Global", "GLOBAL", 7, "Verdana Bold", color2);
   
   
   fibo = 100*(Bid-LastLow)/(LastHigh-LastLow);
   
   CreateFX3_Labels( "Panel029",130+digitshift+Shiftupdown,180); 
   ObjectSetText("Panel029", DoubleToStr(fibo,2)+"%", 11, "Arial Bold", DodgerBlue);

   CreateFX3_Labels( "Panel030",65+digitshift+Shiftupdown,202); 
   ObjectSetText("Panel030", "YH:"+DoubleToStr(LastHigh,DecNos), FontSize, FontType, clrGreen);
   
   CreateFX3_Labels( "Panel031",65+digitshift+Shiftupdown,180); 
   ObjectSetText("Panel031", "YL:"+DoubleToStr(LastLow,DecNos), FontSize, FontType, clrRed);
                
// ------------------------------------------------------------------------------------------ //
  
   }
   return(0);  
}
   int CreateFX1_Labels( string b, int x, int y ) {
   ObjectCreate( b, OBJ_LABEL, WhatWindow, 0, 0 );
   ObjectSet( b, OBJPROP_CORNER, WhatCorner1 );
   ObjectSet( b, OBJPROP_XDISTANCE,x+Shiftupdown);
   ObjectSet( b, OBJPROP_YDISTANCE,y+Shiftsideway);
   ObjectSet( b, OBJPROP_BACK, false );
    return(0);}
   
   int CreateFX3_Labels( string c, int x2, int y2 ) {
   ObjectCreate( c, OBJ_LABEL, WhatWindow, 0, 0 );
   ObjectSet( c, OBJPROP_CORNER, WhatCorner3 );
   ObjectSet( c, OBJPROP_XDISTANCE,x2+Shiftupdown);
   ObjectSet( c, OBJPROP_YDISTANCE,y2+Shiftsideway);
   ObjectSet( c, OBJPROP_BACK, false );
    return(0);}
  
   void deleteObjects(){
   
   ObjectDelete("Panel001");
   ObjectDelete("Panel002");
   ObjectDelete("Panel003");
   ObjectDelete("Panel004");
   ObjectDelete("Panel005");
   ObjectDelete("Panel006");
   ObjectDelete("Panel007");
   ObjectDelete("Panel008");
   ObjectDelete("Panel009");
   ObjectDelete("Panel010");
   ObjectDelete("Panel011");
   ObjectDelete("Panel012");
   ObjectDelete("Panel013");
   ObjectDelete("Panel014");
   ObjectDelete("Panel015");
   ObjectDelete("Panel016");
   ObjectDelete("Panel017");
   ObjectDelete("Panel018");
   ObjectDelete("Panel019");
   ObjectDelete("Panel020");
   ObjectDelete("Panel021");
   ObjectDelete("Panel022");
   ObjectDelete("Panel023");
   ObjectDelete("Panel024");
   ObjectDelete("Panel025");
   ObjectDelete("Panel026");
   ObjectDelete("Panel027");
   ObjectDelete("Trend");
   ObjectDelete("Market");
   ObjectDelete("Global");
   ObjectDelete("Panel029");
   ObjectDelete("Panel030");
   ObjectDelete("Panel031");  
   ObjectDelete("box");  
   ObjectDelete("box1"); 
   ObjectDelete("box2"); 
   ObjectDelete("box3");  
   ObjectDelete("box4"); 
   ObjectDelete("box5");
   ObjectDelete("box6");
   }
    
   void calculatePivotRangeValues(int openBar, int closeBar)
   {
   LastHigh = High[Highest(NULL, 0, MODE_HIGH, (openBar - closeBar + 1), closeBar)];
   LastLow = Low[Lowest(NULL, 0, MODE_LOW, (openBar - closeBar + 1), closeBar)];
   LastClose = Close[closeBar];
   }
// ------------------------------------------------------------------------------------------ //
//                                     E N D   P R O G R A M                                  //
// ------------------------------------------------------------------------------------------ //
/*                                                         
                                        ud$$$**BILLION$bc.                          
                                    u@**"        PROJECT$$Nu                       
                                  J                ""#$$$$$$r                     
                                 @                       $$$$b                    
                               .F                        ^*3$$$                   
                              :% 4                         J$$$N                  
                              $  :F                       :$$$$$                  
                             4F  9                       J$$$$$$$                 
                             4$   k             4$$$$bed$$$$$$$$$                 
                             $$r  'F            $$$$$$$$$$$$$$$$$r                
                             $$$   b.           $$$$$$$$$$$$$$$$$N                
                             $$$$$k 3eeed$$b    XARD777."$$$$$$$$$                
              .@$**N.        $$$$$" $$$$$$F'L $$$$$$$$$$$  $$$$$$$                
              :$$L  'L       $$$$$ 4$$$$$$  * $$$$$$$$$$F  $$$$$$F         edNc   
             @$$$$N  ^k      $$$$$  3$$$$*%   $F4$$$$$$$   $$$$$"        d"  z$N  
             $$$$$$   ^k     '$$$"   #$$$F   .$  $$$$$c.u@$$$          J"  @$$$$r 
             $$$$$$$b   *u    ^$L            $$  $$$$$$$$$$$$u@       $$  d$$$$$$ 
              ^$$$$$$.    "NL   "N. z@*     $$$  $$$$$$$$$$$$$P      $P  d$$$$$$$ 
                 ^"*$$$$b   '*L   9$E      4$$$  d$$$$$$$$$$$"     d*   J$$$$$r   
                      ^$$$$u  '$.  $$$L     "#" d$$$$$$".@$$    .@$"  z$$$$*"     
                        ^$$$$. ^$N.3$$$       4u$$$$$$$ 4$$$  u$*" z$$$"          
                          '*$$$$$$$$ *$b      J$$$$$$$b u$$P $"  d$$P             
                             #$$$$$$ 4$ 3*$"$*$ $"$'c@@$$$$ .u@$$$P               
                               "$$$$  ""F~$ $uNr$$$^&J$$$$F $$$$#                 
                                 "$$    "$$$bd$.$W$$$$$$$$F $$"                   
                                   ?k         ?$$$$$$$$$$$F'*                     
                                    9$$bL     z$$$$$$$$$$$F                       
                                     $$$$    $$$$$$$$$$$$$                        
                                      '#$$c  '$$$$$$$$$"                          
                                       .@"#$$$$$$$$$$$$b                          
                                     z*      $$$$$$$$$$$$N.                       
                                   e"      z$$"  #$$$k  '*$$.                     
                                .u*      u@$P"      '#$$c   "$$c                   
                        u@$*"""       d$$"            "$$$u  ^*$$b.               
                      :$F           J$P"                ^$$$c   '"$$$$$$bL        
                     d$$  ..      @$#                      #$$b         '#$       
                     9$$$$$$b   4$$                          ^$$k         '$      
                      "$$6""$b u$$                             '$    d$$$$$P      
                        '$F $$$$$"                              ^b  ^$$$$b$       
                         '$W$$$$"                                'b@$$$$"         
                                                                  ^$$$*/     