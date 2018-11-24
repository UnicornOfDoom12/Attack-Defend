#include "..\..\script_macros.hpp"
/*
    File: fn_adminLevel.sqf
    Author: Sig

    Description: Checks admin level and returns admin level
    Arguments: 0 - UID <STRING | OBHJECT> to check level of

    Return: Level <NUMBER> that the unit is
*/

params [["_unit", player, [objNull, ""]]];

private _check = [_unit, getPlayerUID _unit] select (_unit isEqualType objNull);

(["one", "two", "three"] findIf {_check in getArray (missionConfigFile >> "adminWhiteList" >> "adminLevel" + _x  >> "playerids")}) + 1
