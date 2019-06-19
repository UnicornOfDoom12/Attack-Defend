#include "..\ui_macros.hpp"
/*
*   @File: dialog_playerMenu.hpp
*   @Author: Sig
*/

class ADC_playerMenuMain {
  idd = IDD_PLAYERMENU_MAIN;
  movingEnable = false;
  onLoad = "['onLoad', _this] spawn ADC_fnc_playerMenu";

  class controls {
    class background: RscText
    {
    	idc = IDC_PMENU_BACKGROUND;
    	x = 0.396849 * safezoneW + safezoneX;
    	y = 0.258 * safezoneH + safezoneY;
    	w = 0.206302 * safezoneW;
    	h = 0.495 * safezoneH;
    	colorBackground[] = {COLOR_BG};
      onLoad = "(_this select 0) ctrlSetFade 1; (_this select 0) ctrlCommit 0";
    };
    class listbox: RscListbox
    {
    	idc = IDC_PMENU_LISTBOX;
    	x = 0.407164 * safezoneW + safezoneX;
    	y = 0.302 * safezoneH + safezoneY;
    	w = 0.185671 * safezoneW + 0.1;
    	h = 0.407 * safezoneH;
      font = P_FONT;
      onLbDblClick = "['select'] call ADC_fnc_playerMenu";
    	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.1)";
      onLoad = "(_this select 0) ctrlSetFade 1; (_this select 0) ctrlCommit 0";
    };
    class header: RscText
    {
    	idc = IDC_PMENU_HEADER;
    	text = "SELECT YOUR CLASS"; //--- ToDo: Localize;
    	x = 0.396849 * safezoneW + safezoneX;
    	y = 0.236 * safezoneH + safezoneY;
    	w = 0.206302 * safezoneW;
    	h = 0.022 * safezoneH;
    	colorBackground[] = {COLOR_MAIN};
      colorText[] = {TEXT_COLOR};
      font = P_FONT;
      onLoad = "(_this select 0) ctrlSetFade 1; (_this select 0) ctrlCommit 0";
    };
    class close: RscButton
    {
    	idc = IDC_PMENU_BTNCLOSE;
    	text = "CLOSE"; //--- ToDo: Localize;
    	x = 0.45874 * safezoneW + safezoneX;
    	y = 0.72 * safezoneH + safezoneY;
    	w = 0.0618905 * safezoneW;
    	h = 0.022 * safezoneH;
      onButtonClick = "['close'] spawn ADC_fnc_playerMenu";
      font = P_FONT;
      colorBackgroundActive[] = {COLOR_MAIN};
      onLoad = "(_this select 0) ctrlSetFade 1; (_this select 0) ctrlCommit 0";
    };
    class select: RscButton
    {
    	idc = IDC_PMENU_BTNSELECT;
    	text = "SELECT"; //--- ToDo: Localize;
    	x = 0.530945 * safezoneW + safezoneX;
    	y = 0.72 * safezoneH + safezoneY;
    	w = 0.0618905 * safezoneW;
    	h = 0.022 * safezoneH;
      font = P_FONT;
      colorBackgroundActive[] = {COLOR_MAIN};
      onButtonClick = "['select'] call ADC_fnc_playerMenu";
      onLoad = "(_this select 0) ctrlSetFade 1; (_this select 0) ctrlCommit 0";
    };
    class combo: RscCombo
    {
    	idc = IDC_PMENU_COMBOBOX;
    	x = 0.407164 * safezoneW + safezoneX;
    	y = 0.269 * safezoneH + safezoneY;
    	w = 0.185671 * safezoneW;
    	h = 0.022 * safezoneH;
      font = P_FONT;
      onMouseButtonClick = "['comboUpdate'] call ADC_fnc_playerMenu";
      onLbSelChanged = "['comboUpdate'] call ADC_fnc_playerMenu";
      onLoad = "(_this select 0) ctrlSetFade 1; (_this select 0) ctrlCommit 0";
    };
  };
};
