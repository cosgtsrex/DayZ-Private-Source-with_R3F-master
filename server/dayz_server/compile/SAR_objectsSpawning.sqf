if(!X_Server) exitWith {};


private ["_obj","_newpos","_worldname","_mpos","_cposx_corr","_cposy_corr","_markersize","_counter","_pos","_markerName","_marker","_amountOfVehicles","_hint"];
_counter = 0;

diag_log format["Objects Spawning Started"];

// objectlist
objectList = [	"Land_prebehlavka",
				"Land_leseni2x",
                "Land_CamoNet_NATO",
				"Base_WarfareBBarrier10xTall",
				"Base_WarfareBBarrier10x",
				"Base_WarfareBBarrier5x",
                "Base_WarfareBBarrier10xTall",
                "Base_WarfareBBarrier10x",
                "Base_WarfareBBarrier5x",
				"Land_Misc_deerstand",
				"Fort_Barricade",
				"Concrete_Wall_EP1",
                "Concrete_Wall_EP1",
                "Land_fort_bagfence_long",
                "Land_fort_bagfence_long",
                "Land_fort_bagfence_round",
                "Land_fort_bagfence_corner",
                "Land_BagFenceLong",
                "Land_BagFenceLong",
                "Land_fort_artillery_nest",
				"Land_fortified_nest_small_EP1",
				"Land_HBarrier_large",
                "Land_HBarrier_large",
				"Land_Misc_Scaffolding",
				"RampConcrete",
                "Hedgehog",
                "Land_ConcreteRamp",
                "Land_CncBlock_Stripes",
                "Land_Campfire_burning",
                "Land_GuardShed",
                "Land_tent_east",
				"Land_ConcreteBlock"];

// define area (Chernarus)

_worldname= toLower format["%1",worldName];

switch (_worldname) do {
    case "chernarus":
    {
        _mpos = getMarkerpos "center";
        _cposx_corr= (_mpos select 0) + 0;
        _cposy_corr= (_mpos select 0) - 0;
        _markersize = [6000,6000];
        
        
    };
    case "tavi":
    {
        _mpos = getMarkerpos "center";
        _cposx_corr= (_mpos select 0) +2000;
        _cposy_corr= (_mpos select 0) -3000;
        _markersize = [9000,9000];
    };
    case "namalsk":
    {
        
    };
    case "lingor":
    {
        
    };
    case "mbg_celle2":
    {
        
    };
    case "takistan":
    {
        
    };
    case "fallujah":
    {
        
    };
    case "panthera":
    {
        
    };

};
_this = createMarker ["_shk_area", [_cposx_corr, _cposy_corr]];
_this setMarkerSize _markersize;

_this setMarkerAlpha 1;
_this setMarkerShape "RECTANGLE";
_this setMarkerType "SOLID";
_this setMarkerBrush "Border";
_marker_0 = _this;

//[_marker_0, true] call CBA_fnc_setMarkerPersistent;


while {_counter < 100} do
{
    // get random point
    
    _newpos = ["_shk_area"] call SHK_pos;
    
    //_newpos = [_pos, 10, 20, 1, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;

    _Objtype = objectList select (random (count objectList - 1));
    _obj = createVehicle [_Objtype,_newpos,[], 10,"None"]; 

    //diag_log format["Newpos:%1 type: %2",_newpos,_Objtype];

    _obj setpos [getpos _obj select 0,getpos _obj select 1,0];
    
    // Set R3F variable
    _obj setVariable ["R3F_LOG_disabled", false, true];
    
    
    _markerName = format["marker%1",_counter];
    _xpos=_newpos select 0;
    _ypos=_newpos select 1;
    
	_marker = createMarker [_markerName, [_xpos,_ypos]];
    _marker setMarkerAlpha 1;
	_marker setMarkerType "FLAG";
	_marker setMarkerColor "ColorRed";
    _marker setMarkerShape "ICON";
    _marker setMarkerSize [0.5,0.5];
    
    //[_marker, true] call CBA_fnc_setMarkerPersistent;
    
    _counter = _counter + 1;
};

diag_log format["SARGE - %1 Objects Spawned",_counter];
objectSpawnComplete = true;