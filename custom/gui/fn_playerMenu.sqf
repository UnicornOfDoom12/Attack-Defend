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
[] call DFUNC(defineClasses);
if (!canChangeClass && !(_mode isEqualTo "close")) exitWith {};
_Var = 0.1;
switch (_mode) do {
  case "onLoad": {
    if !(_params params [["_display", displayNull, [displayNull]]]) then {breakOut "main"};
    private _bg = _display displayCtrl IDC_PMENU_BACKGROUND;
    private _header = _display displayCtrl IDC_PMENU_HEADER;
    private _bgSize = ctrlPosition _bg;
    private _headerPos = ctrlPosition _header;
    _bgSize params ["_bX", "_bY", "_bW", "_bH"];
    _headerPos params ["_hX", "_hY", "_hW", "_hH"];
    _hW = _hW + _Var;
    _bW = _bW + _Var;
    _bg ctrlSetTextColor [0,0,0,0];
    _bg ctrlSetFade 0;
    _bg ctrlSetPosition [_bx, _by, _bW, 0];
    _bg ctrlCommit 0;

    _header ctrlSetFade 0;
    _header ctrlSetPosition [_hX, _bY, _hW, 0];
    _header ctrlCommit 0;
    _header ctrlSetPosition [_hX, _bY, _hW ,_hH];
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
    _arr pushBack ["Player Statistics",5];
    _arr pushBack ["Challenges",6];
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
        private _methods = [[localize "STR_IfritInsertion", 0, "O_MRAP_02_F"], [localize "STR_BoatInsertion",1, "B_Boat_Transport_01_F"], [localize "STR_SubmarineInsertion",2, "B_SDV_01_F"], [localize "STR_OrcaInsertion",3, "O_Heli_Light_02_unarmed_F"],[localize "STR_ProwlerInsertion",4,"B_LSV_01_unarmed_black_F"],[localize "STR_RandomVehicleInsertion",5,"C_Kart_01_F"]];

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
        private _scopes = ["optic_MRCO", "optic_hamr", "optic_Arco_blk_F","optic_ERCO_blk_F","optic_ico_01_f"];
        _UID = getPlayerUID player;
        _clientID = clientOwner;
        LoadDataForChallenges = [_UID,_clientID];
        publicVariableServer "LoadDataForChallenges";
        _data = StatsForChallenge;
        if ((_data select 0) >= 10)then{ // 10 kills
          _scopes append ["optic_Aco"];
        };
        if ((_data select 0) >= 50)then{ // 25 kills
          _scopes append ["optic_ACO_grn"];
        };
        if ((_data select 0) >= 90)then{ // 90 kills
          _scopes append ["optic_Aco_smg"];
        };
        if ((_data select 0) >= 80)then{ // 80 kills
          _scopes append ["optic_ACO_grn_smg"];
        };
        if ((_data select 0) >= 70)then{ // 70 kills
          _scopes append ["optic_Holosight_smg"];
        };
        if ((_data select 0) >= 60)then{ // 60 kills
          _scopes append ["optic_Holosight"];
        };
        if ((_data select 0) >= 100)then{ // 100 kills
          _scopes append ["optic_DMS"];
        };           
        {
          private _name = getText(configFile >> "CfgWeapons" >> _x >> "displayName");
          private _pic = getText(configFile >> "CfgWeapons" >> _x >> "picture");
          if(_x isEqualTo "optic_ico_01_f")then{
            _name = _name + " (Requires a Promet)";
          };
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
        _header ctrlSetText "ADMIN COMMANDS (Checkbox Test)";
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
      case 5: {
        _header ctrlSetText "Player statistics";
        _UID = getPlayerUID player;
        _clientID = clientOwner;
        loadDataForPlayerMenu = [_UID,_clientID];
        publicVariableServer "loadDataForPlayerMenu";
        _name = name player;
        _name = "Statistics for " + _name;
        _list lbAdd _name;
        _array = StatsArray;
        {
          private _displayName = _array select _forEachIndex;
          _list lbAdd _displayName;

        } forEach _array;
        
      };
      case 6: {
        _header ctrlSetText "Challenges";
        _array = ["Get 10 Kills","Get 20 Kills","Get 30 Kills","Get 40 Kills","Get 50 Kills","Get 60 Kills","Get 70 Kills","Get 80 Kills","Get 90 Kills","Get 100 Kills"];
        _MK1Array = ["10 Kills: MK-1","75 Kills: MK-1"];
        _MX_SWArray = ["10 Kills: MX_SW", "25 Kills: MX_SW"];
        _MXMArray = ["10 Kills: MXM", "25 Kills: MXM"];
        _Spar16sCar95 = ["10 Kills: Spar16s/Car95-1","25 Kills: Spar16s-Car95-1"];
        _LPAR = ["10 Kills:(5.45-5.8)Assault Rifles","25 Kills:(5.45-5.8) Assault Rifles"];
        _HPAR = ["10 Kills:(6.5-7.62) Assault Rifles","25 Kills:(6.5-7.62) Assault Rifles"];
        _MR = ["10 Kills: Marksman Rifles","75 Kills: Marksman Rifles"];
        _SMG = ["25 Kills: any SMG"];
        _UID = getPlayerUID player;
        _clientID = clientOwner;
        LoadDataForChallenges = [_UID,_clientID];
        publicVariableServer "LoadDataForChallenges";
        _data = StatsForChallenge;
        _Count = 0;
        _displayName = _array select 0;
        if ((_data select 0) >= 10) then {
            _displayName = _displayName + " [Completed]";
            _list lbAdd _displayName;
            _list lbSetTooltip [_Count,"Unlocks ACO"];
            _Count = _Count + 1;
            _displayName = _array select 1;
    
            if ((_data select 0) >= 20)then{
              _displayName = _displayName + " [Completed]";
              _list lbAdd _displayName;
              _list lbSetTooltip [_Count,"Unlocks Combat Helmet"];
              _Count = _Count + 1;
              _displayName = _array select 2;
              
              if ((_data select 0) >= 30)then{
                _displayName = _displayName + " [Completed]";
                _list lbAdd _displayName;
                _list lbSetTooltip [_Count,"Unlocks Stealth Suit"];
                _Count = _Count + 1;
                _displayName = _array select 3;
                if ((_data select 0) >= 40)then{
                  _displayName = _displayName + " [Completed]";
                  _list lbAdd _displayName;
                  _list lbSetTooltip [_Count,"Unlocks Enhanced Combat helmet"];
                  _Count = _Count + 1;
                  _displayName = _array select 4;
                  if ((_data select 0) >= 50)then{
                    _displayName = _displayName + " [Completed]";
                    _list lbAdd _displayName;
                    _list lbSetTooltip [_Count,"Unlocks ACO green"];
                    _Count = _Count + 1;
                    _displayName = _array select 5;
                    if ((_data select 0) >= 60)then{
                      _displayName = _displayName + " [Completed]";
                      _list lbAdd _displayName;
                      _list lbSetTooltip [_Count,"Unlocks Holo sight"];
                      _Count = _Count + 1;
                      _displayName = _array select 6;
                      if ((_data select 0) >= 70)then{
                        _displayName = _displayName + " [Completed]";
                        _list lbAdd _displayName;
                        _list lbSetTooltip [_Count,"Unlocks Holo sight smg"];
                        _Count = _Count + 1;
                        _displayName = _array select 7;
                        if ((_data select 0) >= 80)then{
                          _displayName = _displayName + " [Completed]";
                          _list lbAdd _displayName;
                          _list lbSetTooltip [_Count,"Unlocks ACO SMG green"];
                          _Count = _Count + 1;
                          _displayName = _array select 8;
                          if ((_data select 0) >= 90)then{
                            _displayName = _displayName + " [Completed]";
                            _list lbAdd _displayName;
                            _list lbSetTooltip [_Count,"Unlocks ACO SMG"];
                            _Count = _Count + 1;
                            _displayName = _array select 9;
                            if ((_data select 0) >= 100)then{
                              _displayName = _displayName + " [Completed]";
                              _list lbAdd _displayName;
                              _list lbSetTooltip [_Count,"DMS scope"];
                              _Count = _Count + 1;
                            }else{
                              _list lbAdd _displayName;
                              _list lbSetTooltip [_Count,"DMS scope"];
                              _Count = _Count + 1;
                            };
                          }else{
                            _list lbAdd _displayName;
                            _list lbSetTooltip [_Count,"Unlocks ACO SMG"];
                            _Count = _Count + 1;
                          };
                        }else{
                          _list lbAdd _displayName;
                          _list lbSetTooltip [_Count,"Unlocks ACO SMG green"];
                          _Count = _Count + 1;
                        };
                      }else{
                        _list lbAdd _displayName;
                        _list lbSetTooltip [_Count,"Unlocks Holo sight smg"];
                        _Count = _Count + 1;
                      };
                    }else{
                      _list lbAdd _displayName;
                      _list lbSetTooltip [_Count,"Unlocks Holo sight"];
                      _Count = _Count + 1;
                    };
                  }else{
                    _list lbAdd _displayName;
                    _list lbSetTooltip [_Count,"Unlocks ACO green"];
                    _Count = _Count + 1;
                  };
                }else{
                  _list lbAdd _displayName;
                  _list lbSetTooltip [_Count,"Unlocks Enhanced Combat helmet"];
                  _Count = _Count + 1;
                };
              }else{
                _list lbAdd _displayName;
                _list lbSetTooltip [_Count,"Unlocks Stealth Suit"];
                _Count = _Count + 1;
              };
            }else{
              _list lbAdd _displayName;
              _list lbSetTooltip [_Count,"Unlocks Combat Helmet"];
              _Count = _Count + 1;
            };

        }else{
          _list lbAdd _displayName;
          _list lbSetTooltip [_Count,"Unlocks ACO"];
          _Count = _Count + 1;
        };
        _displayName = _MK1Array select 0;
        if ((_data select 3) >= 10)then{
          _displayName = _displayName + " [Completed]";
          _list lbAdd _displayName;
          _list lbSetTooltip [_Count,"Unlocks Bipod for MK-1"];
          _Count = _Count + 1;
          _displayName = _MK1Array select 1;
          if((_data select 3) >= 75)then{
            _displayName = _displayName + " [Completed]";
            _list lbAdd _displayName;
          _list lbSetTooltip [_Count,"Unlocks Supressor for MK-1"];
          _Count = _Count + 1;
          }else{
            _list lbAdd _displayName;
            _list lbSetTooltip [_Count,"Unlocks Supressor for MK-1"];
            _Count = _Count + 1;
          };
        }else{
          _list lbAdd _displayName;
          _list lbSetTooltip [_Count,"Unlocks Bipod for MK-1"];
          _Count = _Count + 1;
        };
        _displayName = _MX_SWArray select 0;
        if ((_data select 4) >= 10)then{
          _displayName = _displayName + " [Completed]";
          _list lbAdd _displayName;
          _list lbSetTooltip [_Count,"Unlocks Bipod for MX-SW"];
          _Count = _Count + 1;
          _displayName = _MX_SWArray select 1;
          if((_data select 4) >= 25)then{
            _displayName = _displayName + " [Completed]";
            _list lbAdd _displayName;
            _list lbSetTooltip [_Count,"Unlocks Supressor for MX-SW"];
            _Count = _Count + 1;
          }else{
            _list lbAdd _displayName;
            _list lbSetTooltip [_Count,"Unlocks Supressor for MX-SW"];
            _Count = _Count + 1;
          };
        }else{
          _list lbAdd _displayName;
          _list lbSetTooltip [_Count,"Unlocks Bipod for MX-SW"];
          _Count = _Count + 1;
        };
        _displayName = _MXMArray select 0;
        if ((_data select 5) >= 10)then{
          _displayName = _displayName + " [Completed]";
          _list lbAdd _displayName;
          _list lbSetTooltip [_Count,"Unlocks Bipod for MXM"];
          _Count = _Count + 1;
          _displayName = _MXMArray select 1;
          if((_data select 5) >= 25)then{
            _displayName = _displayName + " [Completed]";
            _list lbAdd _displayName;
            _list lbSetTooltip [_Count,"Unlocks Supressor for MXM"];
            _Count = _Count + 1;
          }else{
            _list lbAdd _displayName;
            _list lbSetTooltip [_Count,"Unlocks Supressor for MXM"];
            _Count = _Count + 1;
          };
        }else{
          _list lbAdd _displayName;
          _list lbSetTooltip [_Count,"Unlocks Bipod for MXM"];
          _Count = _Count + 1;
        };
        _displayName = _Spar16sCar95 select 0;
        if ((_data select 6) >= 10)then{
          _displayName = _displayName + " [Completed]";
          _list lbAdd _displayName;
          _list lbSetTooltip [_Count,"Unlocks Bipod for Spar16s"];
          _Count = _Count + 1;
          _displayName = _Spar16sCar95 select 1;
          if((_data select 6) >= 25)then{
            _displayName = _displayName + " [Completed]";
            _list lbAdd _displayName;
            _list lbSetTooltip [_Count,"Unlocks Supressor for Car95-1 and Spar16s"];
            _Count = _Count + 1;
          }else{
            _list lbAdd _displayName;
            _list lbSetTooltip [_Count,"Unlocks Supressor for Car95-1 and Spar16s"];
            _Count = _Count + 1;
          };
        }else{
          _list lbAdd _displayName;
          _list lbSetTooltip [_Count,"Unlocks Bipod for Spar16s"];
          _Count = _Count + 1;
        };
        _displayName = _LPAR select 0;
        if ((_data select 7) >= 10)then{
          _displayName = _displayName + " [Completed]";
          _list lbAdd _displayName;
          _list lbSetTooltip [_Count,"Unlocks Bipod for (5.56 to 5.8) Rifles"];
          _Count = _Count + 1;
          _displayName = _LPAR select 1;
          if((_data select 7) >= 25)then{
            _displayName = _displayName + " [Completed]";
            _list lbAdd _displayName;
            _list lbSetTooltip [_Count,"Unlocks Supressor for (5.56 to 5.8) Rifles"];
            _Count = _Count + 1;
          }else{
            _list lbAdd _displayName;
            _list lbSetTooltip [_Count,"Unlocks Supressor for (5.56 to 5.8) Rifles"];
            _Count = _Count + 1;
          };
        }else{
          _list lbAdd _displayName;
          _list lbSetTooltip [_Count,"Unlocks Bipod for (5.56 to 5.8) Rifles"];
          _Count = _Count + 1;
        };
        _displayName = _MR select 0;
        if ((_data select 7) >= 10)then{
          _displayName = _displayName + " [Completed]";
          _list lbAdd _displayName;
          _list lbSetTooltip [_Count,"Unlocks Bipod for Marksman Rifles"];
          _Count = _Count + 1;
          _displayName = _MR select 1;
          if((_data select 7) >= 75)then{
            _displayName = _displayName + " [Completed]";
            _list lbAdd _displayName;
            _list lbSetTooltip [_Count,"Unlocks Supressor for Marksman Rifles"];
            _Count = _Count + 1;
          }else{
            _list lbAdd _displayName;
            _list lbSetTooltip [_Count,"Unlocks Supressor for Marksman Rifles"];
            _Count = _Count + 1;
          };
        }else{
          _list lbAdd _displayName;
          _list lbSetTooltip [_Count,"Unlocks Bipod for Marksman Rifles"];
          _Count = _Count + 1;
        };
        _displayName = _SMG select 0;
        if ((_data select 8) >= 10)then{
          _displayName = _displayName + " [Completed]";
          _list lbAdd _displayName;
          _list lbSetTooltip [_Count,"Unlocks Supressor for SMGs"];
          _Count = _Count + 1;
        }else{
          _list lbAdd _displayName;
          _list lbSetTooltip [_Count,"Unlocks Supressor for SMGs"];
          _Count = _Count + 1;
        };
        _displayName = _HPAR select 0;
        if ((_data select 9) >= 10)then{
          _displayName = _displayName + " [Completed]";
          _list lbAdd _displayName;
          _list lbSetTooltip [_Count,"Unlocks bipods for (6.5-7.62) Assault Rifles"];
          _Count = _Count + 1;
          _displayName = _HPAR select 1;
          if((_data select 9) >= 25)then{
            _displayName = _displayName + " [Completed]";
            _list lbAdd _displayName;
            _list lbSetTooltip [_Count,"Unlocks Supressors for (6.5-7.62) Assault Rifles"];
            _Count = _Count + 1;
          }else{
            _list lbAdd _displayName;
            _list lbSetTooltip [_Count,"Unlocks Supressors for (6.5-7.62) Assault Rifles"];
            _Count = _Count + 1;
          };
        }else{
          _list lbAdd _displayName;
          _list lbSetTooltip [_Count,"Unlocks bipods for (6.5-7.62) Assault Rifles"];
          _Count = _Count + 1;
        };

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
