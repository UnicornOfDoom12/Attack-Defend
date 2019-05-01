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
	//_v = "Inside the check event handler for" + _playerName;
	//_v remoteExec ["systemChat"];
	if (_fileExist) then
	{
			systemChat "Welcome back to the server, getting your data now";
			null = [_UID, _clientID] execVM "getData.sqf";
	}
	else
	{
		//"Welcome to the server, generating new data for you now" remoteExec ["systemChat"];
		_kills = 0;
		_deaths = 0;
		_inidbi = ["new", _UID] call OO_INIDBI;
		_kdratio = 0;
		//_v = "Attempting new data gen";
		//_v remoteExec ["systemChat"];
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
		systemChat "Finished With Data gen";
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
"loadDataForPlayerMenu" addPublicVariableEventHandler
{
	_data = (_this select 1);
	_UID = (_data select 0);
	_clientID = (_data select 1);
	_inidbi = ["new", _UID] call OO_INIDBI;
	_Name = ["read", ["Player Information", "Name", []]] call _inidbi;
	_kills = ["read", ["Player Stats", "Kills", []]] call _inidbi;
	_deaths = ["read", ["Player Stats", "Deaths", []]] call _inidbi;
	_ratio = ["read", ["Player Stats", "kdRatio", []]] call _inidbi;
	_Mk1 = ["read", ["MK-1", "Kills", []]] call _inidbi;
	_MXSW = ["read", ["MX-SW", "Kills", []]] call _inidbi;
	_MXM = ["read", ["MXM", "Kills", []]] call _inidbi;
	_Spar16 = ["read", ["Spar-16s", "Kills", []]] call _inidbi;
	_car95 = ["read", ["Car-95-1", "Kills", []]] call _inidbi;
	_MK18 = ["read", ["MK-18", "Kills", []]] call _inidbi;
	_MK14 = ["read", ["MK-14", "Kills", []]] call _inidbi;
	if (_deaths >0) then{
		_ratio = _kills / _deaths;
	};
	_killstring = "Kills: " + str (_kills);
	_deathstring = "Deaths: " + str(_deaths);
	_ratiostring = "kdRatio: " + str(_ratio);
	_mk1string = "MK-1 Kills: " + str (_Mk1);
	_mxswstring = "MX-SW Kills: " + str(_MXSW);
	_mxmstring = "MXM Kills: " + str(_MXM);
	_Spar16string = "Spar-16s Kills: " + str (_Spar16);
	_Car95String = "Car95 Kills: " + str(_car95);
	_mk14string = "MK-18 Kills: " + str(_MK18);
	_mk18string = "MK-14 Kills: " + str (_MK14);

	StatsArray = [_killstring,_deathstring,_ratiostring,_mk1string,_mxswstring,_mxmstring,_Spar16string,_Car95string,_mk14string,_mk18string];
	publicVariable "StatsArray";
};
"LoadDataForChallenges" addPublicVariableEventHandler
{
	_data = (_this select 1);
	_UID =(_data select 0);
	_clientID = (_data select 1);
	_inidbi = ["new", _UID] call OO_INIDBI;
	_kills = ["read", ["Player Stats", "Kills", []]] call _inidbi;
	_deaths = ["read", ["Player Stats", "Deaths", []]] call _inidbi;
	_ratio = ["read", ["Player Stats", "kdRatio", []]] call _inidbi;
	_Mk1 = ["read", ["MK-1", "Kills", []]] call _inidbi;
	_MXSW = ["read", ["MX-SW", "Kills", []]] call _inidbi;
	_MXM = ["read", ["MXM", "Kills", []]] call _inidbi;
	_Spar16 = ["read", ["Spar-16s", "Kills", []]] call _inidbi;
	_car95 = ["read", ["Car-95-1", "Kills", []]] call _inidbi;
	_MK18 = ["read", ["MK-18", "Kills", []]] call _inidbi;
	_MK14 = ["read", ["MK-14", "Kills", []]] call _inidbi;
	StatsForChallenge = [_kills,_deaths,_ratio,_Mk1,_MXSW,_MXM,_Spar16,_car95,_MK18,_MK14];
	publicVariable "StatsForChallenge"

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
	if (_weaponName == "srifle_EBR_F")then{
		_kills = ["read", ["MK-18", "Kills", []]] call _inidbi;
		_kills = _kills + 1;
		["write", ["MK-18", "Kills", _kills]] call _inidbi;
	};
	if (_weaponName == "srifle_DMR_06_camo_F")then{
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
