#include "..\..\script_macros.hpp"
/*
*   @File: fn_handleDisconnect.sqf
*   @Author: Sig
*
*   Description: On player disconnect (goes to lobby), script will fire.
*
*   Arguments:
*     0 - Unit            <OBJECT> that is disconnecting
*     1 - Mission id      <NUMBER> of the player disconnecting
*     2 - UID             <STRING> Player UID for the player disconnecting
*     3 - Name            <STRING> of the player that is disconnecting
*/

params [
  ["_unit", objNull, [objNull]],
  ["_id", -1, [0]],
  ["_uid", "", [""]],
  ["_name", "", [""]]
];

_unit spawn {
  params ["_unit"];
  waitUntil {!isPlayer _unit};
  { deleteVehicle _x } forEach (nearestObjects [getPos _unit, ["WeaponHolderSimulated"], 5]);
  deleteVehicle _unit;
};

false
