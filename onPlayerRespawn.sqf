player setCaptive true;
player hideObjectGlobal true;
removeAllItems player;
removeAllWeapons player;
removeBackpack player;
removeHeadgear player;
removeVest player;
removeUniform player;
removeGoggles player;
{
	player removeMagazine _x;
} forEach magazines player;
{
	if (!(_x == "itemMap") && !(_x == "itemRadio") && !(_x == "itemCompass") && !(_x == "itemWatch")) then {
		player unassignItem _x;
		player removeItem _x;
	};
} forEach assignedItems player;
["Initialize", [player]] call BIS_fnc_EGSpectator;
sleep 1;
player setVariable ["H_respawned",true,true];
