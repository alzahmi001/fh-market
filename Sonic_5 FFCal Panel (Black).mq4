//------------------------------------------------------------------------------------------------+
//                                                                                                |
//                                    SonicR FFCal Panel.mq4                                      |
//                                                                                                |
//------------------------------------------------------------------------------------------------+
#property copyright "Copyright @ 2014 traderathome, deVries, qFish, atstrader"
#property link      "email: traderathome@msn.com" 
 
/*-------------------------------------------------------------------------------------------------
User Notes:

This indicator is coded to run on MT4 Build 600.

This is a special version of the FFCal.mq4 indicator designed especially for the Sonic R. System.
It places a panel on the chart in which are displayed up to four news releases listed on the 
Forex Factory Calendar.  Significant changes are made since the last release.  These changes are
summarized at the bottom of these User Notes.

The time, title and ranking (by color) of the releases are shown.  

The time of a releases is important because the market frequently holds price moves until after 
important releases come out.  Also, Market Makers can prepare in advance for these moves.  The 
Market Makers and banks do know the essence of news and releases in advance, and there is no 
regulation against insider trading in the forex market.  Banks can place orders in advance of
releases and Market Makers can use the intervening time to move prices to fill those orders,
saving the move that will make profits on the orders until the time of the releases. 

The title of the release, and it's ranking by color, is important because the variety of low 
impact releases frequently have no effect on price, whereas the variety of high impact releases 
can trigger a big price move, or can cause Market Makers to start moving prices days in advance,
in preparations for big moves to be made in conjunction with those releases.                  

Of the three impact level events (High, Medium, Low) and Bank Holidays, you have the option to not 
show all but the High Impact events.  The Previous/Forecast data (available on the Forex Factory
Calendar) is not displayed because prices can go either way regardless of specifics released.  it 
is the timing of news that is important, as a market volatility event.  The vertical display and 
the second alert of the original FFCal. mq4 indicator are removed, but one alert remains.

Prioritization of events is fully automated and two more event labels are added to help avoid
surprises.  When two or more events occur simultaneously, only one event of the highest impact
displays unless there are multiple high impact events.  In that case the multple high impact 
events are displayed.  When 2nd, 3rd or 4th events are not scheduled, text noting that appears.  
A current day Bank Holiday will remain displayed in the first label until the Bank Holiday is 
over.  You can show events for any pair on any chart.  For example, you can show  a CNY (China) 
event on a AUDUSD chart.  A new option is added allowing you to ignore the chart pair and 
select what currencies you want to show news for, so that you do not have to display the news
for the chart pair.      

You can select a range of TFs for the display of this indicator, so it automatically will not 
display on a chart TF outside that range.  The indicator can be turned on/off without having 
to remove it from the chart, thereby preserving your chart settings. 

Changes from release 04-04-2012 to release 05-01-2012:
01 - Corrected errors in coding of prioritization of previous and current/future events. 
02 - Revised order of External Inputs.

Changes from release 05-01-2012 to release 05-25-2013: 
01 - Removes outdated .xml files (through previous year) from Experts files.
02 - Saves current files without the chart TF in the file name (reduces current files needed).
03 - Removes all reference to Broker Watermark, which new coding automatically handles.
04 - adds options for sub-window and right side of chart locations.
05 - adds option to not show the panel background.
06 - prefixes background boxes with "z" assuring "on top" display.

Changes from release 05-25-2013 to release 03-01-2014: 
01 - Only one .xml file is used as the source file for all charts with FFCal on them.
02 - Updating was 240 seconds while comment says minutes, now it is minutes.
03 - Checking currency pairs for a country with news now works on Symbols with broker prefix.
Note:  All these improvements have been contributed by "deVries".

Changes from release 03-01-2014 to release 03-17-2014: 
Contributed by "deVries".....
01 - Only one .xml file is used as the source file for all charts with FFCal on them.
02 - Updating was 240 seconds while comment says minutes, now it is minutes.
03 - Checking currency pairs for a country with news now works on Symbols with broker prefix.
04 - Deleted function for calculating GMT and replaced it with TimeGMT(), a new function inside 
     the new 600+ release.
05 - Totally changed the file reading and maintenance coding, involving numerous sections of
     coding, to streamline for compatibility with MT4 Build 600, and which results in faster
     exectution which is very noticeable when changing chart time frames.
Contributed by "qFish".....
06 - Improved the code controlling the timing of updates.     
Contributed by "atstrader".....
07 - Added option to ignore news for both sides of the pair and to replace with news for any pair
     or pairs featured.
                           
                                                                       - Traderathome, 03-17-2014                                                                                                                                            
---------------------------------------------------------------------------------------------------
ACKNOWLEDGEMENTS:

derkwehler and other contributors - the core code of the FFCal indicator,
                                    FFCal_v20 dated 07/07/2009, Copyright @ 2006 derkwehler 
                                    http://www.forexfactory.com/showthread.php?t=19293
                                    email: derkwehler@gmail.com 
                                    
deVries   - for his excellent donated work that significantly altered and streamlined the file 
            handling coding to establish compatibility with the new release of MT4 Build 600+,
            and which has resulted in faster code execution.                                     
            (Jobs for deVries  www.mql5.com/en/job/new?prefered=deVries) 
qFish     - for his generously given time and help during the effort to improve this indicator.
atstrader - For a neat new option controlling for what pair/pairs(s) news is shown.
  
---------------------------------------------------------------------------------------------------
Suggested Colors:                    White Charts          Black Charts

FFCal_Title                          Black                 C'180,180,180'
News_Low_Impact                      Green                 C'046,186,046'
News_Medium_Impact                   MediumBlue            C'086,138,235'
News_High_Impact                     Crimson               C'217,000,000'
Bank_Holiday_Color                   DarkOrchid            Orchid
Remarks_Color                        DarkGray              DimGray      
Background_Color_                    White                 Black                                   

-------------------------------------------------------------------------------------------------*/

	
//+-----------------------------------------------------------------------------------------------+
//| Indicator Global Inputs                                                                       |
//+-----------------------------------------------------------------------------------------------+
#property indicator_chart_window
#property indicator_buffers 1
#property indicator_color1  CLR_NONE

#define READURL_BUFFER_SIZE   100

#define TITLE		0
#define COUNTRY   1
#define DATE		2
#define TIME		3
#define IMPACT		4
#define FORECAST	5
#define PREVIOUS	6

#import  "Wininet.dll"
   int InternetOpenW(string, int, string, string, int);
   int InternetConnectW(int, string, int, string, string, int, int, int); 
   int HttpOpenRequestW(int, string, string, int, string, int, string, int); 
   int InternetOpenUrlW(int, string, string, int, int, int);
   int InternetReadFile(int, uchar & arr[], int, int & arr[]);
   int InternetCloseHandle(int);    
#import

