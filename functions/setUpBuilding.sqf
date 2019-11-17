params ["_building","_number"];
private _group = createGroup EAST;
private _buildingPositions = _building buildingPos -1;
private _a = 0;
missionNameSpace setVariable ["H_shots",0,true];
missionNameSpace setVariable ["H_shotsFired",false,true];
{
	_x setVariable ["H_Kills",0,true];
	_x setVariable ["H_individualShots",0,true];
	_x addEventHandler ["Fired",{
		params ["_firer"];
		_firer setVariable ["H_individualShots",(_firer getVariable "H_individualShots")+1,true];
		missionNameSpace setVariable ["H_shots",(missionNameSpace getVariable "H_shots")+1,true];
		missionNameSpace setVariable ["H_shotsFired",true,true];
	}];
} forEach allPlayers;
while {_a < _number} do {
	private _thisPos = selectRandom _buildingPositions;
	_buildingPositions deleteat (_buildingPositions find _thisPos);
	private _unit = _group createUnit [selectRandom settings_units,_thisPos,[],0,"NONE"];
	_unit setVehiclePosition [_thisPos, [], 0, "CAN_COLLIDE"];
	[_unit] join _group;
	_unit disableai "PATH";
	_unit addMPEventHandler ["MPkilled", {
	params ["_dead", "_killer", "_instigator"];
		_killer setvariable ["H_Kills",(_killer getvariable "H_Kills")+1,true];
	}
	];
	_unit addEventHandler ["Fired",{
		params ["_firer"];
		missionNameSpace setVariable ["H_shotsFired",true,true];
	}];
	_a = _a + 1;
};
{
	_x enableSimulation false;
} forEach units _group;
waitUntil {missionNameSpace getVariable "H_start"};
{
	_x enableSimulation true;
} forEach units _group;
missionNameSpace setVariable ["H_startTime",diag_ticktime,true];

waitUntil {missionNameSpace getVariable "H_shotsFired"};
missionNameSpace setVariable ["H_firstShot",diag_ticktime,true];

waitUntil {(({alive _x} count (units _group)) <= _number/5) || ({(_x distance (getMarkerPos "respawn_west")) > 50} count allPlayers == 0)};
if ({(_x distance (getMarkerPos "respawn_west")) > 50} count allPlayers == 0) exitWith {
	missionNameSpace setVariable ["H_start",false,true];
	[false,diag_tickTime,_number,_building] remoteExec ["H_fnc_endScreen",0];
	sleep settings_votetime;
	{
		deleteVehicle _x;
	} forEach units _group;
}; 
{
	_x enableai "PATH";
	[_building buildingPos -1,_x] spawn {
		params ["_positions","_unit"];
		while {alive _unit} do {
			private _pos = (selectRandom _positions);
			_unit doMove _pos;
			waitUntil {(_unit distance _pos) < 1};
		};
	};
} forEach units _group; 
waitUntil {(({alive _x} count (units _group)) == 0) || ({(_x distance (getMarkerPos "respawn_west")) > 50} count allPlayers == 0)};
if ({(_x distance (getMarkerPos "respawn_west")) > 50} count allPlayers == 0) then {
	missionNameSpace setVariable ["H_start",false,true];
	[false,diag_tickTime,_number,_building] remoteExec ["H_fnc_endScreen",0];	
	sleep settings_votetime;
	{
		deleteVehicle _x;
	} forEach units _group;
} else {
	missionNameSpace setVariable ["H_start",false,true];
	[true,diag_tickTime,_number,_building] remoteExec ["H_fnc_endScreen",0];	
};