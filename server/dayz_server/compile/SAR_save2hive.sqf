/**
 * Saves an object to the hive
 * 
 * 
 * Copyright (C) 2013 SARGE
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

private ["_objectid","_key","_oId","_classname","_pos","_worldspace","_val","_count"];

_object = _this;

_classname = typeOf _object;

_pos = getPosATL _object;
_worldspace = [round(direction _object), _pos];

_objectid = _object getvariable "ObjectID";

_tbl_bld_id = 0;
_ib_id = 0;
_val = 0;
_key = "";
_status = "";


If (isNil "_objectid") then { // check if object has no ID  = not coming from the DB

    // check if classname of object exists in table buildings
    
    // define query
    _key = format ["CHILD:999: select id from building WHERE class_name= '%1' AND id > ?:[0]:", _classname];    
    _result = _key call server_hiveReadWrite;
    
    _status	= _result select 0;
    
    if (_status == "CustomStreamStart") then {
        _val = _result select 1;
        diag_log format["SARGE DEBUG: Value of - _val : %1",_val];
	};
    
    if (_val == 0) then { // need to add object to buildings table
    
        diag_log "Sarge debug: No entries in table building found, starting to insert";
        
        _save_success = false;
        _count = 0;
        
        while {!_save_success && _count < 5} do {
        
            if(_count == 0) then {
                _key = format ["CHILD:999: INSERT INTO building (class_name) VALUES ('%1'):[]:", _classname];  
                _key call server_hiveWrite;

                diag_log "Sarge debug: new classname should have been written to building table, sleeping 1 second";
                sleep 1;
            };
            
            _key = format ["CHILD:999: select id from building WHERE class_name= '%1' AND id > ?:[0]:", _classname];
            _result1 = _key call server_hiveReadWrite;
        
            _status	= _result1 select 0;
            _resultsfound = _result1 select 1;
            
            diag_log format["SARGE DEBUG: Results found = %1",_resultsfound];

            if (_resultsfound == 1) then {
                _save_success = true;
                _result1 = _key call server_hiveReadWrite;
                _tbl_bld_id = _result1 select 0;
                diag_log format["SARGE DEBUG: ID of the inserted buiding: %1",_tbl_bld_id];        
                
            } else {
                _count = _count + 1;
                diag_log format["SARGE DEBUG: %1. retrieving try failed, trying again.",_count];                
            };

        };
        
    } else {
    
        diag_log "Sarge DEBUG: assumes that the building is found in the building table";
    
        _result = _key call server_hiveReadWrite;
        _tbl_bld_id = _result select 0;
        
        diag_log format["SARGE DEBUG: ID of the found buiding: %1",_tbl_bld_id];            
    };

    if (typename _tbl_bld_id == typename 0) then {
    
        _save_success = false;
        _count = 0;
        
        while {!_save_success && _count < 5} do {

            // insert object into instance_building
                
            _key = format ["CHILD:999: INSERT INTO instance_building (building_id,instance_id,worldspace) VALUES (%1,1,'%2'):[]:", _tbl_bld_id,_worldspace];  
            _key call server_hiveWrite;
            
            diag_log format["SARGE DEBUG: Instance_Building entry should have been written! %1",""];
            sleep 1;

            _key = format ["CHILD:999: select id from instance_building WHERE worldspace = '%1' AND ?:[1]:", _worldspace];
            _result2 = _key call server_hiveReadWrite;
            _resultsfound = _result2 select 1;
            
            diag_log format["SARGE DEBUG: Results from instance_building found = %1",_resultsfound];

            if (_resultsfound == 1) then {
                _save_success = true;
                _result2 = _key call server_hiveReadWrite;
                _tbl_ins_id = _result2 select 0;
                diag_log format["SARGE DEBUG: ID of the inserted instance buiding: %1",_tbl_ins_id];
                _object setVariable ["ObjectID",_tbl_ins_id,true];
                
            } else {
                _count = _count + 1;
                diag_log format["SARGE DEBUG: instance_buidling - %1. try failed, trying again.",_count];                
            };
        };
        
    };
    
} else {   // else (object already in instance_buildings

    // generate query to update coordinates

    _key = format ["CHILD:999:update `instance_building` set `worldspace` = '%1' where `id` = ?:[%2]:", _worldspace, _objectid];
    
    diag_log _key; 

	// execute query
    
    _key call server_hiveWrite;

};    
    
// debug

_key = format["ID des Objektes: %1 - Classname: %2 - Worldspace: %3",_objectid,_classname,_worldspace];
diag_log _key;
