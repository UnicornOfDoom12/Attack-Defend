_onScreenTime = 5;

sleep 5; //Wait in seconds before the credits start after player is in-game
 
_role1 = "Welcome player"; //In yellow
_role1names = [profileName]; //In white
_role2 = "Developers";
_role2names = ["Nuclear, Malley"]; 
_role3 = "Skins";
_role3names = ["Butch ,Lil Jeep"];

 
{
sleep 2;
_memberFunction = _x select 0;
_memberNames = _x select 1;
_finalText = format ["<t size='0.80' color='#f2cb0b' align='right'>%1<br /></t>", _memberFunction]; //Changes colours
_finalText = _finalText + "<t size='0.60' color='#282828' align='right'>";
{_finalText = _finalText + format ["%1<br />", _x]} forEach _memberNames;
_finalText = _finalText + "</t>";
_onScreenTime + (((count _memberNames) - 1) * 0.5);
[
_finalText,
[safezoneX + safezoneW - 0.8,0.50], //DEFAULT: 0.5,0.35
[safezoneY + safezoneH - 0.8,0.7], //DEFAULT: 0.8,0.7
_onScreenTime,
0.5
] spawn BIS_fnc_dynamicText;
sleep (_onScreenTime);
} forEach [
//The list below should have exactly the same amount of roles as the list above
[_role1, _role1names],
[_role2, _role2names],
[_role3, _role3names]
];