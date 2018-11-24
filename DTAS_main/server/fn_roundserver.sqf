#include "..\..\script_macros.hpp"
/*
*		@File: fn_roundServer.sqf
*		@Author: Gal Zohar
*/

private ["_deleteTypes", "_i", "_j", "_dUnitArr", "_aUnitArr", "_dUnitCount", "_aUnitCount", "_minX", "_maxX", "_minY", "_maxY", "_vehType", "_vehCount", "_slotCount", "_veh", "_pos", "_aStartDir", "_zoneMarker", "_area", "_posFound", "_driverArray", "_driverArrayCount", "_passengerArray", "_passengerArrayCount", "_endTime", "_group", "_groups", "_groupIndex", "_maxGroupIndex", "_minGroupSize", "_unitsWithoutGroup", "_units", "_vehicleIndex", "_bCont", "_bSpawn", "_spawnMode", "_toDelete", "_crate", "_dx", "_dy", "_jeepType", "_jeepCrewCount"];

fnc_startPos = DFUNC(startPos);

scoreW = 0;
publicVariable "scoreW";
scoreE = 0;
publicVariable "scoreE";
bObjW = false;
bObjE = false;
attackerSide = WEST;
nextAttackerSide = WEST;
publicVariable "attackerSide";
publicVariable "nextAttackerSide";
roundInProgress = false;
publicVariable "roundInProgress";
canChangeClass = true;
publicVariable "canChangeClass";
changeAttackerSide = true;
publicVariable "changeAttackerSide";
"mrkObj" setMarkerSize [capRad, capRad];
trgObj setTriggerArea [capRad, capRad, 0, false];
currentSetupTime = FirstRoundSetupTime;
canChangeObjPos = true;
publicVariable "canChangeObjPos";

ADC_VoteList = [];
publicVariable "ADC_VoteList";
lastObjPosMarker = "";
publicVariable "lastObjPosMarker";

adminPaused = false;
if (DefaultAdminPaused > 0) then
{
	// Pause start of first round until admin un-pauses.
	adminPaused = false;
};
publicVariable "adminPaused";

_deleteTypes = ["GroundWeaponHolder", "WeaponHolderSimulated", "ACE_Explosive_Object", "ACE_M86PDM_Object", "ACE_BreachObject", "Default"];

_jeepType =  "B_MRAP_01_F";
_jeepCrewCount = 4;

if (!isDedicated) then
{
	waitUntil {!isNil "objPosHandlerClient"};
	waitUntil {!isNil "defaultInsertionPosHandler"};
	waitUntil {!isNil "vehArrHandler"};
	waitUntil {!isNil "currentVehHandler"};
};

// Should be obsolete
aStartPosHandlerServer =
{
	private ["_dx", "_dy"];
	if (!roundInProgress) then
	{
		insertionType = requestedInsertionType;
		publicVariable "insertionType";

		aStartPos = aStartPosRequest;
		publicVariable "aStartPos";
		if (!isDedicated) then
		{
			[] call aStartPosHandlerClient;
		};
		aStartPosPicked=true;
		publicVariable "aStartPosPicked";
	};
};
"aStartPosRequest" addPublicVariableEventHandler aStartPosHandlerServer;

updateTime = false;
[] spawn DFUNC(timerUpdateServer);

fnc_allGroupsReady =
{
	private ["_ready", "_minGroupSize", "_group", "_atLeastOneGroup"];
	_ready = true;
	_atLeastOneGroup = false;
	_minGroupSize = [] call DFUNC(minGroupSize);
	{
		_group = _x;
		//if ((side _group isEqualTo attackerSide) && (count (units _group)) >= _minGroupSize) then
		if ((count (units _group)) >= _minGroupSize) then
		{
			_atLeastOneGroup = true;
			if (!(_group getVariable ["groupReady", false])) then
			{
				_ready = false;
			};
		};
	} forEach allGroups;

	(_ready && _atLeastOneGroup)
};

