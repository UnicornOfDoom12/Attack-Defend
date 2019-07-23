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
	_UID = _UID + "AD";
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
		["write", ["Player Stats", "Kills", _kills]] call _inidbi;
		["write", ["Player Stats", "Deaths", _deaths]] call _inidbi;
		["write", ["Player Stats", "kdRatio", _kdratio]] call _inidbi;
		["write", ["MK-1", "Kills", _kills]] call _inidbi;
		["write", ["MX_SW", "Kills", _kills]] call _inidbi;
		["write", ["MXM", "Kills", _kills]] call _inidbi;
		["write", ["Spar-16s/Car95-1", "Kills", _kills]] call _inidbi;
		["write", ["(5.45-5.8) Assault Rifles", "Kills", _kills]] call _inidbi;
		["write", ["Marksman Rifle", "Kills", _kills]] call _inidbi;
		["write", ["SMGs", "Kills", _kills]] call _inidbi;
		["write", ["(6.5-7.62) Assault Rifles", "Kills", _kills]] call _inidbi;
		systemChat "Finished With Data gen";
		_s = "Everyone welcome " + _playerName + " Its his first time on the server";
		_s remoteExec ["systemChat"];
	};
};
"loadDataa" addPublicVariableEventHandler
{
	_data = (_this select 1);
	_UID = (_data select 0);
	_UID = _UID + "AD";
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
	_UID = _UID + "AD";
	_clientID = (_data select 1);
	_inidbi = ["new", _UID] call OO_INIDBI;
	_Name = ["read", ["Player Information", "Name", []]] call _inidbi;
	_kills = ["read", ["Player Stats", "Kills", []]] call _inidbi;
	_deaths = ["read", ["Player Stats", "Deaths", []]] call _inidbi;
	_ratio = ["read", ["Player Stats", "kdRatio", []]] call _inidbi;
	_Mk1 = ["read", ["MK-1", "Kills", []]] call _inidbi;
	_MXSW = ["read", ["MX_SW", "Kills", []]] call _inidbi;
	_MXM = ["read", ["MXM", "Kills", []]] call _inidbi;
	_Spar16 = ["read", ["Spar-16s/Car95-1", "Kills", []]] call _inidbi;
	_LPAR = ["read", ["(5.45-5.8) Assault Rifles", "Kills", []]] call _inidbi;
	_MR = ["read", ["Marksman Rifle", "Kills", []]] call _inidbi;
	_SMG = ["read", ["SMGs", "Kills", []]] call _inidbi;
	_HPAR = ["read", ["(6.5-7.62) Assault Rifles", "Kills", []]] call _inidbi;
	if (_deaths >0) then{
		_ratio = _kills / _deaths;
	};
	_killstring = "Kills: " + str (_kills);
	_deathstring = "Deaths: " + str(_deaths);
	_ratiostring = "kdRatio: " + str(_ratio);
	_mk1string = "MK-1 Kills: " + str (_Mk1);
	_mxswstring = "MX-SW Kills: " + str(_MXSW);
	_mxmstring = "MXM Kills: " + str(_MXM);
	_Spar16string = "Spar-16s/Car95-1 Kills: " + str (_Spar16);
	_LPARString = "(5.45-5.8) Rifle Kills: " + str(_LPAR);
	_MRString = "Marksman Rifle Kills: " + str(_MR);
	_SMGString = "SMG kills: " + str (_SMG);
	_HPARString = "(6.5-7.62) Assault Rifle Kills:" + str (_HPAR);
	StatsArray = [_killstring,_deathstring,_ratiostring,_mk1string,_mxswstring,_mxmstring,_Spar16string,_LPARString,_MRString,_SMGString,_HPARString];
	_clientID publicVariableClient "StatsArray";
};
"LoadDataForChallenges" addPublicVariableEventHandler
{

	_data = (_this select 1);
	_UID =(_data select 0);
	_UID = _UID + "AD";
	_clientID = (_data select 1);
	_inidbi = ["new", _UID] call OO_INIDBI;
	_kills = ["read", ["Player Stats", "Kills", []]] call _inidbi;
	_deaths = ["read", ["Player Stats", "Deaths", []]] call _inidbi;
	_ratio = ["read", ["Player Stats", "kdRatio", []]] call _inidbi;
	_Mk1 = ["read", ["MK-1", "Kills", []]] call _inidbi;
	_MXSW = ["read", ["MX_SW", "Kills", []]] call _inidbi;
	_MXM = ["read", ["MXM", "Kills", []]] call _inidbi;
	_Spar16 = ["read", ["Spar-16s/Car95-1", "Kills", []]] call _inidbi;
	_LPAR = ["read", ["(5.45-5.8) Assault Rifles", "Kills", []]] call _inidbi;
	_MR = ["read", ["Marksman Rifle", "Kills", []]] call _inidbi;
	_SMG = ["read", ["SMGs", "Kills", []]] call _inidbi;
	_HPAR = ["read", ["(6.5-7.62) Assault Rifles", "Kills", []]] call _inidbi;
	StatsForChallenge = [_kills,_deaths,_ratio,_Mk1,_MXSW,_MXM,_Spar16,_LPAR,_MR,_SMG,_HPAR];
	_clientID publicVariableClient "StatsForChallenge";
};
"AddKill" addPublicVariableEventHandler
{
	_data = (_this select 1);
	_UID = (_data select 0);
	_UID = _UID + "AD";
	_weaponName = (_data select 1);
	//systemChat str(_UID);
	//systemChat _weaponName;
	//_a = "adddd";
	//_a remoteExec ["systemChat"];
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
		_kills = ["read", ["MX_SW", "Kills", []]] call _inidbi;
		_kills = _kills + 1;
		["write", ["MX_SW", "Kills", _kills]] call _inidbi;
	};
	if (_weaponName == "arifle_MXM_F" || _weaponName == "arifle_MXM_black_F")then{
		_kills = ["read", ["MXM", "Kills", []]] call _inidbi;
		_kills = _kills + 1;
		["write", ["MXM", "Kills", _kills]] call _inidbi;
	};
	if (_weaponName == "arifle_SPAR_02_blk_F" || _weaponName == "arifle_CTARS_ghex_F" ) then{
		_kills = ["read", ["Spar-16s/Car95-1", "Kills", []]] call _inidbi;
		_kills = _kills + 1;
		["write", ["Spar-16s/Car95-1", "Kills", _kills]] call _inidbi;
	};
	if (_weaponName == "arifle_Mk20_plain_F" || _weaponName == "arifle_TRG21_F" || _weaponName == "arifle_AKS_F" || _weaponName == "arifle_CTAR_ghex_F" || _weaponName == "arifle_SPAR_01_blk_F") then{
		_kills = ["read", ["(5.45-5.8) Assault Rifles", "Kills", []]] call _inidbi;
		_kills = _kills + 1;
		["write", ["(5.45-5.8) Assault Rifles", "Kills", _kills]] call _inidbi;
	};
	if (_weaponName == "srifle_EBR_F" || _weaponName == "arifle_SPAR_03_blk_F" || _weaponName == "srifle_DMR_06_camo_F")then{
		_kills = ["read", ["Marksman Rifle", "Kills", []]] call _inidbi;
		_kills = _kills + 1;
		["write", ["Marksman Rifle", "Kills", _kills]] call _inidbi;
	};
	if (_weaponName == "SMG_01_F" || _weaponName == "SMG_05_F" || _weaponName == "hgun_PDW2000_F" || _weaponName == "SMG_03_TR_black")then{
		_kills = ["read", ["SMGs", "Kills", []]] call _inidbi;
		_kills = _kills + 1;
		["write", ["SMGs", "Kills", _kills]] call _inidbi;
	};
	if (_weaponName == "arifle_Katiba_F" || _weaponName == "arifle_MX_Black_F" || _weaponName == "arifle_AK12_F" || _weaponName == "arifle_ARX_blk_F" || _weaponName == "arifle_ARX_ghex_F")then{
		_kills = ["read", ["(6.5-7.62) Assault Rifles", "Kills", []]] call _inidbi;
		_kills = _kills + 1;
		["write", ["(6.5-7.62) Assault Rifles", "Kills", _kills]] call _inidbi;
	};	
};
"AddDeath" addPublicVariableEventHandler
{
	_UID2 =(_this select 1);
	_UID2 = _UID2 + "AD";
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

DefaultOptions = [true,true,true,true,true,false,false,false,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true];
publicVariable "DefaultOptions";

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


