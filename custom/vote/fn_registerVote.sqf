#include "..\..\script_macros.hpp"
/*
*   @File: fn_registerVote.sqf
*   @Author: Sig
*
*   Description: Remotely Executed to the server whenever smoebody votes, should the current vote count be enough to select a new map, it will
*
*   Arguments:
*     0 - Marker <STRING> that is being voted for (This is from markerAreaArray)
*
*   Return:
*     Nothing
*/

params [
  ["_marker", "", [""]]
];

/*
*   Register the vote to the ADC VoteList variable
*/

private _add = true;
{
  _x params ["_name", "_count"];
  if (_marker isEqualTo _name) exitWith {
    _add = false;
    ADC_VoteList set [_forEachIndex, [_name, (_count + 1)]];
  };
} forEach ADC_VoteList;

if (_add) then {
  ADC_VoteList pushBack [_marker, 1];
};
publicVariable "ADC_VoteList";

/*
*   Check the ADC Votelist to see if the updated version can
*/

private _maxCount = 0;
private _totalCount = 0;
private _area = "";
{
  _x params ["_name", "_count"];
  if (_count > _maxCount) then {
    _maxCount = _count;
    _area = _name;
  };
  _totalCount = _totalCount + _count;
} forEach ADC_VoteList;

if (_maxCount > 0 && !(_area isEqualTo "") && !(_area isEqualTo lastObjPosMarker)) then {
  if (_totalCount >= (count playableUnits * 0.5)) then {
    (markerPos _area) params ["_x", "_y"];
    (markerSize _area) params ["_w", "_h"];

  	private _minX = _x - _w;
  	private _maxX = _x + _w;
  	private _minY = _y - _h;
  	private _maxY = _y + _h;

  	objPos = [_minX + random (_maxX - _minX), _minY + random (_maxY - _minY)];
  	publicVariable "objPos";
  	objPosMarker = _area;
  	publicVariable "objPosMarker";

    if (!isDedicated) then { //If the server is playerhosted, publicVariableEventHandler will not fire and therefore will need to call the handler manually
      [] call objPosHandlerClient;
    };
    [] call fnc_setupObjPos;
  };
};
