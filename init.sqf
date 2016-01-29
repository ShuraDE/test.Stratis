waituntil {!isnil "bis_fnc_init"};
S_INIT = false;
S_CLIENT = false;

if(isServer) then {
    S_INIT = true;
} else {
	S_CLIENT = true;if(isNull player)then{[] spawn {waitUntil {!isNull player};S_INIT = true;}} else {S_INIT = true;};  	// erst wenn Player auf Karte wird init.sqf weitergelden
};
waitUntil{S_INIT};

diag_log "init.sqf";
/////// Start

GA_LOADOUT = compile preprocessFileLineNumbers "loadout_distribution.sqf";

if (isServer) then {
  dummyGroupEast = createGroup east;
  publicVariable "dummyGroupEast";
};

if ((local s1 && isPlayer s1) || (local s2 && isPlayer s2)) then {

  diag_log "init.sqf => player is s1 or s2";
  diag_log str(name player);

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
