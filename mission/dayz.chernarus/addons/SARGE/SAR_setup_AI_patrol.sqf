// =========================================================================================================
//  SAR_AI - DayZ AI library
//  Version: 1.1.0 
//  Author: Sarge (sarge@krumeich.ch) 
//
//		Wiki: to come
//		Forum: to come
//		
// ---------------------------------------------------------------------------------------------------------
//  Required:
//  UPSMon  
//  SHK_pos 
//  
// ---------------------------------------------------------------------------------------------------------
//   SAR_setup_AI_patrol.sqf
//   last modified: 20.3.2013
// ---------------------------------------------------------------------------------------------------------
//  Parameters:
//  [ _patrol_area_name (Markername of area to patrol), 
//    grouptype (numeric -> 1=military, 2=survivor, 3=bandits),  
//    number_of_snipers (numeric),
//    number of riflemen (numeric),
//    behaviour (string -> "patrol", "fortify", "ambush", "noUpsmon") 
//    respawn (boolean, -> true,false)
//   ]
// ------------------------------------------------------------------------------------------------------------


private ["_leadername","_patrol_area_name","_grouptype","_snipers","_riflemen","_action","_side","_leader_group","_riflemenlist","_sniperlist","_rndpos","_group","_leader","_i","_cond","_respawn","_ups_respawn","_leader_weapon_names","_leader_items","_leader_tools","_soldier_weapon_names","_soldier_items","_soldier_tools","_sniper_weapon_names","_sniper_items","_sniper_tools"];

if(!isServer) exitWith {};

_patrol_area_name = _this select 0;
_grouptype = _this select 1;
_snipers = _this select 2;
_riflemen = _this select 3;
_action = _this select 4;
_respawn = _this select 5;

switch (_grouptype) do
{
    case 1: // military
    {
        _side = west;
        _leader_group = SAR_leader_sold_list call BIS_fnc_selectRandom;
        _riflemenlist = SAR_soldier_sold_list;
        _sniperlist = SAR_sniper_sold_list;
    };
    case 2: // survivors
    {
        _side = west;
        _leader_group = SAR_leader_surv_list call BIS_fnc_selectRandom;
        _riflemenlist = SAR_soldier_surv_list;
        _sniperlist = SAR_sniper_surv_list;
    };
    case 3: // bandits
    {
        _side = east;
        _leader_group = SAR_leader_band_list call BIS_fnc_selectRandom;
        _riflemenlist = SAR_soldier_band_list;
        _sniperlist = SAR_sniper_band_list;
    };
};

_leader_weapon_names = ["leader"] call SAR_unit_loadout_weapons;
_leader_items = ["leader"] call SAR_unit_loadout_items;
_leader_tools = ["leader"] call SAR_unit_loadout_tools;

_soldier_weapon_names = ["soldier"] call SAR_unit_loadout_weapons;
_soldier_items = ["soldier"] call SAR_unit_loadout_items;
_soldier_tools = ["soldier"] call SAR_unit_loadout_tools;

_sniper_weapon_names = ["sniper"] call SAR_unit_loadout_weapons;
_sniper_items = ["sniper"] call SAR_unit_loadout_items;
_sniper_tools = ["sniper"] call SAR_unit_loadout_tools;

// get a random starting position that is on land

_rndpos = [_patrol_area_name] call SHK_pos;

_group = createGroup _side;

// create leader of the group
_leader = _group createunit [_leader_group, [(_rndpos select 0) + 10, _rndpos select 1, 0], [], 0.5, "FORM"];

[_leader,_leader_weapon_names,_leader_items,_leader_tools] call SAR_unit_loadout;

_leader setVehicleInit "null = [this] execVM 'addons\SARGE\SAR_trace_entities.sqf';this setIdentity 'id_SAR_sold_lead';";
_leader addMPEventHandler ["MPkilled", {Null = _this execVM "addons\SARGE\SAR_aikilled.sqf";}]; 
_leader addMPEventHandler ["MPHit", {Null = _this execVM "addons\SARGE\SAR_aihit.sqf";}];

_leader addEventHandler ["HandleDamage",{if (_this select 1!="") then {_unit=_this select 0;damage _unit+((_this select 2)-damage _unit)*SAR_leader_health_factor}}];

