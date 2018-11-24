#include "..\..\script_macros.hpp"
#include "ui_macros.hpp"
#define ME playerMenu
disableSerialization;
/*
*   @File: fn_playerMenu.sqf
*   @Author: Sig
*
*   Description: Handles the player menu, where the player can select their class and insertion method
*
*   Arguments:
*     0 - Mode                <STRING> defines what to do with the player menu
*     1 - Additional params   <ARRAY>
*
*   Available modes:
*     "onLoad" - Opens the playermenu
*     "comboUpdate" - the listbox with the next class thingys
*     "select" - selects the current selected
*
*   Return:
*     Nothing
*/

scopeName "main";
params [
  ["_mode", "", [""]],
  ["_params", [], [[]]]
];

if (!canChangeClass && !(_mode isEqualTo "close")) exitWith {};

switch (_mode) do {
  case "onLoad": {
    if !(_params params [["_display", displayNull, [displayNull]]]) then {breakOut "main"};
    private _bg = _display displayCtrl IDC_PMENU_BACKGROUND;
    private _header = _display displayCtrl IDC_PMENU_HEADER;
    private _bgSize = ctrlPosition _bg;
    private _headerPos = ctrlPosition _header;


    _bgSize params ["_bX", "_bY", "_bW", "_bH"];
    _headerPos params ["_hX", "_hY", "_hW", "_hH"];

    _bg ctrlSetTextColor [0,0,0,0];
    _bg ctrlSetFade 0;
    _bg ctrlSetPosition [_bx, _by, _bW, 0];
    _bg ctrlCommit 0;

    _header ctrlSetFade 0;
    _header ctrlSetPosition [_hX, _bY, _hW, 0];
    _header ctrlCommit 0;
    _header ctrlSetPosition [_hX, _bY, _hW, _hH];
    _header ctrlCommit 0.05;

    waitUntil {ctrlCommitted _header};

    _header ctrlSetPosition [_hX, _hY, _hW, _hH];
    _header ctrlCommit 0.2;

    _bg ctrlSetPosition [_bX, _bY, _bW, _bH];
    _bg ctrlSetTextColor [TEXT_COLOR];
    _bg ctrlCommit 0.2;

    waitUntil {ctrlCommitted _bg};

    {
      _x ctrlSetFade 0;
      _x ctrlCommit 0.1;
    } forEach (allControls _display);

    private _combo = _display displayCtrl IDC_PMENU_COMBOBOX;
    private _arr = [];

    _arr pushBack ["Classes", 0];
    if ([player] call fnc_isLeaderWithGroup) then {
      _arr pushBack ["Insertion Methods", 1];
    };
    _arr pushBack ["Scopes", 2];
    _arr pushBack ["Online Players", 3];

    if ([] call FUNC(adminLevel) > 0) then {
      _arr pushBack ["Admin Commands", 4];
    };

    {
      _combo lbAdd (_x select 0);
      _combo lbSetValue [(lbSize _combo) - 1, (_x select 1)];
    } forEach _arr;
    _combo lbSetCurSel 0;

    _display displayAddEventHandler ["KeyDown", {if (_this select 1 isEqualTo 1) then {['close'] spawn FUNC(ME); true};}];

    ["comboUpdate"] call FUNC(ME);
  };

  case "comboUpdate": {
    private _display = findDisplay IDD_PLAYERMENU_MAIN;
    private _combo = _display displayCtrl IDC_PMENU_COMBOBOX;
    private _list = _display displayCtrl IDC_PMENU_LISTBOX;
    lbClear _list;
    private _cValue = _combo lbValue lbCurSel _combo;
    private _header = _display displayCtrl IDC_PMENU_HEADER;

    switch (_cValue) do {
      case 0: {
        _header ctrlSetText "SELECT YOUR CLASS";
        private _classes = [aClasses, dClasses] select !(nextAttackerSide isEqualTo playerSide);
        {
          private _wep = (_x select 0) select 0;
          private _name = getText(configFile >> "CfgWeapons" >> _wep >> "displayName");
          private _pic = getText(configFile >> "CfgWeapons" >> _wep >> "picture");

          _list lbAdd _name;
          _list lbSetData [lbSize _list - 1, (str(_x))];
          _list lbSetPicture [lbSize _list - 1, _pic];
          _list lbSetPictureColor [lbSize _list - 1, [1,1,1,0.8]];
        } forEach _classes;
      };

      case 1: {
        _header ctrlSetText "SELECT YOUR INSERTION METHOD";
        private _methods = [[localize "STR_IfritInsertion", 0, "O_MRAP_02_F"], [localize "STR_BoatInsertion",1, "B_Boat_Transport_01_F"], [localize "STR_SubmarineInsertion",2, "B_SDV_01_F"], [localize "STR_OrcaInsertion",3, "O_Heli_Light_02_unarmed_F"]];

        {
          _x params ["_name", "_val", "_class"];
          private _pic = getText(configFile >> "CfgVehicles" >> _class >> "picture");

          _list lbAdd _name;
          _list lbSetPicture [(lbSize _list) - 1, _pic];
          _list lbSetValue [(lbSize _list) - 1, _val];
          _list lbSetPictureColor [lbSize _list - 1, [1,1,1,0.8]];
        } forEach _methods;
      };

      case 2: {
        _header ctrlSetText "SELECT YOUR PREFERED SCOPE";
        private _scopes = ["optic_MRCO", "optic_hamr", "optic_Arco_blk_F"];

        {
          private _name = getText(configFile >> "CfgWeapons" >> _x >> "displayName");
          private _pic = getText(configFile >> "CfgWeapons" >> _x >> "picture");

          _list lbAdd _name;
          _list lbSetData [(lbSize _list) - 1, _x];
          _list lbSetPicture [(lbSize _list) - 1, _pic];
          _list lbSetPictureColor [lbSize _list - 1, [1,1,1,0.8]];
        } forEach _scopes;
      };

      case 3: {
        _header ctrlSetText "ONLINE PLAYER LIST";
        private _players = allUnits - [player];

        {
          if (isPlayer _x) then {
            private _pic = ["\a3\ui_f\data\GUI\Cfg\GameTypes\defend_ca.paa", "\a3\ui_f\data\GUI\Cfg\GameTypes\seize_ca.paa"] select (side _x isEqualTo attackerSide);

            _list lbAdd (name _x);
            _list lbSetPicture [lbSize _list - 1, _pic];
            _list lbSetData [lbSize _list - 1, str(_x)];
            _list lbSetPictureColor [lbSize _list - 1, [[1,0,0,0.8], [0,0.2,1,0.8]] select (side _x isEqualTo WEST)];
            _list lbSetToolTip [lbSize _list - 1, format ["Nickname - %1", GETVAR(_x,"shortName",name _x)]];
          };
        } forEach _players;
      };

      case 4: {
        _header ctrlSetText "ADMIN COMMANDS";
        _array = "[] call ADC_fnc_adminLevel >= getNumber(_x >> 'level') && [] call compile getText(_x >> 'condition')" configClasses (missionConfigFile >> "adminCommands");

        {
          private _displayName = getText(missionConfigFile >> "adminCommands" >> configName _x >> "displayName");
          private _pic = getText(missionConfigFile >> "adminCommands" >> configName _x >> "picture");

          _list lbAdd _displayName;
          _list lbSetData [(lbSize _list) - 1, configName _x];
          if !(_pic isEqualTo "") then {
            _list lbSetPicture [(lbSize _list) - 1, _pic];
          };
        } forEach _array;
      };
    };
  };

  case "select": {
    private _disp = findDisplay IDD_PLAYERMENU_MAIN;
    private _comboVal = (_disp displayCtrl IDC_PMENU_COMBOBOX) lbValue lbCurSel (_disp displayCtrl IDC_PMENU_COMBOBOX);
    private _list = _disp displayCtrl IDC_PMENU_LISTBOX;
    if (lbCurSel _list <= -1) then {breakOut "main"};

    switch (_comboVal) do {
      case 0: {
        private _class = call compile (_list lbData lbCurSel _list);
        if (nextAttackerSide isEqualTo playerSide) then {
          currentAClass = _class;
        } else {
          currentDClass = _class;
        };
        [false] call DFUNC(assignGear);
      };

      case 1: {
        if (leader player isEqualTo player) then {
          private _vals = _list lbValue lbCurSel _list;
          ["", "", "", [_vals]] call DFUNC(pickSpawnAction);

          closeDialog 0;
          openMap true;
        };
      };

      case 2: {
        private _scope = _list lbData lbCurSel _list;
        profileNameSpace setVariable ["ADC_PreferredScope", _scope];
        hint format ["You have selected the %1 scope!", _list lbText lbCurSel _list];
        saveProfileNameSpace;

        [] call DFUNC(defineClasses);

        {
          (_x select 0) set [3, _scope];
        } forEach [currentAClass, currentDClass];
      };

      case 3: {
        private _data = call compile (_list lbData lbCurSel _list);

        if (isNull _data) then {breakOut "main"};

        ["open", _data] spawn FUNC(nickNameMenu);
      };

      case 4: {
        private _data = _list lbData lbCurSel _list;
        private _condition = getText(missionConfigFile >> "adminCommands" >> _data >> "condition");
        private _level = getNumber(missionConfigFile >> "adminCommands" >> _data >> "level");

        if (call compile _condition && [] call FUNC(adminLevel) >= _level) then {
          call compile (getText(missionConfigFile >> "adminCommands" >> _data >> "action"));
          ["close"] spawn FUNC(ME);
        };
      };
    };
  };

  case "close": {
    private _display = findDisplay IDD_PLAYERMENU_MAIN;
    if (isNull _display) then {breakOut "main"};
    private _header = _display displayCtrl IDC_PMENU_HEADER;
    private _bg = _display displayCtrl IDC_PMENU_BACKGROUND;
    private _ctrls = (allControls _display) - [_header, _bg];
    private _combo = _display displayCtrl IDC_PMENU_COMBOBOX;

    (ctrlPosition _bg) params ["_bX", "_bY", "_bW", "_bH"];
    (ctrlPosition _header) params ["_hX", "_hY", "_hW", "_hH"];

    _header ctrlSetTextColor [0,0,0,0];
    _header ctrlCommit 0.1;
    {
      _x ctrlSetFade 1;
      _x ctrlCommit 0.05;
    } forEach _ctrls;

    _header ctrlSetPosition [_hX, _bY, _hW, 0];
    _bg ctrlSetPosition [_bX, _bY, _bW, 0];
    _bg ctrlCommit 0.2;
    _header ctrlCommit 0.2;

    waitUntil {ctrlCommitted _header};
    closeDialog 0;
  };
};
