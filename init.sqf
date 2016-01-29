waituntil {!isnil "bis_fnc_init"};
waitUntil {!isNull player};


GA_LOADOUT = compile preprocessFileLineNumbers "loadout_distribution.sqf";

if (isServer) then {
  dummyGroupEast = createGroup east;
  publicVariable "dummyGroupEast";
};

if (player == s1 || player ==  s2) then {

  diag_log "player is s1 or s2";

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

  		//loadout distribution
  		switch (side _unit) do {
  			case EAST: { [_unit, LOADOUT_EAST, 1] spawn GA_LOADOUT; };
  			case CIV: { [_unit, LOADOUT_EAST, 0] spawn GA_LOADOUT; };
  		};
	  };
	}];
};

if (player) then {
  player setVariable ["ACE_CanSwitchUnits", true];
};