//global external inputs---------------------------------------------------------------------------
extern string Part_1                          = "Indicator Display Controls:";
extern bool   Indicator_On                    = true;
extern bool   Allow_Panel_In_Subwindow_1      = true; 
extern bool   Allow_Panel_At_Chart_Right      = true;
extern int    Display_Min_TF                  = 1;
extern int    Display_Max_TF                  = 43200;
extern string TF_Choices                      = "1-5-15-30-60-240-1440-10080-43200";

extern string __                              = "";
extern string Part_2                          = "Headline Display Settings:";
extern color  FFCal_Title 	                   = C'180,180,180'; 
extern color  Low_Impact_News_Color           = C'046,186,046';
extern bool   Low_Impact_News_On              = true;             
extern color  Medium_Impact_News_Color        = C'086,138,235';
extern bool   Medium_Impact_News_On           = true;       
extern color  High_Impact_News_Color          = C'217,000,000';
extern color  Bank_Holiday_Color              = Orchid;  
extern bool   Bank_Holiday_On                 = true;
extern color  Remarks_Color                   = DimGray;
extern bool   Show_Panel_Background           = false;     
extern color  Background_Color_               = C'010,010,010';
extern int	  Alert_Minutes_Before            = 0;	    //Set to "0" for no Alert
extern int	  Offset_Hours	                   = 0;     //Set to "0" to not adjust time/DST settings

extern string ___                             = "";
extern string Part_3                          = "Other Currency News Settings:";
extern bool	  Show_USD_News                   = false; //"true" = USD news on non-USD pair charts 
extern bool	  Show_EUR_News                   = false; 
extern bool	  Show_GBP_News                   = false;
extern bool	  Show_NZD_News                   = false;
extern bool	  Show_JPY_News                   = false;
extern bool	  Show_AUD_News                   = false;
extern bool	  Show_CAD_News                   = false; 
extern bool	  Show_CHF_News                   = false;
extern bool	  Show_CNY_News                   = false;
extern bool	  Ignore_Current_Symbol           = false;

//global buffers and variables---------------------------------------------------------------------
bool          Deinitialized, skip; 
bool          FLAG_done0, FLAG_done1, FLAG_done2, FLAG_done3; 
bool          FLAG_none0, FLAG_none1, FLAG_none2, FLAG_none3; 
int           BankIdx1,cnr;
color         TxtColorNews;
datetime      newsTime,calendardate;   //sundaydate calendar
double   	  ExtMapBuffer0[];     // Contains (minutes until) each news event
int 	        xmlHandle, BoEvent, finalend, end, begin, minsTillNews, tmpMins, idxOfNext,
              dispMinutes[9], newsIdx, next, nextNewsIdx, dispMins, Days, Hours, Mins;
int           dayStart,monthStart,F1,F2,i,j,k,curY,W,sx,sfx,Box,x1,x2,x3,y1,y2,y3,index;
int           WebUpdateFreq = 240; // 240 Minutes between web updates to not overload FF server
int           TxtSize       = 7;   
int           TitleSpacer   = 7;
int           EventSpacer   = 4; 
int           curX          = 3;       
static int	  PrevMinute    = -1;
string 		  xmlFileName;
string        xmlSearchName;
int           PrevTF        = 0;      
static int	  UpdateRateSec = 10;
string	     sUrl = "http://www.forexfactory.com/ff_calendar_thisweek.xml"; //original
string   	  myEvent,mainData[100][7], sData, csvoutput, sinceUntil, TimeStr;
string    	  G,/*pair, cntry1, cntry2,*/ dispTitle[9], dispCountry[9], dispImpact[9],event[4];
string 	     sTags[7] = { "<title>", "<country>", "<date><![CDATA[","<time><![CDATA[",
              "<impact><![CDATA[", "<forecast><![CDATA[", "<previous><![CDATA[" };
string 	     eTags[7] = { "</title>", "</country>", "]]></date>", "]]></time>",
              "]]></impact>", "]]></forecast>", "]]></previous>" };
string        Text_Style = "Arial";     
string        box1    = "z[FFCal] Box1";
string        box2    = "z[FFCal] Box2";
string        News1   = "z[FFCal] News1";
string        News2   = "z[FFCal] News2";
string        News3   = "z[FFCal] News3";
string        News4   = "z[FFCal] News4";
string        Sponsor = "z[FFCal] Sponsor";  

//+-----------------------------------------------------------------------------------------------+
//| Indicator Initialization                                                                      |
//+-----------------------------------------------------------------------------------------------+
int init()
   {
   //Get current time frame
   PrevTF = Period();
	//Make sure we are connected.  Otherwise exit.   
   //With the first DLL call below, the program will exit (and stop) automatically after one alert. 
   if ( !IsDllsAllowed() ) 
      {
      Alert(Symbol()," ",Period(),", FFCal: Allow DLL Imports");   
      }
      	
	//deVries: Management of FFCal.xml Files involves setting up a search to find and delete files
	//that are not of this Sunday date.  This search is limited to 10 weeks back (604800 seconds). 
	//Files with Sunday dates that are older will not be purged by this search and will have to be
	//manually deleted by the user.
	xmlFileName = GetXmlFileName();		 
   for (k=calendardate;k>=calendardate-6048000;k=k-604800)
      {
      xmlSearchName =  (StringConcatenate(TimeYear(k),"-",
         PadString(DoubleToStr(TimeMonth(k),0),"0",2),"-",
         PadString(DoubleToStr(TimeDay(k),0),"0",2),"-FFCal-News",".xml"));
      xmlHandle = FileOpen(xmlSearchName, FILE_BIN|FILE_READ);
	   if(xmlHandle >= 0) //file exists.  A return of -1 means file does not exist.
	      {
	      FileClose(xmlHandle); 
	      if(xmlSearchName != xmlFileName)FileDelete(xmlSearchName);       
	      }
	   }
   

   cnr = 2; if(Allow_Panel_At_Chart_Right) {cnr = 3;}   
   if(Allow_Panel_In_Subwindow_1 && WindowsTotal( ) > 1){W= 1;}
   else {W= 0;}
    
	SetIndexBuffer(0, ExtMapBuffer0);
   SetIndexStyle(0, DRAW_NONE);		
   IndicatorShortName("FFCal");    
   
   Deinitialized = false;
      	  		
	return(0);
   }
   
//+-----------------------------------------------------------------------------------------------+
//| Indicator De-initialization                                                                   |
//+-----------------------------------------------------------------------------------------------+
int deinit()
   {         
   int obj_total= ObjectsTotal();  
   for (i= obj_total; i>=0; i--) {
      string name= ObjectName(i);
      if (StringSubstr(name,0,8)=="z[FFCal]") {ObjectDelete(name);}} 
 	  
	return(0);
   }
  
