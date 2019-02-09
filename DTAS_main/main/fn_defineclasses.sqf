#include "..\..\script_macros.hpp"
/*
*		@File: fn_defineClasses.sqf
*		@Author: Nuclear
*
*		Description: Defines all the classes
*
*		Class format:
*			0 - Primary Weapon 		<ARRAY> with all attachments
*			1 - Secondary Weapon 	<ARRAY> with all attachments
*			2 - Handgun 					<ARRAY>	with all attachments
*			3 - Uniform 					<ARRAY> with all contents inside
*			4 - Vest 							<ARRAY> with all contents inside
*			5 - Backpack 					<ARRAY> with all contents inside (usually empty array)
*			6 - Hat 							<STRING>
*			7 - Goggles 					<STRING>
*			8 - Items							<ARRAY> Misc items (I think, all I know is that binos go in that array)
*			9 - Linked items			<ARRAY> (GPS, Map, Compass, NVG etc)
*			10 - Display Name 		<STRING> of the class
*
*		To add a new class, simply follow the format and put it in the aClasses for attacker side, or dClasses for defending side
*		The class will automatically be added
*/

private _nvgs = "NVGoggles_OPFOR";
private _attackerUniform = "U_B_CTRG_Soldier_F";
private _defenderUniform = "U_I_C_Soldier_Para_5_F";
private _Avest = "V_PlateCarrier2_blk";
private _Dvest = "V_PlateCarrier2_rgr";
private _helmet = "H_HelmetSpecB_blk";
private _hat = "H_HelmetSpecB_blk";
private _baseScope = profileNameSpace getVariable ["ADC_PreferredScope", "optic_Arco_blk_F"];
fn_GetIndexOfCommand = compile preprocessFileLineNumbers "DTAS_main\server\fn_GetIndexOfCommand.sqf";
if !(_baseScope in (["optic_MRCO", "optic_hamr", "optic_Arco_blk_F","optic_ERCO_blk_F"])) then {
	_baseScope = "optic_Arco_blk_F";
};
//SeriousMode = "Normal";
systemChat "Defining classes";
//publicVariable "SeriousMode";
aClasses = [
	[
		["srifle_DMR_03_F","","",_baseScope,["20Rnd_762x51_Mag",20],[],"bipod_01_F_blk"],
		[],
		[],
		["U_B_CTRG_Soldier_F",[["FirstAidKit",5]]],
		[_Avest,[["optic_MRCO",1],["optic_hamr",1], ["optic_Arco_blk_F",1],[_nvgs,1],["20Rnd_762x51_Mag",15,20]]],
		[],
		_helmet,
		"G_Balaclava_TI_G_blk_F",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"MK-I EMR"
	],
	[
		["arifle_SPAR_03_blk_F","","",_baseScope,["20Rnd_762x51_Mag",20],[],"bipod_01_F_blk"],
		[],
		[],
		["U_B_CTRG_Soldier_F",[["FirstAidKit",5]]],
		[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["20Rnd_762x51_Mag",15,20]]],
		[],
		_helmet,
		"G_Balaclava_TI_G_blk_F",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"Spar 17"
	],
	[
		["SMG_03_TR_black","","",_baseScope,["50Rnd_570x28_SMG_03",50],[],"bipod_01_F_blk"],
		[],
		[],
		[_attackerUniform,[["FirstAidKit",5]]],
		[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["50Rnd_570x28_SMG_03",15,50]]],
		[],
		_helmet,
		"G_Balaclava_TI_G_blk_F",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"ADR-97 TR"
	],		
	[
		["srifle_EBR_F","","",_baseScope,["20Rnd_762x51_Mag",20],[],"bipod_01_F_blk"],
		[],
		[],
		["U_B_CTRG_Soldier_F",[["FirstAidKit",5]]],
		[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["20Rnd_762x51_Mag",15,20]]],
		[],
		_helmet,
		"G_Balaclava_TI_G_blk_F",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"MK-18"
	],
	
	[
		["arifle_SPAR_02_blk_F","muzzle_snds_M","",_baseScope,["150Rnd_556x45_Drum_Mag_F",150],[],"bipod_01_F_blk"],
		[],
		[],
		["U_I_CombatUniform_shortsleeve",[["FirstAidKit",5]]],
		[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["150Rnd_556x45_Drum_Mag_F",8,150]]],
		[],
		"H_PASGT_basic_black_F",
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"Spar 16-S"
	],

	[
		["arifle_MXM_black_F","muzzle_snds_H","",_baseScope,["30Rnd_65x39_caseless_mag",30],[],"bipod_01_F_blk"],
		[],
		[],
		["U_B_CTRG_Soldier_F",[["FirstAidKit",5]]],
		[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_65x39_caseless_mag",15,30]]],
		[],
		_helmet,
		"G_Balaclava_TI_G_blk_F",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"MXM"
	],

	[
		["arifle_MX_SW_black_F","muzzle_snds_H","",_baseScope,["100Rnd_65x39_caseless_mag",100],[],"bipod_01_F_blk"],
		[],
		[],
		["U_B_CTRG_Soldier_F",[["FirstAidKit",5]]],
		[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["100Rnd_65x39_caseless_mag",8,100]]],
		[],
		_helmet,
		"G_Balaclava_TI_G_blk_F",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"MX-SW"
	]
];

