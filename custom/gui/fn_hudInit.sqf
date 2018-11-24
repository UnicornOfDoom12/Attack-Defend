#include "..\..\script_macros.hpp"
/*
*   @File: fn_hudInit.sqf
*   @Author: Sig
*
*   Description: Initalizes HUD (hide, show)
*
*   Arguments:
*     0 - Mode                <STRING> to init
*     1 - Additional Params   <ARRAY>
*
*   Available modes
*     "Load" - Create HUD
*     "Unload" - Remove HUD
*/

params [
  ["_mode", "", [""]],
  ["_params", [], []]
];

switch (_mode) do {
  case "load": {
    ("DTASHUD" call BIS_fnc_RscLayer) cutRsc ["DTASHUD", "PLAIN"];
  };

  case "unload": {
    _params params [["_fadeTime", 0, [0]]];
    ("DTASHUD" call BIS_fnc_RscLayer) cutFadeOut _fadeTime
  };
};
