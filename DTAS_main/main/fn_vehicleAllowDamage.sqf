#include "..\..\script_macros.hpp"
/*
*   @File: fn_vehicleAllowDamage.sqf
*   @Original Author: Gal Zohar
*     - Edited by Sig
*
*   Description: Look in the name dumbass
*/

if (!isNil "vehArr") then {
  {
    _x allowDamage false;
  } forEach vehArr;


  [] spawn
  {
    private _oldVehArr = vehArr + [];
    private _endTime = time + 30;
    waitUntil {time > _endTime};
    {
      if (!(isNull _x)) then
      {
        _x allowDamage true;
      };
    } forEach _oldVehArr;
  };
};
