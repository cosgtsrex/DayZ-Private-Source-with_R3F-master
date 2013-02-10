/**
 * Player disconnect logic
 * 
 * @param 0 l'objet
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

 if(!X_Server) exitWith {};

 _id = _this select 0;
 _puid = _this select 2;
 
{
    _vehicle_owner_uid = _x getVariable "Vehicle_Owner";
	if (_vehicle_owner_uid == _puid) then {
	
		diag_log format["Match found"];

		_x lock false;
		_x setVehicleLock "UNLOCKED";
		_x setVariable ["Vehicle_Owner", "", true];
		_x setVariable ["Vehicle_Group", "", true];
		_x setVariable ["Vehicle_Faction", "", true];
		_x setVariable ["objectLocked", false, true];
		
		};
	
}forEach vehicles;
