// SARGE DEBUG - TODO - eventually adjust the sleep timer
//
// Traces only bandits

private["_ai","_magazintype","_entity_array","_humanity","_humanitylimit","_sleeptime","_detectrange"];

_ai = _this select 0;

_weapons = weapons _ai;
_weapon = _weapons select 0;
_magazinetype= getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0;

_detectrange=300;
_humanitylimit=0;
_humanity=0;
_sleeptime=0.5;

    
while {alive _ai} do {

    //diag_log "heartbeat";

    _entity_array = (position _ai) nearEntities [["Bandit1_DZ","BanditW1_DZ"],_detectrange];
    
    {

        if(vehicle _ai != _ai) then { // NPC in a vehicle

            if(isPlayer _x) then {
                _humanity= _x getVariable ["humanity",0];

                If (_humanity < _humanitylimit && rating _x > -10000) then {
                    diag_log format["reducing rating for player: %1",name _x];
                    _x addrating -10000;
                };
            };
        
        } else { //NPC on foot

            if(isPlayer _x) then {
                _humanity= _x getVariable ["humanity",0];

                If (_humanity < _humanitylimit && rating _x > -10000) then {
                    diag_log format["reducing rating for player: %1",name _x];
                    _x addrating -10000;
                };
            };
        };

        
    } forEach _entity_array;
    
    // refresh ammo & fuel
    
    if(vehicle _ai != _ai) then {
        vehicle _ai setVehicleAmmo 1;
        //refuel, so they never run out of fuel
        _vehicle = vehicle _ai;
        _vehicle setFuel 1;

    } else {
        if !(someAmmo _ai) then {
            {_ai removeMagazine _x} forEach magazines _ai;
            _ai addMagazine _magazintype;
        };
    };

    sleep _sleeptime;
    
};