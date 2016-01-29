"initPlayerLocal.sqf" call BIS_fnc_log;
str(name player) call BIS_fnc_log;
/*
GA_LOADOUT = compile preprocessFileLineNumbers "loadout_distribution.sqf";

waituntil {!isnil "bis_fnc_init"};
waitUntil {!isNull player};

If (player == s1 || player == s2) then {

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

player addEventHandler ["Killed",{
    [player] joinSilent grpNull;
    [player] joinSilent dummyGroupEast;
    player removeEventHandler ["killed", 0];
}];
*/
