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
//  Sar_functions - generic functions library
//   last modified: 20.3.2013
// ---------------------------------------------------------------------------------------------------------
KRON_StrToArray = {
	private["_in","_i","_arr","_out"];
	_in=_this select 0;
	_arr = toArray(_in);
	_out=[];
	for "_i" from 0 to (count _arr)-1 do {
		_out=_out+[toString([_arr select _i])];
	};
	_out
};

KRON_StrLeft = {
	private["_in","_len","_arr","_out"];
	_in=_this select 0;
	_len=(_this select 1)-1;
	_arr=[_in] call KRON_StrToArray;
	_out="";
	if (_len>=(count _arr)) then {
		_out=_in;
	} else {
		for "_i" from 0 to _len do {
			_out=_out + (_arr select _i);
		};
	};
	_out
};


SAR_unit_loadout_tools = {
// Parameters:
// _unittype (leader, soldier, sniper)
//
// return value: tools array 
//

    private ["_unittype","_unit_tools_list","_unit_tools","_tool","_probability","_chance"];

    _unittype = _this select 0;

    switch (_unittype) do {

        case "leader" :
        {
            _unit_tools_list = SAR_leader_tools;
        };
        case "soldier" :
        {
            _unit_tools_list = SAR_rifleman_tools;
        };
        case "sniper" :
        {
            _unit_tools_list = SAR_sniper_tools;
        };

    };

    _unit_tools = [];
    {
        _tool = _x select 0;
        _probability = _x select 1;
        _chance = (random 100);
        if(_chance < _probability) then {
            _unit_tools set [count _unit_tools, _tool];
        };
    } foreach _unit_tools_list;

    _unit_tools;

};

SAR_unit_loadout_items = {
// Parameters:
// _unittype (leader, soldier, sniper)
//
// return value: items array 
//

    private ["_unittype","_unit_items_list","_unit_items","_item","_probability","_chance"];

    _unittype = _this select 0;

    switch (_unittype) do {

        case "leader" :
        {
            _unit_items_list = SAR_leader_items;
        };
        case "soldier" :
        {
            _unit_items_list = SAR_rifleman_items;
        };
        case "sniper" :
        {
            _unit_items_list = SAR_sniper_items;
        };

    };

    _unit_items = [];
    {
        _item = _x select 0;
        _probability = _x select 1;
        _chance = (random 100);
        if(_chance < _probability) then {
            _unit_items set [count _unit_items, _item];
        };
    } foreach _unit_items_list;

    _unit_items;

};
SAR_unit_loadout_weapons = {
// Parameters:
// _unittype (leader, soldier, sniper)
//
// return value: weapons array 
//

    private ["_unittype","_unit_weapon_list","_unit_pistol_list","_unit_pistol_name","_unit_weapon_name","_unit_weapon_names"];

    _unittype = _this select 0;

    switch (_unittype) do {

        case "leader" :
        {
            _unit_weapon_list = SAR_leader_weapon_list;
            _unit_pistol_list = SAR_leader_pistol_list;
        };
        case "soldier" :
        {
            _unit_weapon_list = SAR_rifleman_weapon_list;
            _unit_pistol_list = SAR_rifleman_pistol_list;
        };
        case "sniper" :
        {
            _unit_weapon_list = SAR_sniper_weapon_list;
            _unit_pistol_list = SAR_sniper_pistol_list;
        };

    };

    _unit_weapon_names = [];
    _unit_weapon_name = _unit_weapon_list call BIS_fnc_selectRandom;
    _unit_pistol_name = _unit_pistol_list call BIS_fnc_selectRandom;
    _unit_weapon_names set [0, _unit_weapon_name];
    _unit_weapon_names set [1, _unit_pistol_name];

    _unit_weapon_names;

};

SAR_unit_loadout = {
// Parameters:
// _unit (Unit to apply the loadout to)
// _weapons (array with weapons for the loadout) 
// _items (array with items for the loadout)
// _tools (array with tools for the loadout)

private ["_unit","_weapons","_weapon","_items","_unit_magazine_name","_item","_tool","_tools"];

    _unit = _this select 0;
    _weapons = _this select 1;
    _items = _this select 2;
    _tools = _this select 3;

    removeAllWeapons _unit;

    {
        _weapon = _weapons select _forEachIndex;

        if (_weapon !="") then
        {
            _unit_magazine_name = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0;
            _unit addMagazine _unit_magazine_name;
            _unit addWeapon _weapon;
        };
        
    } foreach _weapons;

    {
        _item = _items select _forEachIndex;
        _unit addMagazine _item;
    } foreach _items;

    {
        _tool = _tools select _forEachIndex;
        _unit addWeapon _tool;
    } foreach _tools;

};

