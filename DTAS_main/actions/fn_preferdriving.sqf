#include "..\..\script_macros.hpp"
/*
*   @File: fn_preferDriving.sqf
*   @Author: Gal Zohar
*
*   Description: Sets the prefer driving option
*/

(_this select 3) params [ // MAYBE FIX
  "_preference"
];

preferDriver = _preference;
player setVariable ["preferDriver", preferDriver, true];
