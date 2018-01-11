/*
   G e n e r a t e d  by ex4-to-mq4 decompiler FREEWARE 4.0.509.5
   Website:  h t tp :// W W w . M E ta Q UotE S.n ET
   E-mail : s up P OR T @ M eTAquOT ES .nEt
*/

#property indicator_chart_window

extern int Window = 0;
extern int Corner = 1;
int Fi_84 =0;
int Fi_88 = 0;
extern color BackGroundColor = White;
extern bool SortedDisplay = TRUE;
extern int Xposition = -178;
extern int Yposition = 280;
int Fi_108 = 9474192;
extern color PanelColor2 = Yellow;
extern color PanelColor3 = Blue;
string Fs_120 = "CP";
int Fi_128 = 11;
int Fia_132[2];
string Fs_136;
string Fsa_144[] = {"USD", "EUR", "GBP", "JPY", "CHF", "CAD", "NZD", "AUD"};
string Fsa_148[] = {"EURUSD", "GBPUSD", "USDJPY", "USDCHF", "USDCAD", "AUDUSD", "NZDUSD", "EURGBP", "EURJPY", "EURCHF", "EURCAD", "EURAUD", "EURNZD", "GBPJPY", "GBPCHF", "GBPCAD", "GBPAUD",
      "GBPNZD", "AUDJPY", "AUDCHF", "AUDCAD", "AUDNZD", "CHFJPY", "CADJPY", "NZDJPY", "USDSGD"};
string Fs_152 = "";
string Fs_160;
int Fia_168[4] = {135, 150, 135, 150};
int Fia_172[4] = {0, 0, 0, 0};

// DECCBE4E9083C3B5F7CD2632722765BB
int f0_8(string Es_0) {
   for (int index_8 = 0; index_8 < 8; index_8++)
      if (Fsa_144[index_8] == Es_0) break;
   return (index_8);
}

// E37F0136AA3FFAF149B351F6A4C948E9
int init() {
   Xposition += Fi_88;
   Yposition += Fi_84;
   Fs_160 = WindowExpertName();
   string Hs_0 = StringSubstr(Symbol(), 0, 3);
   Fia_132[0] = f0_8(Hs_0);
   Hs_0 = StringSubstr(Symbol(), 3, 3);
   Fia_132[1] = f0_8(Hs_0);
   f0_1();
   Yposition += 2;
   return (0);
}

// 52D46093050F38C27267BCE42543EF60
int deinit() {
   for (int index_0 = 0; index_0 <= ArraySize(Fsa_144) * 2; index_0++) {
      ObjectDelete(Fsa_144[index_0] + "_val");
      ObjectDelete(Fsa_144[index_0] + "_nom");
      ObjectDelete(Fsa_144[index_0] + "_pos");
   }
   ObjectDelete("AA-Panel-1");
   ObjectDelete("AA-Panel-2");
   ObjectDelete("AA-Panel-3");
   ObjectDelete("AA-Panel-4");
   f0_3();
   return (0);
}

// 316B9EF0C5AAEE2F19A1FE5E34BA21F3
void f0_1() {
   string Hs_0 = "gg";
   int Hi_8 = 130;
   int Hi_12 = 80;
   
}

// EA2B2676C28C0DB26D39331A336C6B92
int start() {
   int ind_counted_0 = IndicatorCounted();
   f0_9();
   return (0);
}

// F3BE519BFC0644BDA22D79ECEF0BB9EF
void f0_9() {
   double Hda_0[8][2];
   int Hia_unused_4[8][2];
   int Hi_12;
   double Hd_20;
   int Hi_28;
   string Hs_36;
   string Hs_44;
   int Hi_56;
   for (int index_8 = 0; index_8 < 8; index_8++) {
      Hda_0[index_8][0] = f0_6(Fsa_144[index_8]);
      Hda_0[index_8][1] = index_8;
   }
   if (SortedDisplay) {
      Hi_12 = 2;
      if (Corner > 1) Hi_12 = 1;
      ArraySort(Hda_0, WHOLE_ARRAY, 0, Hi_12);
   }
   int Hi_16 = WindowFind(Fs_160);
   int Hi_32 = Yposition + 14;
   for (int index_52 = 0; index_52 < 8; index_52++) {
      Hi_28 = Hda_0[index_52][1];
      Hi_56 = 8388352;
      Hs_36 = "Courier New";
      Hd_20 = 10.0 * Hda_0[index_52][0];
      Fs_136 = Fs_120 + Fsa_144[Hi_28];
      switch (Corner) {
      case 0:
         Hs_44 = (index_52 + 1) + " " + Fsa_144[Hi_28];
         break;
      case 1:
         Hs_44 = (index_52 + 1) + " " + Fsa_144[Hi_28];
         break;
      case 2:
         Hs_44 = (8 - index_52) + " " + Fsa_144[Hi_28];
         break;
      case 3:
         Hs_44 = (8 - index_52) + " " + Fsa_144[Hi_28];
      }
      if (Hi_28 == Fia_132[0] || Hi_28 == Fia_132[1]) {
         Hs_36 = "Courier New Bold";
         Hi_56 = 16777215;
      }
      f0_5(Fs_136 + "_nom", Corner, Xposition + Fia_168[Corner] - 124, Hi_32, 0, Hs_44, Fi_128, Hs_36, Hi_56);
      f0_5(Fs_136 + "_val", Corner, Xposition + Fia_168[Corner] + 20, Hi_32, 0, DoubleToStr(Hd_20, 0) + "%", Fi_128, Hs_36, Hi_56);
      f0_2(index_52, Hd_20, Xposition + Fia_168[Corner] - 150, Hi_32 + 6);
      Hi_32 += 15;
   }
}

