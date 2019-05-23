//_clientID = clientOwner;
//_UID = getPlayerUID player;
//_name = name player;
//checkForDatabase = [_clientID, _UID, _name];
//publicVariableServer "checkForDatabase";
//_v = "Inside the INIT.sqf for " + _name;
//_v remoteExec ["systemChat"];
"loadData" addPublicVariableEventHandler
{
	_array = (_this select 1);
	systemChat "Your current Stats are:";
	_killstring = _array select 0;
	_deathstring = _array select 1;
	_ratiostring = _array select 2;
	systemChat _killstring;
	systemChat _deathstring;
	systemChat _ratiostring;	
};