dClasses = [
	[
		["srifle_DMR_03_F","","",_baseScope,["20Rnd_762x51_Mag",20],[],"bipod_01_F_blk"],
		[],
		[],
		[_defenderUniform,[["FirstAidKit",5]]],
		[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["20Rnd_762x51_Mag",15,20]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"MK-I EMR"
	],
	[
		["arifle_SPAR_03_blk_F","","",_baseScope,["20Rnd_762x51_Mag",20],[],"bipod_01_F_blk"],
		[],
		[],
		[_defenderUniform,[["FirstAidKit",5]]],
		[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["20Rnd_762x51_Mag",15,20]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"Spar 17"
	],
	[
		["SMG_03_TR_black","","",_baseScope,["50Rnd_570x28_SMG_03",50],[],"bipod_01_F_blk"],
		[],
		[],
		[_defenderUniform,[["FirstAidKit",5]]],
		[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["50Rnd_570x28_SMG_03",15,50]]],
		[],
		_helmet,
		"G_Balaclava_TI_G_blk_F",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"ADR-97 TR"
	],
	[
		["srifle_DMR_06_camo_F","","",_baseScope,["20Rnd_762x51_Mag",20],[],"bipod_01_F_blk"],
		[],
		[],
		[_defenderUniform,[["FirstAidKit",5]]],
		[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["20Rnd_762x51_Mag",15,20]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"MK-14 Camo"
	],

	[
		["arifle_CTARS_ghex_F","muzzle_snds_58_ghex_F","",_baseScope,["100Rnd_580x42_Mag_F",100],[],""],
		[],
		[],
		[_defenderUniform,[["FirstAidKit",5]]],
		[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["100Rnd_580x42_Mag_F",8,100]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"Car 95-1"
	],

	[
		["arifle_MXM_black_F","muzzle_snds_H","",_baseScope,["30Rnd_65x39_caseless_mag",30],[],"bipod_01_F_blk"],
		[],
		[],
		[_defenderUniform,[["FirstAidKit",5]]],
		[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_65x39_caseless_mag",15,30]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"MXM"
	],

	[
		["arifle_MX_SW_black_F","muzzle_snds_H","",_baseScope,["100Rnd_65x39_caseless_mag",100],[],"bipod_01_F_blk"],
		[],
		[],
		[_defenderUniform,[["FirstAidKit",5]]],
		[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["100Rnd_65x39_caseless_mag",8,100]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"MX-SW (100Rnd)"
	]
];
systemChat SeriousMode;
if (SeriousMode == "NotAtAll") then{
	systemChat "Rahim added";
	aClasses append [[
		["srifle_DMR_01_DMS_BI_F","","",_baseScope,["10Rnd_762x54_Mag",10],[],"bipod_01_F_blk"],
		[],
		[],
		[_attackerUniform,[["FirstAidKit",5]]],
		[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["10Rnd_762x54_Mag",15,10]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"Rahim"
	],
	[
		["srifle_DMR_02_F","","",_baseScope,["10Rnd_338_Mag",10],[],"bipod_01_F_blk"],
		[],
		[],
		[_attackerUniform,[["FirstAidKit",5]]],
		[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["10Rnd_338_Mag",15,10]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"Mar-10"
	],
	[
		["LMG_03_F","muzzle_snds_M","",_baseScope,["200Rnd_556x45_Box_F",200],[],"bipod_01_F_blk"],
		[],
		[],
		[_attackerUniform,[["FirstAidKit",5]]],
		[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["200Rnd_556x45_Box_F",3,200]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"Lim"
	],
	[
		["srifle_DMR_04_F","","",_baseScope,["10Rnd_127x54_Mag",10],[],""],
		[],
		[],
		[_attackerUniform,[["FirstAidKit",5]]],
		[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["10Rnd_127x54_Mag",3,10]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"ASP-1 Kir"
	],
	[
		["arifle_AKM_F","muzzle_snds_B","",_baseScope,["30Rnd_762x39_Mag_F",30],[],""],
		[],
		[],
		[_attackerUniform,[["FirstAidKit",5]]],
		[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_762x39_Mag_F",10,30]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"AKM"
	]];
	dClasses append [[
		["srifle_DMR_01_DMS_BI_F","","",_baseScope,["10Rnd_762x54_Mag",10],[],"bipod_01_F_blk"],
		[],
		[],
		[_defenderUniform,[["FirstAidKit",5]]],
		[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["10Rnd_762x54_Mag",15,10]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"Rahim"
	],
	[
		["srifle_DMR_02_F","","",_baseScope,["10Rnd_338_Mag",10],[],"bipod_01_F_blk"],
		[],
		[],
		[_defenderUniform,[["FirstAidKit",5]]],
		[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["10Rnd_338_Mag",15,10]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"Mar-10"
	],
	[
		["LMG_03_F","muzzle_snds_M","",_baseScope,["200Rnd_556x45_Box_F",200],[],"bipod_01_F_blk"],
		[],
		[],
		[_defenderUniform,[["FirstAidKit",5]]],
		[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["200Rnd_556x45_Box_F",3,200]]],
		[],
		_helmet,
		"G_Balaclava_TI_G_blk_F",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"Lim"
	],
	[
		["srifle_DMR_04_F","","",_baseScope,["10Rnd_127x54_Mag",10],[],"bipod_01_F_blk"],
		[],
		[],
		[_defenderUniform,[["FirstAidKit",5]]],
		[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["10Rnd_127x54_Mag",3,10]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"ASP-1 Kir"
	],
	[
		["arifle_AKM_F","muzzle_snds_B","",_baseScope,["30Rnd_762x39_Mag_F",30],[],""],
		[],
		[],
		[_defenderUniform,[["FirstAidKit",5]]],
		[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_762x39_Mag_F",10,30]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"AKM"
	]];
};
if (SeriousMode != "Serious") then {
	aClasses append [[
		["arifle_ARX_blk_F","muzzle_snds_65_TI_blk_F","",_baseScope,["30Rnd_65x39_caseless_green",30],[],"bipod_01_F_blk"],
		[],
		[],
		[_attackerUniform,[["FirstAidKit",5]]],
		[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_65x39_caseless_green",15,30]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"Type 115"
	],
	[
		["arifle_Katiba_F","muzzle_snds_H","",_baseScope,["30Rnd_65x39_caseless_green",30],[],""],
		[],
		[],
		[_attackerUniform,[["FirstAidKit",5]]],
		[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_65x39_caseless_green",15,30]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"Katiba"
	],
	[
		["SMG_01_F","muzzle_snds_acp","",_baseScope,["30Rnd_45ACP_Mag_SMG_01",30],[],""],
		[],
		[],
		[_attackerUniform,[["FirstAidKit",5]]],
		[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_45ACP_Mag_SMG_01",15,30]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"Vermin"
	],
	[
		["arifle_AK12_F","","",_baseScope,["30Rnd_762x39_Mag_F",30],[],"bipod_01_F_blk"],
		[],
		[],
		[_attackerUniform,[["FirstAidKit",5]]],
		[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_762x39_Mag_F",10,30]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"AK-12"
	]];
	dClasses append [[
		["arifle_AKS_F","","",_baseScope,["30Rnd_545x39_Mag_F",30],[],"bipod_01_F_blk"],
		[],
		[],
		[_defenderUniform,[["FirstAidKit",5]]],
		[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_545x39_Mag_F",15,30]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"AKS-74u"
	],
	[
		["arifle_Katiba_F","muzzle_snds_H","",_baseScope,["30Rnd_65x39_caseless_green",30],[],""],
		[],
		[],
		[_defenderUniform,[["FirstAidKit",5]]],
		[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_65x39_caseless_green",15,30]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"Katiba"
	],
	[
		["SMG_01_F","muzzle_snds_acp","",_baseScope,["30Rnd_45ACP_Mag_SMG_01",30],[],""],
		[],
		[],
		[_defenderUniform,[["FirstAidKit",5]]],
		[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_45ACP_Mag_SMG_01",15,30]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"Vermin"
	],
	[
		["arifle_AK12_F","","",_baseScope,["30Rnd_762x39_Mag_F",30],[],"bipod_01_F_blk"],
		[],
		[],
		[_defenderUniform,[["FirstAidKit",5]]],
		[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_762x39_Mag_F",10,30]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"AK-12"
	]];
}
else{
	systemchat "Rahim removed";
};
call fn_GetIndexOfCommand;