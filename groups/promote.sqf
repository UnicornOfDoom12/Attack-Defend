private ["_params", "_newLeader", "_nameStr"];
_params = _this select 3;
_newLeaderVarName = _params select 0;

_newLeader = missionNameSpace getVariable [_newLeaderVarName, objNull];

if (_newLeader in (units (group player))) then
{
	isGroupLeader = false;
	(group player) setVariable ["groupLeader", _newLeaderVarName, true];
}
else
{
	_nameStr = "";
	if (!(isNull _newLeader)) then
	{
		_nameStr = format [" %1", name _newLeader];
	};
	hint format ["%1 %2", format [localize "STR_CannotPromote", _nameStr], localize "STR_PlayerHasLeft"];
};

[] call fnc_groupCancel;