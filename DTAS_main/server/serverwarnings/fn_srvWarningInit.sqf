#include "..\..\..\script_macros.hpp"
/*
*		@File: fn_srvWarningInit.sqf
*		@Author: Gal Zohar
*/

if (!isDedicated) then {
	call DFUNC(difficulty);
};

call DFUNC(fpsMonitor);
