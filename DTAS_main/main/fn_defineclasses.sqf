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
_Options = DefaultOptions;
_UID = getPlayerUID player;
_clientID = clientOwner;
LoadDataForChallenges = [_UID,_clientID];
publicVariableServer "LoadDataForChallenges";
_data = StatsForChallenge;
_nvgs = "NVGoggles_OPFOR";
_attackerUniform = "U_I_CombatUniform_shortsleeve";
_defenderUniform = "U_I_C_Soldier_Para_5_F";
if((_data select 0) >= 30)then{
	_attackerUniform = "U_B_CTRG_Soldier_F";
	_defenderUniform = "U_B_CTRG_Soldier_F";
}else{
	_attackerUniform = "U_I_CombatUniform_shortsleeve";
	_defenderUniform = "U_I_C_Soldier_Para_5_F";
};
_Avest = "V_PlateCarrier2_blk";
_Dvest = "V_PlateCarrier2_rgr";
_helmet = "H_PASGT_basic_black_F";
_dhelmet = "H_HelmetB_light";
if((_data select 0) >=20)then{
	_helmet = "H_HelmetB";
	_dhelmet = "H_HelmetB";
}else{
	_helmet = "H_PASGT_basic_black_F";
	_dhelmet = "H_HelmetB_light";
};
if((_data select 0) >=40)then{
	_helmet = "H_HelmetSpecB_blk";
	_dhelmet = "H_HelmetSpecB_blk";
};
_SMG45Sup = "";
_SMG9Sup = "";
_SMG57Sup = "";

_MK1Sup = "";
_MXSWSup = "";
_MXMSup = "";
_SPARSup = "";
_CARSup = "";

_LPAR556Sup = "";
_LPAR58Sup = "";

_MRSup = "";

_HPAR65Sup = "";
_HPAR65stSup = "";
_HPAR762Sup = "";
if((_data select 9)>= 25)then{
	_SMG45Sup = "muzzle_snds_acp";
	_SMG9Sup = "muzzle_snds_L";
	_SMG57Sup = "muzzle_snds_570";
};
if((_data select 8)>= 75)then{
	_MRSup = "muzzle_snds_B";
};
if((_data select 7)>= 25)then{
	_LPAR556Sup = "muzzle_snds_M";
	_LPAR58Sup = "muzzle_snds_58_ghex_F";
};
if((_data select 6)>= 25)then{
	_SPARSup = "muzzle_snds_M";
	_CARSup = "muzzle_snds_58_ghex_F";
};
if((_data select 5)>= 25)then{
	_MXMSup = "muzzle_snds_H";
};
if((_data select 4)>= 25)then{
	_MXSWSup = "muzzle_snds_H";
};
if((_data select 3)>= 75)then{
	_MK1Sup = "muzzle_snds_B";
};
if((_data select 10)>= 25)then{
	_HPAR65Sup = "muzzle_snds_H";
	_HPAR65stSup = "muzzle_snds_65_TI_blk_F";
	_HPAR762Sup = "muzzle_snds_B";
};

_LPbipod = "";
_HPbipod = "";
_MK1bipod = "";
_MXSWbipod = "";
_MXMbipod = "";
_MRbipod = "";
_carsparpod = "";
if((_data select 8)>= 10)then{
	_MRbipod = "bipod_01_F_blk";
};
if((_data select 7)>= 10)then{
	_LPbipod = "bipod_01_F_blk";
};
if((_data select 6)>= 10)then{
	_carsparpod = "bipod_01_F_blk";
};
if((_data select 5)>= 10)then{
	_MXMbipod = "bipod_01_F_blk";
};
if((_data select 4)>= 10)then{
	_MXSWbipod = "bipod_01_F_blk";
};
if((_data select 3)>= 10)then{
	_MK1bipod = "bipod_01_F_blk";
};
if((_data select 10)>= 10)then{
	_HPbipod = "bipod_01_F_blk";
};
private _baseScope = profileNameSpace getVariable ["ADC_PreferredScope", "optic_Arco_blk_F"];
fn_GetIndexOfCommand = compile preprocessFileLineNumbers "DTAS_main\server\fn_GetIndexOfCommand.sqf";
fn_definedefaultextras = compile preprocessFileLineNumbers "DTAS_main\main\fn_definedefaultextras.sqf";
fn_defineNonSeriousModeClasses = compile preprocessFileLineNumbers "DTAS_main\main\fn_defineNonSeriousModeClasses.sqf";
if !(_baseScope in (["optic_MRCO", "optic_hamr", "optic_Arco_blk_F","optic_ERCO_blk_F"])) then {
	_baseScope = "optic_Arco_blk_F";
};
aClasses = [];
dClasses =[];