_cond="(side _this == west) && (side _target == west) && ('ItemBloodbag' in magazines _this)";

[nil,_leader,rADDACTION,"Give me a blood transfusion!", "addons\SARGE\SAR_interact.sqf","",1,true,true,"",_cond] call RE;
 
[_leader] joinSilent _group;

SAR_leader_number = SAR_leader_number + 1;

_leadername = format["SAR_leader_%1",SAR_leader_number];

diag_log format["Leadername: %1",_leadername];

_leader setVehicleVarname _leadername;

// SARGE - do i need this name on the clientside ???

// create global variable for this group
call compile format ["KRON_UPS_%1=1",_leadername];

// if needed broadcast to the clients
//_leader Call Compile Format ["%1=_This ; PublicVariable ""%1""",_leadername];

// create crew
for [{_i=0}, {_i < _snipers}, {_i=_i+1}] do
{
    _this = _group createunit [_sniperlist call BIS_fnc_selectRandom, [(_rndpos select 0) - 30, _rndpos select 1, 0], [], 0.5, "FORM"];
    
    [_this,_sniper_weapon_names,_sniper_items,_sniper_tools] call SAR_unit_loadout;
    
    _this setVehicleInit "null = [this] execVM 'addons\SARGE\SAR_trace_entities.sqf';this setIdentity 'id_SAR';";
    _this addMPEventHandler ["MPkilled", {Null = _this execVM "addons\SARGE\SAR_aikilled.sqf";}]; 
    _this addMPEventHandler ["MPHit", {Null = _this execVM "addons\SARGE\SAR_aihit.sqf";}]; 
    [_this] joinSilent _group;
};

for [{_i=0}, {_i < _riflemen}, {_i=_i+1}] do
{
    _this = _group createunit [_riflemenlist call BIS_fnc_selectRandom, [(_rndpos select 0) + 30, _rndpos select 1, 0], [], 0.5, "FORM"];
    
    [_this,_soldier_weapon_names,_soldier_items,_soldier_tools] call SAR_unit_loadout;
    
    _this setVehicleInit "null = [this] execVM 'addons\SARGE\SAR_trace_entities.sqf';this setIdentity 'id_SAR_sold_man';";    
    _this addMPEventHandler ["MPkilled", {Null = _this execVM "addons\SARGE\SAR_aikilled.sqf";}]; 
    _this addMPEventHandler ["MPHit", {Null = _this execVM "addons\SARGE\SAR_aihit.sqf";}];     
    [_this] joinSilent _group;
};

_leader = leader _group;

// initialize upsmon for the group

if (_respawn) then {
    _ups_respawn = 'respawn';
};

switch (_action) do {

    case "noupsmon":
    {
    };
    case "fortify":
    {
        null=[_leader,_patrol_area_name,'fortify','nofollow','nowait','aware','showmarker',_ups_respawn,'delete:',SAR_DELETE_TIMEOUT] execVM 'addons\UPSMON\scripts\upsmon.sqf';
    };
    case "fortify2":
    {
        null=[_leader,_patrol_area_name,'fortify2','nofollow','nowait','aware','showmarker',_ups_respawn,'delete:',SAR_DELETE_TIMEOUT] execVM 'addons\UPSMON\scripts\upsmon.sqf';
    };
    case "patrol":
    {
        null=[_leader,_patrol_area_name,'nofollow','nowait','aware','noslow','showmarker',_ups_respawn,'delete:',SAR_DELETE_TIMEOUT] execVM 'addons\UPSMON\scripts\upsmon.sqf';
    };
    case "ambush":
    {
        null=[_leader,_patrol_area_name,'ambush','nofollow','nowait','aware','showmarker',_ups_respawn,'delete:',SAR_DELETE_TIMEOUT] execVM 'addons\UPSMON\scripts\upsmon.sqf';
    };
    case "":
    {
        null=[_leader,_patrol_area_name,'nofollow','nowait','aware','noslow','showmarker',_ups_respawn,'delete:',SAR_DELETE_TIMEOUT] execVM 'addons\UPSMON\scripts\upsmon.sqf';
    };
};
    
    
processInitCommands;

if(SAR_DEBUG) then {
    diag_log format["SAR_DEBUG: static Infantry patrol spawned in: %1 with action: %2",_patrol_area_name,_action];
};
_group;