private ["_group", "_needsLeader", "_leader"];
_group = _this select 0;
_needsLeader = true;
_leader = [_group] call fnc_getLeader;
if (!(isNull _leader)) then
{
	if (_leader in (units _group)) then
	{
		_needsLeader = false;
	};
};
_needsLeader