//+-----------------------------------------------------------------------------------------------+
//| Indicator Start                                                                               |
//+-----------------------------------------------------------------------------------------------+  
int start()
   {
   //If Indicator is "Off" or chart is out of range deinitialize only once, not every tick.
   if((!Indicator_On) || ((Period() < Display_Min_TF) || (Period() > Display_Max_TF)))        
      {
      if (!Deinitialized)  {deinit(); Deinitialized = true;}
      //deleting old versions xml file 
      return(0);
      }    

   InitNews(sUrl);

	//qFish-----------------------------------------------------------------------------------------
	//Perform remaining checks once per UpdateRateSec (Refreshing News from XML file)
   if(PrevTF==Period())  
      {
      //if we haven't changed time frame then keep doing what we are doing
      if(MathMod(Seconds(),UpdateRateSec)==0)
         {
         return (true);
         }
      //otherwise, we've switched time frame and do not need to skip every 10 s,
      //thus immediately execute all of the start() function code   
      else   
         {
         PrevTF = Period();
         }
      }

	//Init the buffer array to zero just in case
	ArrayInitialize(ExtMapBuffer0, 0);
	
	//deVries---------------------------------------------------------------------------------------
	//New xml file handling coding and revised parsing coding
	xmlHandle = FileOpen(xmlFileName, FILE_BIN|FILE_READ);
	if(xmlHandle>=0)
	   {
	   int size = FileSize(xmlHandle);
	   sData = FileReadString(xmlHandle, size);	
	   FileClose(xmlHandle);
	   }

	//Clear prioritization data
	BankIdx1   = 0; 
	FLAG_done0 = false; 
   FLAG_done1 = false;  
   FLAG_done2 = false;
   FLAG_done3 = false;
   FLAG_none0 = false;    
   FLAG_none1 = false; 
   FLAG_none2 = false;
   FLAG_none3 = false;  
	for (i=0; i<=9; i++)
	   {
	   dispTitle[i]   = "";
	   dispCountry[i] = "";
	   dispImpact[i] 	= "";
	   dispMinutes[i]	= 0;	
      }

	//Parse the XML file looking for an event to report		
	newsIdx = 0;
	nextNewsIdx = -1;	
	tmpMins = 10080;	// (a week)
	BoEvent = 0;
	while (true)
   	{
		BoEvent = StringFind(sData, "<event>", BoEvent);
		if (BoEvent == -1) break;			
		BoEvent += 7;	
		next = StringFind(sData, "</event>", BoEvent);
		if (next == -1) break;	
		myEvent = StringSubstr(sData, BoEvent, next - BoEvent);
		BoEvent = next;		
		begin = 0;
		skip = false;
		for (i=0; i < 7; i++)
		   {
			mainData[newsIdx][i] = "";
			next = StringFind(myEvent, sTags[i], begin);			
			// Within this event, if tag not found, then it must be missing; skip it
			if (next == -1) continue;
			else
			   {
				// We must have found the sTag okay...
				begin = next + StringLen(sTags[i]);		   	// Advance past the start tag
				end = StringFind(myEvent, eTags[i], begin);	// Find start of end tag
				//Get data between start and end tag
				if (end > begin && end != -1) 
				   {mainData[newsIdx][i] = StringSubstr(myEvent, begin, end - begin);}
			   }
		   }//End "for" loop
	
		//Test against filters that define whether we want to skip this particular announcement
		if(!IsNewsCurrency(Symbol(),mainData[newsIdx][COUNTRY]))	//deVries
			{skip = true;}	

		else if ((!Medium_Impact_News_On) && 
		   (mainData[newsIdx][IMPACT] == "Medium"))
		   {skip = true;} 
		   														   
		else if ((!Low_Impact_News_On) && 
		   (mainData[newsIdx][IMPACT] == "Low"))
		   {skip = true;} 

		//else if (!StringSubstr(mainData[newsIdx][TITLE],0,4)== "Bank")
		else if ((!Bank_Holiday_On) && (StringSubstr(mainData[newsIdx][TITLE],0,4)== "Bank"))
		    {skip = true;}
		    
		else if (StringSubstr(mainData[newsIdx][TITLE],0,8)== "Daylight")
		    {skip = true;}    	
			
   	else if ((mainData[newsIdx][TIME] == "All Day" && mainData[newsIdx][TIME] == "") || 
		   (mainData[newsIdx][TIME] == "Tentative" && mainData[newsIdx][TIME] == "")     ||
		  	(mainData[newsIdx][TIME] == ""))
		  	{skip = true;}			  	
		    				  	 				  	 
		//If not skipping this event, then log time to event it into ExtMapBuffer0
		if (!skip)
		   {   
			//If we got this far then we need to calc the minutes until this event
			//First, convert the announcement time to seconds (in GMT)
			newsTime = MakeDateTime(mainData[newsIdx][DATE], mainData[newsIdx][TIME]);			
			// Now calculate the minutes until this announcement (may be negative)
			minsTillNews = (newsTime - TimeGMT()) / 60;
			
         //If this is a Bank Holiday current or past event, 
         //then skip it by changing time to 2 days back
         if ((StringFind(mainData[newsIdx][TITLE], "Bank Holiday", 
            StringLen(mainData[newsIdx][TITLE])-12) != -1) && (minsTillNews <= 0))
            {
            minsTillNews = minsTillNews - 2880;
            }
            
			//At this point, only events applicable to the pair ID/Symbol are being processed:
			//Find the most recent past event.  Do this by incrementing idxOfNext for each event 
			//with a past time, (i.e. minsTillNews < 0).  When coming upon the first event with 
			//minsTillNews > 0, idxOfNext is not incremented, and therefore continues to be for 
			//the most recent past event.  It does not get incremented again until the absolute 
			//value of the time since this most recent past event exceeds the time to the next
			//future event.
			
			if (minsTillNews < 0 || MathAbs(tmpMins) > minsTillNews)	
			   {idxOfNext = newsIdx; tmpMins	= minsTillNews;}	
						
			//Do alert if user has enabled
			if (Alert_Minutes_Before != 0 && minsTillNews == Alert_Minutes_Before)
				Alert(Alert_Minutes_Before, " minutes until news for ", 
				mainData[newsIdx][COUNTRY], ": ", mainData[newsIdx][TITLE]);
						
			//ExtMapBuffer0 contains the time UNTIL each announcement (can be negative)
			//e.g. [0] = -372; [1] = 25; [2] = 450; [3] = 1768 (etc.)
			ExtMapBuffer0[newsIdx] = minsTillNews;
			
			newsIdx++;
		   }//End "skip" routine
	   }//End "while" routine
	   
	//----------------------------------------------------------------------------------------------
	//Prioritization coding:  Cycle thru the range of "newsIdx" prioritizing events for display.
	for (i=0; i < newsIdx; i++)
	   {
      //The 1st event to be displayed is either a past event, or an upcoming event, whichever is 
      //most most close in time.  If the 1st event is a past event, then look at the three previous 
      //past events.  For any of them that occurred at the same time as the 1st event, choose for 
      //display the most recent one with a higher impact.  If none have a higher impact, then stay 
      //with the 1st event.
      
      //Get 4th previous item:
      if (i == idxOfNext-3) 
         {    
			dispTitle[6]	   = mainData[i][TITLE];
			dispCountry[6] 	= mainData[i][COUNTRY];
			dispImpact[6]  	= mainData[i][IMPACT];
			dispMinutes[6] 	= ExtMapBuffer0[i];      
         }      
      //Get 3rd previous item:
      if (i == idxOfNext-2) 
         {      
			dispTitle[5]	   = mainData[i][TITLE];
			dispCountry[5] 	= mainData[i][COUNTRY];
			dispImpact[5]  	= mainData[i][IMPACT];
			dispMinutes[5] 	= ExtMapBuffer0[i];      
         }
      //Get 2nd previous item:   
      if (i == idxOfNext-1) 
         {   
			dispTitle[4]	   = mainData[i][TITLE];
			dispCountry[4] 	= mainData[i][COUNTRY];
			dispImpact[4]  	= mainData[i][IMPACT];
			dispMinutes[4] 	= ExtMapBuffer0[i];      
         }  
      //Get previous/current items:        
      if (i == idxOfNext)  
         {
         dispTitle[0]	   = mainData[i][TITLE];
			dispCountry[0] 	= mainData[i][COUNTRY];
			dispImpact[0]  	= mainData[i][IMPACT];
			dispMinutes[0] 	= ExtMapBuffer0[i];
         //If idxOfNext is a previous event, then compare to 2nd, 3rd and 4th previous events.
         //If none of these three also previous events have the same time and a higher impact,
         //stay with the most recent previous event ([0]):  			         
         if (dispMinutes[0] <= 0) 
            {
	         //if time [0] = [4] and [4] is > impact than [0], then [4] becomes 1st event [0]
	         //In other words, if 2nd previous event back is of higher impact use it:
	         if ((dispMinutes[0] == dispMinutes[4]) &&		
	         ((dispImpact[0] == "Medium" && dispImpact[4] == "High")  ||
			   (dispImpact[0]  == "Low"    && dispImpact[4] == "High")  ||
			   (dispImpact[0]  == "Low"    && dispImpact[4] == "Medium")))
		 	      {		 	   
		   	   dispTitle[0]	= dispTitle[4];
			      dispCountry[0] = dispCountry[4];
			      dispImpact[0]  = dispImpact[4];
			      dispMinutes[0] = dispMinutes[4];
			      }	                                       									
		      //if time [0] = [5] and [5] is > impact than [0], then [5] becomes 1st event [0]
		      //In other words, if 3rd previous event back is of higher impact use it: 
	         else if ((dispMinutes[0] == dispMinutes[5]) &&		
	         ((dispImpact[0] == "Medium" && dispImpact[5] == "High")  ||
			   (dispImpact[0]  == "Low"    && dispImpact[5] == "High")  ||
			   (dispImpact[0]  == "Low"    && dispImpact[5] == "Medium")))
		 	      {		 	   
		      	dispTitle[0]   = dispTitle[5];
			      dispCountry[0] = dispCountry[5];
			      dispImpact[0]  = dispImpact[5];
			      dispMinutes[0] = dispMinutes[5];						   
               }
            //if time [0] = [6] and [6] is  > impact than [0], then [6] becomes 1st event [0]
            //In other words, if 4th previous event back is of higher impact use it:
	         else if ((dispMinutes[0] == dispMinutes[6]) &&		
	         ((dispImpact[0] == "Medium" && dispImpact[6] == "High")  ||
			   (dispImpact[0]  == "Low"    && dispImpact[6] == "High")  ||
			   (dispImpact[0]  == "Low"    && dispImpact[6] == "Medium")))
		 	      {		 	   
		      	dispTitle[0]   = dispTitle[6];
			      dispCountry[0] = dispCountry[6];
			      dispImpact[0]  = dispImpact[6];
			      dispMinutes[0] = dispMinutes[6];						   
               }   					   
            }
         }   
         
		//---------------------------------------------------------------- 	            
      //Now that 1st event[0] is initialized, go thru rest of items, prioritizing.  
		if (i >= idxOfNext+1)  
		   {  
         dispTitle[6]	= mainData[i][TITLE];
			dispCountry[6] = mainData[i][COUNTRY];
			dispImpact[6]  = mainData[i][IMPACT];
			dispMinutes[6] = ExtMapBuffer0[i];
			//If 1st event [0] is not done with prioritization, and         		   
			//if time [i] = [0] and [i] has > impact than [0] then [i] becomes 1st event [0].
	   	//Otherwise, if time [i] > [0] then initialize [i] as 2nd event [1]: 
	   	if (!FLAG_done0) 
	   	   { 
			   if ((dispMinutes[0] == dispMinutes[6]) && 			
	            ((dispImpact[0]  == "Medium" && dispImpact[6] == "High")  ||
			      (dispImpact[0]   == "Low"    && dispImpact[6] == "High")  || 
			      (dispImpact[0]   == "Low"    && dispImpact[6] == "Medium")))
		 	      {
               dispTitle[0]	  = dispTitle[6];
			      dispCountry[0]   = dispCountry[6];
			      dispImpact[0]    = dispImpact[6];
			      dispMinutes[0]   = dispMinutes[6];	 	   		 	   		 	   			
			      }		      
		      else if ((dispMinutes[0] < dispMinutes[6]) ||
		         ((dispMinutes[0] == dispMinutes[6]) && (dispImpact[6] == "High")) )    
		         {
               dispTitle[1]	  = dispTitle[6];
			      dispCountry[1]   = dispCountry[6];
			      dispImpact[1]    = dispImpact[6];
			      dispMinutes[1]   = dispMinutes[6];
			      FLAG_done0 = true;
			      continue;
		         }		         
		      }
		   //If 1st event [0] is done prioritization, but 2nd event [1] is not, and   
			//if time [i] = [1] and [i] has > impact than [1], then [i] becomes 2nd event [1].
			//Otherwise, if time [i] > [1] then intialize [i] as 3rd event [2]: 
         if ((FLAG_done0) && (!FLAG_done1)) 
		      {			 			   	
			   if ((dispMinutes[1] == dispMinutes[6]) && 		
	            ((dispImpact[1]  == "Medium" && dispImpact[6] == "High")  ||
			      (dispImpact[1]   == "Low"    && dispImpact[6] == "High")  || 
			      (dispImpact[1]   == "Low"    && dispImpact[6] == "Medium")))
		 	      {
               dispTitle[1]	   = dispTitle[6];
			      dispCountry[1] 	= dispCountry[6];
			      dispImpact[1]  	= dispImpact[6];
			      dispMinutes[1] 	= dispMinutes[6];	
			      }
			   else if ((dispMinutes[1] < dispMinutes[6]) ||
		         ((dispMinutes[1] == dispMinutes[6]) && (dispImpact[6] == "High")) )  			   		    
			      {
               dispTitle[2]	   = dispTitle[6];
			      dispCountry[2] 	= dispCountry[6];
			      dispImpact[2]  	= dispImpact[6];
			      dispMinutes[2] 	= dispMinutes[6];					      
			      FLAG_done1 = true;
			      continue;
			      }   
			   }
	      //If 1st event [0] and 2nd event [1] are done, but 3rd event [2] is not, and
			//if time [i] = [2] and [i] has > impact than [2], then [i] becomes 3rd event [2].
		   //Otherwise, if time [i] > [2] then intialize [i] as 4th event [3]:  	
         if ((FLAG_done0) && (FLAG_done1) && (!FLAG_done2)) 
		      {						   
			   if ((dispMinutes[2] == dispMinutes[6]) && 		
	            ((dispImpact[2]  == "Medium" && dispImpact[6] == "High")  ||
			      (dispImpact[2]   == "Low"    && dispImpact[6] == "High")  || 
			      (dispImpact[2]   == "Low"    && dispImpact[6] == "Medium")))
		 	      {
               dispTitle[2]	   = dispTitle[6];
			      dispCountry[2] 	= dispCountry[6];
			      dispImpact[2]  	= dispImpact[6];
			      dispMinutes[2] 	= dispMinutes[6];		   			        		 	   		 	   		 	   			
			      }
			   else if ((dispMinutes[2] < dispMinutes[6]) ||
		         ((dispMinutes[2] == dispMinutes[6]) && (dispImpact[6] == "High")) )  			    
			      {
               dispTitle[3]	   = dispTitle[6];
			      dispCountry[3] 	= dispCountry[6];
			      dispImpact[3]  	= dispImpact[6];
			      dispMinutes[3] 	= dispMinutes[6];					      
			      FLAG_done2 = true;
			      continue;
			      }  
			   }
         //If 1st, 2nd, and 3rd events are done, but 4th event [3] is not, and
			//if time [i] = [3] and [i] has > impact than [3], then [i] becomes 4th event [3].
			//Otherwise, prioritizing is finished:  	
         if ((FLAG_done0) && (FLAG_done1) && (FLAG_done2) && (!FLAG_done3)) 
		      {						   
			   if ((dispMinutes[3] == dispMinutes[6])  &&
	            ((dispImpact[3]  == "Medium" && dispImpact[6] == "High")  ||
			      (dispImpact[3]   == "Low"    && dispImpact[6] == "High")  || 
			      (dispImpact[3]   == "Low"    && dispImpact[6] == "Medium")))     	
		 	      {
               dispTitle[3]	   = dispTitle[6];
			      dispCountry[3] 	= dispCountry[6];
			      dispImpact[3]  	= dispImpact[6];
			      dispMinutes[3] 	= dispMinutes[6];  			        		 	   		 	   		 	   			
			      }			      			      		         			      
			   //Otherwise, prioritizing is finished:    
			   else
			      {			     
			      FLAG_done3 = true;
			      } 			      			   			   
			   }
						    			
 			//If all four event items are prioritized, exit loop.	   			   							   			   
		   if ((FLAG_done0) && (FLAG_done1) && (FLAG_done2) && (FLAG_done3)) {break;} 
			}
			  
	   }//End prioritizing "for" loop	
	   
	   //Next, determine if any events are out of sequence in time, or are duplicates in title 
	   //and are within the same 24 hour period.  If so, eliminate the higher event item by
	   //setting the flag to not show the item.
	   //Check 1st and 2nd items.  
		if (((dispTitle[0]==dispTitle[1]) && (dispMinutes[0]+ 1440 > dispMinutes[1])) ||
		   (dispMinutes[0] > dispMinutes[1]))
			{
			{FLAG_none1  = true;}	
			}			 	   	
      //Also check 1st and 3rd, and 2nd and 3rd items. 
		if (((dispTitle[0]==dispTitle[2]) && (dispMinutes[0]+ 1440 > dispMinutes[2])) ||  
			((dispTitle[1]==dispTitle[2]) && (dispMinutes[1]+ 1440 > dispMinutes[2]))  ||
			(dispMinutes[0] > dispMinutes[2]) || (dispMinutes[1] > dispMinutes[2]))
			{
			{FLAG_none2  = true;}	
			} 				     
      //Also check 1st and 4th, and 3rd and 4th items. 
		if (((dispTitle[0]==dispTitle[3]) && (dispMinutes[0]+ 1440 > dispMinutes[3])) ||  
			((dispTitle[2]==dispTitle[3]) && (dispMinutes[2]+ 1440 > dispMinutes[3]))  ||
			(dispMinutes[0] > dispMinutes[3]) || (dispMinutes[2] > dispMinutes[3]))
			{
			{FLAG_none3  = true;}	
			}
			
	   //Check if 1st event[0] is more than half a day old and no 2nd event is scheduled.
	   //If so, eliminate the 1st event[0].	
	   if ((dispMinutes[0] < -720) && (dispMinutes[1] == 0 )) 
			{
			{FLAG_none0  = true;}	
			}
					
		//Be sure no "FLAG_none" remains false if a lower one turned to true
		if (FLAG_none0) 
		   {
		   FLAG_none1  = true;
		   FLAG_none2  = true;
		   FLAG_none3  = true;
		   }
		else if (FLAG_none1) 
		   {
		   FLAG_none2  = true;
		   FLAG_none3  = true;
		   }
		else if (FLAG_none2) 
		   {
		   FLAG_none3  = true;
		   }
	
		//Be sure to "FLAG_none" any with no country tag
		if (dispCountry[0] == "") {FLAG_none0 = true;}
		if (dispCountry[1] == "") {FLAG_none1 = true;}
		if (dispCountry[2] == "") {FLAG_none2 = true;}
		if (dispCountry[3] == "") {FLAG_none3 = true;}
		        
		//Check for current day Bank Holiday.  If there is one, then move all
      //events up one tier and insert the Bank Holiday into 1st event.
      if (BankIdx1 == 1)
		   {      
         dispTitle[3]	   = dispTitle[2];
			dispCountry[3] 	= dispCountry[2];
			dispImpact[3]  	= dispImpact[2];
			dispMinutes[3] 	= dispMinutes[2];
			FLAG_none3        = FLAG_none2;
		  
			dispTitle[2]	   = dispTitle[1];
			dispCountry[2] 	= dispCountry[1];
			dispImpact[2]  	= dispImpact[1];
			dispMinutes[2] 	= dispMinutes[1];
			FLAG_none2        = FLAG_none1;
			     	
         dispTitle[1]	   = dispTitle[0];
			dispCountry[1] 	= dispCountry[0];
			dispImpact[1]  	= dispImpact[0];
			dispMinutes[1] 	= dispMinutes[0];
			FLAG_none1        = FLAG_none0;
			     
         dispTitle[0]	   = dispTitle[7];
			dispCountry[0]    = dispCountry[7];
			dispImpact[0]  	= dispImpact[7];
			dispMinutes[0]    = dispMinutes[7];
			FLAG_none0        = false;
			}
      
	//---------------------------------------------------------------------------------------------
	//Go to subroutine to draw panel background and event labels.					
	OutputToChart();
			
	return (0);
   }
   
