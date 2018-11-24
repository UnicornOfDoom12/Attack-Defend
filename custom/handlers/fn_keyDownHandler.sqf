#include "..\..\script_macros.hpp"
/*
*   @File: fn_keyDownHandler.sqf
*   @Author: Sig
*
*   Description: Key down handler
*
*   Arguments:
*     0 - Display Control       <CONTROL> that the key down is executed from
*     1 - DIK Key               <NUMBER> number of key that is breing pressed
*     2 - Shift                 <BOOL> whether or not shift was pressed
*     3 - Alt                   <BOOL> whether or not alt was pressed
*     4 - Ctrl                  <BOOL> whether or not ctrl was pressed
*
*   Return:
*     <BOOL> whether or not to overrun default keybinds
*/

params [
  "_control",
  ["_key", -1, [0]],
  ["_shift", false, [false]],
  ["_alt", false, [false]],
  ["_ctrl", false, [false]]
];

scopeName "main";
private _overRun = false;

private _jumpButton = 57;

{
  if (_key in actionKeys _x) then {
    true breakOut "main"
  };
} forEach ["TacticalView"];

for "_i" from 0 to 9 do {
  private _cmd = format ["CommandingMenu%1", _i];
  private _select = format ["SelectGroupUnit%1", _i];
  if (_key in actionKeys _cmd || _key in actionkeys _select) then {_overRun = true};
};
/*
if (_key in actionKeys "GetOver") then {
  if (_shift && {!(animationState player isEqualTo "AovrPercMrunSrasWrflDf")} && {isTouchingGround player} && {stance player in ["STAND", "CROUCH"]} && {speed player > 2} && {((velocity player) select 2) < 2.5} && {time - (player getVariable [VARQ(jumpActionTime), 0]) > 1.5}) exitWith {
    player setVariable [VARQ(jumpActionTime), time, true];
    [player] remoteExec [QFNC(jumpAction), 0]; //Global execution
    _overRun = true;
  };
};
*/


switch (_key) do {

  // Holster / unholster (SHIFT + H)
  case 35: {
    if (_shift) then {
      if !(currentWeapon player isEqualTo "") then {
        player action ["SwitchWeapon", player, player, 100];
        player switchCamera cameraView;
      } else {
        {
          if !(_x isEqualTo "") then {
            player selectWeapon _x;
          };
        } forEach [primaryWeapon player, secondaryWeapon player, handGunWeapon player];
      };
      _overRun = true;
    };
  };

  case 6: {
    if (_shift) then {
      if (roundInProgress && player getVariable ["isPlaying",false]) then {
        [true] call DFUNC(assignGear);
      } else {
        [false] call DFUNC(assignGear);
      };
      titleText ["Your gear has been re-equipped", "PLAIN"];
    };
  };

  //Y (Selection Menu)
  case 21: {
    if (canChangeClass && ((player distance (markerPos 'respawn_west') < 100) || (player distance (markerPos 'respawn_east') < 100)) && !dialog) then {
      _overRun = true;
      createDialog "ADC_playerMenuMain";
    };
  };

//Text below hexagons (SHIFT 6)
  case 7: {
    if (_shift) then {
      GVAR(showHexText) = !GVAR(showHexText);
      hint (["You have disabled name tags for group hexagons", "You have enabled name tags for group hexagons"] select GVAR(showHexText));
      _overRun = true;
    };
  };

//earplugs (SHIFT O)
  case 24: {
    if (_shift) then {
      if !(soundVolume isEqualTo 1) then {
        1 fadeSound 1;
        hint "Earplugs taken out";
      } else {
        1 fadeSound 0.1;
        hint "Earplugs in";
      };
      _overRun = true;
    };
  };

//low detail mode (SHFIT END)
  case 207: {
      if (_shift) then {
          if (getTerrainGrid != 25) then {
              setTerrainGrid 25;
              hint "Low detail mode off";
          } else {
              setTerrainGrid 50;
              hint "Low detail mode on";
          };
          _overRun = true;
      };
  };

};

_overRun
