missionNameSpace setVariable ["vote1",true,true];
missionNameSpace setVariable ["vote2",false,true];
missionNameSpace setVariable ["H_voteStart",Diag_tickTime,true];
waitUntil {(Diag_tickTime - H_voteStart) > settings_votetime};
missionNameSpace setVariable ["vote1",false,true];
{
	private _var = _x getVariable "H_playerVoteChoice";
	missionNameSpace setVariable [format ["%1votes",_var],(missionNameSpace getVariable format ["%1votes",_var])+1,true];
} forEach allPlayers;

private _winningValue = 0;
private _winner = (selectRandom H_markers);
{
	private _var = missionNameSpace getVariable format ["%1votes",_x];
	if (_var > _winningValue) then {
		_winningValue = _var;
		_winner = _x;
	};
} forEach H_markers;
{
	if (_x != _winner) then {
		_x setMarkerAlpha 0;
	} else {
		_x setMarkerText "Target Building";
		_x setMarkerColor "ColorOPFOR";
		_x setMarkerType "mil_objective";
		_x setMarkerAlpha 1;
	};
}  forEach H_markers;
private _building = nearestBuilding (getMarkerPos _winner);
private _buildingDistance = 1000;
{
	if ((_x distance getMarkerPos _winner) < _buildingDistance) then {
		_building = _x;
		_buildingDistance = (_x distance getMarkerPos _winner);
	};
} forEach H_availableBuildings;

missionNameSpace setVariable ["H_targetBuilding",_building,true];
missionNameSpace setVariable ["H_5nme",0,true];
missionNameSpace setVariable ["H_10nme",0,true];
missionNameSpace setVariable ["H_15nme",0,true];
missionNameSpace setVariable ["H_20nme",0,true];
missionNameSpace setVariable ["H_25nme",0,true];

["MapSingleClick"] remoteExec ["removeAllMissionEventHandlers",0];
[0] remoteExec ["closeDialog",0];
["NUMBERENEMY"] remoteExec ["createDialog",0];
[false] remoteExec ["openMap",0];
missionNameSpace setVariable ["H_voteStart",Diag_tickTime,true];
missionNameSpace setVariable ["vote2",true,true];
[_building] remoteExec ["H_fnc_buildingCam",0];
waitUntil {(Diag_tickTime - H_voteStart) > settings_votetime};
missionNameSpace setVariable ["vote2",false,true];
private _variableArray = [H_5nme,H_10nme,H_15nme,H_20nme,H_25nme];
_variableArray sort false;
private _winner2 = (selectRandom _variableArray);
private _number = 25;

if (_winner2 == H_20nme) then {_number = 20};
if (_winner2 == H_15nme) then {_number = 15};
if (_winner2 == H_10nme) then {_number = 10};
if (_winner2 == H_5nme) then {_number = 5};

