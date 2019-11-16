{
	missionNameSpace setvariable [format ["%1votes",_x],0,true];
} forEach H_markers;
{
	deleteVehicle _x;
} forEach allDeadMen;
sleep 0.25;
{
	_x setMarkerType "mil_dot";
	_x setMarkerColor "ColorRED";	
	_x setMarkerAlpha 1;	
} forEach H_markers;
"startPosition" setMarkerAlpha 0;
{
	_x setvariable ["H_playerVoteChoice","",true];
	_x removeAllEventHandlers "Fired";
	_x setCaptive false;
} forEach allPlayers;

[] spawn H_fnc_buildingVote;