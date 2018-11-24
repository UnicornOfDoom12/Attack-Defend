private ["_params", "_leader", "_oldGroup", "_group", "_bJoined"];

_params = _this select 3;
_leader = _params select 0;
_group = _params select 1;

_oldGroup = group player;

_bJoined = false;

if
(
	(!(isNull _leader))
	&&
	(!(isNull _group))
) then
{
	if
	(
		(_leader in (units _group))
		&&
		(_leader == ([_group] call fnc_getLeader))
		&&
		(_group getVariable ["isGroupUnlocked", true])
	) then
	{
		isJoining = true;
		isGroupLeader = false;
		//[player] joinSilent _group;
		[player] join _group;
		[] call fnc_groupCancel;
		waitUntil {group player != _oldGroup};
		if ((!(isNull _oldGroup)) && (count (units _oldGroup)) == 0) then
		{
			deleteGroup _oldGroup;
		};
		_bJoined = true;
		isJoining = false;
	}
};
if (!_bJoined) then
{
	hint localize "STR_GroupUnavailable";
	[] call fnc_groupRefresh;
};