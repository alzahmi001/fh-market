//#property indicator_separate_window
#property indicator_chart_window
#property indicator_buffers 0
#property strict

extern string  UniqueID      = "SymbolChanger1"; // Indicator unique ID
extern int     Corner        = 3;
extern string  Corner_Note   = "0 = Left_Upper, 1 = Right_Upper, 2 =Left_Lower, 3 =Right_Lower";
extern int     XSize         = 44;              // Width of buttons
extern int     YSize         = 16;              // Height of buttons
extern int     FSize         = 7;               // Fort size

extern string  Buttons_Pairs = "";
extern int     ButtonsInARow = 4;               // Buttons in a horizontal row
extern int     XShift        = 44;              // Horizontal shift
extern int     YShift        = 246;              // Vertical shift

extern string  Buttons_TimeFrame = "";
extern int     ButtonsInARow1 = 9;               // Buttons in a horizontal row
extern int     XShift1        = 44;             // Horizontal shift
extern int     YShift1        = 700;             // Vertical shift

extern color   Bcolor        = C'11,11,11';     // Button color
extern color   Dcolor        = C'64,64,64';      // Button border color
extern color   Tncolor       = C'164,164,164';         // Text color - normal
extern color   Sncolor       = White;           // Text color - selected
extern bool    Transparent   = false;            // Transparent buttons?

//-----------------------------------------------------------------------------------
//
//-----------------------------------------------------------------------------------
//
//
//
//
//
//

int OnInit() 
{
   IndicatorShortName(UniqueID); 
   int xpos=0,ypos=0,maxx=0,maxy=0; 
         for (int i = 0; i<SymbolsTotal(true); i++)
            { if (i>0 && MathMod(i,ButtonsInARow)==0) { xpos=0; ypos+=YSize+1; } createButton(UniqueID+":symbol:"+string(i),SymbolName(i,true),XShift+xpos,YShift+ypos); xpos +=XSize+1; }                     
       xpos = 0; ypos += YSize;     
         for (int i = 0; i<ArraySize(sTfTable); i++)
            { if (i>0 && MathMod(i,ButtonsInARow1)==0) { xpos=0; ypos+=YSize+1; } createButton(UniqueID+":time:"+string(i),sTfTable[i],XShift1+xpos,YShift1+ypos); xpos +=XSize+1; }                     
         
         //
         //
         //
         //
         //
         
               
   setSymbolButtonColor();
   setTimeFrameButtonColor();
   return(0);   
}
void OnDeinit(const int reason)
{ 
   switch(reason)
   {
      case REASON_CHARTCHANGE :
      case REASON_RECOMPILE   :
      case REASON_CLOSE       : break;
      default :
      {
         string lookFor       = UniqueID+":";
         int    lookForLength = StringLen(lookFor);
         for (int i=ObjectsTotal()-1; i>=0; i--)
         {
               string objectName = ObjectName(i);  if (StringSubstr(objectName,0,lookForLength) == lookFor) ObjectDelete(objectName);
         }
      }                  
   }
}

//
//
//
//
//


void createButton(string name, string caption, int xpos, int ypos)
{
   //int window = WindowFind(UniqueID);
          ObjectCreate(name,OBJ_BUTTON,0,0,0);//ObjectCreate(name,OBJ_BUTTON,window,0,0);
          ObjectSet(name,OBJPROP_CORNER   ,Corner);//ObjectSet(name,OBJPROP_CORNER   ,CORNER_LEFT_UPPER);
          ObjectSet(name,OBJPROP_XDISTANCE,xpos);
          ObjectSet(name,OBJPROP_YDISTANCE,ypos);
          ObjectSet(name,OBJPROP_XSIZE,XSize);
          ObjectSet(name,OBJPROP_YSIZE,YSize);
          ObjectSetText(name,caption,FSize,"Arial",Tncolor);
              ObjectSet(name,OBJPROP_FONTSIZE,FSize);
              ObjectSet(name,OBJPROP_BORDER_TYPE,BORDER_FLAT);
              ObjectSet(name,OBJPROP_COLOR,Tncolor); 
              ObjectSet(name,OBJPROP_BGCOLOR,Bcolor); 
              ObjectSet(name,OBJPROP_BACK,Transparent); 
              ObjectSet(name,OBJPROP_BORDER_COLOR,Dcolor); 
              ObjectSet(name,OBJPROP_STATE,false);
              ObjectSet(name,OBJPROP_HIDDEN,true);
}

void setSymbolButtonColor()
{
   string lookFor       = UniqueID+":symbol:";
   int    lookForLength = StringLen(lookFor);
   for (int i=ObjectsTotal()-1; i>=0; i--)
   {
      string objectName = ObjectName(i);  
      if (StringSubstr(objectName,0,lookForLength) == lookFor)
      {
         string symbol = ObjectGetString(0,objectName,OBJPROP_TEXT);
         if (symbol != _Symbol)
               ObjectSet(objectName,OBJPROP_COLOR,Tncolor); 
         else  ObjectSet(objectName,OBJPROP_COLOR,Sncolor);
      }         
   }
}
void setTimeFrameButtonColor()
{
   string lookFor       = UniqueID+":time:";
   int    lookForLength = StringLen(lookFor);
   for (int i=ObjectsTotal()-1; i>=0; i--)
   {
      string objectName = ObjectName(i);  
      if (StringSubstr(objectName,0,lookForLength) == lookFor)
      {
         int time = stringToTimeFrame(ObjectGetString(0,objectName,OBJPROP_TEXT));
         if (time != _Period)
               ObjectSet(objectName,OBJPROP_COLOR,Tncolor); 
         else  ObjectSet(objectName,OBJPROP_COLOR,Sncolor);
      }         
   }
}

//
//
//
//
//
//

string sTfTable[] = {"M5","M15","M30","H1"};
int    iTfTable[] = {5,15,30,60};

string timeFrameToString(int tf)
{
   for (int i=ArraySize(iTfTable)-1; i>=0; i--) 
         if (tf==iTfTable[i]) return(sTfTable[i]);
                              return("");
}
int stringToTimeFrame(string tf)
{
   for (int i=ArraySize(sTfTable)-1; i>=0; i--) 
         if (tf==sTfTable[i]) return(iTfTable[i]);
                              return(0);
}

//
//
//
//
//

void OnChartEvent(const int id, const long& lparam, const double& dparam, const string& sparam)
{
   if (id==CHARTEVENT_OBJECT_CLICK && ObjectGet(sparam,OBJPROP_TYPE)==OBJ_BUTTON)
   {
      if (StringFind(sparam,UniqueID+":symbol:",0)==0) ChartSetSymbolPeriod(0,ObjectGetString(0,sparam,OBJPROP_TEXT),_Period);
      if (StringFind(sparam,UniqueID+":time:"  ,0)==0) ChartSetSymbolPeriod(0,_Symbol,stringToTimeFrame(ObjectGetString(0,sparam,OBJPROP_TEXT)));
      if (StringFind(sparam,UniqueID+":back:"  ,0)==0) ObjectSet(sparam,OBJPROP_STATE,false);
   }
}  

//
//
//
//
//

int start() { return(0); }