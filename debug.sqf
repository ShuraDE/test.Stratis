private ["_caller","_output"];

if (isNil "DEBUG_OUTPUT" || !DEBUG_OUTPUT) exitWith {};


if (!(isServer)) then exitWith {
  if (player) then {
    _caller = name player;
  } else {
    _caller = "no pl/srv";
  };
  [[_caller, _this],"GA_DEBUG",false,false] call BIS_fnc_MP;
};


if (typeName _this == "ARRAY" && count _this == 2) then {
  _output = _this select 0;
  _caller = _this select 1;
} else {
  _output = str(_this);
  _caller = "server";
};


if (!isNil "DEBUG_OUTPUT" && DEBUG_TYPE_HINT) then {hintSilent format ["debug: %1", _msg];};
if (!isNil "DEBUG_TYPE_CHAT" && DEBUG_TYPE_CHAT) then {systemChat format ["debug: %1", _msg];};
if (!isNil "DEBUG_TYPE_LOG" && DEBUG_TYPE_CHAT) then {diag_log format ["debug: %1", _msg]};
