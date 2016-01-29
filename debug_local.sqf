private ["_output","_caller"];
_output = _this;

if (!isServer) then {

  //local output
  _output call BIS_fnc_log;

  if (isNull player) then {
    _caller = "no pl/srv";
  } else {
    _caller = profileName;
  };

  //add to server log
  [[_caller, _output],"GA_DEBUG_SRV",false,false] call BIS_fnc_MP;
} else {
  (format ["SRV DEBUG : %1", _output]) call BIS_fnc_log;
};
