/*
   G e n e r a t e d  by ex4-to-mq4 decompiler FREEWARE 4.0.509.5
   Website:  httP : // W W W. m E t a q UO t E S. n et
   E-mail : s u pp o R t @meTA QuO TeS. Ne t
*/

#property indicator_chart_window

extern int X = -37;
extern int Y = 295;
extern int Corner = 1;
extern int window = 0;
int Fi_92 = 11;
string Fs_arial_96 = "Courier New";
string Fsa_104[] = {"USD", "EUR", "GBP", "JPY", "CHF", "CAD", "AUD", "NZD", "XAU"};
int Fia_108[] = {16777215, 15570276, 13688896, 5275647, 13353215, 10025880, 13850042, 55295};
string Fsa_112[] = {"USDCHF", "GBPUSD", "EURUSD", "USDJPY", "USDCAD", "NZDUSD", "AUDUSD", "AUDNZD", "AUDCAD", "AUDCHF", "AUDJPY", "CHFJPY", "EURGBP", "EURAUD", "EURCHF", "EURJPY", "EURNZD",
      "EURCAD", "EURNZD", "EURCAD", "GBPCHF", "GBPAUD", "GBPCAD", "GBPJPY", "CADJPY", "NZDJPY", "GBPNZD", "USDSGD", "XAUUSD"};
string Fs_116 = "";
string Fs_124;

int init() {
   Fs_124 = WindowExpertName();
   return (0);
}

int deinit() {
   for (int index_0 = 0; index_0 <= ArraySize(Fsa_104) * 2; index_0++) {
      ObjectDelete(Fsa_104[index_0] + "_val");
      ObjectDelete(Fsa_104[index_0] + "_nom");
      ObjectDelete(Fsa_104[index_0] + "_pos");
   }
   return (0);
}

int start() {
   int ind_counted_0 = IndicatorCounted();
   displayMeter();
   
return (0);}

void displayMeter() {
   double Hda_0[8][2];
   int Hia_unused_4[8][2];
   int Hi_12;
   Hda_0[0][0] = currency_strength(Fsa_104[0]);
   Hda_0[1][0] = currency_strength(Fsa_104[1]);
   Hda_0[2][0] = currency_strength(Fsa_104[2]);
   Hda_0[3][0] = currency_strength(Fsa_104[3]);
   Hda_0[4][0] = currency_strength(Fsa_104[4]);
   Hda_0[5][0] = currency_strength(Fsa_104[5]);
   Hda_0[6][0] = currency_strength(Fsa_104[6]);
   Hda_0[7][0] = currency_strength(Fsa_104[7]);
   Hda_0[0][1] = 0;
   Hda_0[1][1] = 1;
   Hda_0[2][1] = 2;
   Hda_0[3][1] = 3;
   Hda_0[4][1] = 4;
   Hda_0[5][1] = 5;
   Hda_0[6][1] = 6;
   Hda_0[7][1] = 7;
   ArraySort(Hda_0, WHOLE_ARRAY, 0, MODE_DESCEND);
   int Hi_8 = WindowFind(Fs_124);
   int Hi_16 = Y;
   for (int index_20 = 0; index_20 < 8; index_20++) {
      Hi_12 = Hda_0[index_20][1];
      objectCreate(Fsa_104[Hi_12] + "_pos", Corner, X + 85, Hi_16, 0, (index_20 + 1) + "| ", Fi_92, Fs_arial_96, symcolor(Hda_0[index_20][0]));
      objectCreate(Fsa_104[Hi_12] + "_nom", Corner, X + 65, Hi_16, 0, Fsa_104[Hi_12], Fi_92, Fs_arial_96, symcolor(Hda_0[index_20][0]));
      objectCreate(Fsa_104[Hi_12] + "_val", Corner, X - 10, Hi_16, 0, DoubleToStr(Hda_0[index_20][0], 0), Fi_92, Fs_arial_96, symcolor(Hda_0[index_20][0]));
      Hi_16 += 15;
   }
}