//+-----------------------------------------------------------------------------------------------+
//| Subroutines: recoded creation and maintenance of single xml file                              |
//+-----------------------------------------------------------------------------------------------+   
//deVries: void InitNews(string& mainData[][], string newsUrl)
void InitNews(string newsUrl)
   {
   if(DoFileDownLoad()) //Added to check if the CSV file already exists
      {
      DownLoadWebPageToFile(newsUrl); //downloading the xml file
      } 
   }

//deVries: If we have recent file don't download again
bool DoFileDownLoad()  
   {
   xmlHandle = 0;
   int size;
   datetime time = TimeCurrent();
   //datetime time = TimeLocal();
   
   if(GlobalVariableCheck("Update.FF_Cal") == false)return(true);
   if((time - GlobalVariableGet("Update.FF_Cal")) > WebUpdateFreq*60)return(true);
    
   xmlFileName = GetXmlFileName();
   xmlHandle=FileOpen(xmlFileName,FILE_BIN|FILE_READ);  //check if file exist 
   if(xmlHandle>=0)//when the file exists we read data
      {
	   size = FileSize(xmlHandle); 
	   sData = FileReadString(xmlHandle, size);	  
      FileClose(xmlHandle);//close it again check is done
      return(false);//file exists no need to download again
      }
   //File does not exist if FileOpen return -1 or if GetLastError = ERR_CANNOT_OPEN_FILE (4103)
   return(true); //commando true to download xml file     
   } 
  
