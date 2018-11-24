#include "..\ui_macros.hpp"
#define HIDE "(_this select 0) ctrlSetFade 1; (_this select 0) ctrlShow false; (_this select 0) ctrlCommit 0"
/*
*   @File: dialog_mapVote.hpp
*   @Author: Sig
*/

class ADC_mapVoteMenu {
  idd = IDD_MAPVOTE_MENU;
  movingEnable = false;
  onLoad = "['onLoad', _this] spawn ADC_fnc_mapVoteMenu";

  class controls {
    class mapBackground: RscText
    {
    	idc = IDC_MAPVOTE_BACKGROUND;
    	x = 0 * safezoneW + safezoneX;
    	y = 0.247 * safezoneH + safezoneY;
    	w = 0.149569 * safezoneW;
    	h = 0.55 * safezoneH;
    	colorBackground[] = {COLOR_BG};
      onLoad = HIDE;
    };
    class mapHeader: RscText
    {
    	idc = IDC_MAPVOTE_HEADER;
    	x = 0 * safezoneW + safezoneX;
    	y = 0.225 * safezoneH + safezoneY;
    	w = 0.149569 * safezoneW;
    	h = 0.022 * safezoneH;
    	colorBackground[] = {COLOR_MAIN};
      colorText[] = {TEXT_COLOR};
      font = P_FONT;
      text = "VOTE FOR NEXT POSITION";
      onLoad = HIDE;
    };
    class mapListbox: RscListbox
    {
    	idc = IDC_MAPVOTE_LISTBOX;
    	x = 0.00487599 * safezoneW + safezoneX;
    	y = 0.258 * safezoneH + safezoneY;
    	w = 0.139254 * safezoneW;
    	h = 0.495 * safezoneH;
      onLoad = HIDE;
      font = P_FONT;
      onLbSelChanged = "['selChanged'] call ADC_fnc_mapVoteMenu";
    	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    };
    class mapVote: RscButton
    {
    	idc = IDC_MAPVOTE_BTNVOTE;
    	text = "VOTE"; //--- ToDo: Localize;
    	x = 0.0925542 * safezoneW + safezoneX;
    	y = 0.764 * safezoneH + safezoneY;
    	w = 0.0515754 * safezoneW;
    	h = 0.022 * safezoneH;
      colorBackgroundActive[] = {COLOR_MAIN};
      font = P_FONT;
      onLoad = HIDE;
      onButtonClick = "['vote'] call ADC_fnc_mapVoteMenu";
    };
    class mapVoteMarkerTick: RscCheckBox
    {
      idc = IDC_MAPVOTE_MARKERTICK;
    	x = 0.0048394 * safezoneW + safezoneX;
    	y = 0.764 * safezoneH + safezoneY;
    	w = 0.0165 * safezoneW;
    	h = 0.022 * safezoneH;
      onLoad = HIDE;
      onCheckedChanged = "['markerTick'] call ADC_fnc_mapVoteMenu";
    };
    class mapVoteMarkerText: RscText
    {
      idc = -1;
      text = "SHOW MARKERS";
      font = P_FONT;
    	x = 0.0223394 * safezoneW + safezoneX;
    	y = 0.764 * safezoneH + safezoneY;
    	w = 0.06 * safezoneW;
    	h = 0.022 * safezoneH;
      onLoad = HIDE;
    	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
    };
  };
};