SAR_AI_mon_upd = {

// Parameters:
// _typearray (possible values = "max_grps", "rnd_grps", "max_p_grp", "grps_band","grps_sold","grps_surv")
// _valuearray (must be an array)
// _gridname (is the areaname of the grid for this change)

    private ["_typearray","_valuearray","_gridname","_path","_success"];

    _typearray = _this select 0;
    _valuearray =_this select 1;
    _gridname = _this select 2;

    _path = [SAR_AI_monitor, _gridname] call BIS_fnc_findNestedElement;

    {

        switch (_x) do 
        {
            case "max_grps":
            {
                _path set [1,1];
            };
            case "rnd_grps":
            {
                _path set [1,2];
            };
            case "max_p_grp":
            {
                _path set [1,3];
            };
            case "grps_band":
            {
                _path set [1,4];
            };
            case "grps_sold":
            {
                _path set [1,5];
            };
            case "grps_surv":
            {
                _path set [1,6];
            };
            
        };
        
        _success = [SAR_AI_monitor, _path, _valuearray select _forEachIndex] call BIS_fnc_setNestedElement;

    }foreach _typearray;

    _success;

    
};
SAR_AI_mon_read = {

// Parameters:
// _typearray (possible values = "max_grps", "rnd_grps", "max_p_grp", "grps_band","grps_sold","grps_surv")
// _gridname (is the areaname of the grid for this change)

    private ["_typearray","_gridname","_path","_resultarray"];

    _typearray = _this select 0;
    _gridname = _this select 1;
    _resultarray=[];

    _path = [SAR_AI_monitor, _gridname] call BIS_fnc_findNestedElement;

    {

        switch (_x) do 
        {
            case "max_grps":
            {
                _path set [1,1];
            };
            case "rnd_grps":
            {
                _path set [1,2];
            };
            case "max_p_grp":
            {
                _path set [1,3];
            };
            case "grps_band":
            {
                _path set [1,4];
            };
            case "grps_sold":
            {
                _path set [1,5];
            };
            case "grps_surv":
            {
                _path set [1,6];
            };
            
        };

        _resultarray set[count _resultarray,[SAR_AI_monitor, _path ] call BIS_fnc_returnNestedElement];

    }foreach _typearray;

    _resultarray;
    
};

SAR_DEBUG_mon = {

    diag_log "--------------------Start of AI monitor values -------------------------";
    {
        diag_log format["SAR EXTREME DEBUG: %1",_x];
    }foreach SAR_AI_monitor;
    
    diag_log "--------------------End of AI monitor values   -------------------------";
};


SAR_fnc_returnConfigEntry = {

	private ["_config", "_entryName","_entry", "_value"];

	_config = _this select 0;
	_entryName = _this select 1;
	_entry = _config >> _entryName;

	//If the entry is not found and we are not yet at the config root, explore the class' parent.
	if (((configName (_config >> _entryName)) == "") && (!((configName _config) in ["CfgVehicles", "CfgWeapons", ""]))) then {
		[inheritsFrom _config, _entryName] call SAR_fnc_returnConfigEntry;
	}
	else { if (isNumber _entry) then { _value = getNumber _entry; } else { if (isText _entry) then { _value = getText _entry; }; }; };
	//Make sure returning 'nil' works.
	if (isNil "_value") exitWith {nil};

	_value;
};

// *WARNING* BIS FUNCTION RIPOFF - Taken from fn_fnc_returnVehicleTurrets and shortened a bit
SAR_fnc_returnVehicleTurrets = {

	private ["_entry","_turrets","_turretIndex","_i"];

	_entry = _this select 0;
	_turrets = [];
	_turretIndex = 0;

	//Explore all turrets and sub-turrets recursively.
	for "_i" from 0 to ((count _entry) - 1) do {
		private ["_subEntry"];
		_subEntry = _entry select _i;
		if (isClass _subEntry) then {
			private ["_hasGunner"];
			_hasGunner = [_subEntry, "hasGunner"] call SAR_fnc_returnConfigEntry;
			//Make sure the entry was found.
			if (!(isNil "_hasGunner")) then {
				if (_hasGunner == 1) then {
					_turrets = _turrets + [_turretIndex];
					//Include sub-turrets, if present.
					if (isClass (_subEntry >> "Turrets")) then { _turrets = _turrets + [[_subEntry >> "Turrets"] call SAR_fnc_returnVehicleTurrets]; }
					else { _turrets = _turrets + [[]]; };
				};
			};
			_turretIndex = _turretIndex + 1;
		};
		sleep 0.01;
	};
	_turrets;
};