// Function to clean up vehicles.
fnc_cleanUpVehicles =
{
	{
		if (!(isNull _x)) then
		{
			deleteVehicle _x;
		};
	} forEach vehArr;

	{
		if (_x isKindOf "AIR") then
		{
			deleteVehicle _x;
		};
	} forEach vehicles;
};

fnc_setupObjPos =
{
	private ["_group"];
	defaultInsertionPos = [] call DFUNC(startPos);
	publicVariable "defaultInsertionPos";
	if (!isDedicated) then
	{
		[] call defaultInsertionPosHandler;
	};

	{
		_group = _x;
		if (side _group isEqualTo attackerSide) then
		{
			_group setVariable ["insertionType", 0, true];
			_group setVariable ["insertionPos", defaultInsertionPos, true];
			_group setVariable ["insertionPosPicked", false, true];
		};
		_group setVariable ["groupReady", false, true];
	} forEach allGroups;

	trgObj setPos objPos;
	//objFlag setPos objPos;
	"mrkObj" setMarkerPos objPos;
	"mrkObj1" setMarkerPos objPos;

	if (currentSetupTime isEqualTo -2) then
	{
		currentSetupTime = setupTime * 2;
	};
	roundStartTime = time + currentSetupTime;

	updateTime = true;
	//setupReady = true;
	//publicVariable "setupReady";
	//roundStart = false;
	//publicVariable "roundStart";
	aStartPosPicked = false;
	publicVariable "aStartPosPicked";

	canChangeObjPos = true;
	publicVariable "canChangeObjPos";

	forceRoundStart = false;
	publicVariable "forceRoundStart";
};

adminObjPosHandler =
{
	// This condition is almost the same as roundInProgress, but safe for updating objective position.
	if (canChangeObjPos) then
	{
		objPos = adminObjPos;
		publicVariable "objPos";
		objPosMarker = "AdminForced";
		publicVariable "objPosMarker";

		if (!isDedicated) then
		{
			[] call objPosHandlerClient;
		};
		[] call fnc_setupObjPos;
	};
};
"adminObjPos" addPublicVariableEventHandler adminObjPosHandler;

fnc_hasPlayers =
{
	private ["_aCount", "_dCount"];

	_aCount = 0;
	_dCount = 0;

	{
		_unit = _x;
		if (_unit getVariable ["ready", false]) then
		{
			if ((side _unit) isEqualTo attackerSide) then
			{
				_aCount = _aCount + 1;
			}
			else
			{
				_dCount = _dCount + 1;
			};
		};
	} forEach allUnits;

	((_aCount > 0) && (_dCount > 0))
};

vehArr = [];

markerAreaArray = [];
totalMarkerArea = 0;
_j = 0;
_markerPrefixCharArray = toArray "mrkZone";
_maxi = count _markerPrefixCharArray;
{
	_markerCharArray = toArray _x;
	_equal = (count _markerCharArray) >= _maxi;
	_i = 0;
	while {_equal && _i < _maxi} do
	{
		if ((_markerCharArray select _i) != (_markerPrefixCharArray select _i)) then
		{
			_equal = false;
		};
		_i = _i + 1;
	};
	if (_equal) then
	{
		_area = ((markerSize _x) select 0) * ((markerSize _x) select 1);
		totalMarkerArea = totalMarkerArea + _area;
		markerAreaArray set [_j, [_x, _area]];
		_j = _j + 1;
	};
} forEach allMapMarkers;
publicVariable "markerAreaArray";

[] spawn
{
	private ["_fnc_handleGroupsServer"];
	_fnc_handleGroupsServer = compile preprocessFileLineNumbers "groups\fnc_handlegroupsserver_bisgroups.sqf";
	while {true} do
	{
		sleep 1;
		[] call _fnc_handleGroupsServer;
	};
};

