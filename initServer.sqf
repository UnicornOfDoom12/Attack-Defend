#include "script_macros.hpp"
/*
*   @File: initServer.sqf
*   @Author: Sig
*
*   Description: Server-side player init (when player joins mission)
*/

private _initStart = diag_tickTime;
diag_log format ["================================ Misson File: %1 ================================", missionName];
diag_log         "                               Initializing Server                               ";
diag_log         "=================================================================================";

waitUntil {!isNil "preInitDone"};
call compile preprocessFileLineNumbers "serverStartConfiguration.sqf";


[] spawn DFUNC(srvWarningInit);
[] spawn DFUNC(capture);
[] spawn DFUNC(roundServer);
[] spawn DFUNC(endHandler);
[] spawn DFUNC(weather);


addMissionEventHandler ["HandleDisconnect", { _this spawn FUNC(handleDisconnect) }];

["Initialize"] call BIS_fnc_dynamicGroups;

private _execTime = diag_tickTime - _initStart;
diag_log         "=================================================================================";
diag_log 				 "=========================== Server Initialization Completed =====================";
diag_log format ["========================== Time: The initialization took %1 =====================", [_execTime, "MM:SS.MS"] call BIS_fnc_secondsToString];
diag_log format	["=================================  Mission: %1 ===============================", missionName];
