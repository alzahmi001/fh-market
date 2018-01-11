/*
   G e n e r a t e d  by ex4-to-mq4 decompiler FREEWARE 4.0.509.5
   Website:  h t T P : / / WW W.M Et Aq Uo tEs . N e T
   E-mail : SUp poR t @ m ET a qUo TE s . NE t
*/

#property indicator_chart_window

color F_color_76 = Silver;
color F_color_80 = C'0x96,0xC8,0xFA';
int Fi_unused_84 = 4132109;
color F_color_88 = C'0x53,0x53,0x53';
color F_color_92 = C'0x1E,0x32,0x53';
bool Fi_96 = TRUE;
bool Fi_100 = TRUE;
bool Fi_104 = FALSE;
int Fi_108 = 38;
string F_fontname_112 = "Arial Bold";
int Fi_unused_120 = 13;
string Fs_arial_124 = "Arial";
int Fi_132 = 0;
int F_corner_136 = 3;
double Fd_140;
double Fd_148;

double SetPoint() {
   double Hd_ret_0;
   if (Digits < 4) Hd_ret_0 = 0.01;
   else Hd_ret_0 = 0.0001;
   return (Hd_ret_0);
}

int init() {
   IndicatorShortName("Price-Info");
   Fd_148 = SetPoint();
   return (0);
}

int deinit() {
   ObjectsDeleteAll(Fi_132, OBJ_LABEL);
   return (0);
}

