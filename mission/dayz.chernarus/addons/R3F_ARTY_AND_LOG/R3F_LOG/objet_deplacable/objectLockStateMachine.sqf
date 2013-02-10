/*
	@file Author: [404] Costlyy
	@file Version: 1.0
   	@file Date:	21/11/2012	
	@file Description: Locks an object until the player disconnects.
	@file Args: [object,player,int,lockState(lock = 0 / unlock = 1)]
*/

// Check if mutex lock is active.
if(R3F_LOG_mutex_local_verrou) exitWith {
	player globalChat STR_R3F_LOG_mutex_action_en_cours;
};

private["_locking", "_currObject", "_lockState", "_lockDuration", "_stringEscapePercent", "_interation", "_unlockDuration", "_totalDuration"];

_currObject = _this select 0;
_lockState = _this select 3;

_totalDuration = 0;
_stringEscapePercent = "%"; // Required to get the % sign into a formatted string.

switch (_lockState) do {
    case 0:{ // LOCK
    
    	R3F_LOG_mutex_local_verrou = true; // Set mutex lock to stop the player performing concurrent actions.
    
		// SARGE
		_totalDuration = 2;
	//	_totalDuration = 5;
		_lockDuration = _totalDuration;
		_iteration = 0;
		
		player switchMove "AinvPknlMstpSlayWrflDnon_medic"; // Begin the full medic animation...
		
		for "_iteration" from 1 to _lockDuration do {
		    
			_lockDuration = _lockDuration - 1;
		    _iterationPercentage = floor (_iteration / _totalDuration * 100);
		    
			2 cutText [format["Object lock %1%2 complete", _iterationPercentage, _stringEscapePercent], "PLAIN DOWN", 1];
		    sleep 1;
		    
			if (!(isNil {player getVariable "Owned_Vehicle"}) && !(isNil {_currObject getVariable "Vehicle_Owner"})) exitWith { // already owns a car
		        2 cutText ["You can only lock one vehicle at a time ...", "PLAIN DOWN", 1];
                R3F_LOG_mutex_local_verrou = false;
			};


		    if(player distance _currObject > 50) exitWith { // If the player dies, revert state.
		        2 cutText ["Object lock interrupted...", "PLAIN DOWN", 1];
                R3F_LOG_mutex_local_verrou = false;
			};
		    
			if (_iteration >= _totalDuration) exitWith { // Sleep a little extra to show that lock has completed.
		        sleep 1;
                _currObject setVariable ["objectLocked", true, true];

				_vehicle_owner = _currObject getVariable "Vehicle_Owner";
				//check if its a vehicle and not a structure
				if !(isNil "_vehicle_owner") then
					{
					diag_log format["DEBUG - Locked a vehicle"];
					_currObject lock true;
					_currObject setVehicleLock "Locked";
					// fill in owner information
					_currObject setVariable ["Vehicle_Owner", getPlayerUID player, true];
					_currObject setVariable ["Vehicle_Group", group player, true];
					_currObject setVariable ["Vehicle_Faction", side player, true];
					
					//set vehicle object ID in player variable

					player setVariable ["Owned_Vehicle", _currObject,false];
					diag_log format["DEBUG - vehiclename: %1",str _currObject];					
					};
				
                2 cutText ["", "PLAIN DOWN", 1];
                R3F_LOG_mutex_local_verrou = false;
		    }; 
		};
		
		player SwitchMove "amovpknlmstpslowwrfldnon_amovpercmstpsraswrfldnon"; // Redundant reset of animation state to avoid getting locked in animation.       
    };
    case 1:{ // UNLOCK
        
        R3F_LOG_mutex_local_verrou = true; // Set mutex lock to stop the player performing concurrent actions.
		
		// SARGE
		//_totalDuration = 45;
		_totalDuration = 2;
		_vehicle_theft=false;
		

		if (R3F_LOG_lock_active) then {

			diag_log format["DEBUG - Vehicle lock functionality active"];
		
			_vehicle_owner = _currObject getVariable "Vehicle_Owner";
			_vehicle_group = _currObject getVariable "Vehicle_Group";
			_vehicle_faction = _currObject getVariable "Vehicle_Faction";
			
			// check if its a vehicle and not a structure
			if !(isNil "_vehicle_owner") then
				{
				diag_log format["DEBUG - some value in vehicle_owner, so it is a vehicle - unlocking"];
				_totalDuration = 10;

				diag_log format["Debug: Vehicle Owner: %1 - Owner Group: %2- Owner faction: %3 - Player UID: %4 - Player Group: %5 - Player faction: %6",_vehicle_owner,_vehicle_group,_vehicle_faction,getplayerUID player,group player, side player];

				_vehicle_theft=false;
				
				switch (R3F_LOG_CFG_locktype) do {
					case "Owner":{
						_ownertype="";
						if(_vehicle_owner != getplayerUID player) then {
							_vehicle_theft=true;
						};
					};
					case "Group":{
						_ownertype="r group";			
						if(_vehicle_group != group player) then {
							_vehicle_theft=true;
						};
					};
					case "Faction":{
						_ownertype="r faction";
						if(_vehicle_faction != side player) then {
							_vehicle_theft=true;
						};
					};
				};
				
				if (_vehicle_theft) then {
					2 cutText [format["This vehicle does not belong to you%1!",_ownertype], "PLAIN DOWN", 1];
				};

			};

		};
			
		// SARGE implement getout logic
		
		_unlockDuration = _totalDuration;
		_iteration = 0;
		
		player switchMove "AinvPknlMstpSlayWrflDnon_medic"; // Begin the full medic animation...
		
		for "_iteration" from 1 to _unlockDuration do {
		    
            if (animationState player != "AinvPknlMstpSlayWrflDnon_medic") then { // Keep the player locked in medic animation for the full duration of the unlock.
                player switchMove "AinvPknlMstpSlayWrflDnon_medic";
            };
            
			_unlockDuration = _unlockDuration - 1;
		    _iterationPercentage = floor (_iteration / _totalDuration * 100);
		    
		    if(	_vehicle_theft) exitWith { // If the player dies, revert state.
                R3F_LOG_mutex_local_verrou = false;
			};

			2 cutText [format["Object unlock %1%2 complete", _iterationPercentage, _stringEscapePercent], "PLAIN DOWN", 1];
		    sleep 1;

		    if(player distance _currObject > 50) exitWith { // If the player dies, revert state.
		        2 cutText ["Object lock interrupted...", "PLAIN DOWN", 1];
                R3F_LOG_mutex_local_verrou = false;
			};
		    
			if (_iteration >= _totalDuration) exitWith { // Sleep a little extra to show that lock has completed
		        sleep 1;
                
				if !(R3F_LOG_lock_active) then {
					
					_currObject setVariable ["objectLocked", false, true];
					
				} else {

					_vehicle_owner = _currObject getVariable "Vehicle_Owner";
					
					// check if its a vehicle and not a structure
					if !(isNil "_vehicle_owner") then
					{
						diag_log format["DEBUG - remove Lock - vehicle owner value found"];
						_currObject lock false;
						_currObject setVehicleLock "UNLOCKED";
						_currObject setVariable ["Vehicle_Owner", "", true];
						_currObject setVariable ["Vehicle_Group", "", true];
						_currObject setVariable ["Vehicle_Faction", "", true];
						
						// delete object variable in player
						player setVariable ["Owned_Vehicle", nil,false];
						
					};
						
					_currObject setVariable ["objectLocked", false, true];
							
					
				};		
				
                2 cutText ["", "PLAIN DOWN", 1];
                R3F_LOG_mutex_local_verrou = false;
		    }; 
		};
		
		player SwitchMove "amovpknlmstpslowwrfldnon_amovpercmstpsraswrfldnon"; // Redundant reset of animation state to avoid getting locked in animation.     
    };
    default{  // This should not happen... 
        hint "An error has occured in LockStateMachine.sqf and the current action can not be completed. Please notify the server administrator.";
        diag_log format["WASTELAND DEBUG: An error has occured in LockStateMachine.sqf. _lockState was unknown. _lockState actual: %1", _lockState];
    };
    
    if !(R3F_LOG_mutex_local_verrou) then {
        R3F_LOG_mutex_local_verrou = false;
        diag_log format["WASTELAND DEBUG: An error has occured in LockStateMachine.sqf. Mutex lock was not reset. Mutex lock state actual: %1", R3F_LOG_mutex_local_verrou];
    }; 
};
