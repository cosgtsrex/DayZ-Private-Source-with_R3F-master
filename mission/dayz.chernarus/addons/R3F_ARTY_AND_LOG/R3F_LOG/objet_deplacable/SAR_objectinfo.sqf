/**
 * Fait déplacer un objet par le joueur. Il garde l'objet tant qu'il ne le relâche pas ou ne meurt pas.
 * L'objet est relaché quand la variable R3F_LOG_joueur_deplace_objet passe à objNull ce qui terminera le script
 * 
 * @param 0 l'objet à déplacer
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

_object = _this select 0;

_classname = typeof _object;
_r3f_disabled = _object getVariable "R3F_LOG_disabled";
_obid = _object getVariable "ObjectID";

hint format["Type of object: %1\nR3F_disabled: %2\nObjectID: %3",_classname,_r3f_disabled,_obid];
