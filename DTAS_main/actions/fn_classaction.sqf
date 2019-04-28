#include "..\..\script_macros.hpp"
/*
*		@File: fn_classAction.sqf
*		@Author: Gal Zohar
*
*		Description: Fired when the player selects a new class
*/
remoteExec ["fn_defineclasses"];
(_this select 3) params [
	["_class", [], [[]]],
	["_side", WEST, [WEST]]
];

fn_defineclasses = compile preprocessFileLineNumbers "DTAS_main\main\fn_defineclasses.sqf";
remoteExec ["fn_defineclasses"];

if (_side isEqualTo WEST) then
{
	currentAClass = _class;
}
else
{
	currentDClass = _class;
};

[false] call DFUNC(assignGear);
