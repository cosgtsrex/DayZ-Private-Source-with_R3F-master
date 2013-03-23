// =========================================================================================================
//  SAR_AI - DayZ AI library
//  Version: 1.1.0 
//  Author: Sarge (sarge@krumeich.ch) 
//
//		Wiki: to come
//		Forum: http://opendayz.net/index.php?threads/sarge-ai-framework-public-release.8391/
//		
// ---------------------------------------------------------------------------------------------------------
//  Required:
//  UPSMon  (special version, the standard one will NOT work
//  SHK_pos 
//  
// ---------------------------------------------------------------------------------------------------------
// SAR_config.sqf - User adjustable config values
// last modified: 20.3.2013  
// ---------------------------------------------------------------------------------------------------------

// use dynamic grid spawning system
SAR_dynamic_spawning = true;

// -----------------------------------------------
// default values for dynamic grid spawning
// -----------------------------------------------

// maximum number of groups / grid
SAR_max_grps_bandits = 1;
SAR_max_grps_soldiers = 1;
SAR_max_grps_survivors = 1;

// chance for a group to spawn (1-100)
SAR_chance_bandits = 50;
SAR_chance_soldiers = 30;
SAR_chance_survivors = 50;

// maximum size of group (+1 Leader)
SAR_max_grpsize_bandits = 3;
SAR_max_grpsize_soldiers = 3;
SAR_max_grpsize_survivors = 3;

// -----------------------------------------------
// Humanity values 
// -----------------------------------------------

// Humanity Value that gets substracted for a survivor or soldier AI kill
SAR_surv_kill_value = 250;

// Humanity Value that gets ADDED for a bandit AI kill
SAR_band_kill_value = 50;

// the humanity value below which a player will be considered hostile
SAR_HUMANITY_HOSTILE_LIMIT = -20000;

// -----------------------------------------------
// Track and show AI kills in the debug monitor of the player 
// -----------------------------------------------

// Log AI kills
SAR_log_AI_kills = true;

// -----------------------------------------------
// Special health values for specific units
// -----------------------------------------------

// values: 0.1 - 1, 1 = no change, 0.1 = 10 x health
SAR_leader_health_factor = 0.5;

// -----------------------------------------------
// respawning of groups & vehicles that are dynamically spawned in the grid system
// -----------------------------------------------

SAR_dynamic_group_respawn = false;

// time after which AI are respawned if configured
SAR_respawn_waittime = 30; // 30 seconds

// -----------------------------------------------
// Timeout values 
// -----------------------------------------------

// time after which units and groups despawn after players have left the area
SAR_DESPAWN_TIMEOUT = 120; // 2 minutes

// time after which dead AI bodies are deleted
SAR_DELETE_TIMEOUT = 120; // 2 minutes

// -----------------------------------------------
// System performance 
// -----------------------------------------------

// the max range within AI is detecting Zombies and player bandits and makes them hostile - the bigger this value, the more CPU needed
SAR_DETECT_HOSTILE = 200;

// the interval in seconds that an AI scans for new hostiles. The lower this value, the more accurate, but your server will see an impact. Recommended value: 15 
SAR_DETECT_INTERVAL = 15;

// -----------------------------------------------
// Debug 
// -----------------------------------------------

// Shows extra debug info in .rpt
SAR_DEBUG = true;

// careful with setting this, this shows a LOT, including the grid properties and definitions for every spawn and despawn event
SAR_EXTREME_DEBUG = true;

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//
// Overwriting UPSMON standard values, so they dont have to be changed in the UPSMON package. Be careful with changing these.
//
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//Efective distance for doing perfect ambush (max distance is this x2)
KRON_UPS_ambushdist = 100;

//Frequency for doing calculations for each squad.
KRON_UPS_Cycle = 20; //org 20 , try to adjust for server performance

//Time that leader waits until doing another movement, this time reduced dynamically under fire, and on new targets
KRON_UPS_react = 60;

//Min time to wait for doing another reaction
KRON_UPS_minreact = 10; // org 30

//Max waiting is the maximum time patrol groups will wait when arrived to target for doing another target.
KRON_UPS_maxwaiting = 30;

// how long AI units should be in alert mode after initially spotting an enemy
KRON_UPS_alerttime = 90;