//+-----------------------------------------------------------------------------------------------+
//| Subroutine: getting the name of the ForexFactory .xml file                                    |
//+-----------------------------------------------------------------------------------------------+ 
//deVries: one file for all charts!   
string GetXmlFileName()
   {
   int adjustDays = 0;
   switch(TimeDayOfWeek(TimeLocal()))
      {
      case 0:
      adjustDays = 0;
      break;
      case 1:
      adjustDays = 1;
      break;
      case 2:
      adjustDays = 2;
      break;
      case 3:
      adjustDays = 3;
      break;
      case 4:
      adjustDays = 4;
      break;
      case 5:
      adjustDays = 5;
      break;
      case 6:
      adjustDays = 6;
      break;
      } 
   calendardate =  TimeLocal() - (adjustDays  * 86400);
   string fileName =  (StringConcatenate(TimeYear(calendardate),"-",
          PadString(DoubleToStr(TimeMonth(calendardate),0),"0",2),"-",
          PadString(DoubleToStr(TimeDay(calendardate),0),"0",2),"-FFCal-News",".xml"));

   return (fileName); //Always a Sunday date  		
   }
  
//+-----------------------------------------------------------------------------------------------+
//| Subroutine: downloading the ForexFactory .xml file                                            |
//+-----------------------------------------------------------------------------------------------+    
//deVries: new coding replacing old "GrabWeb" coding
void DownLoadWebPageToFile(string url = "http://www.forexfactory.com/ff_calendar_thisweek.xml") 
   {
   int HttpOpen = InternetOpenW(" ", 0, " ", " ", 0); 
   int HttpConnect = InternetConnectW(HttpOpen, "", 80, "", "", 3, 0, 1); 
   int HttpRequest = InternetOpenUrlW(HttpOpen, url, NULL, 0, 0, 0);

   int read[1];
   uchar  Buffer[];
   ArrayResize(Buffer, READURL_BUFFER_SIZE + 1);
   string NEWS = "";
   
	   xmlFileName = GetXmlFileName();
	   xmlHandle = FileOpen(xmlFileName, FILE_BIN|FILE_READ|FILE_WRITE);
	   //File exists if FileOpen return >=0. 
	   if (xmlHandle >= 0) {FileClose(xmlHandle); FileDelete(xmlFileName);}	
   	
		//Open new XML.  Write the ForexFactory page contents to a .htm file.  Close new XML.
		xmlHandle = FileOpen(xmlFileName, FILE_BIN|FILE_WRITE);   
      
   while (true)
      {
      InternetReadFile(HttpRequest, Buffer, READURL_BUFFER_SIZE, read);      
      string strThisRead = CharArrayToString(Buffer, 0, read[0], CP_UTF8);
      if (read[0] > 0)NEWS = NEWS + strThisRead;
      else
         {
         FileWriteString(xmlHandle, NEWS);
         FileClose(xmlHandle);
		   //Find the XML end tag to ensure a complete page was downloaded.
		   end = StringFind(NEWS, "</weeklyevents>", 0);
		   //If the end of file tag is not found, a return -1 (or, "end <=0" in this case), 
		   //then return (false).
		   if (end == -1) {Alert(Symbol()," ",Period(),", FFCal Error: File download incomplete!");}
		   //Else, set global to time of last update
		   else {GlobalVariableSet("Update.FF_Cal", TimeCurrent());}             
         break;
         }      
      }				
   if (HttpRequest > 0) InternetCloseHandle(HttpRequest); 
   if (HttpConnect > 0) InternetCloseHandle(HttpConnect); 
   if (HttpOpen > 0) InternetCloseHandle(HttpOpen);      
   }
   
