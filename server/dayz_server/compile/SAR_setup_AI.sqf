if(!isServer) exitWith {};

private ["_counter","_soldierlist", "_group", "_pos","_markerName","_marker","_amountOfVehicles","_hint"];


diag_log format["AI Main Setup Spawning Started"];

// type of soldier list

_leader_sold_list = ["Rocket_DZ"];
_sniper_sold_list = ["Sniper1_DZ"];
_soldier_sold_list = ["Soldier1_DZ","Camo1_DZ"];

_bandit_band_list = ["Bandit1_DZ", "BanditW1_DZ"];

_leader_surv_list = ["Survivor3_DZ"]; 
_sniper_surv_list = ["Sniper1_DZ"];
_soldier_surv_list = ["Survivor2_DZ","SurvivorW2_DZ"];


_soldiertype="Soldier1_DZ";
_soldiertype2="Bandit1_DZ";


_debugarea = "None";
_debug_2_groups = true;
_debug_helionly= false;

_counter = 1;
_areaname="SAR_patrol_NWAF";

// SARGE DEBUG todo: all the calls should be execVMs or spawns

//Heli Patrol NWAF
[g_marker_helipatrol_nwaf] call SAR_AI_heli;

//Heli Patrol NEAF
[g_marker_helipatrol_neaf] call SAR_AI_heli;


// Heli patrol south coast
[g_marker_helipatrol_southcoast] call SAR_AI_heli;
[g_marker_helipatrol_southcoast] call SAR_AI_heli;

// heli patrol east coast
[g_marker_helipatrol_eastcoast] call SAR_AI_heli;
[g_marker_helipatrol_eastcoast] call SAR_AI_heli;