while {true} do
{
	roundInProgress=false;
	publicVariable "roundInProgress";
	bLastPlayersCountdown = false;
	publicVariable "bLastPlayersCountdown";
	fakeExtraDefenderTime = 0;
	publicVariable "fakeExtraDefenderTime";

	ADC_VoteList = [];
	publicVariable "ADC_VoteList";

	if (changeAttackerSide) then
	{
		_posFound = false;
		while {!_posFound} do
		{
			_zoneMarker = (selectRandom markerAreaArray) select 0;

			_minX = (markerPos _zoneMarker select 0) - (markerSize _zoneMarker select 0);
			_maxX = (markerPos _zoneMarker select 0) + (markerSize _zoneMarker select 0);
			_minY = (markerPos _zoneMarker select 1) - (markerSize _zoneMarker select 1);
			_maxY = (markerPos _zoneMarker select 1) + (markerSize _zoneMarker select 1);

			objPos = [_minX + random (_maxX - _minX), _minY + random (_maxY - _minY)];
			objPosMarker = _zoneMarker;

			if
			(
				(!(surfaceIsWater objPos))
				&&
				(!(([objPos, (markerPos "respawn_west")] call fnc_airDistance) < (minDist + 50)))
				&&
				(!(([objPos, (markerPos "respawn_east")] call fnc_airDistance) < (minDist + 50)))
				&&
				!(objPosMarker isEqualTo lastObjPosMarker)
			) then
			{
				_posFound = true;
			};
		};

		publicVariable "objPos";
		publicVariable "objPosMarker";
		if (!isDedicated) then
		{
			[] call objPosHandlerClient;
		};
	};

	[] call fnc_setupObjPos;

	if (currentSetupTime > 0 && !forceRoundStart) then
	{
		waitUntil
		{
			if (!([] call fnc_hasPlayers)) then
			{
				roundStartTime = time + currentSetupTime;
				//roundStart = false;
			};
			forceRoundStart || ((time > roundStartTime || ([] call fnc_allGroupsReady)) && ([] call fnc_hasPlayers))
		};
	}
	else
	{
		waitUntil {forceRoundStart || (([] call fnc_allGroupsReady) && ([] call fnc_hasPlayers))};
	};

	// Don't start until admin un-paused the round start.
	waitUntil {!adminPaused || forceRoundStart};

	if (adminPaused && DefaultAdminPaused > 1) then
	{
		adminPaused = false;
		publicVariable "adminPaused";
	};

	canChangeObjPos = false;
	publicVariable "canChangeObjPos";

	lastObjPosMarker = objPosMarker;
	publicVariable "lastObjPosMarker";

	currentSetupTime = setupTime;

	// Clean up vehicles that somehow weren't cleaned at end of round
	[] call fnc_cleanUpVehicles;

	{
		if (!isNull _x) then
		{
			if (_x isKindOf "MAN") then
			{
				if (!isPlayer _x) then
				{
					deleteVehicle _x;
				}
				else
				{
					[_x] spawn DFUNC(deleteOldBody);
				};
			};
		};
	} forEach allDead;

	_toDelete = nearestObjects [markerPos "mrkObj1", _deleteTypes, 10000];
	_toDelete = _toDelete + ((markerPos "mrkObj1") nearObjects ["Default", 10000]); // fix for bug with detecting satchels
	_toDelete = _toDelete + nearestObjects [getPos westMenuFlag, _deleteTypes, 100];
	_toDelete = _toDelete + nearestObjects [getPos eastMenuFlag, _deleteTypes, 100];
	for "_i" from 0 to ((count _toDelete) - 1) do
	{
		deleteVehicle (_toDelete select _i);
	};

	bObjW = false;
	bObjE = false;

	_dUnitArr = [];
	_aUnitArr = [];
	_dUnitCount = 0;
	_aUnitCount = 0;
	{
		if ((isPlayer _x) && (alive _x) && (_x getVariable ["ready", false])) then
		{
			if (side _x isEqualTo attackerSide) then
			{
				_aUnitArr set [_aUnitCount, _x];
				_aUnitCount = _aUnitCount + 1;
			}
			else
			{
				_dUnitArr set [_dUnitCount, _x];
				_dUnitCount = _dUnitCount + 1;
			};
			_x setVariable ["ready", false];
			_x setVariable ["isPlaying", true, true];
		};
	} forEach allUnits;

	canChangeClass = false;
	publicVariable "canChangeClass";

	if (changeAttackerSide) then
	{
		if (attackerSide isEqualTo WEST) then
		{
			nextAttackerSide = EAST;
		}
		else
		{
			nextAttackerSide = WEST;
		};
		publicVariable "nextAttackerSide";
	};

	//Handle vehicle spawning and assignment

	vehArr = [];
	//_minGroupSize = [] call DFUNC(minGroupSize); // This is the gay function
	_minGroupSize = 1;
	_unitsWithoutGroup = [] + _aUnitArr;
	_groups = allGroups;
	_groupIndex = 0;
	_maxGroupIndex = count _groups;
	_bCont = true;
	while {_bCont} do
	{
		_bSpawn = false;
		if (_groupIndex < _maxGroupIndex) then
		{
			_group = _groups select _groupIndex;
			_groupIndex = _groupIndex + 1;
			_units = units _group;
			//if (((side _group) isEqualTo attackerSide) && ((count (units _group)) >= _minGroupSize)) then
			if ((side _group) isEqualTo attackerSide) then
			{
				_bSpawn = true;
				_unitsWithoutGroup = _unitsWithoutGroup - _units;
				_slotCount = 0;
				switch (_group getVariable ["insertionType", 0]) do
				{
					// Ifrit , Hunter, Strider
					case 0:
					{
						_vehType = selectRandom ["B_MRAP_01_F","O_MRAP_02_F","I_MRAP_03_F"];
						_slotCount = _jeepCrewCount;
					};
					// Boat
					case 1:
					{
						_vehType = selectRandom ["B_Boat_Transport_01_F", "B_Lifeboat", "B_G_Boat_Transport_02_F"];
						_slotCount = 5;
					};
					// Submarine
					case 2:
					{
						_vehType = "B_SDV_01_F";
						_slotCount = 4;
					};
					// Orca , hummingbird, taru bench
					case 3:
					{
						_vehType = selectRandom [ "O_Heli_Light_02_unarmed_F","O_Heli_Transport_04_bench_black_F","B_Heli_Light_01_F"];
						_slotCount = 4;
					};
					//Prowler
					case 4:
					{
						_vehType = "B_LSV_01_unarmed_black_F";
						_slotCount = 7;
					};
				};
			};
		}
		else // Run for all people without group
		{
			_units = _unitsWithoutGroup;
			_bCont = false;
			_bSpawn = (count _units > 0); // Counts through the array units where the value is more than one

			_vehType = selectRandom ["B_MRAP_01_F","O_MRAP_02_F","I_MRAP_03_F"];
			_slotCount = 4;
		};

		if (_bSpawn) then // If there are any units without a group this is run
		{
			_vehCount = ceil ((count _units) / (_slotCount)); // divides the amount of units by the slotcount (which is 4 because hunter) then rounds up
			_pos = defaultInsertionPos;
			if (_bCont) then // This is run if there are units without groups
			{
				_pos = _group getVariable ["insertionPos", defaultInsertionPos];
			};

			_dx = (objPos select 0) - (_pos select 0);
			_dy = (objPos select 1) - (_pos select 1);
			_aStartDir = atan (_dy / _dx);
			if (_dx < 0) then
			{
				_aStartDir = _aStartDir + 180;
			};
			if (_dx isEqualTo 0) then
			{
				if (_dy > 0) then
				{
					_aStartDir = 90;
				}
				else
				{
					_aStartDir = -90;
				};
			};
			_aStartDir = 90 - _aStartDir;

			_vehicleIndex = count vehArr;

			for "_i" from 0 to (_vehCount - 1) do
			{
				_pos = [(_pos select 0) - 10 * (sin _aStartDir), (_pos select 1) - 10 * (cos _aStartDir)];
				_spawnMode = "NONE";
				// If position is on water, spawn flying.
				if (surfaceIsWater _pos) then
				{
					_spawnMode = "FLY";
				};
				//_vehType = selectRandom ["B_MRAP_01_F","O_MRAP_02_F","I_MRAP_03_F"]; // we might have to delete this if helis/boats dont work
				_veh = createVehicle [_vehType, _pos, [], 3, _spawnMode];
				_veh setDir _aStartDir;

				clearWeaponCargoGlobal _veh;
				clearMagazineCargoGlobal _veh;
				clearItemCargoGlobal _veh;
				clearBackpackCargoGlobal _veh;
				vehArr set [count vehArr, _veh];

				if (_veh isKindOf "B_MRAP_01_F") then 
				{
					
					//White			//Yellow    //Pink			//Cyan				//Black						//Purple			//Blue					//Red				//Green
					//private _tex = selectRandom [[1,1,1,0.8],[1,1,0,0.8],[1,0,0.2,0.8],[0,1,1,0.8],[0.02,0.02,0.02,1],[0.2,0,1,0.8],[0,0.2,1,0.8], [1,0,0,1], [0,1,0.3,0.8]];
					//[0,"Textures\hunterc.paa"] [1,"Textures\hunterb.paa"]
					/*private _tex = selectRandom [[0.02,0.02,0.02,1]];
					{
						_x params ["_red", "_green", "_blue", "_alpha"];
						private _format = format ["#(rgb,8,8,3)color(%1,%2,%3,%4)", _red, _green, _blue, _alpha];
						_veh setObjectTextureGlobal [_forEachIndex, _format];
					} forEach [_tex,[0.02,0.02,0.02,1]]
					*/
					{
					_veh setObjectTextureGlobal [0,"Textures\hunterb.paa"];
					_veh setObjectTextureGlobal [1,"Textures\hunterc.paa"];
					}forEach [_tex,[0.02,0.02,0.02,1]]
				};
			};

			_driverArray = [];
			_driverArrayCount = 0;
			_passengerArray = [];
			_passengerArrayCount = 0;
			{
				if (_x getVariable ["preferDriver", false]) then
				{
					_driverArray set [_driverArrayCount, _x];
					_driverArrayCount = _driverArrayCount + 1;
				}
				else
				{
					_passengerArray set [_passengerArrayCount, _x];
					_passengerArrayCount = _passengerArrayCount + 1;
				};
			} forEach _units;

			for "_i" from 0 to (_vehCount - 1 - _driverArrayCount) do
			{
				_driverArray set [_driverArrayCount, _passengerArray select _i];
				_driverArrayCount = _driverArrayCount + 1;
			};

			_passengerArray = _passengerArray - _driverArray;
			_passengerArrayCount = count _passengerArray;

			for "_i" from _vehCount to (_driverArrayCount - 1) do
			{
				_passengerArray set [_passengerArrayCount, _driverArray select _i];
				_passengerArrayCount = _passengerArrayCount + 1;
			};

			for "_i" from 0 to (_vehCount - 1) do
			{
				currentVeh = [vehArr select _vehicleIndex + _i, 0];
				(owner (_driverArray select _i)) publicVariableClient "currentVeh";
				if (!isDedicated) then
				{
					if (player isEqualTo (_driverArray select _i)) then
					{
						//[currentVeh] call currentVehHandler;
					};
				};

				for "_j" from 0 to (_slotCount - 2) do
				{
					if (((_i * (_slotCount - 1)) + _j) < _passengerArrayCount) then
					{
						currentVeh set [1, _j + 1];
						(owner (_passengerArray select ((_i * (_slotCount - 1)) + _j))) publicVariableClient "currentVeh";
						if (!isDedicated) then
						{
							if (player isEqualTo (_passengerArray select ((_i * (_slotCount - 1)) + _j))) then
							{
								[currentVeh] call currentVehHandler;
							};
						};
					};
				};
			};
		};
	};

	[] spawn
	{
		sleep 1;
		canChangeClass = true;
		publicVariable "canChangeClass";
	};

	// Tell clients to run generic vehicle initialization scripts
	publicVariable "vehArr";
	if (!isDedicated) then
	{
		//Make sure scripts run on host
		[] call vehArrHandler;
	}
	else
	{
		// Run invulnerability script on server too (already runs on host and clients from vehArrHandler)
		[] call DFUNC(vehicleAllowDamage);
	};

	sleep 1.5;

	roundEnd = 0;
	publicVariable "roundEnd";
	roundEndTime = time + timeLimit;
	updateTime = true;
	roundInProgress = true;
	publicVariable "roundInProgress";

	// If parameter was chosen, pause the next round start timer.
	if (DefaultAdminPaused > 1) then
	{
		adminPaused = true;
		publicVariable "adminPaused";
	};

	waitUntil
	{
		{alive _x} count _dUnitArr isEqualTo 0
		||
		{alive _x} count _aUnitArr isEqualTo 1
		||
		{alive _x} count _aUnitArr <= 0.1 * _aUnitCount
		||
		(bObjW && attackerSide isEqualTo WEST) || (bObjE && attackerSide isEqualTo EAST)
		||
		time > roundEndTime
	};

	while {roundEnd isEqualTo 0} do
	{
		if (time > roundEndTime) then
		{
			roundEnd=4;
			publicVariable "roundEnd";
		}
		else
		{
			if ((bObjW && attackerSide isEqualTo WEST) || (bObjE && attackerSide isEqualTo EAST)) then
			{
				roundEnd=3;
				publicVariable "roundEnd";
			}
			else
			{
				if ({alive _x} count _dUnitArr isEqualTo 0) then
				{
					roundEnd=2;
					publicVariable "roundEnd";
				}
				else
				{
					if ({alive _x} count _aUnitArr isEqualTo 0) then
					{
						roundEnd=1;
						publicVariable "roundEnd";
					}
					else
					{
						if ((time + lastPlayersCountdown) < roundEndTime) then
						{
							fakeExtraDefenderTime = roundEndTime - time - lastPlayersCountdown;
							publicVariable "fakeExtraDefenderTime";

							roundEndTime = time + lastPlayersCountdown;
							bLastPlayersCountdown = true;
							publicVariable "bLastPlayersCountdown";
							updateTime = true;
						};
						WaitUntil
						{
							{alive _x} count _dUnitArr isEqualTo 0
							||
							{alive _x} count _aUnitArr isEqualTo 0
							||
							((bObjW && attackerSide isEqualTo WEST) || (bObjE && attackerSide isEqualTo EAST))
							||
							time > roundEndTime
						};
					};
				};
			};
		};
	};

	if (((roundEnd isEqualTo 2 || roundEnd isEqualTo 3) && attackerSide isEqualTo WEST) || ((roundEnd isEqualTo 1 || roundEnd isEqualTo 4) && attackerSide isEqualTo EAST))then
	{
		scoreW = scoreW + 1;
		publicVariable "scoreW";
	}
	else
	{
		scoreE = scoreE + 1;
		publicVariable "scoreE";
	};

	sleep 1.5;

	// Clean up vehicles
	[] call fnc_cleanUpVehicles;

	//Reset broken down buildings
	{
		_x setDamage 0;
	} forEach nearestTerrainObjects [objPos, [], 300];

	// Empty base crates
	{
		_crate = _x;
		clearWeaponCargoGlobal _crate;
		clearMagazineCargoGlobal _crate;
		clearItemCargoGlobal _crate;
	} forEach all_crates;

	changeAttackerSide = !changeAttackerSide;
	attackerSide = nextAttackerSide;
	publicVariable "changeAttackerSide";
	publicVariable "attackerSide";
};
