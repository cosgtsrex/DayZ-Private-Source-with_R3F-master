if(!isServer) exitWith {};

//adjust and cleanup
private ["_counter","_soldierlist", "_group", "_pos","_markerName","_marker","_amountOfVehicles","_hint"];

diag_log format["AI Heli Spawning Started"];

_patrol_area = _this select 0;
_patrol_area_name = _patrol_area;

_patrol_weapon_name="M4A1";
_patrol_magazine_name= getArray (configFile >> "CfgWeapons" >> _patrol_weapon_name >> "magazines") select 0;

diag_log format["SARGE DEBUG: magazintype: %1",_patrol_magazine_name];

// type of soldier list

_leader_sold_list = ["Rocket_DZ"];
_soldier_sold_list = ["Soldier1_DZ","Camo1_DZ"];

_soldiertype="Soldier1_DZ";

_marker_upsmon = _patrol_area;
_rndpos = [_patrol_area_name] call SHK_pos;

// create Heli and patrol the south coast

_groupheli = createGroup west;

// create the heli

_heli = createVehicle ["UH1H_DZ", [(_rndpos select 0) + 10, _rndpos select 1, 80], [], 0, "FLY"];
_heli setVariable ["Sarge",1,true];
_heli engineon true; 
_heli allowDamage false;
[_heli] joinSilent _groupheli;

// create ppl in it

_leaderheli = _groupheli createunit [_leader_sold_list select 0, [(_rndpos select 0) + 10, _rndpos select 1, 0], [], 0.5, "NONE"];
_leaderheli addMagazine _patrol_magazine_name;
_leaderheli addWeapon _patrol_weapon_name;
_leaderheli setVehicleInit "null = [this] execVM 'addons\SARGE\SAR_trace_banditsonly.sqf';";
_leaderheli addMPEventHandler ["MPkilled", {Null = _this execVM "addons\SARGE\SAR_aikilled.sqf";}]; 

_leaderheli action ["getInPilot", _heli];
[_leaderheli] joinSilent _groupheli;

//Support
_man2heli = _groupheli createunit [_soldiertype, [(_rndpos select 0) - 30, _rndpos select 1, 0], [], 0.5, "NONE"];
_man2heli addMagazine _patrol_magazine_name;
_man2heli addWeapon _patrol_weapon_name;
_man2heli addMPEventHandler ["MPkilled", {Null = _this execVM "addons\SARGE\SAR_aikilled.sqf";}]; 

_man2heli action ["getInTurret", _heli,[0]];
[_man2heli] joinSilent _groupheli;

//Rifleman
_man3heli = _groupheli createunit [_soldiertype, [_rndpos select 0, (_rndpos select 1) + 30, 0], [], 0.5, "NONE"];
_man3heli addMagazine _patrol_magazine_name;
_man3heli addWeapon _patrol_weapon_name;
_man3heli addMPEventHandler ["MPkilled", {Null = _this execVM "addons\SARGE\SAR_aikilled.sqf";}]; 

_man3heli action ["getInTurret", _heli,[1]];
[_man3heli] joinSilent _groupheli;

// initialize upsmon for the group

_leaderheli = leader _groupheli;

null=[_leaderheli,_patrol_area_name,'spawned','nofollow','nowait','aware'] execVM 'addons\UPSMON\scripts\upsmon.sqf';

processInitCommands;

diag_log "SARGE - AI Heli patrol spawned";