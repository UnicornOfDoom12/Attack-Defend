#include "..\..\script_macros.hpp"
#include "ui_macros.hpp"
disableSerialization;
/*
    File: fn_nickNameMenu.sqf
    Author: Sig

    Description: Handles the nick name menu

    Arguments:
      0 <STRING> mode that determines what to do with the menu
      1 <OBJECT> that is being named

    Return: Nothing
*/

if !(params [["_mode", "", [""]], ["_unit", objNull, [objNull]]]) exitWith {};

scopeName "main";
switch (_mode) do {
  case "open": {
    if (!isNull findDisplay IDD_NICKNAME_MENU) then {breakOut "main"};

    createDialog "nickNameMenu";
    waitUntil {!isNull findDisplay IDD_NICKNAME_MENU};
    private _display = findDisplay IDD_NICKNAME_MENU;

    private _header = _display displayCtrl IDC_NICKNAME_HEADER;

    _header ctrlSetText format ["%1's NICKNAME", toUpper(name _unit)];
    uiNameSpace setVariable ["nicknameEditorUnit", _unit];
  };

  case "set": {
    private _display = findDisplay IDD_NICKNAME_MENU;
    if (isNull _display) exitWith {};

    private _edit = _display displayCtrl IDC_NICKNAME_EDIT;
    private _name = ctrlText _edit;
    private _arr = toArray _name;

    if (count _arr < 6) then {
      closeDialog 0;
      _unit setVariable ["shortName", _name];
      hint format ["You have successfully set a new nickname for %1 (%2)", name _unit, _name];
    } else {
      hint "The nickname can not be over 6 characters!";
    };
  };

  case "unLoad": {
    uiNameSpace setVariable ["nickNameEditorUnit", nil];
  };
};