// 373DCE9A3EEC90592F732651A785701E
void f0_2(int Ei_0, double Ed_4, int Ei_12, int Ei_16) {
   f0_7(Ei_0, Ei_12, Ei_16);
   
}

// B6ED9622D8254A44DF149A6B47536276
void f0_7(int Ei_0, int Ei_4, int Ei_8) {
   
}

// 83D6DDE7133D9C392954F5EEC1D101E7
double f0_6(string Es_0) {
   int Hi_8;
   string Hs_12;
   double Hd_20;
   double Hd_28;
   double Hd_ret_36 = 0;
   int count_44 = 0;
   for (int index_48 = 0; index_48 < ArraySize(Fsa_148); index_48++) {
      Hi_8 = 0;
      Hs_12 = Fsa_148[index_48];
      if (Es_0 == StringSubstr(Hs_12, 0, 3) || Es_0 == StringSubstr(Hs_12, 3, 3)) {
         Hs_12 = Hs_12 + Fs_152;
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

// 7F5123111406C08A187AF15DFB0DAD39
void f0_5(string E_name_0, int Ei_unused_8, int E_x_12, int E_y_16, int E_angle_20, string E_text_24 = "-", int E_fontsize_32 = 42, string E_fontname_36 = "Arial", color E_color_44 = -1) {
   if (ObjectFind(E_name_0) != 0) ObjectCreate(E_name_0, OBJ_LABEL, Window, 0, 0);
   ObjectSet(E_name_0, OBJPROP_CORNER, Corner);
   ObjectSet(E_name_0, OBJPROP_COLOR, E_color_44);
   ObjectSet(E_name_0, OBJPROP_BACK, FALSE);
   ObjectSet(E_name_0, OBJPROP_XDISTANCE, E_x_12);
   ObjectSet(E_name_0, OBJPROP_YDISTANCE, E_y_16);
   ObjectSet(E_name_0, OBJPROP_ANGLE, E_angle_20);
   ObjectSetText(E_name_0, E_text_24, E_fontsize_32, E_fontname_36, E_color_44);
}

// 2F8AF98CEFF878937B91A9059F386F01
int f0_0(string E_name_0, int E_x_8, int Ei_12, string E_text_16, int E_fontsize_24, string E_fontname_28) {
   ObjectCreate(E_name_0, OBJ_LABEL, Window, 0, 0);
   ObjectSet(E_name_0, OBJPROP_CORNER, Corner);
   ObjectSet(E_name_0, OBJPROP_XDISTANCE, E_x_8);
   ObjectSet(E_name_0, OBJPROP_YDISTANCE, Ei_12 + Fi_128 / E_fontsize_24 * Fi_84);
   ObjectSet(E_name_0, OBJPROP_BACK, FALSE);
   ObjectSetText(E_name_0, E_text_16, E_fontsize_24, E_fontname_28 );
   return (0);
}

// 5B6FDEEBF01CC164AE7AAE4134186CAF
void f0_4(string E_name_0, int Ei_8, int Ei_12, string E_text_16 = "g", int E_fontsize_24 = 8, string E_fontname_28 = "Webdings") {
   ObjectCreate(E_name_0, OBJ_LABEL, Window, 0, 0);
   ObjectSet(E_name_0, OBJPROP_CORNER, Corner);
   ObjectSet(E_name_0, OBJPROP_XDISTANCE, Ei_8 + Fi_88 + 21);
   ObjectSet(E_name_0, OBJPROP_YDISTANCE, Ei_12 + Fi_84 - 4);
   ObjectSetText(E_name_0, E_text_16, E_fontsize_24, E_fontname_28);
}

// 4351E8BD5808B5D62E7AB0705C30C26E
void f0_3() {
   string name_0;
   int Hi_8 = ObjectsTotal(OBJ_LABEL);
   if (Hi_8 > 0) {
      for (int objs_total_12 = Hi_8; objs_total_12 >= 0; objs_total_12--) {
         name_0 = ObjectName(objs_total_12);
         if (StringFind(name_0, Fs_120, 0) >= 0) ObjectDelete(name_0);
      }
   }
}
