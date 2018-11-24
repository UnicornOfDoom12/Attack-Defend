#include "..\..\script_macros.hpp"
/*
*   @File: fn_damageHandler.sqf
*   @Author: Sig
*
*   Description: Damage handler
*
*   Arguments:
*     0 - Unit <OBJECT> that is being damaged
*     1 - Selection <STRING> name of the selection that was hit
*     2 - Damage <NUMBER> that is being done to the unit
*     3 - Source <OBJECT> that caused the damage
*     4 - Projectile <STRING> that inflicted the damage
*     5 - Hit Part Index <NUMBER> index of the hit part that was hit
*     6 - Instigator <OBJECT> Person who pulled the trigger
*     7 - HitPoint <STRING> hit point Cfg name
*
*     Return:
*       Final damage <NUMBER> to be applied to the unit
*/

params [
  ["_unit", player, [objNull]],
  ["_selection", "", [""]],
  ["_damage", 0, [0]],
  ["_source", objNull, [objNull]],
  ["_projectile", "", [""]],
  ["_hitPartIndex", -1, [0]],
  ["_instigator", objNull, [objNull]],
  ["_hitPoint", "", [""]]
];

private _neutralDamage = [_unit getHit _selection, damage _unit] select (_selection isEqualTo "");

if !(_unit getVariable ["playerAllowDamage", true]) exitWith {_neutralDamage};
if (_unit distance objPos > 750) exitWith {_neutralDamage};

_damage
