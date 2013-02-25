if(!isServer) exitWith {};

// setting up predefined areas for UPSMON to patrol

private ["_counter","_soldierlist", "_group", "_pos","_markerName","_marker","_amountOfVehicles","_hint"];

diag_log format["Area & Trigger definition Started"];

// soutcoast, heli patrol area
_this = createMarker ["SAR_patrol_soutcoast", [7997.2837, 2687.6707]];
_this setMarkerShape "RECTANGLE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [6500, 1200];
g_marker_helipatrol_southcoast = _this;


// eastcoast, heli patrol area
_this = createMarker ["SAR_patrol_eastcoast", [13304.196, 8220.9795]];
_this setMarkerShape "RECTANGLE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [1200, 6000];
g_marker_helipatrol_eastcoast = _this;

// NWAF, heli patrol area
_this = createMarker ["SAR_patrol_NWAF", [4525.3335, 10292.299]];
_this setMarkerShape "RECTANGLE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [1500, 500];
_this setMarkerDir 59.354115;
g_marker_helipatrol_nwaf = _this;

// NEAF, heli patrol area
_this = createMarker ["SAR_AREA_NEAF", [12034.16, 12725.376, 0]];
_this setMarkerShape "RECTANGLE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [1000, 600];
g_marker_helipatrol_neaf = _this;


//setting up triggers around the map




/*
// define area (testarea for upsmon)
if(_debugarea=="NWAF") then {

    // NWAF, free area

    _pos = [4529.7852, 10259.297, 0];

    _this = createMarker [_areaname, _pos ];
    _this setMarkerShape "RECTANGLE";
    _this setMarkerType "Flag";
    _this setMarkerBrush "Solid";
    _this setMarkerSize [500, 500];
    
    _marker_upsmon = _this;

};

if(_debugarea=="NOVY") then {

    // Novy, city
    _pos = [7075.9956, 7709.9102, 0];

    _this = createMarker [_areaname, _pos];
    _this setMarkerAlpha 1;
    _this setMarkerShape "ELLIPSE";
    _this setMarkerType "Flag";
    _this setMarkerColor "ColorRed";
    _this setMarkerBrush "Solid";
    _this setMarkerSize [200, 100];

    _marker_upsmon = _this;
    
};



//[_marker_upsmon, true] call CBA_fnc_setMarkerPersistent;

_rndpos = [_areaname] call SHK_pos;


// create Heli and patrol the south coast

_groupheli = createGroup west;

// create the heli

_heli = createVehicle ["UH1H_DZ", [(_rndpos select 0) + 10, _rndpos select 1, 80], [], 0, "FLY"];
_heli setVariable ["Sarge",1,true];
_heli engineon true; 
_heli allowDamage false;
[_heli] joinSilent _groupheli;

// create ppl in it

_leaderheli = _groupheli createunit [_leader_sold_list select 0, [(_rndpos select 0) + 10, _rndpos select 1, 0], [], 0.5, "Form"];
_leaderheli addMagazine "30Rnd_545x39_AK";
_leaderheli addWeapon "AKS_74_U";
_leaderheli setVariable ["Magazin_type","30Rnd_545x39_AK",true];
_leaderheli setVehicleInit "null = [this] execVM 'addons\SARGE\SAR_trace_banditsonly.sqf';";
_leaderheli addMPEventHandler ["MPkilled", {Null = _this execVM "addons\SARGE\SAR_aikilled.sqf";}]; 

_leaderheli action ["getInPilot", _heli]; 

//Support
_man2heli = _groupheli createunit [_soldiertype, [(_rndpos select 0) - 30, _rndpos select 1, 0], [], 0.5, "Form"];
_man2heli addMagazine "75Rnd_545x39_RPK";
_man2heli addWeapon "RPK_74";
_man2heli setVehicleInit "null = [this] execVM 'addons\SARGE\SAR_trace_banditsonly.sqf';";
_man2heli setVariable ["Magazin_type","75Rnd_545x39_RPK",true];
_man2heli addMPEventHandler ["MPkilled", {Null = _this execVM "addons\SARGE\SAR_aikilled.sqf";}]; 

_man2heli action ["getInGunner", _heli];

//Rifleman
_man3heli = _groupheli createunit [_soldiertype, [_rndpos select 0, (_rndpos select 1) + 30, 0], [], 0.5, "Form"];
_man3heli addMagazine "30Rnd_762x39_AK47";
_man3heli addWeapon "AK_47_M";
_man3heli setVehicleInit "null = [this] execVM 'addons\SARGE\SAR_trace_banditsonly.sqf';";
_man3heli setVariable ["Magazin_type","30Rnd_762x39_AK47",true];
_man3heli addMPEventHandler ["MPkilled", {Null = _this execVM "addons\SARGE\SAR_aikilled.sqf";}]; 

_man3heli action ["getInGunner", _heli];

// initialize upsmon for the group

_leaderheli = leader _groupheli;

null=[_leaderheli,_areaname,'spawned','nofollow','nowait','aware'] execVM 'addons\UPSMON\scripts\upsmon.sqf';




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

processInitCommands;

diag_log format["SARGE - %1 groups of AI Spawned",_counter];
AISpawnComplete = true;

*/
diag_log format["Area & Trigger definition finalized"];