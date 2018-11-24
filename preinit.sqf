#include "script_macros.hpp"
/*
*		@File: preInit.sqf
*		@Author: Gal Zohar
*
*		Description: Preinit
*/

private ["_i", "_maxi", "_markerCharArray", "_markerPrefixCharArray", "_equal", "_currentMarker"];

// Create a mission entry for the server and client RPT file, easier to debug when you know what mission created the error
diag_log text "";
diag_log text format["|=============================   %1   =============================|", missionName]; // stamp mission name
diag_log text "";

tf_no_auto_long_range_radio = true;
tf_same_sw_frequencies_for_side = true;

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
		_x setMarkerAlpha 0;
	};
} forEach allMapMarkers;

// Workaround for bug 24051
[] spawn DFUNC(preInit);
