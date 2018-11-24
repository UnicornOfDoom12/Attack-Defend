_params = _this select 3;
_unlocked = _params select 0;

(group player) setVariable ["isGroupUnlocked", _unlocked, true];

[] call fnc_groupCancel;