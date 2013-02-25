/**
 * Fait d�placer un objet par le joueur. Il garde l'objet tant qu'il ne le rel�che pas ou ne meurt pas.
 * L'objet est relach� quand la variable R3F_LOG_joueur_deplace_objet passe � objNull ce qui terminera le script
 * 
 * @param 0 l'objet � d�placer
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

SAR_savebuilding = _this select 0;

publicVariableServer "SAR_savebuilding";
if (isServer) then {
	SAR_savebuilding call SAR_save2hive;
};