if(_Options select 0)then{
	aClasses append [
	[	
	["SMG_01_F",_SMG45Sup,"",_baseScope,["30Rnd_45ACP_Mag_SMG_01",30],[],""],
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
	["SMG_05_F",_SMG9Sup,"",_baseScope,["30Rnd_9x21_Mag_SMG_02",30],[],""],
	[],
	[],
	[_attackerUniform,[["FirstAidKit",5]]],
	[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_9x21_Mag_SMG_02",15,30]]],
	[],
	_helmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"Protector"
	],
	[	
	["SMG_03_TR_black",_SMG57Sup,"",_baseScope,["50Rnd_570x28_SMG_03",50],[],""],
	[],
	[],
	[_attackerUniform,[["FirstAidKit",5]]],
	[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["50Rnd_570x28_SMG_03",15,50]]],
	[],
	_helmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"ADR-97"
	]
	];
	dClasses append [
	[	
	["SMG_01_F",_SMG45Sup,"",_baseScope,["30Rnd_45ACP_Mag_SMG_01",30],[],""],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_45ACP_Mag_SMG_01",15,30]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"Vermin"
	],
	[	
	["SMG_05_F",_SMG9Sup,"",_baseScope,["30Rnd_9x21_Mag_SMG_02",30],[],""],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_9x21_Mag_SMG_02",15,30]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"Protector"
	],
	[	
	["SMG_03_TR_black",_SMG57Sup,"",_baseScope,["50Rnd_570x28_SMG_03",50],[],""],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["50Rnd_570x28_SMG_03",15,50]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"ADR-97"
	]
	];
};
if(_Options select 1)then{
	aClasses append [
	[	
	["arifle_Mk20_plain_F",_LPAR556Sup,"",_baseScope,["30Rnd_556x45_Stanag",30],[],""],
	[],
	[],
	[_attackerUniform,[["FirstAidKit",5]]],
	[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_556x45_Stanag",15,30]]],
	[],
	_helmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"MK20"
	],
	[	
	["arifle_SPAR_01_blk_F",_LPAR556Sup,"",_baseScope,["30Rnd_556x45_Stanag",30],[],_LPbipod],
	[],
	[],
	[_attackerUniform,[["FirstAidKit",5]]],
	[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_556x45_Stanag",15,30]]],
	[],
	_helmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"Spar 16"
	]];

	dClasses append [
	[	
	["arifle_AKS_F","","",_baseScope,["30Rnd_545x39_Mag_F",30],[],""],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_545x39_Mag_F",15,30]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"AKS-74u"
	],
	[	
	["arifle_CTAR_ghex_F",_LPAR58Sup,"",_baseScope,["30Rnd_580x42_Mag_F",30],[],""],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_580x42_Mag_F",15,30]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"Car 95"
	],
	[	
	["arifle_TRG21_F",_LPAR556Sup,"",_baseScope,["30Rnd_556x45_Stanag",30],[],""],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_556x45_Stanag",15,30]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"TRG 21"
	]];
};
if(_Options select 2)then{
	aClasses append [
	[	
	["arifle_MX_Black_F",_HPAR65Sup,"",_baseScope,["30Rnd_65x39_caseless_mag",30],[],_HPbipod],
	[],
	[],
	[_attackerUniform,[["FirstAidKit",5]]],
	[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_65x39_caseless_mag",15,30]]],
	[],
	_helmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"MX"
	],
	[	
	["arifle_ARX_blk_F",_HPAR65stSup,"",_baseScope,["30Rnd_65x39_caseless_green",30],[],_HPbipod],
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
	]];

	dClasses append [
	[	
	["arifle_Katiba_F",_HPAR65Sup,"",_baseScope,["30Rnd_65x39_caseless_green",30],[],""],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_65x39_caseless_green",15,30]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"Katiba"
	],
	[	
	["arifle_AK12_F",_HPAR762Sup,"",_baseScope,["30Rnd_762x39_Mag_F",30],[],_HPbipod],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_762x39_Mag_F",15,30]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"AK-12"
	],
	[	
	["arifle_ARX_ghex_F",_HPAR65stSup,"",_baseScope,["30Rnd_65x39_caseless_green",30],[],_HPbipod],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_65x39_caseless_green",15,30]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"Type 115"
	]];
};
if(_Options select 3)then{
	aClasses append [
	[	
	["arifle_MXM_Black_F",_MXMSup,"",_baseScope,["30Rnd_65x39_caseless_mag",30],[],_MXMbipod],
	[],
	[],
	[_attackerUniform,[["FirstAidKit",5]]],
	[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_65x39_caseless_mag",15,30]]],
	[],
	_helmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"MXM"
	],
	[	
	["srifle_DMR_03_F",_MK1Sup,"",_baseScope,["20Rnd_762x51_Mag",20],[],_MK1bipod],
	[],
	[],
	[_attackerUniform,[["FirstAidKit",5]]],
	[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["20Rnd_762x51_Mag",15,20]]],
	[],
	_helmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"MK-1"
	],
	[	
	["arifle_SPAR_03_blk_F",_MRSup,"",_baseScope,["20Rnd_762x51_Mag",20],[],_MRbipod],
	[],
	[],
	[_attackerUniform,[["FirstAidKit",5]]],
	[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["20Rnd_762x51_Mag",15,20]]],
	[],
	_helmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"Spar-17"
	],
	[	
	["srifle_EBR_F",_MRSup,"",_baseScope,["20Rnd_762x51_Mag",20],[],_MRbipod],
	[],
	[],
	[_attackerUniform,[["FirstAidKit",5]]],
	[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["20Rnd_762x51_Mag",15,20]]],
	[],
	_helmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"MK-18"
	]
	];

	dClasses append [
	[	
	["arifle_MXM_F",_MXMSup,"",_baseScope,["30Rnd_65x39_caseless_mag",30],[],_MXMbipod],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_65x39_caseless_mag",15,30]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"MXM"
	],
	[	
	["srifle_DMR_03_khaki_F",_MK1Sup,"",_baseScope,["20Rnd_762x51_Mag",20],[],_MK1bipod],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["20Rnd_762x51_Mag",15,20]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"MK-1"
	],
	[	
	["srifle_DMR_06_camo_F",_MRSup,"",_baseScope,["20Rnd_762x51_Mag",20],[],_MRbipod],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["20Rnd_762x51_Mag",15,20]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"MK14"
	]];
};
if(_Options select 4)then{
	aClasses append [
	[	
	["arifle_MX_SW_Black_F",_MXSWSup,"",_baseScope,["100Rnd_65x39_caseless_mag",100],[],_MXSWbipod],
	[],
	[],
	[_attackerUniform,[["FirstAidKit",5]]],
	[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["100Rnd_65x39_caseless_mag",15,100]]],
	[],
	_helmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"MXSW"
	],
	[	
	["arifle_SPAR_02_blk_F",_SPARSup,"",_baseScope,["150Rnd_556x45_Drum_Mag_F",150],[],_carsparpod],
	[],
	[],
	[_attackerUniform,[["FirstAidKit",5]]],
	[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["150Rnd_556x45_Drum_Mag_F",15,150]]],
	[],
	_helmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"Spar-16s"
	]];

	dClasses append [
	[	
	["arifle_MX_SW_F",_MXSWSup,"",_baseScope,["100Rnd_65x39_caseless_mag",100],[],_MXSWbipod],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["100Rnd_65x39_caseless_mag",15,100]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"MXSW"
	],
	[	
	["arifle_CTARS_ghex_F",_CARSup,"",_baseScope,["100Rnd_580x42_Mag_F",100],[],""],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["100Rnd_580x42_Mag_F",15,100]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"Car-95-1"
	]];
};
if(_Options select 5)then{
	aClasses append [
	[	
	["arifle_AKM_F","","",_baseScope,["30Rnd_762x39_Mag_F",30],[],""],
	[],
	[],
	[_attackerUniform,[["FirstAidKit",5]]],
	[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_762x39_Mag_F",15,30]]],
	[],
	_helmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"AKM"
	],
	[	
	["LMG_03_F",_SPARSup,"",_baseScope,["200Rnd_556x45_Box_F",200],[],""],
	[],
	[],
	[_attackerUniform,[["FirstAidKit",5]]],
	[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["200Rnd_556x45_Box_F",15,200]]],
	[],
	_helmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"LIM"
	],
	[	
	["srifle_DMR_01_F","","",_baseScope,["10Rnd_762x54_Mag",10],[],""],
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
	["srifle_DMR_07_blk_F",_HPAR65stSup,"",_baseScope,["20Rnd_650x39_Cased_Mag_F",20],[],""],
	[],
	[],
	[_attackerUniform,[["FirstAidKit",5]]],
	[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["20Rnd_650x39_Cased_Mag_F",15,20]]],
	[],
	_helmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"CMR"
	]
	];

	dClasses append [
	[	
	["arifle_AKM_F","","",_baseScope,["30Rnd_762x39_Mag_F",30],[],""],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["30Rnd_762x39_Mag_F",15,30]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"AKM"
	],
	[	
	["LMG_03_F",_SPARSup,"",_baseScope,["200Rnd_556x45_Box_F",200],[],""],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["200Rnd_556x45_Box_F",15,200]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"LIM"
	],
	[	
	["srifle_DMR_01_F","","",_baseScope,["10Rnd_762x54_Mag",10],[],""],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["10Rnd_762x54_Mag",15,10]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"Rahim"
	],
	[	
	["srifle_DMR_07_blk_F",_HPAR65stSup,"",_baseScope,["20Rnd_650x39_Cased_Mag_F",20],[],""],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["20Rnd_650x39_Cased_Mag_F",15,20]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"CMR"
	]
	];
};
if(_Options select 6)then{
	aClasses append [
	[	
	["LMG_Mk200_F","","",_baseScope,["200Rnd_65x39_cased_Box",200],[],_MXSWbipod],
	[],
	[],
	[_attackerUniform,[["FirstAidKit",5]]],
	[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["200Rnd_65x39_cased_Box",15,200]]],
	[],
	_helmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"MK200"
	],
	[	
	["LMG_Zafir_F","","",_baseScope,["150Rnd_762x54_Box",150],[],""],
	[],
	[],
	[_attackerUniform,[["FirstAidKit",5]]],
	[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["150Rnd_762x54_Box",15,150]]],
	[],
	_helmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"Zafir"
	],
	[	
	["srifle_DMR_04_F","","",_baseScope,["10Rnd_127x54_Mag",10],[],""],
	[],
	[],
	[_attackerUniform,[["FirstAidKit",5]]],
	[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["10Rnd_127x54_Mag",15,10]]],
	[],
	_helmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"ASP"
	],
	[	
	["srifle_DMR_02_F","","",_baseScope,["10Rnd_338_Mag",10],[],""],
	[],
	[],
	[_attackerUniform,[["FirstAidKit",5]]],
	[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["10Rnd_338_Mag",15,10]]],
	[],
	_helmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"MAR-10"
	]
	];

	dClasses append [
	[	
	["LMG_Mk200_F","","",_baseScope,["200Rnd_65x39_cased_Box",200],[],_MXSWbipod],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["200Rnd_65x39_cased_Box",15,200]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"MK200"
	],
	[	
	["LMG_Zafir_F","","",_baseScope,["150Rnd_762x54_Box",150],[],""],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["150Rnd_762x54_Box",15,150]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"Zafir"
	],
	[	
	["srifle_DMR_04_F","","",_baseScope,["10Rnd_127x54_Mag",10],[],""],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["10Rnd_127x54_Mag",15,10]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"ASP"
	],
	[	
	["srifle_DMR_05_blk_F","","",_baseScope,["10Rnd_93x64_DMR_05_Mag",10],[],""],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["10Rnd_93x64_DMR_05_Mag",15,10]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"Cyrus"
	]
	];
};
if(_Options select 7)then{
	aClasses append [
	[	
	["srifle_GM6_ghex_F","","",_baseScope,["5Rnd_127x108_Mag",5],[],""],
	[],
	[],
	[_attackerUniform,[["FirstAidKit",5]]],
	[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["5Rnd_127x108_Mag",15,5]]],
	[],
	_helmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"Lynx"
	],
	[	
	["MMG_01_hex_F","","",_baseScope,["150Rnd_93x64_Mag",150],[],""],
	[],
	[],
	[_attackerUniform,[["FirstAidKit",5]]],
	[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["150Rnd_93x64_Mag",15,150]]],
	[],
	_helmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"Navid"
	],
	[	
	["MMG_02_camo_F","","",_baseScope,["130Rnd_338_Mag",130],[],""],
	[],
	[],
	[_attackerUniform,[["FirstAidKit",5]]],
	[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["130Rnd_338_Mag",15,130]]],
	[],
	_helmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"SPMG"
	],
	[	
	["srifle_LRR_tna_F","","",_baseScope,["7Rnd_408_Mag",7],[],""],
	[],
	[],
	[_attackerUniform,[["FirstAidKit",5]]],
	[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["7Rnd_408_Mag",15,7]]],
	[],
	_helmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"M320"
	]
	];

	dClasses append [
	[	
	["srifle_GM6_ghex_F","","",_baseScope,["5Rnd_127x108_Mag",5],[],""],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["5Rnd_127x108_Mag",15,5]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"Lynx"
	],
	[	
	["MMG_01_hex_F","","",_baseScope,["150Rnd_93x64_Mag",150],[],""],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["150Rnd_93x64_Mag",15,150]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"Navid"
	],
	[	
	["MMG_02_camo_F","","",_baseScope,["130Rnd_338_Mag",130],[],""],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["130Rnd_338_Mag",15,130]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"SPMG"
	],
	[	
	["srifle_LRR_tna_F","","",_baseScope,["7Rnd_408_Mag",7],[],""],
	[],
	[],
	[_defenderUniform,[["FirstAidKit",5]]],
	[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["7Rnd_408_Mag",15,7]]],
	[],
	_dhelmet,
	"G_Bandanna_beast",
	["Rangefinder","","","",[],[],""],
	["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
	"M320"
	]
	];
};
/*
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
		["arifle_MX_SW_black_F","muzzle_snds_H","",_baseScope,["100Rnd_65x39_caseless_black_mag",100],[],"bipod_01_F_blk"],
		[],
		[],
		["U_B_CTRG_Soldier_F",[["FirstAidKit",5]]],
		[_Avest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["100Rnd_65x39_caseless_black_mag",8,100]]],
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
		["srifle_DMR_03_khaki_F","","",_baseScope,["20Rnd_762x51_Mag",20],[],"bipod_01_F_blk"],
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
		["arifle_MXM_F","muzzle_snds_H","",_baseScope,["30Rnd_65x39_caseless_mag",30],[],"bipod_01_F_blk"],
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
		["arifle_MX_SW_F","muzzle_snds_H","",_baseScope,["100Rnd_65x39_caseless_black_mag",100],[],"bipod_01_F_blk"],
		[],
		[],
		[_defenderUniform,[["FirstAidKit",5]]],
		[_Dvest,[["optic_MRCO",1],["optic_hamr",1],[_nvgs,1],["100Rnd_65x39_caseless_black_mag",8,100]]],
		[],
		_helmet,
		"G_Bandanna_beast",
		["Rangefinder","","","",[],[],""],
		["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""],
		"MX-SW (100Rnd)"
	]
];
*/







call fn_GetIndexOfCommand;
