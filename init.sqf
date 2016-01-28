GA_LOADOUT = compile preprocessFileLineNumbers "loadout_distribution.sqf";

//toDO
//add ugl ammo to akm gp25 (opfor loadout)

if (local s1 && isPlayer s1 || local s2 && isPlayer s2) then {

	//define "LOADOUT_EAST" loadout array's
	script_handler = [] spawn compile preprocessFileLineNumbers "loadout_opfor.sqf";
	waitUntil { scriptDone script_handler };

	//select gm modul
	_gmModul = if (local s1) then { GM01; } else { GM02; };
	//append EH to modul
	_gmModul addEventHandler ["CuratorObjectPlaced",{

	  _unit = (_this select 1);
	  if (_unit isKindOf "Man") then {

		//make unit switchable
		addSwitchableUnit _unit;
		_unit setVariable ["ACE_CanSwitchUnits", true];

		//loadout distribution
		switch (side _unit) do {
			case EAST: { [_unit, LOADOUT_EAST, 1] spawn GA_LOADOUT; };
			case CIV: { [_unit, LOADOUT_EAST, 0] spawn GA_LOADOUT; };
		};
	  } else {
		//debug
			hint "no soldier";
	  }
	}];
};
