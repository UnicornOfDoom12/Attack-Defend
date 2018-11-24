#define CT_STATIC         0
#define ST_LEFT           0x00
#define ST_CENTER         0x02

	class DTASHUD
	{
      	idd = 1000;
     	movingEnable=0;
      	duration=1e+011;
      	name = "DTASHUD_name";
      	onLoad = "['onLoad', _this] call ADC_fnc_hudHandler";
				onUnLoad = "['onUnLoad', _this] call ADC_fnc_hudHandler";
      	controlsBackground[] = {};
      	objects[] = {};
      	class controls
		{
			class TimerDisplay
			{
				type = CT_STATIC;
				style = ST_CENTER;
				idc = 1001;
				text = "";
				x = 0.4625 * safezoneW + safezoneX;
				y = 0.02 * safezoneH + safezoneY;
				w = 0.075 * safezoneW;
				h = 0.04 * safezoneH;
				font = "PuristaMedium";
				colorBackground[] = {0.05,0.05,0.05,0.3};
				colorText[] = {1,1,1,1};
				sizeEx = 0.05;
			};

			class MissionDisplay
			{
				type = CT_STATIC;
				style = ST_CENTER;
				idc = 1002;
				text = "";
				x = 0.55 * safezoneW + safezoneX;
				y = 0.02 * safezoneH + safezoneY;
				w = 0.1 * safezoneW;
				h = 0.04 * safezoneH;
				font = "PuristaMedium";
				colorBackground[] = {0.05,0.05,0.05,0.3};
				colorText[] = {1,1,1,1};
				sizeEx = 0.05;
			};

			class ScoreWDisplay
			{
				type = CT_STATIC;
				style = ST_CENTER;
				idc = 1101;
				text = "";
				x = 0.679 * safezoneW + safezoneX;
				y = 0.02 * safezoneH + safezoneY;
				w = 0.03 * safezoneW;
				h = 0.04 * safezoneH;
				font = "PuristaMedium";
				colorBackground[] = {0,0,1,0.3};
				colorText[] = {1,1,1,1};
				sizeEx = 0.05;
			};

			class ScoreEDisplay
			{
				type = CT_STATIC;
				style = ST_CENTER;
				idc = 1102;
				text = "";
				x = 0.71 * safezoneW + safezoneX;
				y = 0.02 * safezoneH + safezoneY;
				w = 0.03 * safezoneW;
				h = 0.04 * safezoneH;
				font = "PuristaMedium";
				colorBackground[] = {1,0,0,0.3};
				colorText[] = {1,1,1,1};
				sizeEx = 0.05;
			};

			class voteList: RscListNBox
			{
				idc = 1004;
				x = 0.840398 * safezoneW + safezoneX;
				y = 0.214 * safezoneH + safezoneY;
				w = 0.149569 * safezoneW;
				h = 0.154 * safezoneH;
				font = "PuristaMedium";
				onLoad = "(_this select 0) ctrlShow false";
				colorBackground[] = {0,0,0,0.5};
			  columns[] = {-0.01, 0.87};
			  class ListScrollBar
			  {
				  arrowEmpty = "#(argb,8,8,3)color(0,0,0,0)";
				  arrowFull = "#(argb,8,8,3)color(0,0,0,0)";
				  border = "#(argb,8,8,3)color(0,0,0,0)";
				  color[] = {1,1,1,0};
				  colorActive[] = {1,1,1,0};
				  colorDisabled[] = {1,1,1,0};
				  thumb = "#(argb,8,8,3)color(1,1,1,0)";
			  };
			};
			class nextMissionHeader: RscText
			{
				idc = 1003;
				text = ""; //--- ToDo: Localize;
				x = 0.840398 * safezoneW + safezoneX;
				y = 0.192 * safezoneH + safezoneY;
				w = 0.149569 * safezoneW;
				h = 0.022 * safezoneH;
				font = "PuristaLight";
				onLoad = "(_this select 0) ctrlShow false";
				colorBackground[] = {0,0,0,0.7};
			};
		};
	};
