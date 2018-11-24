#include "..\..\script_macros.hpp"
/*
*   @File: fn_nextSpecateUnit.sqf
*   @Author: Gal Zohar
*
*   Description: Selects the next unit to spectate
*/

private ["_step", "_unitArr", "_oldUnit", "_unitArrCount", "_i", "_oldUnitIndex", "_nextUnit"];

	_step = 1;
	if ((count _this) > 0) then
	{
		_step = _this select 0;
	};

	_unitArr = allUnits;
	_unitArrCount = count _unitArr;
	_oldUnit = spectateUnit;
	spectateUnit = player;
	_i = 0;
	if (_step < 0) then
	{
		_i = _unitArrCount - 1;
	};
	_oldUnitIndex = -1;
	_search = true;
	while {_search && (spectateUnit == player)} do
	{
		if (_i == _oldUnitIndex) then
		{
			_search = false;
		};
		if (_oldUnitIndex >= 0) then
		{
			_nextUnit = _unitArr select _i;
			if
			(
				(alive _nextUnit)
				&&
				(side _nextUnit == playerSide)
				&&
				(isPlayer _nextUnit)
				&&
				((_nextUnit distance (markerPos "respawn_west")) > 100)
				&&
				((_nextUnit distance (markerPos "respawn_east")) > 100)
			) then
			{
				spectateUnit = _nextUnit;
				_search = false;
			};
		}
		else
		{
			if ((_unitArr select _i) == _oldUnit) then
			{
				_oldUnitIndex = _i;
			};
		};

		_i = _i + _step;

		if (_i >= _unitArrCount) then
		{
			_i = 0;
			if (_oldUnitIndex < 0) then
			{
				_oldUnitIndex = _unitArrCount - 1;
			};
		};
		if (_i < 0) then
		{
			_i = _unitArrCount - 1;
			if (_oldUnitIndex < 0) then
			{
				_oldUnitIndex = 0;
			};
		};
	};

	isSpectating = true;
	[] call fnc_switchCamera;
	if (spectateUnit != player) then
	{
		systemChat  format [localize "STR_SpectatingFrom", name spectateUnit];
	};
