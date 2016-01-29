private ["_caller","_output"];

//if (isNil "DEBUG_OUTPUT" || !DEBUG_OUTPUT) exitWith {};

if (!isServer) exitWith {
  if (isNull player) then {
    _caller = "no pl/srv";
  } else {
    _caller = name player;
  };
  [[_caller, _this],"GA_DEBUG",false,false] call BIS_fnc_MP;
};


if ((typeName _this) == "ARRAY" && (count _this) == 2) then {
  _output = _this select 0;
  _caller = _this select 1;
} else {
  _output = str(_this);
  _caller = "server";
};

diag_log format ["DEBUG %1 : %2", _caller, _output];
