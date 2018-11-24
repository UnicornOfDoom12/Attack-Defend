private ["_group", "_varName", "_leader"];

_group = _this select 0;

_leader = objNull;

_varName = _group getVariable "groupLeader";

if (!(isNil "_varName")) then
{
	if (_varName != "") then
	{
		_leader = missionNameSpace getVariable [_varName, objNull];
	};
};

_leader