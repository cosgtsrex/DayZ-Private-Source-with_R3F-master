/**
 * Initialise un véhicule transporteur
 * 
 * @param 0 le transporteur
 */

private ["_transporteur", "_est_desactive", "_objets_charges"];

_transporteur = _this select 0;
_doLock = 0;
_doUnlock = 1;

_est_desactive = _transporteur getVariable "R3F_LOG_disabled";
if (isNil "_est_desactive") then
{
	_transporteur setVariable ["R3F_LOG_disabled", false];
};

// Définition locale de la variable si elle n'est pas définie sur le réseau
_objets_charges = _transporteur getVariable "R3F_LOG_objets_charges";
if (isNil "_objets_charges") then
{
	_transporteur setVariable ["R3F_LOG_objets_charges", [], false];
};

 _vehicle_owner = _transporteur getVariable "Vehicle_Owner";
 if (isNil "_vehicle_owner") then
 {
	_transporteur setVariable ["Vehicle_Owner", "", true];
	_transporteur setVariable ["Vehicle_Group", "", true];
	_transporteur setVariable ["Vehicle_Faction", "", true];
	
 };





_transporteur addAction [("<t color=""#dddd00"">" + STR_R3F_LOG_action_charger_deplace + "</t>"), "addons\R3F_ARTY_AND_LOG\R3F_LOG\transporteur\charger_deplace.sqf", nil, 6, true, true, "", "R3F_LOG_objet_addAction == _target && R3F_LOG_action_charger_deplace_valide && Object_canLock"];

_transporteur addAction [("<t color=""#eeeeee"">" + STR_R3F_LOG_action_charger_selection + "</t>"), "addons\R3F_ARTY_AND_LOG\R3F_LOG\transporteur\charger_selection.sqf", nil, 6, true, true, "", "R3F_LOG_objet_addAction == _target && R3F_LOG_action_charger_selection_valide && Object_canLock"];

_transporteur addAction [("<t color=""#dddd00"">" + STR_R3F_LOG_action_contenu_vehicule + "</t>"), "addons\R3F_ARTY_AND_LOG\R3F_LOG\transporteur\voir_contenu_vehicule.sqf", nil, 5, false, true, "", "R3F_LOG_objet_addAction == _target && R3F_LOG_action_contenu_vehicule_valide && Object_canLock"];

_transporteur addAction [("<t color=""#dddd00"">" + STR_R3F_LOG_action_lock_vehicule + "</t>"), "addons\R3F_ARTY_AND_LOG\R3F_LOG\objet_deplacable\objectLockStateMachine.sqf", _doLock, -5, false, true, "", "R3F_LOG_objet_addAction == _target && R3F_LOG_action_contenu_vehicule_valide && Object_canLock"];
_transporteur addAction [("<t color=""#E01B1B"">" + STR_R3F_LOG_action_unlock_vehicule + "</t>"), "addons\R3F_ARTY_AND_LOG\R3F_LOG\objet_deplacable\objectLockStateMachine.sqf", _doUnlock, -5, false, true, "", "R3F_LOG_objet_addAction == _target && R3F_LOG_action_contenu_vehicule_valide && !Object_canLock"];
	
	