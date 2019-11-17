
vote1 = false;
vote2 = false;
vote3 = false;
vote4 = false;
vote5 = false;
player setVariable ["H_respawned",false,true];
#include "customisation\settings.sqf"
H_fnc_setUpBuilding = compile (preprocessFileLineNumbers "functions\setUpBuilding.sqf");
H_fnc_setUpMission = compile (preprocessFileLineNumbers "functions\setUpMission.sqf");
H_fnc_buildingVote = compile (preprocessFileLineNumbers "functions\buildingVote.sqf");
H_fnc_voteText = compile (preprocessFileLineNumbers "functions\voteText.sqf");
H_fnc_buildingCam = compile (preprocessFileLineNumbers "functions\buildingCam.sqf");
H_fnc_endScreen = compile (preprocessFileLineNumbers "functions\endScreen.sqf");
H_fnc_enemyCount = compile (preprocessFileLineNumbers "functions\enemyCount.sqf");


if (isServer) then {
	H_availableBuildings = [];
	private _houses = ([worldSize / 2, worldsize / 2, 0] nearObjects ["House", worldSize]);
	private _buildings = ([worldSize / 2, worldsize / 2, 0] nearObjects ["Building", worldSize]);
	private _allStructures = _houses + _buildings;
	private _bigStructures = [];
	{
		if ((count (_x buildingPos -1)) > settings_buildingThreshold) then {
			_bigStructures pushback _x;
		};	
	} forEach _allStructures;
	{
		H_availableBuildings pushBackUnique _x;
	} forEach _bigStructures;
	private _buildingPosisitions = [];
	{
		_buildingPosisitions pushBackUnique [_x,400];
	} forEach H_availableBuildings;
	private _pos = [[worldSize / 2, worldsize / 2, 0],0,worldsize,5,0,20,0,_buildingPosisitions,[worldSize / 2, worldsize / 2, 0]] call BIS_fnc_findSafePos;
	createMarker ["respawn_west",_pos];
	private _a = 0;
	private _b = 0;
	private _marker = createMarker ["startPosition",[worldSize / 2, worldsize / 2, 0]];
	_marker setMarkerAlpha 0;
	_marker setMarkerType "Mil_Start";
	_marker setMarkerColor "colorBLUFOR";
	_marker setMarkerText "Start Position";
	missionNameSpace setVariable ["H_shots",0,true];
	missionNameSpace setVariable ["H_start",false,true];
	missionNameSpace setVariable ["H_shotsFired",false,true];
	{
		_x setVariable ["H_Kills",0,true];
	} forEach allPlayers;
	while {_a <= 60} do {
		private _position = _pos getPos [15,_b];
		private _wall = createVehicle ["Land_CncWall1_F",_position,[],0,"CAN_COLLIDE"];
		_wall setDir _b;
		_wall enablesimulation false;
		_a = _a + 1;	
		_b = _b + 6;	
	};
	H_markers = [];
	H_buildingVotes = [];
	{
		private _marker = createMarker [format ["Marker%1",_forEachIndex],position _x];
		_marker setMarkerType "mil_dot";
		_marker setMarkerColor "ColorRED";
		private _buildingName = getText (configfile >> "CfgVehicles" >> typeOf _x >> "displayName");
		_marker setMarkerText format ["%1 - %2",(_forEachIndex + 1),_buildingName];
		H_markers pushBack _marker;
	} forEach H_availableBuildings;
	publicVariable "H_markers";
	publicVariable "H_availableBuildings";
	[] spawn H_fnc_setUpMission;
	
};

player setVariable ["H_playerName",profileName,true];
player setVariable ["H_respawned",false,true];
player setVariable ["H_hasVoted",false,true];
[] spawn H_fnc_enemyCount;
[] spawn H_fnc_voteText;