_pos1 = [position _building, 75,200,6,0,5,0] call BIS_fnc_findSafePos;
while {[objNull, "VIEW"] checkVisibility [[(position _building) # 0,(position _building) # 1,((position _building) # 2)+10], _pos1] > 0} do {
	_pos1 = [position _building, 75,200,6,0,5,0] call BIS_fnc_findSafePos;
};
_pos2 = [position _building, 75,200,6,0,5,0,[[_pos1,30]]] call BIS_fnc_findSafePos;
while {[objNull, "VIEW"] checkVisibility [[(position _building) # 0,(position _building) # 1,((position _building) # 2)+10], _pos2] > 0} do {
	_pos2 = [position _building, 75,200,6,0,5,0,[[_pos1,30]]] call BIS_fnc_findSafePos;
};
_pos3 = [position _building, 75,200,6,0,5,0,[[_pos1,30],[_pos2,30]]] call BIS_fnc_findSafePos;
while {[objNull, "VIEW"] checkVisibility [[(position _building) # 0,(position _building) # 1,((position _building) # 2)+10], _pos3] > 0} do {
	_pos3 = [position _building, 75,200,6,0,5,0,[[_pos1,30],[_pos2,30]]] call BIS_fnc_findSafePos;
};
missionNameSpace setVariable ["H_pos1",_pos1,true];
missionNameSpace setVariable ["H_pos2",_pos2,true];
missionNameSpace setVariable ["H_pos3",_pos3,true];
missionNameSpace setVariable ["H_pos1votes",0,true];
missionNameSpace setVariable ["H_pos2votes",0,true];
missionNameSpace setVariable ["H_pos3votes",0,true];
missionNameSpace setVariable ["vote3",true,true];
missionNameSpace setVariable ["H_voteStart",Diag_tickTime,true];
[0] remoteExec ["closeDialog",0];
["STARTLOC"] remoteExec ["createDialog",0];
waitUntil {(Diag_tickTime - H_voteStart) > settings_votetime};
missionNameSpace setVariable ["vote3",false,true];
private _variableArray2 = [(missionNameSpace getVariable "H_pos1votes"),(missionNameSpace getVariable "H_pos2votes"),(missionNameSpace getVariable "H_pos3votes")];
_variableArray2 sort false;
private _winner3 = _variableArray2 # 0;
if ((missionNameSpace getVariable "H_pos1votes") == _winner3) then {missionNameSpace setVariable ["H_startpos",_pos1,true]};
if ((missionNameSpace getVariable "H_pos2votes") == _winner3) then {missionNameSpace setVariable ["H_startpos",_pos2,true]};
if ((missionNameSpace getVariable "H_pos3votes") == _winner3) then {missionNameSpace setVariable ["H_startpos",_pos3,true]};
H_box = "B_CargoNet_01_ammo_F" createVehicle H_startpos;
clearMagazineCargoGlobal H_box;
clearWeaponCargoGlobal H_box;
clearItemCargoGlobal H_box;
clearBackpackCargoGlobal H_box;
[H_box,settings_arsenalWeapons,true] call BIS_fnc_addVirtualWeaponCargo;
[H_box,settings_arsenalMagazines,true] call BIS_fnc_addVirtualMagazineCargo;
[H_box,settings_arsenalItems,true] call BIS_fnc_addVirtualItemCargo;
[H_box,settings_arsenalBackpacks,true] call BIS_fnc_addVirtualBackpackCargo;
_stand = "SatelliteAntenna_01_Olive_F" createVehicle (missionNameSpace getVariable "H_startpos");
missionNameSpace setVariable ["H_readyPlayers",[],true];
missionNameSpace setVariable ["H_stand",_stand,true];
[(missionNameSpace getVariable "H_stand"),["Ready Up!",{
	(missionNameSpace getVariable "H_readyPlayers") pushBackUnique (player getVariable "H_playerName"); (missionNameSpace getVariable "H_stand") removeAction (_this # 2);
},nil,1.5,true,true,"","true",4]] remoteExec ["addAction",0];
H_walls = [];
private _a = 0;
private _b = 0;
while {_a <= 60} do {
	private _pos = (missionNameSpace getVariable "H_startpos") getPos [15,_b];
	private _wall = createVehicle ["Land_CncWall1_F",_pos,[],0,"CAN_COLLIDE"];
	_wall setDir _b;
	_wall enablesimulation false;
	H_walls pushBack _wall;
	_a = _a + 1;	
	_b = _b + 6;	
};
publicVariable "H_walls";

{
	_x setPos (missionNameSpace getVariable "H_startpos");
} forEach allPlayers;
"startPosition" setMarkerPos (missionNameSpace getVariable "H_startpos");
"startPosition" setMarkerAlpha 1;
missionNameSpace setVariable ["vote4",true,true];
missionNameSpace setVariable ["H_dawnVotes",0,true];
missionNameSpace setVariable ["H_morningVotes",0,true];
missionNameSpace setVariable ["H_afternoonVotes",0,true];
missionNameSpace setVariable ["H_duskVotes",0,true];
missionNameSpace setVariable ["H_nightVotes",0,true];
[0] remoteExec ["closeDialog",0];
missionNameSpace setVariable ["H_voteStart",Diag_tickTime,true];
["TIMEOFDAY"] remoteExec ["createDialog",0];
waitUntil {(Diag_tickTime - H_voteStart) > settings_votetime};
missionNameSpace setVariable ["vote4",false,true];
private _variableArray3 = [missionNameSpace getVariable "H_dawnVotes",missionNameSpace getVariable "H_morningVotes",missionNameSpace getVariable "H_afternoonVotes",missionNameSpace getVariable "H_duskVotes",missionNameSpace getVariable "H_nightVotes"];
_variableArray3 sort false;
private _winner4 = _variableArray3 # 0;
private _date = [2035,06,10,04,15];
if (_winner4 == (missionNameSpace getVariable "H_morningVotes")) then {_date = [2035,06,10,09,00]};
if (_winner4 == (missionNameSpace getVariable "H_afternoonVotes")) then {_date = [2035,06,10,14,00]};
if (_winner4 == (missionNameSpace getVariable "H_duskVotes")) then {_date = [2035,06,10,19,30]};
if (_winner4 == (missionNameSpace getVariable "H_nightVotes")) then {_date = [2035,06,10,23,30]};
[_date,true,true] call BIS_fnc_setDate;
[_building,_number] spawn H_fnc_setUpBuilding;
sleep 1;
missionNameSpace setVariable ["vote5",true,true];
waitUntil {(count (missionNameSpace getVariable "H_readyPlayers")) == (count allPlayers)};
sleep 1;
deleteVehicle (missionNameSpace getVariable "H_stand");
deleteVehicle H_box;
missionNameSpace setVariable ["vote5",false,true];
sleep 5;
missionNameSpace setVariable ["H_start",true,true];
{
	deleteVehicle _x;
} forEach H_walls;