/*





_marker_upsmon = g_marker_helipatrol_nwaf;
_rndpos = [_areaname] call SHK_pos;




If !(_debug_helionly) then {

    // create infantry

    // create group

    _group = createGroup west;

    // create units for group

    //Anti Vehicle
    _leader = _group createunit [_leader_sold_list select 0, [(_rndpos select 0) + 10, _rndpos select 1, 0], [], 0.5, "Form"];
    _leader addMagazine "30Rnd_545x39_AK";
    _leader addWeapon "AKS_74_U";
    _leader setVariable ["Magazin_type","30Rnd_545x39_AK",true];
    _leader setVehicleInit "null = [this] execVM 'addons\SARGE\SAR_trace_entities.sqf';";
    _leader addMPEventHandler ["MPkilled", {Null = _this execVM "addons\SARGE\SAR_aikilled.sqf";}]; 

    //Support
    _man2 = _group createunit [_soldiertype, [(_rndpos select 0) - 30, _rndpos select 1, 0], [], 0.5, "Form"];
    _man2 addMagazine "75Rnd_545x39_RPK";
    _man2 addWeapon "RPK_74";
    _man2 setVehicleInit "null = [this] execVM 'addons\SARGE\SAR_trace_entities.sqf';";
    _man2 setVariable ["Magazin_type","75Rnd_545x39_RPK",true];
    _man2 addMPEventHandler ["MPkilled", {Null = _this execVM "addons\SARGE\SAR_aikilled.sqf";}]; 

    //Rifleman
    _man3 = _group createunit [_soldiertype, [_rndpos select 0, (_rndpos select 1) + 30, 0], [], 0.5, "Form"];
    _man3 addMagazine "30Rnd_762x39_AK47";
    _man3 addWeapon "AK_47_M";
    _man3 setVehicleInit "null = [this] execVM 'addons\SARGE\SAR_trace_entities.sqf';";
    _man3 setVariable ["Magazin_type","30Rnd_762x39_AK47",true];
    _man3 addMPEventHandler ["MPkilled", {Null = _this execVM "addons\SARGE\SAR_aikilled.sqf";}]; 

    _man4 = _group createunit [_soldiertype, [_rndpos select 0, (_rndpos select 1) + 30, 0], [], 0.5, "Form"];
    _man4 addMagazine "30Rnd_762x39_AK47";
    _man4 addWeapon "AK_47_M";
    _man4 setVehicleInit "null = [this] execVM 'addons\SARGE\SAR_trace_entities.sqf';";
    _man4 setVariable ["Magazin_type","30Rnd_762x39_AK47",true];
    _man4 addMPEventHandler ["MPkilled", {Null = _this execVM "addons\SARGE\SAR_aikilled.sqf";}]; 

    _man5 = _group createunit [_soldiertype, [_rndpos select 0, (_rndpos select 1) + 30, 0], [], 0.5, "Form"];
    _man5 addMagazine "30Rnd_762x39_AK47";
    _man5 addWeapon "AK_47_M";
    _man5 setVehicleInit "null = [this] execVM 'addons\SARGE\SAR_trace_entities.sqf';";
    _man5 setVariable ["Magazin_type","30Rnd_762x39_AK47",true];
    _man5 addMPEventHandler ["MPkilled", {Null = _this execVM "addons\SARGE\SAR_aikilled.sqf";}]; 


    // initialize upsmon for the group

    _leader = leader _group;

    null=[_leader,_areaname,'spawned','nofollow','nowait','aware'] execVM 'addons\UPSMON\scripts\upsmon.sqf';



    // 2. group

    if (_debug_2_groups) then {

        // position

        _rndpos = [_areaname] call SHK_pos;

        // create group

        _group2 = createGroup east;

        // create units for group

        //Anti Vehicle
        _leader2 = _group2 createunit [_soldiertype2, [(_rndpos select 0) + 10, _rndpos select 1, 0], [], 0.5, "Form"];
        _leader2 addMagazine "30Rnd_545x39_AK";
        _leader2 addWeapon "AKS_74_U";
        _leader2 setVehicleInit "null = [this] execVM 'addons\SARGE\SAR_trace_entities.sqf';";
        _leader2 setVariable ["Magazin_type","30Rnd_545x39_AK",true];
        _leader2 addMPEventHandler ["MPkilled", {Null = _this execVM "addons\SARGE\SAR_aikilled.sqf";}];
        
        diag_log format["Unit1 side: %1", side _leader2];
        [_leader2] joinSilent _group2;
        diag_log format["Unit1 side: %1", side _leader2];
      
        //Support
        _man22 = _group2 createunit [_soldiertype2, [(_rndpos select 0) - 30, _rndpos select 1, 0], [], 0.5, "Form"];
        _man22 addMagazine "30Rnd_545x39_AK";
        _man22 addWeapon "AKS_74_U";
        _man22 setVehicleInit "null = [this] execVM 'addons\SARGE\SAR_trace_entities.sqf';";
        _man22 setVariable ["Magazin_type","30Rnd_545x39_AK",true];
        _man22 addMPEventHandler ["MPkilled", {Null = _this execVM "addons\SARGE\SAR_aikilled.sqf";}]; 

        diag_log format["Unit2 side: %1", side _man22];
        
        [_man22] joinSilent _group2;
        
        diag_log format["Unit2 side: %1", side _man22];
        
        //Rifleman
        _man32 = _group2 createunit [_soldiertype2, [_rndpos select 0, (_rndpos select 1) + 30, 0], [], 0.5, "Form"];
        _man32 addMagazine "30Rnd_545x39_AK";
        _man32 addWeapon "AKS_74_U";
        _man32 setVehicleInit "null = [this] execVM 'addons\SARGE\SAR_trace_entities.sqf';";
        _man32 setVariable ["Magazin_type","30Rnd_545x39_AK",true];
        _man32 addMPEventHandler ["MPkilled", {Null = _this execVM "addons\SARGE\SAR_aikilled.sqf";}]; 
        [_man32] joinSilent _group2;
        
        _man42 = _group2 createunit [_soldiertype2, [_rndpos select 0, (_rndpos select 1) + 30, 0], [], 0.5, "Form"];
        _man42 addMagazine "30Rnd_545x39_AK";
        _man42 addWeapon "AKS_74_U";
        _man42 setVehicleInit "null = [this] execVM 'addons\SARGE\SAR_trace_entities.sqf';";
        _man42 setVariable ["Magazin_type","30Rnd_545x39_AK",true];
        _man42 addMPEventHandler ["MPkilled", {Null = _this execVM "addons\SARGE\SAR_aikilled.sqf";}]; 
        [_man42] joinSilent _group2;

        _man52 = _group2 createunit [_soldiertype2, [_rndpos select 0, (_rndpos select 1) + 30, 0], [], 0.5, "Form"];
        _man52 addMagazine "30Rnd_545x39_AK";
        _man52 addWeapon "AKS_74_U";
        _man52 setVehicleInit "null = [this] execVM 'addons\SARGE\SAR_trace_entities.sqf';";
        _man52 setVariable ["Magazin_type","30Rnd_545x39_AK",true];
        _man52 addMPEventHandler ["MPkilled", {Null = _this execVM "addons\SARGE\SAR_aikilled.sqf";}]; 
        [_man52] joinSilent _group2;

        _man62 = _group2 createunit [_soldiertype2, [_rndpos select 0, (_rndpos select 1) + 30, 0], [], 0.5, "Form"];
        _man62 addMagazine "30Rnd_545x39_AK";
        _man62 addWeapon "AKS_74_U";
        _man62 setVehicleInit "null = [this] execVM 'addons\SARGE\SAR_trace_entities.sqf';";
        _man62 setVariable ["Magazin_type","30Rnd_545x39_AK",true];
        _man62 addMPEventHandler ["MPkilled", {Null = _this execVM "addons\SARGE\SAR_aikilled.sqf";}]; 
        [_man62] joinSilent _group2;
        



        _leader2 = leader _group2;    
        

        // initialize upsmon for the group
        null=[_leader2,_areaname,'spawned','nofollow','nowait','aware'] execVM 'addons\UPSMON\scripts\upsmon.sqf';

    };

};

processInitCommands;

*/
diag_log "SARGE - general AI Spawned";
AISpawnComplete = true;