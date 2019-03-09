#include "..\..\script_macros.hpp"
/*
*		@File: fn_classMenu.sqf
*		@Author: Gal Zohar
*
*		Description: Adds the actions for the
*
*		Arguments:
*			0 - Object <OBJECT> that has the actions
*/


params [
	["_veh", objNull, [objNull]]
];
fn_defineclasses = compile preprocessFileLineNumbers "DTAS_main\main\fn_defineclasses.sqf";
[[], fn_defineclasses] remoteExec ["spawn"];
call fn_defineclasses;
remoteExec ["fn_defineclasses"];
_veh allowDammage false;

waituntil {!isNil "aClasses"};
waitUntil {!isNil "dClasses"};

{
	private _cond = "(nextAttackerSide isEqualTo playerSide) && canChangeClass";
	_veh addAction [_x select 10, {_this call DFUNC(classAction)}, [_x, WEST], 4, false, true, "", _cond];
} forEach aClasses;


{
	private _cond = "(!(nextAttackerSide isEqualTo playerSide)) && canChangeClass";
	_veh addAction [_x select 10, {_this call DFUNC(classAction)}, [_x, EAST], 4, false, true, "", _cond];
} forEach dClasses;
