#include "..\..\script_macros.hpp"
/*
*		@File: fn_keyUp.sqf
*		@Author: Gal Zohar
*/

params [
	"_ctrl",
	["_dikCode", -1, [0]],
	["_shift", false, [false]],
	["_ctrlKey", false, [false]],
	["_alt", [false, [false]]]
];

private _handled = false;

if (!_shift && !_ctrlKey && !_alt) then
{
	if (_dikCode in (actionKeys "ForceCommandingMode")) then
	{
		//_handled = true;
	};

	// Handle group management keys
	//if (_dikCode in (actionKeys "TeamSwitch")) then
	//{
	//	[] call fnc_groupRefresh;
	//	_handled = true;
	//};

	// Handle spectator keys
	if (isSpectating) then
	{
		if ((_dikCode in (actionKeys "MoveForward")) || (_dikCode in (actionKeys "MoveRight"))) then
		{
			[1] call DFUNC(nextSpectateUnit);
			_handled = true;
		};
		if ((_dikCode in (actionKeys "MoveBack")) || (_dikCode in (actionKeys "MoveLeft"))) then
		{
			[-1] call DFUNC(nextSpectateUnit);
			_handled = true;
		};
		// Exit spectator (prone not working for some reason)
		if
		(
			(_dikCode in (actionKeys "Prone"))
			||
			(_dikCode in (actionKeys "Stand"))
			||
			(_dikCode in (actionKeys "Crouch"))
			||
			(_dikCode in (actionKeys "LeanLeft"))
			||
			(_dikCode in (actionKeys "LeanRight"))
		) then
		{
			spectateUnit = player;
			isSpectating = false;
			[] call fnc_switchCamera;
			_handled = true;
		};
	};
};

_handled
