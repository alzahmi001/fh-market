// THIS CODE IS POSTED SO THAT LIKE MINDED PAY IT FORWARD CODERS MAY
// IMPROVE ON IT AND REPOST IT ON THE FORUM FOR THEIR FELLOW TRADERS
//==================================================================
// [!!!-MT4 DAILY TARGETS]           \¦/   
//                                  (ò ó)
//_____________________________o0o___(_)___o0o______________________ 
#property copyright "Welcome to the World of Forex"
#property indicator_chart_window
     extern bool showDailyOpenOnly=false,showLinesInBackground=true;        
     extern int ViewDays=20; int XPeriod=PERIOD_D1; double avgDayRange;
     extern double Target1=0.854,Target2=1.382,Target3=1.618,Target4=2.146;
     extern color DailyPivotClr=clrWhite,SuplevelsClr=clrFireBrick,ReslevelsClr=clrRoyalBlue; 
//==========================================================================================================       
   int init(){double summ=0; for(int i=ViewDays-1; i>=0; i--) {
   summ+=MathAbs(iClose(NULL,XPeriod,i)-iOpen(NULL,XPeriod,i));} avgDayRange=summ/ViewDays; return(0);} 
//==========================================================================================================
   int deinit() {string XPivot; for(int i=ObjectsTotal(); i>=0;i--) {XPivot=ObjectName(i);
   if(StringFind(XPivot,"level",0)==0) {ObjectDelete(XPivot);}} return(0);}
//==========================================================================================================  
   int start(){int i,dayi,counted_bars=IndicatorCounted();
   if(counted_bars<0) {return(-1);} if(counted_bars>0) counted_bars--; int limit=Bars-counted_bars-1;
//==========================================================================================================   
   double PP; for(i=limit; i>=0; i--){dayi=iBarShift(NULL,XPeriod,Time[i],false);
   PP=iOpen(NULL,XPeriod,dayi);  if(dayi!=iBarShift(NULL,XPeriod,Time[i+1],false)) {
   if(showDailyOpenOnly) {       
   if(Period()<=240) {
   createLevel("level01",PP,Time[i],Time[i]+86400,2,DailyPivotClr);}}
   else {           
   if(Period()<=240) {
   createLevel("level01",PP,Time[i],Time[i]+86400,2,DailyPivotClr);}         
   if(Period()<=60) {
   createLevel("level02",PP+(avgDayRange*Target1),Time[i],Time[i]+86400,1,ReslevelsClr);
   createLevel("level03",PP-(avgDayRange*Target1),Time[i],Time[i]+86400,1,SuplevelsClr);
   createLevel("level04",PP+(avgDayRange*Target2),Time[i],Time[i]+86400,1,ReslevelsClr);
   createLevel("level05",PP-(avgDayRange*Target2),Time[i],Time[i]+86400,1,SuplevelsClr);
   createLevel("level06",PP+(avgDayRange*Target3),Time[i],Time[i]+86400,1,ReslevelsClr);
   createLevel("level07",PP-(avgDayRange*Target3),Time[i],Time[i]+86400,1,SuplevelsClr);
   createLevel("level08",PP+(avgDayRange*Target4),Time[i],Time[i]+86400,1,ReslevelsClr);
   createLevel("level09",PP-(avgDayRange*Target4),Time[i],Time[i]+86400,1,SuplevelsClr);}}}} return(0);}
//==========================================================================================================
   void createLevel(string XPivot,double level,datetime openTime,datetime closeTime,int width,color lineColor) {
   XPivot=XPivot+TimeDayOfYear(openTime); if(ObjectFind(XPivot)!=-1) {ObjectDelete(XPivot);}
   if(TimeDayOfWeek(closeTime)==0 || TimeDayOfWeek(closeTime)==6) {closeTime=closeTime+60*60*24*2;}       
   ObjectCreate(XPivot,OBJ_TREND,0,openTime,level,closeTime,level);
      ObjectSet(XPivot,OBJPROP_COLOR,lineColor);
      ObjectSet(XPivot,OBJPROP_WIDTH,width);
      ObjectSet(XPivot,OBJPROP_STYLE,2);
     
   if(showLinesInBackground) {   
      ObjectSet(XPivot,OBJPROP_BACK,true);}
   else {
      ObjectSet(XPivot,OBJPROP_BACK,false);}   
      ObjectSet(XPivot,OBJPROP_RAY,false);}
//==========================================================================================================      