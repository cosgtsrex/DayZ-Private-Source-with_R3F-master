// SARGE DEBUG - TODO - eventually adjust the sleep timer
//
//

private["_ai","_magazintype","_entity_array","_humanity","_humanitylimit","_sleeptime","_detectrange"];

_ai = _this select 0;
_magazintype = _ai getVariable "Magazin_type";

_detectrange=200;
_humanitylimit=0;
_humanity=0;
_sleeptime = 0.5;
    
while {alive _ai} do {

    //diag_log "heartbeat";

    _entity_array = (position _ai) nearEntities ["CAManBase",_detectrange];
    
    {

        if(vehicle _ai != _ai) then { // is in vehicle

            if(isPlayer _x) then {
                _humanity= _x getVariable ["humanity",0];

                If (_humanity < _humanitylimit && rating _x > -10000) then {
                    diag_log format["reducing rating for player: %1",name _x];
                    _x addrating -10000;
                };
            };
        
        } else {

            if(isPlayer _x) then {
                _humanity= _x getVariable ["humanity",0];

                If (_humanity < _humanitylimit && rating _x > -10000) then {
                    diag_log format["reducing rating for player: %1",name _x];
                    _x addrating -10000;
                };
            } else {
            
                if (_x isKindof "zZombie_Base") then {
            
                    if(rating _x > -10000) then {
                        _x addrating -10000;
                        //diag_log format["Zombie rated down: %1",(rating _x)];
                    };
                };
            };
        };

    } forEach _entity_array;

    // refresh ammo
    
    if !(someAmmo _ai) then {
        {_ai removeMagazine _x} forEach magazines _ai;
        _ai addMagazine _magazintype;
    };
    
    sleep _sleeptime;
    
};

//diag_log "AI killed";