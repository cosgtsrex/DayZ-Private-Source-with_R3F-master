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
//   SAR_trace_entities.sqf
//   last modified: 20.3.2013
// ---------------------------------------------------------------------------------------------------------

private ["_ai","_magazintype","_entity_array","_humanity","_humanitylimit","_sleeptime","_detectrange","_weapons","_weapon"];

_ai = _this select 0;

_weapons = weapons _ai;
_weapon = _weapons select 0;
_magazintype = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0;
_detectrange = SAR_DETECT_HOSTILE;
_humanitylimit=0;
_humanity=0;
_sleeptime = SAR_DETECT_INTERVAL;
    
while {alive _ai} do {

    if !(isServer) then {
        
        _entity_array = (position _ai) nearEntities ["CAManBase",_detectrange];
        {
            if(vehicle _ai != _ai) then { // is in vehicle

                if(isPlayer _x) then {
                    _humanity= _x getVariable ["humanity",0];

                    If (_humanity < _humanitylimit && rating _x > -10000) then {
                        if(SAR_EXTREME_DEBUG) then {
                            diag_log format["SAR EXTREME DEBUG: reducing rating (trace_entities - vehicle) for player: %1", _x];
                        };
                        _x addrating -10000;
                    };
                };
            
            } else {

                if(isPlayer _x) then {
                    _humanity= _x getVariable ["humanity",0];

                    If (_humanity < _humanitylimit && rating _x > -10000) then {
                        if(SAR_EXTREME_DEBUG) then {
                            diag_log format["SAR EXTREME DEBUG: reducing rating (trace_entities - foot) for player: %1", _x];
                        };
                        _x addrating -10000;
                    };
                } else {
                
                    if (_x isKindof "zZombie_Base") then {
                
                        if(rating _x > -10000) then {
                            _x addrating -10000;
                            if(SAR_EXTREME_DEBUG) then {
                                diag_log "SAR EXTREME DEBUG: Zombie rated down";
                            };
                        };
                    };
                };
            };

        
        } forEach _entity_array;
    };

    // refresh ammo
    
    // SARGE 2add: reloading of rifle and pistol
    
    if (isServer) then {
        
        {
            if(_x typeOf "Rifle") then {
                if ((_ai ammo _x == 0) || ((count magazines _ai) < 1))  then {
                    {_ai removeMagazine _x} forEach magazines _ai;
                    _ai addMagazine _magazintype;
                    if (SAR_EXTREME_DEBUG) then {diag_log "SAR_EXTREME_DEBUG: Infantry reloaded ammo for a rifle.";};
                };
            };
            if(_x typeOf "Pistol") then {
                if ((_ai ammo _x == 0) || ((count magazines _ai) < 1))  then {
                    {_ai removeMagazine _x} forEach magazines _ai;
                    _ai addMagazine _magazintype;
                    if (SAR_EXTREME_DEBUG) then {diag_log "SAR_EXTREME_DEBUG: Infantry reloaded ammo for a pistol.";};
                };
            };

        } foreach _weapons;
        
    };
    
    sleep _sleeptime;
    
};