// how close unit has to be to target to generate a new one target or to enter stealth mode
// SARGE DEBUG CHANGE
KRON_UPS_closeenough = 10; // if you have vast plain areas, increase this to sth around 150-300 

// if you are spotted by AI group, how close the other AI group have to be to You , to be informed about your present position. over this, will lose target
KRON_UPS_sharedist = 200;

// If enabled IA communication between them with radio defined sharedist distance, 0/2 
// (must be set to 2 in order to use reinforcement !R)
KRON_UPS_comradio = 0;

// Distance from destination for searching vehicles. (Search area is about 200m), 
// If your destination point is further than KRON_UPS_searchVehicledist, AI will try to find a vehicle to go there.
KRON_UPS_searchVehicledist = 1600; // 700, 900  

//1=Enable or 0=disable debug. In debug could see a mark positioning de leader and another mark of the destination of movement, very useful for editing mission
KRON_UPS_Debug = 1;

//
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//
// definition of classes and weapon loadouts
//

//
// type of soldier lists, only allowed DayZ classes listed. adjust if you run rmod or another map that allows different classes
//
// IMPORTANT: The leader types must be different to each other! So you need 3 different leader types here!

// military AI
SAR_leader_sold_list = ["Rocket_DZ"]; // the potential classes of the leader of a soldier group
SAR_sniper_sold_list = ["Sniper1_DZ"]; // the potential classes of the snipers of a soldier group
SAR_soldier_sold_list = ["Soldier1_DZ","Camo1_DZ"]; // the potential classes of the riflemen of a soldier group

// bandit AI
SAR_leader_band_list = ["Bandit1_DZ"]; // the potential classes of the leader of a bandit group
SAR_sniper_band_list = ["Sniper1_DZ"]; // the potential classes of the snipers of a bandit group
SAR_soldier_band_list = ['Bandit1_DZ', 'BanditW1_DZ',"Survivor2_DZ","SurvivorW2_DZ","Soldier_Crew_PMC"]; // the potential classes of the bandit of a soldier group

// survivor AI
SAR_leader_surv_list = ["Survivor3_DZ"]; // the potential classes of the leaders of a survivor group
SAR_sniper_surv_list = ["Sniper1_DZ"]; // the potential classes of the snipers of a survivor group
SAR_soldier_surv_list = ["Survivor2_DZ","SurvivorW2_DZ","Soldier_Crew_PMC"]; // the potential classes of the riflemen of a soldier group


// ---------------------------------------------------------------------------------------------------------------------
// Weapon & Item Loadout
// ---------------------------------------------------------------------------------------------------------------------

// potential weapon list for leaders
SAR_leader_weapon_list = ["M4A1","M4A3_CCO_EP1","AK_47_M"];
SAR_leader_pistol_list = ["glock17_EP1","Colt1911","M9","",""]; 

// potential item list for leaders -> Item / Chance 1 - 100
SAR_leader_items = [["ItemSodaCoke",75],["FoodCanBakedBeans",60]];
SAR_leader_tools =  [["ItemMap",50],["ItemCompass",30],["Binocular_Vector",5],["NVGoggles",5]];

//potential weapon list for riflemen
SAR_rifleman_weapon_list = ["M16A2","Winchester1866","AK_74","LeeEnfield","M1014"];
SAR_rifleman_pistol_list = ["Makarov","revolver_EP1","","",""];

// potential item list for riflemen
SAR_rifleman_items = [["ItemSodaCoke",75],["FoodCanBakedBeans",60]];
SAR_rifleman_tools = [["ItemMap",50],["ItemCompass",30]];

//potential weapon list for snipers
SAR_sniper_weapon_list = ["M4A1_Aim","SVD_CAMO","Huntingrifle"];
SAR_sniper_pistol_list = ["M9SD","glock17_EP1","","","",""];

// potential item list for snipers
SAR_sniper_items = [["ItemSodaCoke",75],["FoodCanBakedBeans",60],["Skin_Sniper1_DZ",10]];
SAR_sniper_tools = [["ItemMap",50],["ItemCompass",30]];

// ---------------------------------------------------------------------------------------------------------------------
// heli patrol definiton
// ---------------------------------------------------------------------------------------------------------------------

// define the type of heli(s) you want to use here for the heli patrols - make sure you include helis that have minimum 2 gunner positions, anything else might fail
SAR_heli_type=["UH1H_DZ","Mi17_DZ"];
