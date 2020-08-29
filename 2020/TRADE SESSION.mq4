//+------------------------------------------------------------------+
//|                                                     Sessions.mq4 |
//+------------------------------------------------------------------+

#property indicator_chart_window

//+------------------------------------------------------------------+
extern int    NumberOfDays = 228;             
extern string AsiaBegin    = "09:00";        
extern string AsiaEnd      = "19:00";        
extern color  AsiaColor    = C'28,28,28';      
extern string EurBegin     = "15:00";        
extern string EurEnd       = "19:00";        
extern color  EurColor     = C'21,21,21';      
extern string USABegin     = "10:00";        
extern string USAEnd       = "19:00";        
extern color  USAColor     = C'21,21,21';      
extern bool   ShowPrice    = false;          
extern color  clFont       = Silver;           
extern int    SizeFont     = 11;              
extern int    OffSet       = 75;             
extern bool   Background   = true;

int    dig;
double pnt, spr, tickval;
string ccy;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
void init() {
  ccy     = Symbol();
  pnt     = MarketInfo(ccy,MODE_POINT);
  dig     = MarketInfo(ccy,MODE_DIGITS);
  spr     = MarketInfo(ccy,MODE_SPREAD);
  tickval = MarketInfo(ccy,MODE_TICKVALUE);
  if (dig == 3 || dig == 5) {
    pnt     *= 10;
    spr     /= 10;
    tickval *= 10;
  }  
  DeleteObjects();
  for (int i=0; i<NumberOfDays; i++) {
    CreateObjects("AS"+i, AsiaColor);
    CreateObjects("EU"+i, EurColor);
    CreateObjects("US"+i, USAColor);
  }
  Comment("");
}

//+------------------------------------------------------------------+
//| Custor indicator deinitialization function                       |
//+------------------------------------------------------------------+
void deinit() {
  DeleteObjects();
  Comment("");
}

//+------------------------------------------------------------------+
void CreateObjects(string no, color cl) {
//+------------------------------------------------------------------+
  ObjectCreate(no,OBJ_RECTANGLE, 0, 0,0, 0,0);
  ObjectSet   (no, OBJPROP_STYLE, STYLE_SOLID);
  ObjectSet   (no, OBJPROP_COLOR, cl);
  ObjectSet  (no, OBJPROP_BACK, Background);
}

//+------------------------------------------------------------------+
void DeleteObjects() {
//+------------------------------------------------------------------+
  for (int i=0; i<NumberOfDays; i++) {
    ObjectDelete("AS"+i);
    ObjectDelete("EU"+i);
    ObjectDelete("US"+i);
  }
  ObjectDelete("ASup");
  ObjectDelete("ASdn");
  ObjectDelete("EUup");
  ObjectDelete("EUdn");
  ObjectDelete("USup");
  ObjectDelete("USdn");
}

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
void start() {
  datetime dt=CurTime();
  
  for (int i=0; i<NumberOfDays; i++) {
    if (ShowPrice && i==0) {
      DrawPrices(dt, "AS", AsiaBegin, AsiaEnd);
      DrawPrices(dt, "EU", EurBegin, EurEnd);
      DrawPrices(dt, "US", USABegin, USAEnd);
    }
    DrawObjects(dt, "AS"+i, AsiaBegin, AsiaEnd);
    DrawObjects(dt, "EU"+i, EurBegin, EurEnd);
    DrawObjects(dt, "US"+i, USABegin, USAEnd);
    dt=decDateTradeDay(dt);
    while (TimeDayOfWeek(dt)>5) dt=decDateTradeDay(dt);
  }
}

//+------------------------------------------------------------------+
void DrawObjects(datetime dt, string no, string tb, string te) {
//+------------------------------------------------------------------+
  datetime t1, t2;
  double   p1, p2;
  int      b1, b2;

  t1=StrToTime(TimeToStr(dt, TIME_DATE)+" "+tb);
  t2=StrToTime(TimeToStr(dt, TIME_DATE)+" "+te);
  b1=iBarShift(NULL, 0, t1);
  b2=iBarShift(NULL, 0, t2);
  p1=High[Highest(NULL, 0, MODE_HIGH, b1-b2, b2)];
  p2=Low [Lowest (NULL, 0, MODE_LOW , b1-b2, b2)];
  ObjectSet(no, OBJPROP_TIME1 , t1);
  ObjectSet(no, OBJPROP_PRICE1, p1);
  ObjectSet(no, OBJPROP_TIME2 , t2);
  ObjectSet(no, OBJPROP_PRICE2, p2);
  ObjectSetText(no,DoubleToStr((p1-p2)/pnt,0));
}

//+------------------------------------------------------------------+
void DrawPrices(datetime dt, string no, string tb, string te) {
//+------------------------------------------------------------------+
  datetime t1, t2;
  double   p1, p2;
  int      b1, b2;

  t1=StrToTime(TimeToStr(dt, TIME_DATE)+" "+tb);
  t2=StrToTime(TimeToStr(dt, TIME_DATE)+" "+te);
  b1=iBarShift(NULL, 0, t1);
  b2=iBarShift(NULL, 0, t2);
  p1=High[Highest(NULL, 0, MODE_HIGH, b1-b2, b2)];
  p2=Low [Lowest (NULL, 0, MODE_LOW , b1-b2, b2)];

  if (ObjectFind(no+"up")<0) ObjectCreate(no+"up", OBJ_TEXT, 0, 0,0);
  ObjectSet(no+"up", OBJPROP_TIME1   , t2);
  ObjectSet(no+"up", OBJPROP_PRICE1  , p1+OffSet*Point);
  ObjectSet(no+"up", OBJPROP_COLOR   , clFont);
  ObjectSet(no+"up", OBJPROP_FONTSIZE, SizeFont);
  ObjectSetText(no+"up", DoubleToStr(p1+Ask-Bid, Digits));

  if (ObjectFind(no+"dn")<0) ObjectCreate(no+"dn", OBJ_TEXT, 0, 0,0);
  ObjectSet(no+"dn", OBJPROP_TIME1   , t2);
  ObjectSet(no+"dn", OBJPROP_PRICE1  , p2);
  ObjectSet(no+"dn", OBJPROP_COLOR   , clFont);
  ObjectSet(no+"dn", OBJPROP_FONTSIZE, SizeFont);
  ObjectSetText(no+"dn", DoubleToStr(p2, Digits));
}

//+------------------------------------------------------------------+
datetime decDateTradeDay (datetime dt) {
//+------------------------------------------------------------------+
  int ty=TimeYear(dt);
  int tm=TimeMonth(dt);
  int td=TimeDay(dt);
  int th=TimeHour(dt);
  int ti=TimeMinute(dt);

  td--;
  if (td==0) {
    tm--;
    if (tm==0) {
      ty--;
      tm=12;
    }
    if (tm==1 || tm==3 || tm==5 || tm==7 || tm==8 || tm==10 || tm==12) td=31;
    if (tm==2) if (MathMod(ty, 4)==0) td=29; else td=28;
    if (tm==4 || tm==6 || tm==9 || tm==11) td=30;
  }
  return(StrToTime(ty+"."+tm+"."+td+" "+th+":"+ti));
}

