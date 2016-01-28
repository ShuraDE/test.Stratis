private ["_unit", "_loadout", "_armed", "_weaponMarkAttachment","_weaponMark2ndAmmo",
				 "_rnd_uniform","_rnd_vest","_rnd_helmet","_rnd_backpack","_nades",
				 "_rnd_weapon_primary","_rnd_weapon_secondary","_rnd_weapon_side",
				 "_basicItemsInv","_basicItemsLinked","_backbackMark","_goggleMark", "_weaponMarkGL"];

/*
IN: _unit 		= player or ki men
	_loadout	= array with arrays with pieces of loadouts --> loadout_opfor.sqf
				[_rnd_uniform, _rnd_vest, _rnd_helmet, _rnd_backpack, _nades, _rnd_weapon_primary, _rnd_weapon_secondary, _rnd_weapon_side, _basicItemsInv, _basicItemsLinked];
	_armed 		= 0 = unarmed
*/


//params
_backbackMark = 2; //value 0-10,  					x > (random 10) == add backpack (at & ar get alway one)
_goggleMark = 9;  //value 0-10,   					x > (random 10) == add google / beard
_weaponMarkAttachment = 7; //value 0-10, 		x > (random 10) == add attachment
_weaponMark2ndAmmo = 6; //value 0-10,  			x > (random 10) == add ammo from secondary ammo array
_weaponMarkGL = 2; //value 0-10,  					x > (random 10) == add GL weapon instead default


//function params
_unit = _this select 0;
_loadout = _this select 1;
_armed = _this select 2;


//loadout faction master .. contains differnet arrays = cloth(uniform, vest, helmet, backpack), weapons(nades,primary,secondary,side), other(linkItems, Items)
/*
LOADOUT_EAST = [_rnd_uniform, _rnd_vest, _rnd_helmet, _rnd_backpack,
				_rnd_nades, _rnd_weapon_primary, _rnd_weapon_secondary, _rnd_weapon_side,
				_basicItemsInv, _basicItemsLinked,
				_rnd_weapon_primary_lmg, _rnd_goggles];
*/
_rnd_uniform = _loadout select 0;
_rnd_vest = _loadout select 1;
_rnd_helmet = _loadout select 2;
_rnd_backpack = _loadout select 3;
_rnd_nades = _loadout select 4;
_rnd_weapon_primary = _loadout select 5;
_rnd_weapon_secondary = _loadout select 6;
_rnd_weapon_side = _loadout select 7;
_basicItemsInv = _loadout select 8;
_basicItemsLinked = _loadout select 9;
_rnd_weapon_primary_lmg = _loadout select 10;
_rnd_googles = _loadout select 11;
_rnd_weapon_primary_gl = _loadout select 12;

//remove all items
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

//// INV Helpers
_fortuity = {
	if (_this < (random 10)) then { true; } else { false; };
};

_addItems = {
    _class = _this select 0;
    _amount = _this select 1;

    for "_i" from 1 to _amount do {
        _unit addItem _class;
    };
};

_addMagsToUnit = {
	_mag = _this select 0;

	//working with arma 1.55
	//_unit addItemCargo [_mag select 0, (floor random [(_mag select 1), (_mag select 2), (_mag select 3)])];
	[_mag select 0, (_mag select 2)] call _addItems;
};
_addWeaponToUnit = {
	_weapon = _this select 0 select 0;
	_magArray = (_this select 0 select 1) call BIS_fnc_selectRandom;
	_attachments = _this select 0 select 2;
	_additionalAmmo = _this select 0 select 3;


	//mags first, weapon is armed
	//add mags
	[_magArray] call _addMagsToUnit;
	//add additional mags
	if (count _additionalAmmo > 0 && _weaponMark2ndAmmo call _fortuity) then {
		[_additionalAmmo call BIS_fnc_selectRandom] call _addMagsToUnit;
	};

	//add weapon with attachment
	_unit addWeapon _weapon;
	hint format["%1\n%2", getText(configFile >> "CfgVehicles" >> _weapon >> "vehicleClass"), _weapon];
	if (count _attachments > 0 && _weaponMarkAttachment call _fortuity) then {
		switch (getText(configFile >> "CfgVehicles" >> _weapon >> "vehicleClass")) do {
			case "WeaponsPrimary": { _unit addPrimaryWeaponItem (_attachments call BIS_fnc_selectRandom); };
			case "WeaponsSecondary": { _unit addSecondaryWeaponItem (_attachments call BIS_fnc_selectRandom); };
			case "WeaponsHandgun": { _unit addHandgunItem  (_attachments call BIS_fnc_selectRandom); };
		};
	};
};

//// START Inventory

//outfit
_unit forceAddUniform (_rnd_uniform call BIS_fnc_selectRandom);
_unit addVest (_rnd_vest call BIS_fnc_selectRandom);
_unit addHeadgear (_rnd_helmet call BIS_fnc_selectRandom);
if (_goggleMark call _fortuity) then { _unit addGoggles (_rnd_googles call BIS_fnc_selectRandom); };  //80% units get goggles/beards
if (_backbackMark call _fortuity
			|| (typeOf _unit in LOADOUT_EAST_CLASSES_AR)
			|| (typeOf _unit in LOADOUT_EAST_CLASSES_AT)) then { _unit addBackpack  (_rnd_backpack call BIS_fnc_selectRandom); };


//items
{ _unit linkItem _x; } forEach _basicItemsLinked;
{ [_x select 0, _x select 1] call _addItems; } forEach _basicItemsInv;

//weapons
if (_armed > 0) then {
	if (typeOf _unit in LOADOUT_EAST_CLASSES_AR) then  {
		[_rnd_weapon_primary_lmg call BIS_fnc_selectRandom] call _addWeaponToUnit;
	} else {
		//add launcher if AT an regular weapon
		if (typeOf _unit in LOADOUT_EAST_CLASSES_AT) then {
			[_rnd_weapon_secondary call BIS_fnc_selectRandom] call _addWeaponToUnit;
			[_rnd_weapon_primary call BIS_fnc_selectRandom] call _addWeaponToUnit;
		} else {
			//anyone else gets regular weapon or with a chance a better one (gl what ever)
			[(if (_weaponMarkGL call _fortuity) then { _rnd_weapon_primary } else { _rnd_weapon_primary_gl })
			 					call BIS_fnc_selectRandom] call _addWeaponToUnit;
		};
	};


};


//nades, 2 times - (last objects; if no space left, no problem)
[_rnd_nades call BIS_fnc_selectRandom] call _addMagsToUnit;
[_rnd_nades call BIS_fnc_selectRandom] call _addMagsToUnit;
