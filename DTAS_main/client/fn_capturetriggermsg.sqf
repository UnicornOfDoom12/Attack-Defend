#include "..\..\script_macros.hpp"
/*
*		@File: fn_captureTriggerMsg.sqf
*		@Author: Gal Zohar
*
*		Description: Notifies the player when they enter the zone
*/

for "_i" from 0 to 1 do {
	waitUntil {[player] call DFUNC(isCapturing)};
	if (roundInProgress) then
	{
		if (attackerSide == playerSide) then
		{
			hint localize "STR_CapMsg";
		}
		else
		{
			hint localize "STR_DefendMsg";
		};
	};
	waitUntil {!([player] call DFUNC(isCapturing))};
	if (roundInProgress) then
	{
		if (attackerSide == playerSide) then
		{
			hint localize "STR_StopCapMsg";
		}
		else
		{
			hint localize "STR_StopDefendMsg";
		};
	};
};
