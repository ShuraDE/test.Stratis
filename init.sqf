waituntil {!isnil "bis_fnc_init"};
S_INIT = false;
S_CLIENT = false;

if(isServer) then {
    S_INIT = true;
} else {
	S_CLIENT = true;if(isNull player)then{[] spawn {waitUntil {!isNull player};S_INIT = true;}} else {S_INIT = true;};  	// erst wenn Player auf Karte wird init.sqf weitergelden
};
waitUntil{S_INIT};

//load srv first !
GA_DEBUG_SRV = compile preprocessFileLineNumbers "debug.sqf";
GA_DEBUG = compile preprocessFileLineNumbers "debug_local.sqf";

GA_LOADOUT = compile preprocessFileLineNumbers "loadout_distribution.sqf";



"init.sqf" call GA_DEBUG;
"init.sqf" call BIS_fnc_log;
/////// Start

if (isServer) then {
  dummyGroupEast = createGroup east;
  publicVariable "dummyGroupEast";
  "isServer" call GA_DEBUG;
};

if ((local s1 && isPlayer s1) || (local s2 && isPlayer s2)) then {

  "init.sqf => player is s1 or s2" call GA_DEBUG;
  str(name player) call GA_DEBUG;

	//define "LOADOUT_EAST" loadout array's
	script_handler = [] spawn compile preprocessFileLineNumbers "loadout_opfor.sqf";
	waitUntil { scriptDone script_handler };

	//select gm modul
	_gmModul = if (local s1) then { GM01; } else { GM02; };
	//append EH to modul
	_gmModul addEventHandler ["CuratorObjectPlaced",{
  _unit = (_this select 1);

	  if (_unit isKindOf "Man") then {
  		//loadout distribution
  		switch (side _unit) do {
  			case EAST: { [_unit, LOADOUT_EAST, 1] spawn GA_LOADOUT; };
  			case CIV: { [_unit, LOADOUT_EAST, 0] spawn GA_LOADOUT; };
  		};
	  };
	}];
};

"init done" call GA_DEBUG;
"init done" call BIS_fnc_log;
