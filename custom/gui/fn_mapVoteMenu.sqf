#include "..\..\script_macros.hpp"
#include "ui_macros.hpp"
#define ME mapVoteMenu
disableSerialization;
/*
*   @File: fn_mapVoteMenu.qsf
*   @Author: Sig
*
*   Description: Opens the map vote menu upon loading the map
*
*   Arguments:
*     0 - Mode                <STRING> decides what to do with the menu
*     1 - Additional Params   <ARRAY>
*
*   Available modes:
*     "onLoad" - whenever the dialog is opened
*     "expand" - expands the dialog
*     "collapse" - collapses the dialog
*
*   Return:
*     Nothing
*/

params [
  ["_mode", "", [""]],
  ["_params", [], [[]]]
];

if (!canChangeClass || (player distance (markerPos "respawn_west") > 100 && player distance (markerPos "respawn_east") > 100)) exitWith {};
scopeName "main";
switch (_mode) do {
  case "onLoad": {
    _params params ["_display"];
    waitUntil {!isNull _display};

    ["expand"] spawn FUNC(ME);
  };

  case "expand": {
    private _display = findDisplay IDD_MAPVOTE_MENU;
    private _header = _display displayCtrl IDC_MAPVOTE_HEADER;
    private _background = _display displayCtrl IDC_MAPVOTE_BACKGROUND;

    (ctrlPosition _background) params ["_bX", "_bY", "_bW", "_bH"];
    (ctrlPosition _header)     params ["_hX", "_hY", "_hW", "_hH"];

    _background ctrlSetPosition [_bX, _bY, 0, 0];
    _header     ctrlSetPosition [_hX, _hY, 0, _hH];
    _background ctrlCommit 0;
    _header     ctrlCommit 0;

    _background ctrlShow true;
    _header     ctrlShow true;

    _background ctrlSetFade 0;
    _header     ctrlSetFade 0;

    _background ctrlCommit 0.05;
    _header     ctrlCommit 0.05;

    waitUntil  {ctrlCommitted _header};

    _header     ctrlSetPosition [_hX, _hY, _hW, _hH];
    _background ctrlSetPosition [_bX, _bY, _bW, 0];
    _background ctrlCommit 0;
    _header     ctrlCommit 0.2;

    waitUntil  {ctrlCommitted _header};

    _background ctrlSetPosition [_bX, _bY, _bW, _bH];
    _background ctrlCommit 0.3;

    waitUntil  {ctrlCommitted _background};

    {
      _x ctrlShow true;
      _x ctrlSetFade 0;
      _x ctrlCommit 0.1;
    } forEach allControls _display;

    ["update"] call FUNC(ME);
  };

  case "collapse": {

    _params params [["_close", false, [false]]];

    private _display = findDisplay IDD_MAPVOTE_MENU;
    if (_close) then {(_display closeDisplay 0) breakOut "main"};

    private _header = _display displayCtrl IDC_MAPVOTE_HEADER;
    private _background = _display displayCtrl IDC_MAPVOTE_BACKGROUND;

    {
      _x ctrlSetFade 1;
      _x ctrlShow false;
      _x ctrlCommit 0.1;
    } foreach ((allControls _display) - [_header, _background]);

    (ctrlPosition _background) params ["_bX", "_bY", "_bW", "_bH"];
    (ctrlPosition _header)     params ["_hX", "_hY", "_hW", "_hH"];

    _background ctrlSetPosition [_bX, _bY, _bW, 0];
    _background ctrlCommit 0.3;

    waitUntil {ctrlCommitted _background};

    _header ctrlSetPosition [_hX, _hY, 0, _hH];
    _header ctrlCommit 0.2;

    waitUntil {ctrlCommitted _header};

    {
      _x ctrlSetFade 1;
      _x ctrlShow false;
      _x ctrlCommit 0;
    } forEach [_header, _background];

    waitUntil {ctrlCommitted _header};


    _background ctrlSetPosition [_bX, _bY, _bW, _bH];
    _header     ctrlSetPosition [_hX, _hY, _hW, _hH];
    _header ctrlCommit 0;
    _background ctrlCommit 0;
  };

  case "update": {
    private _display = findDisplay IDD_MAPVOTE_MENU;

    if (isNull _display) then {breakOut "Main"};

    private _list = _display displayCtrl IDC_MAPVOTE_LISTBOX;
    lbClear _list;

    {
      _x params ["_name"];
      private _text = markerText _name;
      private _pic = ["\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\default_ca.paa", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\danger_ca.paa"] select (_name isEqualTo lastObjPosMarker);

      if (!isNil "_text" && !(_text isEqualTo "")) then {
        _list lbAdd _text;
        _list lbSetData [lbSize _list - 1, _x select 0];
        _list lbSetPicture [lbSize _list - 1, _pic];
        if (_name isEqualTo lastObjPosMarker) then {
          _list lbSetTooltip [lbSize _list - 1, format ["You can not vote for %1 because it was played last round", _text]];
        };
      };
    } forEach markerAreaArray;
  };

  case "vote": {
    if (GVAR(AlreadyVoted)) then {breakOut "main"};

    private _display = findDisplay IDD_MAPVOTE_MENU;
    private _list = _display displayCtrl IDC_MAPVOTE_LISTBOX;
    private _voteButton = _display displayCtrl IDC_MAPVOTE_BTNVOTE;
    _voteButton ctrlEnable false;
    _voteButton ctrlSetToolTip "You have already voted for this round!";

    if (lbCurSel _list <= -1 || roundInProgress || !canChangeClass || !canChangeObjPos || !changeAttackerSide) then {(_voteButton ctrlEnable true) breakOut "main"};
    private _data = _list lbData lbCurSel _list;

    // -- Run a loop to see whether we should add to an existing array or make a new one

    GVAR(AlreadyVoted) = true;
    [_data] remoteExecCall ["ADC_fnc_registerVote", 2];

    publicVariable "ADC_VoteList";
    hint format ["You voted for %1.", markerText _data];

    if (!isNil "ADC_voteDisplayMarkers") then {
      {
        deleteMarkerLocal _x;
      } forEach GVAR(voteDisplayMarkers);
    };

    ["collapse"] spawn FUNC(ME);

    if (isServer) then {
      [] call voteObjPosHandler;
    };
  };


  case "selChanged": {
    private _display = findDisplay IDD_MAPVOTE_MENU;
    private _list = _display displayCtrl IDC_MAPVOTE_LISTBOX;
    private _voteBtn = _display displayCtrl IDC_MAPVOTE_BTNVOTE;

    if (lbCurSel _list <= -1) then {breakOut "main"};

    private _data = _list lbData lbCurSel _list;

    _voteBtn ctrlEnable (!(_data isEqualTo lastObjPosMarker));

    mapAnimAdd [1, 0.1, markerPos _data];
    mapAnimCommit;
  };

  case "markers": {
    private _display = findDisplay IDD_MAPVOTE_MENU;
    waitUntil {!isNull _display};

    private _tick = _display displayCtrl IDC_MAPVOTE_MARKERTICK;
    if (profileNameSpace getVariable ["ADC_showVotePreviewMarkers", true]) then {
      GVAR(voteDisplayMarkers) = [];
      {
        _x params ["_name", ""];

        private _marker = createMarkerLocal [format ["Display_marker%1_%2", _forEachIndex, random 100], markerPos _name];
        _marker setMarkerTypeLocal "mil_marker";
        _marker setMarkerColorLocal "colorYellow";
        _marker setMarkerTextLocal (markerText _name);

        GVAR(voteDisplayMarkers) pushBack _marker;
      } forEach markerAreaArray;

      _tick cbSetChecked true;
    } else {
      if (!isNil "ADC_voteDisplayMarkers") then {
        {
          deleteMarkerLocal _x;
        } forEach GVAR(voteDisplayMarkers);
      };

      _tick cbSetChecked false;
    };
  };

  case "markerTick": {
    profileNameSpace setVariable ["ADC_showVotePreviewMarkers", !(profileNameSpace getVariable ["ADC_showVotePreviewMarkers", true])];
    ["markers"] spawn FUNC(ME);
    saveProfileNameSpace;
  };
};
