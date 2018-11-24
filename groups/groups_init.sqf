fnc_getLeader = compile preprocessFileLineNumbers "groups\fnc_getleader.sqf";

if (!isDedicated) then
{
	playerActions = [];

	fnc_groupRefresh = compile preprocessFileLineNumbers "groups\refresh.sqf";
	fnc_groupCancel = compile preprocessFileLineNumbers "groups\cancel.sqf";
	fnc_groupLeave = compile preprocessFileLineNumbers "groups\leave.sqf";
	
	[] spawn
	{
		waitUntil {time>2};
		waitUntil {!(isNil "fnc_reveal")};
		[] call fnc_groupLeave;
	};
};

if (isServer) then
{
	fnc_needsLeader = compile preprocessFileLineNumbers "groups\fnc_needsleader.sqf";
	fnc_handleGroupsServer = compile preprocessFileLineNumbers "groups\fnc_handlegroupsserver.sqf";
	
	[] spawn
	{
		waitUntil {!isNil "attackerSide"};
		
		while {true} do
		{
			[] call fnc_handleGroupsServer;
			sleep 1;
		};
	};
};