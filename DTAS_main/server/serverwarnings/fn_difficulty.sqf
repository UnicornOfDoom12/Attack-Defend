#include "..\..\..\script_macros.hpp"
/*
*		@File: fn_difficulty.sqf
*		@Author: Gal Zohar
*
*		Description: ???
*/

private ["_PvPOptions", "_realismOptions", "_message", "_badPvPOptionDetected", "_badRealismOptionDetected"];

_PvPOptions = ["Armor", "EnemyTag", "MineTag", "AutoSpot", "Map", "3rdPersonView", "DeathMessages", "NetStats"];

_realismOptions = ["FriendlyTag", "HUD", "HUDWp", "HUDWpPerm", "HUDGroupInfo", "WeaponCursor"];

_message = "";

_badPvPOptionDetected = false;
{
	if (difficultyEnabled _x) then
	{
		if (!_badPvPOptionDetected) then
		{
			_badPvPOptionDetected = true;
			_message = localize "STR_ServerDifficultyPvP";
			_message = _message + " " + _x;
		}
		else
		{
			_message = _message + ", " + _x;
		};
	};
} forEach _PvPOptions;
if (_badPvPOptionDetected) then
{
	_message = _message + ".";
};

_badRealismOptionDetected = false;
{
	if (difficultyEnabled _x) then
	{
		if (!_badRealismOptionDetected) then
		{
			_badRealismOptionDetected = true;
			if (_badPvPOptionDetected) then
			{
				_message = _message + " ";
			};
			_message = _message + (localize "STR_ServerDifficultyRealism");
			_message = _message + " " + _x;
		}
		else
		{
			_message = _message + ", " + _x;
		};
	};
} forEach _realismOptions;
if (_badRealismOptionDetected) then
{
	_message = _message + ".";
};

if (_message != "") then
{
	_message = localize "STR_Warning" + " " + _message;
	diag_log _message;
	if (!isDedicated) then
	{
		waitUntil {!(isNull player)};
		sleep 1;
		hintC _message;
	};
};
