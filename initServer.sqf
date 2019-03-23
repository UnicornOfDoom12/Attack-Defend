#include "script_macros.hpp"

/*
*   @File: initServer.sqf
*   @Author: Sig
*
*   Description: Server-side player init (when player joins mission)
*/
"checkForDatabase" addPublicVariableEventHandler
{
	private ["_data"];
	_data = (_this select 1);
	_clientID = (_data select 0);
	_UID = (_data select 1);
	_playerName = (_data select 2);
	_inidbi = ["new", _UID] call OO_INIDBI;
	_fileExist = "exists" call _inidbi;
	_version = "getVersion" call _inidbi;
	systemChat _version;
	if (_fileExist) then
	{
			systemChat "Welcome back to the server, getting your data now";
			null = [_UID, _clientID] execVM "getData.sqf";
	}
	else
	{
		systemChat "Welcome to the server, generating new data for you now";
		_kills = 0;
		_deaths = 0;
		_inidbi = ["new", _UID] call OO_INIDBI;
		_kdratio = 0;
		["write", ["Player Information", "Name", _playerName]] call _inidbi;
		["write", ["Player Information", "UID", _UID]] call _inidbi;
		["write", ["Player Information", "ClientID", _clientID]] call _inidbi;
		["write", ["Player Stats", "Kills", _kills]] call _inidbi;
		["write", ["Player Stats", "Deaths", _deaths]] call _inidbi;
		["write", ["Player Stats", "kdRatio", _kdratio]] call _inidbi;
		["write", ["MK-1", "Kills", _kills]] call _inidbi;
		["write", ["MX-SW", "Kills", _kills]] call _inidbi;
		["write", ["MXM", "Kills", _kills]] call _inidbi;

		["write", ["Spar-16s", "Kills", _kills]] call _inidbi;

		["write", ["Car-95-1", "Kills", _kills]] call _inidbi;

		["write", ["MX-SW", "Kills", _kills]] call _inidbi;

		["write", ["MK-18", "Kills", _kills]] call _inidbi;

		["write", ["MK-14", "Kills", _kills]] call _inidbi;

		_s = "Everyone welcome " + _playerName + " Its his first time on the server";
		_s remoteExec ["systemChat"];
	};
};
"loadDataa" addPublicVariableEventHandler
{
	_data = (_this select 1);
	_UID = (_data select 0);
	_clientID = (_data select 1);
	_inidbi = ["new", _UID] call OO_INIDBI;
	_kills = ["read", ["Player Stats", "Kills", []]] call _inidbi;
	_deaths = ["read", ["Player Stats", "Deaths", []]] call _inidbi;
	_ratio = ["read", ["Player Stats", "kdRatio", []]] call _inidbi;
	if (_deaths >0) then{
		_ratio = _kills / _deaths;
	};
	_killstring = "Kills: " + str (_kills);
	_deathstring = "Deaths: " + str(_deaths);
	_ratiostring = "kdRatio: " + str(_ratio);
	loadData = [_killstring,_deathstring,_ratiostring];
	_clientID publicVariableClient "loadData";

};
"AddKill" addPublicVariableEventHandler
{
	_data = (_this select 1);
	_UID = (_data select 0);
	_weaponName = (_data select 1);
 	_inidbi = ["new", _UID] call OO_INIDBI;
  	_kills = ["read", ["Player Stats", "Kills", []]] call _inidbi;
  	_deathsOfKiller = ["read", ["Player Stats", "Deaths", []]] call _inidbi;
  	_kills = _kills + 1;
  	_kdRatioKiller = 0;
  	["write", ["Player Stats", "Kills", _kills]] call _inidbi;
  	if(_deathsOfKiller > 0)then{
    _kdRatioKiller = _kills / _deathsOfKiller;
  	};
  	["write", ["Player Stats", "kdRatio", _kdRatioKiller]] call _inidbi;
	if (_weaponName == "srifle_DMR_03_F" || _weaponName == "srifle_DMR_03_khaki_F") then{
		_kills = ["read", ["MK-1", "Kills", []]] call _inidbi;
		_kills = _kills + 1;
		["write", ["MK-1", "Kills", _kills]] call _inidbi;
	};
	if (_weaponName == "arifle_MX_SW_black_F" || _weaponName == "arifle_MX_SW_F")then{
		_kills = ["read", ["MX-SW", "Kills", []]] call _inidbi;
		_kills = _kills + 1;
		["write", ["MX_SW", "Kills", _kills]] call _inidbi;
	};
	if (_weaponName == "arifle_MXM_F" || _weaponName == "arifle_MXM_black_F")then{
		_kills = ["read", ["MXM", "Kills", []]] call _inidbi;
		_kills = _kills + 1;
		["write", ["MXM", "Kills", _kills]] call _inidbi;
	};
	if (_weaponName == "arifle_SPAR_02_blk_F") then{
		_kills = ["read", ["Spar-16s", "Kills", []]] call _inidbi;
		_kills = _kills + 1;
		["write", ["Spar-16s", "Kills", _kills]] call _inidbi;
	};
	if (_weaponName == "arifle_CTARS_ghex_F") then{
		_kills = ["read", ["Car-95-1", "Kills", []]] call _inidbi;
		_kills = _kills + 1;
		["write", ["Car-95-1", "Kills", _kills]] call _inidbi;
	};
	if (_weaponName == "srifle_DMR_06_camo_F")then{
		_kills = ["read", ["MK-18", "Kills", []]] call _inidbi;
		_kills = _kills + 1;
		["write", ["MK-18", "Kills", _kills]] call _inidbi;
	};
	if (_weaponName == "srifle_EBR_F")then{
		_kills = ["read", ["MK-14", "Kills", []]] call _inidbi;
		_kills = _kills + 1;
		["write", ["MK-14", "Kills", _kills]] call _inidbi;
	};
	
};
"AddDeath" addPublicVariableEventHandler
{
	_UID2 =(_this select 1);
 	_inidbi2 = ["new", _UID2] call OO_INIDBI;
  	_deaths = ["read", ["Player Stats", "Deaths", []]] call _inidbi2;
  	_deaths = _deaths + 1;
  	["write", ["Player Stats", "Deaths", _deaths]] call _inidbi2;
  	_killsOfKilled = ["read", ["Player Stats", "Kills", []]] call _inidbi2;
  	_kdRatioKilled = _killsOfKilled / _deaths;
  	["write", ["Player Stats", "kdRatio", _kdRatioKilled]] call _inidbi2;
};

private _initStart = diag_tickTime;
diag_log format ["================================ Misson File: %1 ================================", missionName];
diag_log         "                               Initializing Server                               ";
diag_log         "=================================================================================";

waitUntil {!isNil "preInitDone"};
call compile preprocessFileLineNumbers "serverStartConfiguration.sqf";


[] spawn DFUNC(srvWarningInit);
[] spawn DFUNC(capture);
[] spawn DFUNC(roundServer);
[] spawn DFUNC(endHandler);
[] spawn DFUNC(weather);


addMissionEventHandler ["HandleDisconnect", { _this spawn FUNC(handleDisconnect) }];

["Initialize"] call BIS_fnc_dynamicGroups;

private _execTime = diag_tickTime - _initStart;
diag_log         "=================================================================================";
diag_log 				 "=========================== Server Initialization Completed =====================";
diag_log format ["========================== Time: The initialization took %1 =====================", [_execTime, "MM:SS.MS"] call BIS_fnc_secondsToString];
diag_log format	["=================================  Mission: %1 ===============================", missionName];