int symcolor(double Ed_0) {
   int Hi_ret_8;
   if (Ed_0 <= 2.0) Hi_ret_8 = 3937500;
   if (Ed_0 > 2.0) Hi_ret_8 = 11829830;
   if (Ed_0 >= 7.0) Hi_ret_8 = 3329330;
   return (Hi_ret_8);
}

double currency_strength(string Es_0) {
   int Hi_8;
   string Hs_12;
   double Hd_20;
   double Hd_28;
   double Hd_ret_36 = 0;
   int count_44 = 0;
   for (int index_48 = 0; index_48 < ArraySize(Fsa_112); index_48++) {
      Hi_8 = 0;
      Hs_12 = Fsa_112[index_48];
      if (Es_0 == StringSubstr(Hs_12, 0, 3) || Es_0 == StringSubstr(Hs_12, 3, 3)) {
         Hs_12 = Hs_12 + Fs_116;
         Hd_20 = (MarketInfo(Hs_12, MODE_HIGH) - MarketInfo(Hs_12, MODE_LOW)) * MarketInfo(Hs_12, MODE_POINT);
         if (Hd_20 != 0.0) {
            Hd_28 = 100.0 * ((MarketInfo(Hs_12, MODE_BID) - MarketInfo(Hs_12, MODE_LOW)) / Hd_20 * MarketInfo(Hs_12, MODE_POINT));
            if (Hd_28 > 3.0) Hi_8 = 1;
            if (Hd_28 > 10.0) Hi_8 = 2;
            if (Hd_28 > 25.0) Hi_8 = 3;
            if (Hd_28 > 40.0) Hi_8 = 4;
            if (Hd_28 > 50.0) Hi_8 = 5;
            if (Hd_28 > 60.0) Hi_8 = 6;
            if (Hd_28 > 75.0) Hi_8 = 7;
            if (Hd_28 > 90.0) Hi_8 = 8;
            if (Hd_28 > 97.0) Hi_8 = 9;
            count_44++;
            if (Es_0 == StringSubstr(Hs_12, 3, 3)) Hi_8 = 9 - Hi_8;
            Hd_ret_36 += Hi_8;
         }
      }
   }
   Hd_ret_36 /= count_44;
   return (Hd_ret_36);
}

void objectCreate(string E_name_0, int E_corner_8, int E_x_12, int E_y_16, int E_angle_20, string E_text_24 = "-", int E_fontsize_32 = 42, string E_fontname_36 = "Arial", color E_color_44 = -1) {
   if (ObjectFind(E_name_0) != 0) {
      ObjectCreate(E_name_0, OBJ_LABEL, window, 0, 0);
      ObjectSet(E_name_0, OBJPROP_CORNER, E_corner_8);
      ObjectSet(E_name_0, OBJPROP_COLOR, E_color_44);
      ObjectSet(E_name_0, OBJPROP_XDISTANCE, E_x_12);
      ObjectSet(E_name_0, OBJPROP_YDISTANCE, E_y_16);
      ObjectSet(E_name_0, OBJPROP_ANGLE, E_angle_20);
      ObjectSetText(E_name_0, E_text_24, E_fontsize_32, E_fontname_36, E_color_44);
      return;
   }
   ObjectSet(E_name_0, OBJPROP_CORNER, E_corner_8);
   ObjectSet(E_name_0, OBJPROP_COLOR, E_color_44);
   ObjectSet(E_name_0, OBJPROP_XDISTANCE, E_x_12);
   ObjectSet(E_name_0, OBJPROP_YDISTANCE, E_y_16);
   ObjectSet(E_name_0, OBJPROP_ANGLE, E_angle_20);
   ObjectSetText(E_name_0, E_text_24, E_fontsize_32, E_fontname_36, E_color_44);
}