//+-----------------------------------------------------------------------------------------------+
//| Subroutine: to pad string                                                                     |
//+-----------------------------------------------------------------------------------------------+ 
//deVries: 
string PadString(string toBePadded, string paddingChar, int paddingLength)
   {
   while(StringLen(toBePadded) <  paddingLength)
      {
      toBePadded = StringConcatenate(paddingChar,toBePadded);
      }
   return (toBePadded);
   }
   
//+-----------------------------------------------------------------------------------------------+
//| Subroutine: to ID currency even if broker has added a prefix to the symbol, and is used to    |
//| determine the news to show, based on the users external inputs selections                     |
//+-----------------------------------------------------------------------------------------------+  
//deVries: works even when broker has attached prefix (or suffix) to the Currency, so that the
//symbol format does not look like the standard example EURUSD or USDJPY.
//atstrader: adds option to ignore the chart symbol pair and re-select other(s). 
bool IsNewsCurrency(string cSymbol, string fSymbol)
   {
   if(!Ignore_Current_Symbol && (StringFind(cSymbol, fSymbol, 0)>=0)){return(true);}
   if(Show_USD_News && fSymbol == "USD"){return(true);}
   if(Show_GBP_News && fSymbol == "GBP"){return(true);}
   if(Show_EUR_News && fSymbol == "EUR"){return(true);}   
   if(Show_CAD_News && fSymbol == "CAD"){return(true);}
   if(Show_AUD_News && fSymbol == "AUD"){return(true);}   
   if(Show_CHF_News && fSymbol == "CHF"){return(true);}   
   if(Show_JPY_News && fSymbol == "JPY"){return(true);}   
   if(Show_NZD_News && fSymbol == "NZD"){return(true);}         
   if(Show_CNY_News && fSymbol == "CNY"){return(true);}
   return(false);
   } 

