private ["_group", "_i", "_units", "_unitsCount", "_varName", "_deleteTime", "_locked"];
{
	_group = _x;
	if (!(isNull _group)) then
	{
		if ((count (units _group)) == 0) then
		{
			_deleteTime = _group getVariable "deleteTime";
			if (isNil "_deleteTime") then
			{
				_deleteTime = time + 10;
				_group setVariable ["deleteTime", _deleteTime];
			};
			if (_deleteTime > time) then
			{
				deleteGroup _group;
			};
		};
	};
} forEach allGroups;
