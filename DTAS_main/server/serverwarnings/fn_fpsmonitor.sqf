averageFPS = 50;

if (isServer) then
{
	_fpsArraySize = 10;
	_minimumFPS = 20;
	_fpsArray = [];
	for "_i" from 0 to (_fpsArraySize - 1) do
	{
		_fpsArray set [_i, 50];
	};
	_fpsArrayCurrentIndex = 0;
	while {true} do
	{
		sleep 1;
		_fpsSum = 0;
		_fpsCount = 0;
		{
			_fpsSum = _fpsSum + _x;
			_fpsCount = _fpsCount + 1;
		} forEach _fpsArray;
		averageFPS = _fpsSum / _fpsCount;
		
		if (averageFPS < _minimumFPS) then
		{
			publicVariable "averageFPS";
			sleep 30;
		};
		
		_fpsArray set [_fpsArrayCurrentIndex, diag_fps];
		_fpsArrayCurrentIndex = _fpsArrayCurrentIndex + 1;
		if (_fpsArrayCurrentIndex >= _fpsArraySize) then
		{
			_fpsArrayCurrentIndex = 0;
		};
	};
}
else
{
	averageFPSWarningGiven = false;
	
	averageFPSPVHandler =
	{
		private ["_str"];
		
		_str = format [localize "STR_WarningPoorServerPerformance", round averageFPS];
		systemChat _str;
		hint _str;
		if (!averageFPSWarningGiven) then
		{
			averageFPSWarningGiven = true;
			[_str] spawn
			{
				waitUntil {!(isNull player)};
				sleep 1;
				hintC (_this select 0);
			};
		};
	};

	"averageFPS" addPublicVariableEventHandler
	{
		[] call averageFPSPVHandler;
	};
};