#include "..\..\script_macros.hpp"
/*
*		@File: fn_assignGear.sqf
*		@Original Author: Gal Zohar
*			- Edited by Sig
*
*		Description: Assigns gear to the player lad
*
*		Arguments
*			0 - <BOOL> whether or not to give weapons in the lobby
*
*		Return:
*			Nothing
*
*/

params [
	["_bGiveWeapons", false, [false]]
];

gearAssigned = false;

private _aClassSide = [nextAttackerSide, attackerSide] select _bGiveWeapons;
private _currentClass = [currentDClass, currentAClass] select (_aClassSide isEqualTo playerSide);
private _gear = +_currentClass;

// -- Since resize and set alters the array, the only way I could think of was to re-alter the array at the end with the previous variables
private _name = _gear select 10;
private _weapons = [_gear select 0, _gear select 1, _gear select 2];
private _rgF = _gear select 8;

_gear resize 10;

currentUniform = (_gear select 3) select 0;
SETVAR(player,"currentUniform",currentUniform,true);


// Prevent them from getting their weapons in the lobby
if (!_bGiveWeapons) then {
	hint ((format [localize "STR_SelectedClass", _name]) + " " + (localize "STR_WeaponsWillBeGiven"));
	for "_i" from 0 to 2 do {
		_gear set [_i, []];
	};
	_gear set [8, []];
};


//Assign the new gear and select the first weapon
[] call FUNC(playerStrip);
player setUnitLoadout _gear;

{
	if !(_x isEqualTo "") exitWith {
		player selectWeapon _x;
	};
	player action ["switchWeapon", player, player, 100];
} forEach [primaryWeapon player, secondaryWeapon player, handGunWeapon player];

gearAssigned = true;
