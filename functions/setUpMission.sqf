
{
	deleteVehicle _x;
} forEach allDeadMen;
sleep 0.25;
{
	_x setMarkerType "mil_dot";
	_x setMarkerColor "ColorRED";	
	_x setMarkerText "";	
	_x setMarkerAlpha 1;	
} forEach H_markers;
"startPosition" setMarkerAlpha 0;
{
	_x setvariable ["H_playerVoteChoice","",true];
	_x removeAllEventHandlers "Fired";
	_x setCaptive false;
	_x hideObjectGlobal false;	
} forEach allPlayers;

[] spawn H_fnc_buildingVote;