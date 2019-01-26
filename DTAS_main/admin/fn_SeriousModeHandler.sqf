fn_SeriousModeEnable = compile preprocessFileLineNumbers "DTAS_main\admin\fn_SeriousModeEnable.sqf";
fn_SeriousModeDisable = compile preprocessFileLineNumbers "DTAS_main\admin\fn_SeriousModeDisable.sqf";
fn_SeriousModeFunTime = compile preprocessFileLineNumbers "DTAS_main\admin\fn_SeriousModeFunTime.sqf";
fn_defineclasses = compile preprocessFileLineNumbers "DTAS_main\main\fn_defineclasses.sqf";
_DoneIfYet = false;
if (SeriousMode == "Serious" && !_DoneIfYet) then
{
	call fn_SeriousModeDisable;
	_DoneIfYet = true;
};
if (SeriousMode == "Normal" && !_DoneIfYet) then
{

	call fn_SeriousModeFunTime;
	_DoneIfYet = true;
};
if (SeriousMode == "NotAtAll" && !_DoneIfYet) then
{
	call fn_SeriousModeEnable;
	_DoneIfYet = true

};
call fn_defineclasses;