int start() {
   int Hi_0;
   int Hi_4;
   int Hi_8;
   int Hi_12;
   int Hi_16;
   int Hi_unused_20;
   double Hd_28;
   double Hd_36;
   double Hd_44;
   int Hi_52;
   string text_56;
   int Hi_64;
   int Hi_68;
   int Hi_72;
   double Hd_76;
   int Hi_84;
   string Hs_88;
   int Hi_96;
   if (Fi_104) {
      Hi_0 = 1;
      Hi_4 = -3;
      Hi_8 = -5;
      Hi_12 = 3;
      Hi_16 = 4;
      Hi_unused_20 = 1;
   } else {
      Hi_4 = 0;
      Hi_8 = 0;
      Hi_12 = 0;
      Hi_16 = 0;
      Hi_unused_20 = 0;
   }
   if (StringFind(Symbol(), "JPY", 0) != -1) Fd_140 = Hi_0 + 2;
   else Fd_140 = Hi_0 + 4;
   int ind_counted_24 = IndicatorCounted();
   if (Fi_96 == TRUE) {
      Hd_28 = -254;
      Hd_36 = -14;
      
      if (Hd_44 > 1.0 && Hd_44 <= 10.0) Hi_52 = 4;
      
      if (Symbol() == "EURUSD" || Symbol() == "EURUSDm") text_56 = "EURUSD";
      else {
         if (Symbol() == "GBPUSD" || Symbol() == "GBPUSDm") text_56 = "GBPUSD";
         else {
            if (Symbol() == "USDCHF" || Symbol() == "USDCHFm") text_56 = "USDCHF";
            else {
               if (Symbol() == "USDJPY" || Symbol() == "USDJPYm") text_56 = "USDJPY";
               else {
                  if (Symbol() == "EURJPY" || Symbol() == "EURJPYm") text_56 = "EURJPY";
                  else {
                     if (Symbol() == "EURCHF" || Symbol() == "EURCHFm") text_56 = "EURCHF";
                     else {
                        if (Symbol() == "EURGBP" || Symbol() == "EURGBPm") text_56 = "EURGBP";
                        else {
                           if (Symbol() == "USDCAD" || Symbol() == "USDCADm") text_56 = "USDCAD";
                           else {
                              if (Symbol() == "AUDUSD" || Symbol() == "AUDUSDm") text_56 = "AUDUSD";
                              else {
                                 if (Symbol() == "GBPCHF" || Symbol() == "GBPCHFm") text_56 = "GBPCHF";
                                 else {
                                    if (Symbol() == "GBPJPY" || Symbol() == "GBPJPYm") text_56 = "GBPJPY";
                                    else {
                                       if (Symbol() == "CHFJPY" || Symbol() == "CHFJPYm") text_56 = "CHFJPY";
                                       else {
                                          if (Symbol() == "NZDUSD" || Symbol() == "NZDUSDm") text_56 = "NZDUSD";
                                          else {
                                             if (Symbol() == "EURCAD" || Symbol() == "EURCADm") text_56 = "EURCAD";
                                             else {
                                                if (Symbol() == "AUDJPY" || Symbol() == "AUDJPYm") text_56 = "AUDJPY";
                                                else {
                                                   if (Symbol() == "EURAUD" || Symbol() == "EURAUDm") text_56 = "EURAUD";
                                                   else {
                                                      if (Symbol() == "AUDCAD" || Symbol() == "AUDCADm") text_56 = "AUDCAD";
                                                      else {
                                                         if (Symbol() == "AUDNZD" || Symbol() == "AUDNZDm") text_56 = "AUDNZD";
                                                         else {
                                                            if (Symbol() == "NZDJPY" || Symbol() == "NZDJPYm") text_56 = "NZDJPY";
                                                            else {
                                                               if (Symbol() == "CADJPY" || Symbol() == "CADJPYm") text_56 = "CADJPY";
                                                               else {
                                                                  if (Symbol() == "XAUUSD" || Symbol() == "XAUUSDm") text_56 = "XAUUSD";
                                                                  else {
                                                                     if (Symbol() == "XAGUSD" || Symbol() == "XAGUSDm") text_56 = "XAGUSD";
                                                                     else {
                                                                        if (Symbol() == "GBPAUD" || Symbol() == "GBPAUDm") text_56 = "GBPAUD";
                                                                        else {
                                                                           if (Symbol() == "GBPCAD" || Symbol() == "GBPCADm") text_56 = "GBPCAD";
                                                                           else {
                                                                              if (Symbol() == "AUFCHF" || Symbol() == "AUFCHFm") text_56 = "AUFCHF";
                                                                              else {
                                                                                 if (Symbol() == "CADCHF" || Symbol() == "CADCHFm") text_56 = "CADCHF";
                                                                                 else {
                                                                                    if (Symbol() == "NZDCHF" || Symbol() == "NZDCHFm") text_56 = "NZDCHF";
                                                                                    else {
                                                                                       text_56 = Symbol();
                                                                                       Hi_64 = 5;
                                                                                       Hi_68 = 2;
                                                                                    }
                                                                                 }
                                                                              }
                                                                           }
                                                                        }
                                                                     }
                                                                  }
                                                               }
                                                            }
                                                         }
                                                      }
                                                   }
                                                }
                                             }
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      ObjectDelete("Obj04");
      ObjectCreate("Obj04", OBJ_LABEL, Fi_132, 0, 0);
      ObjectSetText("Obj04", "O " + DoubleToStr(iOpen(NULL, PERIOD_D1, 0), Fd_140), 11, Fs_arial_124, clrSilver);
      ObjectSet("Obj04", OBJPROP_CORNER, F_corner_136);
      ObjectSet("Obj04", OBJPROP_BACK, FALSE);
      ObjectSet("Obj04", OBJPROP_XDISTANCE, Hd_36 + 18.0 + Hi_4);
      ObjectSet("Obj04", OBJPROP_YDISTANCE, Hd_28 + 430.0);
      
      ObjectDelete("Obj03");
      ObjectCreate("Obj03", OBJ_LABEL, Fi_132, 0, 0);
      ObjectSetText("Obj03", "H " + DoubleToStr(iHigh(NULL, PERIOD_D1, 0), Fd_140), 11, Fs_arial_124, clrSpringGreen);
      ObjectSet("Obj03", OBJPROP_CORNER, F_corner_136);
      ObjectSet("Obj03", OBJPROP_BACK, FALSE);
      ObjectSet("Obj03", OBJPROP_XDISTANCE, Hd_36 + 18.0 + Hi_4);
      ObjectSet("Obj03", OBJPROP_YDISTANCE, Hd_28 + 409.0);
      
      ObjectDelete("Obj05");
      ObjectCreate("Obj05", OBJ_LABEL, Fi_132, 0, 0);
      ObjectSetText("Obj05", "L " + DoubleToStr(iLow(NULL, PERIOD_D1, 0), Fd_140), 11, Fs_arial_124, clrTomato);
      ObjectSet("Obj05", OBJPROP_CORNER, F_corner_136);
      ObjectSet("Obj05", OBJPROP_BACK, FALSE);
      ObjectSet("Obj05", OBJPROP_XDISTANCE, Hd_36 + 18.0 + Hi_4);
      ObjectSet("Obj05", OBJPROP_YDISTANCE, Hd_28 + 390.0);
      if (Fi_100 == TRUE) {
         Hi_72 = Time[0] + 60 * Period() - TimeCurrent();
         Hd_76 = Hi_72 / 60.0;
         Hi_84 = Hi_72 % 60;
         Hi_72 = (Hi_72 - Hi_72 % 60) / 60;
         if (Hi_84 <= 9) Hs_88 = "0";
         if (Hi_72 >= 1 && Hi_72 <= 9) Hi_96 = -10;
         else {
            if (Hi_72 >= 10 && Hi_72 <= 99) Hi_96 = -13;
            else {
               if (Hi_72 >= 100 && Hi_72 <= 999) Hi_96 = -16;
               else {
                  if (Hi_72 >= 1000 && Hi_72 <= 9999) Hi_96 = -24;
                  else
                     if (Hi_72 >= 10000 && Hi_72 <= 99999) Hi_96 = -29;
               }
            }
         }
         
      }
   }
   return (0);
}
