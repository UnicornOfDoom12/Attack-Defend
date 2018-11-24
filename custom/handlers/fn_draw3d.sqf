#include "..\..\script_macros.hpp"
/*
*   @File: fn_draw3d.sqf
*   @Author: Sig
*
*   Description: Handles drawing of all 3D icons and lines
*/

#define ID VARQ(Draw_Hexagons)

if (isNil {missionNameSpace getVariable ID}) then {
  missionNameSpace setVariable [ID, addMissionEventHandler ["Draw3D", {
    _this call {

      {

        if (_x distance (markerPos "respawn_west") > 100 && _x distance (markerPos "respawn_east") > 100) then {

          private _pos = (vehicle _x) modelToWorldVisual ([_x selectionPosition "spine3", [0, 0, 0]] select (!isNull objectParent _x));
          private _color = switch true do {case (_x isEqualTo (leader player)): {[1, 1, 0, 1]}; case (_x in units (group player)): {[0, 0.8, 0, 1]}; default {[0, 0.8, 1, 1]};}; // maybe it broke

          drawIcon3D ["\a3\ui_f\data\igui\cfg\cursors\select_ca.paa", _color, _pos, 1.1, 1.1, 0];
          drawIcon3D ["", [1,1,1,0.8], _pos, 1.1, 1.1, 0, ["", _x getVariable ["shortName", name _x]] select GVAR(showHexText), 2, .027, "RobotoCondensedBold", "center", false];

        };

        true
      } count (playableUnits select {!(vehicle _x isEqualTo vehicle player) && side _x isEqualTo playerSide});

    };
  }]]
};
