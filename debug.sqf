private ["_caller","_output"];

_caller = _this select 0;
_output = _this select 1;

(format ["Remote DEBUG %1 : %2", _caller, _output]) call BIS_fnc_log;
