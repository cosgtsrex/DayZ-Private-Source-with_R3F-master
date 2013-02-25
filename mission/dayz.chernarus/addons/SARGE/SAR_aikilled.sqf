private["_pos","_ai","_aikiller","_player_or_ai","_aikiller_type","_aikiller_name", "_aikiller_side"];

//_pos = _this select 0;

// SARGE DEBUG: TODO - humanity adjustments for players killing AI

_ai = _this select 0;
_aikiller = _this select 1;

if(isPlayer _aikiller) then {
    _player_or_ai = "Player";
    
} else {
    _player_or_ai = "AI";
};

_aikilled_type = typeof _ai;
_aikilled_name = name _ai;
_aikilled_side = side _ai;
_aikilled_group_side = side (group _ai);

_aikiller_type = typeof _aikiller;
_aikiller_name = name _aikiller;
_aikiller_side = side _aikiller;
_aikiller_group_side = side (group _aikiller);
// add side 4 debug

diag_log format["AI killed - Type: %1 Name: %2 Side: %3 Group Side: %4",_aikilled_type,_aikilled_name, _aikilled_side,_aikilled_group_side];

diag_log format["AI Killer - Type: %1 Name: %2 Side: %3 Group Side: %4",_aikiller_type,_aikiller_name, _aikiller_side,_aikiller_group_side];