#include "..\..\script_macros.hpp"
/*
*		@File: populateAmmoCrate.sqf
*		@Author: Gal Zohar
*
*		Description: Assign actions and clear wepaon crates in base
*/

params [
	["_veh", objNull, [objNull]]
];

waitUntil {!isNil "preInitDone"};

_veh spawn DFUNC(classMenu);

if (isServer) then
{
	clearWeaponCargoGlobal _veh;
	clearMagazineCargoGlobal _veh;
	clearItemCargoGlobal _veh;
	clearBackPackCargoGlobal _veh;

	all_crates = all_crates + [_veh];
};
