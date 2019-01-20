#include "script_macros.hpp"
/*
*   @File: serverStartConfiguration.sqf
*   @Author: Sig
*
*   Description: Variable configration for server start
*/

minCapTime = 20;
maxCapTime = 60;
attackerSide = west;
publicVariable "minCapTime";
publicVariable "maxCapTime";
publicVariable "attackerSide";

minDistFactors = [1, 0.7, 0.55, 1, 1, 1];
publicVariable "minDistFactors";

fnc_getSqrDist = DFUNC(getSqrDist);
fnc_cleanName = DFUNC(cleanName);
fnc_airDistance = { sqrt (_this call DFUNC(getSqrDist)) };
fnc_isCapturing = DFUNC(isCapturing);
fnc_vehicleAllowDamage = DFUNC(vehicleAllowDamage);
//fnc_minGroupSize = { private _minGroupSize = (playersNumber (attackerSide)) / 3; _minGroupSize min 3 };
fnc_minGroupSize = { private _minGroupSize = 1};
fnc_deleteOldBody = DFUNC(deleteOldBody);
fnc_addRadio = {};
fnc_assigngear = DFUNC(assignGear);

publicVariable "fnc_getSqrDist";
publicVariable "fnc_cleanName";
publicVariable "fnc_airDistance";
publicVariable "fnc_isCapturing";
publicVariable "fnc_vehicleAllowDamage";
publicVariable "fnc_minGroupSize";
publicVariable "fnc_deleteOldBody";
publicVariable "fnc_addRadio";
publicVariable "fnc_assignGear";
