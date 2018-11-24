#include "..\..\script_macros.hpp"
/*
*   @File: fn_killedHandler.sqf
*   @Author: Sig
*
*   Description: Fired each time a unit dies
*
*   Arguments:
*     0 - Unit        <OBJECT> that was killed
*     1 - Unit        <OBJECT> that shot the person (if any)
*     2 - Instigator  <OBJECT> that pulled the trigger
*     3 - Use Effects <BOOL>
*
*   Return:
*     Nothing
*/

params [
  ["_unit", objNull, [objNull]],
  ["_killer", objNull, [objNull]],
  ["_instigator", objNull, [objNull]],
  ["_useEffects", true, [false]]
];

if (!(side _killer isEqualTo side _unit) && isPlayer _killer && isPlayer _unit) then {
  [[_unit], {playSound "onKillSound"; hint format ["You killed %1", name (_this select 0)]}] remoteExec ["bis_fnc_call", _killer];
};
