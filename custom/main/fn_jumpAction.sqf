/*
 *  @File: fn_jumpAction.sqf
 *  @Author: No clue, optimized by Sig
 *
 *  Description: Jumps bitch
 *
 *  Argument(s):
 *    0: OBJECT - Unit that is jumping
 */

#define ANIM "AovrPercMrunSrasWrflDf"

if (!params [["_unit", objNull, [objNull]]] || isNull _unit) exitWith {};

if (animationState _unit == ANIM) exitWith {};

if (local _unit) then {

	private _baseH = 1.8;
	private _maxH  = 3.5;
	private _speed = 0.4; // Base speed

	private _h = _baseH - (load _unit) max _maxH;
	private _v = velocity _unit;
	private _dir = direction _unit;

	_unit setVelocity [(_v # 0) + (sin _dir * _speed), (_v # 1) + (cos _dir * _speed), ((_v # 2) * _speed) + _h];
	
};

if !(currentWeapon _unit isEqualTo "") then {
	_unit switchMove ANIM;
	_unit playMoveNow ANIM;
}
else {
	_unit switchMove ANIM;
};
