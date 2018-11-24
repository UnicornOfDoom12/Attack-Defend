#include "..\..\script_macros.hpp"
/*
*		@File: fn_cleanName.sqf
*		@Author: Gal Zohar
*			- Redone by Sig
*
*		Description: Takes gang tags out of names
*/

params [["_originalName", "", [""]]];

private _skipChars = toArray "<>";

toString ((toArray _originalName) apply {[_x, 32] select (_x in _skipChars)})
