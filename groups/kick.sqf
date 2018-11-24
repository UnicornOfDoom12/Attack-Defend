private ["_params", "_unit"];
_params = _this select 3;
_unit = _params select 0;

if (_unit in (units (group player))) then
{
	_unit setVariable ["groupKicked", true, true];
}
else
{
	_nameStr = "";
	if (!(isNull _unit)) then
	{
		_nameStr = format [" %1", name _unit];
	};
	hint format ["%1 %2", format [localize "STR_CannotKick", _nameStr], localize "STR_PlayerHasLeft"];
};

[] call fnc_groupCancel;