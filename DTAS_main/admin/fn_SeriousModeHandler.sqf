fn_SeriousModeEnable = compile preprocessFileLineNumbers "DTAS_main\admin\fn_SeriousModeEnable.sqf";
fn_SeriousModeDisable = compile preprocessFileLineNumbers "DTAS_main\admin\fn_SeriousModeDisable.sqf";
if (SeriousMode) then
{
	call fn_SeriousModeDisable;
}
else
{
	call fn_SeriousModeEnable;
};