waituntil {!isnil "bis_fnc_init"};
S_INIT = false;
S_CLIENT = false;

if(isServer) then {
    S_INIT = true;
} else {
	S_CLIENT = true;if(isNull player)then{[] spawn {waitUntil {!isNull player};S_INIT = true;}} else {S_INIT = true;};  	// erst wenn Player auf Karte wird init.sqf weitergelden
};
waitUntil{S_INIT};

GA_LOADOUT = compile preprocessFileLineNumbers "loadout_distribution.sqf";


"init.sqf" call GA_fnc_DEBUG;

/////// Start

if (isServer) then {
  "isServer" call GA_fnc_DEBUG;
};


"init done" call GA_fnc_DEBUG;
