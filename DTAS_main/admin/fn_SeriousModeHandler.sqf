#include "..\..\script_macros.hpp"
fn_SeriousModeEnable = compile preprocessFileLineNumbers "DTAS_main\admin\fn_SeriousModeEnable.sqf";
fn_SeriousModeDisable = compile preprocessFileLineNumbers "DTAS_main\admin\fn_SeriousModeDisable.sqf";
fn_SeriousModeFunTime = compile preprocessFileLineNumbers "DTAS_main\admin\fn_SeriousModeFunTime.sqf";
fn_defineclasses = compile preprocessFileLineNumbers "DTAS_main\main\fn_defineclasses.sqf";
fn_getdata = compile preprocessFileLineNumbers "getData.sqf";
_DoneIfYet = false;

if (SeriousMode == "Serious" && !_DoneIfYet) then
{
	call fn_SeriousModeDisable;
	_DoneIfYet = true;
	"Serious" setMarkerAlpha 0;
	"NotSerious" setMarkerAlpha 1;
	"FunTime" setMarkerAlpha 0;
};
if (SeriousMode == "Normal" && !_DoneIfYet) then
{

	call fn_SeriousModeFunTime;
	_DoneIfYet = true;
	"Serious" setMarkerAlpha 0;
	"NotSerious" setMarkerAlpha 0;
	"FunTime" setMarkerAlpha 1;
};
if (SeriousMode == "NotAtAll" && !_DoneIfYet) then
{
	call fn_SeriousModeEnable;
	_DoneIfYet = true;
	"Serious" setMarkerAlpha 1;
	"NotSerious" setMarkerAlpha 0;
	"FunTime" setMarkerAlpha 0;

};
publicVariable SeriousMode;
publicVariable "SeriousMode";
[[], fn_defineclasses] remoteExec ["spawn"];
[] call DFUNC(defineClasses);
