#include "..\..\script_macros.hpp"
/*
*   @File: fn_getSqrDist.sqf
*   @Author: Gal Zohar
*     - Optimized by Sig
*
*   Description: I dont even know to be honest
*/

params [
  ["_pos1", [], [[]]],
  ["_pos2", [], [[]]]
];

private _dx = SUB(_pos1 select 0, _pos2 select 0);
private _dy = SUB(_pos1 select 1, _pos2 select 1);

ADD(_dx ^ 2, _dy ^ 2)
