/*
//dependency
RHS
TFAR
*/

_rnd_uniform = [
	"rhs_chdkz_uniform_5",
	"rhs_chdkz_uniform_4",
	"rhs_chdkz_uniform_3",
	"rhs_chdkz_uniform_2",
	"rhs_chdkz_uniform_1"
];

_rnd_vest = [
  "rhsusf_spc_iar"
];

_rnd_helmet = [
	"H_ShemagOpen_khk",
	"H_ShemagOpen_tan",
	"H_Shemag_olive"
];


_rnd_backpack = [
  "B_Carryall_khk"
];


//bärte
_rnd_goggles = [
"TRYK_Beard_BK","TRYK_Beard_BK","TRYK_Beard_BK","TRYK_Beard_BK",
"TRYK_Beard_BK2","TRYK_Beard_BK2","TRYK_Beard_BK2","TRYK_Beard_BK2",
"TRYK_Beard_BK3","TRYK_Beard_BK3","TRYK_Beard_BK3","TRYK_Beard_BK3",
"TRYK_Beard_BK4","TRYK_Beard_BK4","TRYK_Beard_BK4","TRYK_Beard_BK4",
"TRYK_Beard_Gr","TRYK_Beard_Gr2","TRYK_Beard_Gr3","TRYK_Beard_Gr4"
];

//each unit get all
//basic items (medic, earplugs,...), count
_basicItemsInv = 	[
	["ACE_Earplugs", 1],
	["ACE_fieldDressing", 6],
	["ACE_Morphine", 2],
	["ACE_epinephrine", 1],
	["ACE_Flashlight_KSF1", 1],
	["ACE_MapTools", 1],
	["Chemlight_blue", 2]
];

//each unit get all
_basicItemsLinked = [
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"tf_fadak"
];

//object, min, mid, max count
_rnd_nades = [
 ["rhs_VG40OP_white",1,1,2],
 ["rhs_GRD40_Green",0,0,2],
 ["rhs_VOG25",0,1,2]
];


//weapon, [] possible mags with min, mid, max counter, [] weapon attachments, [] additional ammo (gl, missle types)
_rnd_weapon_primary = [
  ["rhs_weap_akm",
		[["rhs_30Rnd_762x39mm",3,5,8],["rhs_30Rnd_762x39mm_tracer",3,5,6]],
		["acc_flashlight"],
		[]
	]
];

_rnd_weapon_primary_gl = [
	["rhs_weap_ak103_gp25_npz",
		[["rhs_30Rnd_762x39mm",3,5,6],["rhs_30Rnd_762x39mm_tracer",3,5,6]],
		["acc_flashlight","rhs_acc_dtk","optic_Aco"],
		[["rhs_mag_rgd5",1,2,8]]
	]
];

_rnd_weapon_secondary = [
  ["rhs_weap_rpg7",
		[["rhs_rpg7_PG7VL_mag",1,2,3]],
		[],
		[]
	]
];

_rnd_weapon_primary_lmg = [
  ["rhs_weap_pkm",
		[["rhs_100Rnd_762x54mmR",1,3,5],["rhs_100Rnd_762x54mmR_green",1,3,5]],
		[],
		[]
	]
];

//pistol
_rnd_weapon_side = [
  ["rhsusf_weap_glock17g4",
		[["rhsusf_mag_17Rnd_9x19_JHP",1,1,3]],
		[],
		[]
	]
];

LOADOUT_EAST_CLASSES_AR = ["O_G_Soldier_AR_F","O_Soldier_AR_F","O_soldierU_AR_F","O_HeavyGunner_F","O_Urban_HeavyGunner_F"];
LOADOUT_EAST_CLASSES_AT = ["O_G_Soldier_LAT_F", "O_Soldier_LAT_F","O_Soldier_AT_F","O_recon_LAT_F","O_soldierU_LAT_F"];

LOADOUT_EAST = [_rnd_uniform, _rnd_vest, _rnd_helmet, _rnd_backpack,
				_rnd_nades, _rnd_weapon_primary, _rnd_weapon_secondary, _rnd_weapon_side,
				_basicItemsInv, _basicItemsLinked,
				_rnd_weapon_primary_lmg, _rnd_goggles, _rnd_weapon_primary_gl];
