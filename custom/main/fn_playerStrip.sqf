#include "..\..\script_macros.hpp"
/*
*   @File: fn_playerStrip.sqf
*   @Author: Sig
*
*   Description: Strips the player down
*
*   Arguments:
*     0 - Unit <OBJECT> that will get his gear stripped
*
*   Return:
*     Nothing
*/

params [
  ["_unit", objNull, [objNull]]
];

removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;
removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeAllItems _unit;