//+-----------------------------------------------------------------------------------------------+
//| Indicator Routine For Normal Display                                                          |
//+-----------------------------------------------------------------------------------------------+  
void OutputToChart()
   {
   //Compose fourth event description line--------------------------------------------------------- 	           
   sinceUntil = "until ";
   dispMins = dispMinutes[3]+1; 
	if (dispMinutes[3] <= 0) {dispMins = dispMins - 1; sinceUntil = "since "; dispMins *= -1;} 	
   if (dispMins < 60) {TimeStr = dispMins + " mins ";}
	else // time is 60 minutes or more
	   {
		Hours = MathRound(dispMins / 60);
	   Mins = dispMins % 60;
	   if (Hours < 24) // less than a day: show hours and minutes 
		   {
			TimeStr = Hours + " hrs " + Mins + " mins ";
		   }
		else // days, hours, and minutes
		  	{
		  	Days = MathRound(Hours / 24);
		 	Hours = Hours % 24;
		  	TimeStr = Days + " days " + Hours + " hrs " + Mins + " mins ";
		  	}
	   }               	
   index = StringFind(TimeStr+sinceUntil+dispCountry[3], "since  mins", 0);  
   TxtColorNews = ImpactToColor(dispImpact[3]);	   		      	
	ObjectDelete(News4);       	
   ObjectCreate(News4, OBJ_LABEL, W, 0, 0);
		if((index != -1) || (FLAG_none3)) 
		   {	        
		   ObjectSetText(News4, "(4)  Additional news per settings is not scheduled", 
		      TxtSize, Text_Style, Remarks_Color);
		   event[4] = "(4)  Additional news per settings is not scheduled";
		   }	           		                		            			            	            		   	   
	   else 
	      {
		   ObjectSetText(News4, TimeStr + sinceUntil + dispCountry[3] + 
		      ": " + dispTitle[3], TxtSize, Text_Style, TxtColorNews);
		   event[4] = TimeStr + sinceUntil + dispCountry[3] + ": " + dispTitle[3];
		   }
             
   //Compose third event description line--------------------------------------------------------- 	           
   sinceUntil = "until ";
   dispMins = dispMinutes[2]+1;
	if (dispMinutes[2] <= 0) {dispMins = dispMins - 1; sinceUntil = "since "; dispMins *= -1;}   	
   if (dispMins < 60) {TimeStr = dispMins + " mins ";}
	else // time is 60 minutes or more
	   {
		Hours = MathRound(dispMins / 60);
	   Mins = dispMins % 60;
	   if (Hours < 24) // less than a day: show hours and minutes 
		   {
			TimeStr = Hours + " hrs " + Mins + " mins ";
		   }
		else // days, hours, and minutes
		  	{
		  	Days = MathRound(Hours / 24);
		 	Hours = Hours % 24;
		  	TimeStr = Days + " days " + Hours + " hrs " + Mins + " mins ";
		  	}
	   }               	
   index = StringFind(TimeStr+sinceUntil+dispCountry[2], "since  mins", 0); 		      	
   TxtColorNews = ImpactToColor(dispImpact[2]);	 	      	
	ObjectDelete(News3);       	
   ObjectCreate(News3, OBJ_LABEL, W, 0, 0);
		if((index != -1) || (FLAG_none2)) 
		   {	        
		   ObjectSetText(News3, "(3)  Additional news per settings is not scheduled", 
		      TxtSize, Text_Style, Remarks_Color);
		   event[3] = "(3)  Additional news per settings is not scheduled";
		   }	           		                		            			            	            		   	   
	   else 
	      {
		   ObjectSetText(News3, TimeStr + sinceUntil + dispCountry[2] + 
		      ": " + dispTitle[2], TxtSize, Text_Style, TxtColorNews);
		   event[3] = TimeStr + sinceUntil + dispCountry[2] + ": " + dispTitle[2];
		   }		   		  
           
	//Compose second event description line-------------------------------------------------------- 	           
   sinceUntil = "until ";
   dispMins = dispMinutes[1]+1;  
	if (dispMinutes[1] <= 0) {dispMins = dispMins - 1; sinceUntil = "since "; dispMins *= -1;} 	
   if (dispMins < 60) {TimeStr = dispMins + " mins ";}
	else // time is 60 minutes or more
	   {
	   Hours = MathRound(dispMins / 60);
	   Mins = dispMins % 60;
	   if (Hours < 24) // less than a day: show hours and minutes 
		   {
		   TimeStr = Hours + " hrs " + Mins + " mins ";
		   }
		else // days, hours, and minutes
		   {
		   Days = MathRound(Hours / 24);
			Hours = Hours % 24;
			TimeStr = Days + " days " + Hours + " hrs " + Mins + " mins ";
		   }
	   }               	
	index = StringFind(TimeStr+sinceUntil+dispCountry[1], "since  mins", 0); 		      	
   TxtColorNews = ImpactToColor(dispImpact[1]);	 	      	
	ObjectDelete(News2);       	
   ObjectCreate(News2, OBJ_LABEL, W, 0, 0);
		if((index != -1) || (FLAG_none1)) 
		   {		       
		   ObjectSetText(News2, "(2)  Additional news per settings is not scheduled", 
		      TxtSize, Text_Style, Remarks_Color);
		   event[2] = "(2)  Additional news per settings is not scheduled";
		   }	           		                		            			            	            		   	   
	   else 
	      {
		   ObjectSetText(News2, TimeStr + sinceUntil + dispCountry[1] + 
		      ": " + dispTitle[1], TxtSize, Text_Style, TxtColorNews);
		   event[2] = TimeStr + sinceUntil + dispCountry[1] + ": " + dispTitle[1];
		   }		  
         
	//Compose first event description line---------------------------------------------------------  
	//If time is 0 or negative, we want to say "xxx mins SINCE ... news event", 
	//else say "UNTIL ... news event"
	sinceUntil = "until ";
	dispMins = dispMinutes[0]+1;  //dispMins "*= -1" = multiply by "-1" 
	if (dispMinutes[0] <= 0) {dispMins = dispMins - 1; sinceUntil = "since "; dispMins *= -1;}	      
	if (dispMins < 60) {TimeStr = dispMins + " mins ";}
	else // time is 60 minutes or more
	   {
		Hours = MathRound(dispMins / 60);
		Mins = dispMins % 60;
		if (Hours < 24) // less than a day: show hours and minutes
		   {
		   TimeStr = Hours + " hrs " + Mins + " mins ";
		   }
		else  // days, hours, and minutes
		   {
		   Days = MathRound(Hours / 24);
			Hours = Hours % 24;
			TimeStr = Days + " days " + Hours + " hrs " + Mins + " mins ";
		   }
	   }	  		         
	index = StringFind(TimeStr+sinceUntil+dispCountry[0], "since  mins", 0); //Comment (index);	
	TxtColorNews = ImpactToColor(dispImpact[0]);	       	   
	ObjectDelete(News1);		         	    
	ObjectCreate(News1, OBJ_LABEL, W, 0, 0);
		if((index != -1) || (FLAG_none0)) 
		   {	      
		   ObjectSetText(News1, "(1)  Additional news per settings is not scheduled", 
		      TxtSize, Text_Style, Remarks_Color);
		   event[1] = "(1)  Additional news per settings is not scheduled";
		   }			                  	         		         	
		else 
		   {
	   	ObjectSetText(News1, TimeStr + sinceUntil + dispCountry[0] + 
	   	   ": " + dispTitle[0], TxtSize, Text_Style, TxtColorNews);
	   	event[1] = TimeStr + sinceUntil + dispCountry[0] + ": " + dispTitle[0];
	   	}

   //Do background---------------------------------------------------------------------------------
   //Set variables.   
   x1 = 0; 
   x2 = 0;               
	y2 = 1;
	
   //Automate Determination of Width of Background
   //Determine the length (x1) of the maximum length event string (i = 1-4)
   for (i=1; i<=4; i++) 
      {
      if(i == 0) {x1 = StringLen(event[i]);}
      else
         {
         if(StringLen(event[i]) > x1)
           {
           x1 = StringLen(event[i]);
           }
         }  
      } 
   if(x1<94) {x2 = 95;}
   else {x2 = x1-94+95;}//x2 = starts where x1 characters stop
 	   
   //Set up for background boxes             
   //Space in Panel is req'd for Watermark if no subwindow exists and the panel is in the
   //main window on the left side, or if a subwindow does exist and the panel is in the
   //subwindow on the left side.
   if((!Allow_Panel_At_Chart_Right) && 
     (WindowsTotal( )==1 || (WindowsTotal( )>1 && Allow_Panel_In_Subwindow_1)))
     {
     //Use larger rectangle Panel & start text higher from bottom
     curY = 18;        
     Box  = 64;//64
     G    = "gg";              
     //block size "gg" requires background #2 to start further right
     x2=x2+46;      
     }
   //No space in Panel is req'd for Watermark if a subwindow exists and the panel is in the
   //main window, or if the panel is in the subwindow, but on the right side.          
   else  
     {
     //Use shorter rectangle Panel & start text lower from bottom  
     curY = 6;       
     Box  = 54;//54
     G    = "ggg"; 
     }
     
   //Draws Background boxes
   if(Show_Panel_Background) {    
   ObjectCreate(box1, OBJ_LABEL, W, 0,0);
   ObjectSetText(box1, G, Box, "Webdings");          
   ObjectSet(box1, OBJPROP_CORNER, cnr);
   ObjectSet(box1, OBJPROP_XDISTANCE, 1);      
   ObjectSet(box1, OBJPROP_YDISTANCE, 1);       
   ObjectSet(box1, OBJPROP_COLOR, Background_Color_);
   ObjectSet(box1, OBJPROP_BACK, false);

   ObjectCreate(box2, OBJ_LABEL, W, 0,0);
   ObjectSetText(box2, G, Box, "Webdings");         
   ObjectSet(box2, OBJPROP_CORNER, cnr);
   ObjectSet(box2, OBJPROP_XDISTANCE, x2);     
   ObjectSet(box2, OBJPROP_YDISTANCE, 1);      
   ObjectSet(box2, OBJPROP_COLOR, Background_Color_);
   ObjectSet(box2, OBJPROP_BACK, false); }

   //Draw Event4
	ObjectSet(News4, OBJPROP_CORNER, cnr);
	ObjectSet(News4, OBJPROP_XDISTANCE, curX);
	ObjectSet(News4, OBJPROP_YDISTANCE, curY); 	   	   	
   curY = curY + TxtSize + EventSpacer;
   
   //Draw Event3
	ObjectSet(News3, OBJPROP_CORNER, cnr);
	ObjectSet(News3, OBJPROP_XDISTANCE, curX);
	ObjectSet(News3, OBJPROP_YDISTANCE, curY); 	   	   	
   curY = curY + TxtSize + EventSpacer; 
       
   //Draw Event2
	ObjectSet(News2, OBJPROP_CORNER, cnr);
   ObjectSet(News2, OBJPROP_XDISTANCE, curX);
	ObjectSet(News2, OBJPROP_YDISTANCE, curY); 	   	   	
   curY = curY + TxtSize + EventSpacer;     
      
   //Draw Event1   
	ObjectSet(News1, OBJPROP_CORNER, cnr);
	ObjectSet(News1, OBJPROP_XDISTANCE, curX );
	ObjectSet(News1, OBJPROP_YDISTANCE, curY);        	
   curY = curY + TxtSize + TitleSpacer;    
      	       
   //Finish with title-----------------------------------------------------------------------------
	ObjectDelete(Sponsor);         	     	         	
	ObjectCreate(Sponsor, OBJ_LABEL, W, 0, 0);
 	ObjectSetText(Sponsor, "SONIC R. SYSTEM  FFCAL HEADLINES:", TxtSize, "Verdana", FFCal_Title);
	ObjectSet(Sponsor, OBJPROP_CORNER, cnr);
	ObjectSet(Sponsor, OBJPROP_XDISTANCE, curX);
	ObjectSet(Sponsor, OBJPROP_YDISTANCE, curY);                          
   }

