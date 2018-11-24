#include "..\..\script_macros.hpp"
/*
*		@File: fn_classAction.sqf
*		@Author: Gal Zohar
*
*		Description: Fired when the player selects a new class
*/

(_this select 3) params [
	["_class", [], [[]]],
	["_side", WEST, [WEST]]
];

if (_side isEqualTo WEST) then
{
	currentAClass = _class;
}
else
{
	currentDClass = _class;
};

[false] call DFUNC(assignGear);
