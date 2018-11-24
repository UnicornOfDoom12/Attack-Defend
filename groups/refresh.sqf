private ["_playerActionsCount", "_group", "_groupName", "_units", "_leader", "_maxi", "_action", "_i"];

// Remove old actions
[] call fnc_groupCancel;

// Add basic actions

_action = player addAction [localize "STR_CancelGroupMenu", "groups\cancel.sqf", [], 12, true, true, "", "true"];
playerActions = [_action];

_action = player addAction [format ["<t color='#ff0000'>%1</t>", localize "STR_LockGroup"], "groups\lock.sqf", [false], 11, true, false, "", "isGroupLeader && ((group player) getVariable ['isGroupUnlocked', true])"];
playerActions set [1, _action];

_action = player addAction [format ["<t color='#00ff00'>%1</t>", localize "STR_UnlockGroup"], "groups\lock.sqf", [true], 11, true, false, "", "isGroupLeader && (!((group player) getVariable ['isGroupUnlocked', true]))"];
playerActions set [2, _action];

_action = player addAction [format ["<t color='#ff0000'>%1</t>", localize "STR_LeaveGroup"], "groups\leave.sqf", [], 11, true, false, "", "(count (units (group player))) > 1"];
playerActions set [3, _action];

_playerActionsCount = 4;


// Add group joining actions

{
	_group = _x;
	if ((side _group == playerSide) && (_group != (group player))) then
	{
		_leader = [_group] call fnc_getLeader;
		if ((!(isNull _leader)) && (_group getVariable ["isGroupUnlocked", true]) && ((count (units _group)) > 0)) then
		{
			_groupName = [name _leader] call fnc_cleanName;

			_units = (units _group) - [_leader];
			_maxi = count _units;
			if (_maxi > 0) then
			{
				_groupName = _groupName + " (";
				for "_i" from 0 to (_maxi-1) do
				{
					_groupName = _groupName + name (_units select _i);
					if (_i != _maxi-1) then
					{
						_groupName = _groupName + " ";
					};
				};
				_groupName = _groupName + ")";
			};
			_action = player addAction [format ["<t color='#00bfff'>%1</t>", format [localize "STR_Join", _groupName]], "groups\join.sqf", [_leader, _group], 10, true, true, "", "true"];
			playerActions set [_playerActionsCount, _action];
			_playerActionsCount = _playerActionsCount +1;
		};
	};
} forEach allGroups;


// Add kick and promote actions

if (isGroupLeader && ((count (units (group player))) > 1)) then
{
	_action = player addAction ["<t color='#000000'>- - - - - - - - -</t>", "blank.sqf", [], 9, false, false, "", "isGroupLeader"];
	playerActions set [_playerActionsCount, _action];
	_playerActionsCount = _playerActionsCount +1;

	_action = player addAction ["<t color='#000000'>- - - - - - - - -</t>", "blank.sqf", [], 7, false, false, "", "isGroupLeader"];
	playerActions set [_playerActionsCount, _action];
	_playerActionsCount = _playerActionsCount +1;

	{
		_action = player addAction [format ["<t color='#ff0000'>%1</t>", format [localize "STR_Kick", name _x]], "groups\kick.sqf", [_x], 8, true, true, "", "isGroupLeader"];
		playerActions set [_playerActionsCount, _action];
		_playerActionsCount = _playerActionsCount +1;

		_action = player addAction [format ["<t color='#ffa500'>%1</t>", format [localize "STR_Promote", name _x]], "groups\promote.sqf", [vehicleVarName _x], 6, true, true, "", "isGroupLeader"];
		playerActions set [_playerActionsCount, _action];
		_playerActionsCount = _playerActionsCount +1;

	} forEach ((units group player) - [player]);
};