//+-----------------------------------------------------------------------------------------------+
//| Indicator Subroutine For Impact Color                                                         |
//+-----------------------------------------------------------------------------------------------+  
double ImpactToColor (string impact)
   {
	if (impact == "High") return (High_Impact_News_Color);
	else {if (impact == "Medium") return (Medium_Impact_News_Color);
	else {if (impact == "Low") return (Low_Impact_News_Color);
	else {if (impact == "Holiday") return (Bank_Holiday_Color); 
	else {return (Remarks_Color);} }}}  
   }

//+-----------------------------------------------------------------------------------------------+
//| Indicator Subroutine For Date/Time    changed by deVries                                      |
//+-----------------------------------------------------------------------------------------------+ 
datetime MakeDateTime(string strDate, string strTime)  //not string now datetime
   {
	int n1stDash = StringFind(strDate, "-");
	int n2ndDash = StringFind(strDate, "-", n1stDash+1);

	string strMonth = StringSubstr(strDate, 0, 2);
	string strDay = StringSubstr(strDate, 3, 2);
	string strYear = StringSubstr(strDate, 6, 4); 
   //strYear = "20" + strYear;
	
	int nTimeColonPos = StringFind(strTime, ":");
	string strHour = StringSubstr(strTime, 0, nTimeColonPos);
	string strMinute = StringSubstr(strTime, nTimeColonPos+1, 2);
	string strAM_PM = StringSubstr(strTime, StringLen(strTime)-2);

	int nHour24 = StrToInteger(strHour);
	if ((strAM_PM == "pm" || strAM_PM == "PM") && nHour24 != 12) {nHour24 += 12;}
	if ((strAM_PM == "am" || strAM_PM == "AM") && nHour24 == 12) {nHour24 = 0;}

	datetime newsevent = StringToTime(strYear+ "." + strMonth + "." + 
	   strDay)+nHour24*3600+ (StringToInteger(strMinute)*60);
	return(newsevent);
   }

//+-----------------------------------------------------------------------------------------------+
//| Indicator End                                                                                 |                                                        
//+-----------------------------------------------------------------------------------------------+