#include "..\..\script_macros.hpp"
/*
    File: fn_repack.sqf
    Author: Sig

    Description:
    Function for repacking magazines lad
    This function will only repack the magazines that are in the players inventory, not currently loaded

    Arguments: Nothing
    Return: Nothing
*/

private _maxMag = [];

{
  _x params ["_className", "_ammoCount", "_magState", "_magType", "_article"];
  if (_magType isEqualTo -1) then {
    private _add = true;
    {
      _x params ["_class", "_amount"];
      if (_className in _x) exitWith {
        _x set [1, (_amount + _ammoCount)];
        _add = false;
      };
    } forEach _maxMag;

    if (_add) then {
      _maxMag pushBack [_className, _ammoCount];
    };
  };
} forEach (magazinesAmmoFull player);

if (count _maxMag > 0) then {
  {player removeMagazine _x} forEach (magazines player);
  {
    _x params ["_className", "_amount"];
    private _maxCount = getNumber(configFile >> "CfgMagazines" >> _className >> "count");
    private _count = floor (_amount / _maxCount);
    private _spareRounds = _amount mod _maxCount;

    if (_count > 0) then {
      player addMagazines [_className, _count];
    };

    if (_spareRounds > 0) then {
      player addMagazine [_className, _spareRounds];
    };

  } forEach _maxMag;
};
