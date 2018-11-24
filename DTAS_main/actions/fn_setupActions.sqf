#include "..\..\script_macros.hpp"
/*
*   @File: fn_setupActions.sqf
*   @Author: Sig
*
*   Description: Sets up all actions
*/

GVAR(actions) = [];

GVAR(actions) pushBack (player addAction ["<t color='#00f582'>Selection Menu</t>", {createDialog "ADC_playerMenuMain"}, [], 0, true, true, "", "canChangeClass && ((player distance (markerPos 'respawn_west') < 100) || (player distance (markerPos 'respawn_east') < 100))"]);
GVAR(actions) pushBack (player addAction ["Re-equip gear", {[true] call DFUNC(assignGear)}, [], 0, true, true, "", "roundInProgress && player getVariable ['isPlaying', false] && (primaryWeapon player isEqualTo '')"]);
GVAR(actions) pushBack (player addAction ["Unflip vehicle", {cursorObject setPos [getPos cursorObject select 0, getPos cursorObject select 1, 1.5]}, [], 0, true, true, "", "(cursorObject isKindOf 'Car' || cursorObject isKindOf 'Air') && (vectorUp cursorObject select 2) < 0"]);
