#include "..\ui_macros.hpp"
/*
    File: dialog_nickName.hpp
    Author: Sig

    Description: Dialog for assigning nicknames to people
*/

class nickNameMenu {
  idd = IDD_NICKNAME_MENU;
  movingEnabled = false;
  onUnLoad = "['unLoad'] call ADC_fnc_nickNameMenu";

  class controls {
    class background: RscText
    {
    	idc = -1;
    	x = 0.422637 * safezoneW + safezoneX;
    	y = 0.489 * safezoneH + safezoneY;
    	w = 0.154726 * safezoneW;
    	h = 0.099 * safezoneH;
    	colorBackground[] = {COLOR_BG};
    };
    class header: RscText
    {
    	idc = IDC_NICKNAME_HEADER;
    	text = "HEADER"; //--- ToDo: Localize;
    	x = 0.422637 * safezoneW + safezoneX;
    	y = 0.467 * safezoneH + safezoneY;
    	w = 0.154726 * safezoneW;
    	h = 0.022 * safezoneH;
    	colorBackground[] = {COLOR_MAIN};
      font = P_FONT;
    };
    class nameEdit: RscEdit
    {
    	idc = IDC_NICKNAME_EDIT;
    	x = 0.427794 * safezoneW + safezoneX;
    	y = 0.5 * safezoneH + safezoneY;
    	w = 0.144411 * safezoneW;
    	h = 0.033 * safezoneH;
      font = P_FONT;
    };
    class cancelButton: RscButton
    {
    	idc = -1;
    	text = "CANCEL"; //--- ToDo: Localize;
    	x = 0.427794 * safezoneW + safezoneX;
    	y = 0.544 * safezoneH + safezoneY;
    	w = 0.067048 * safezoneW;
    	h = 0.033 * safezoneH;
      font = P_FONT;
      onButtonClick = "closeDialog 0";
      colorBackgroundActive[] = {COLOR_MAIN};
    };
    class setNickButton: RscButton
    {
    	idc = -1;
    	text = "SET NAME"; //--- ToDo: Localize;
    	x = 0.505158 * safezoneW + safezoneX;
    	y = 0.544 * safezoneH + safezoneY;
    	w = 0.067048 * safezoneW;
    	h = 0.033 * safezoneH;
      font = P_FONT;
      colorBackgroundActive[] = {COLOR_MAIN};
      onButtonClick = "['set', uiNameSpace getVariable ['nickNameEditorUnit', objNull]] call ADC_fnc_nicknameMenu";
    };
  };
};
