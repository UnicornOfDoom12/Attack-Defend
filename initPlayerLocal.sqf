#include "script_macros.hpp"
/*
*   @File: initPlayerLocal.sqf
*   @Author: Sig
*
*   Description: Local player init file
*
*		Arguments:
*			0 - Unit <OBJECT> that joined the mission
*			1 - isJIP <BOOLEAN> whether the player joined when the mission was in progress or not
*/


private _initStart = diag_tickTime;
diag_log format ["================================ Misson File: %1 ================================", missionName];
diag_log         "                               Initializing Player                               ";
diag_log         "=================================================================================";


params [
	["_unit", player, [objNull]],
	["_isJIP", false, [false]]
];

enableSaving [false, false];
enableSentences false;
player enableStamina false;
[] call DFUNC(defineClasses);

// -- Thread for making sure that
[] spawn {
	waitUntil {!isNil "objPos"};
	"mrkObj" setMarkerPosLocal objPos;
	"mrkObj1" setMarkerPosLocal objPos;
};

// -- Make sure teamkillers don't go on side enemy
[] spawn {
	for "_i" from 0 to 1 step 0 do {
		waitUntil {sideEnemy countSide allUnits > 0};
		{
			if ((side _x == sideEnemy) && (local _x)) then
			{
				_x addRating (-(rating _x));
			};
		} forEach allUnits;
	};
};

GVAR(showHexText) = false;
GVAR(AlreadyVoted) = false;

["InitializePlayer", [_unit]] call BIS_fnc_dynamicGroups;

isJoining = false;
forceRoundStart = false;

call compile preprocessFileLineNumbers "briefing.sqf";
[] spawn DFUNC(unitMarkers);
[] call FUNC(setupHandlers);

uiSleep .01;
[] spawn DFUNC(endHandler);
[] spawn DFUNC(weather);
[] spawn DFUNC(roundClient);
[] spawn DFUNC(afkKiller);
[] spawn DFUNC(captureTriggerMsg);
[] call DFUNC(setupActions);

["load"] call FUNC(hudInit);

private _execTime = diag_tickTime - _initStart;
diag_log         "=================================================================================";
diag_log 				 "=========================== Player Initialization Completed =====================";
diag_log format ["========================== Time: The initialization took %1 =====================", [_execTime, "MM:SS.MS"] call BIS_fnc_secondsToString];
diag_log format	["=================================  Mission: %1 ===============================", missionName];
