
waitUntil {missionNameSpace getVariable "H_start"};
while {missionNameSpace getVariable "H_start"} do {
	private _enemy = {side _x == east} count allUnits;
	[format ["<t shadow='2' size='0.5'>%1 enemy remaining.</t>", _enemy],safeZoneX+safeZoneW/1.5,safezoneY + safezoneH - 0.3,0.5,0] spawn BIS_fnc_dynamicText;
	sleep 0.5;
};
[] spawn H_fnc_enemyCount;