params ["_win","_time","_number","_building"];
if (!isDedicated) then {
	private _shots = missionNameSpace getVariable "H_shots";
	private _shotsPerKill = "N/A";
	if (_number > 0) then {
		_shotsPerKill = _shots/_number;
	};
	private _totalTime = [(round (_time - (missionNameSpace getVariable "H_startTime"))),"MM:SS"] call BIS_fnc_secondsToString;
	private _shotsTime = [(round (_time - (missionNameSpace getVariable "H_firstShot"))),"MM:SS"] call BIS_fnc_secondsToString;
	private _winText = "";
	if (_win) then {
		_winText = "Mission Success.";
	} else {
		_winText = "Mission Failed.";
		_shotsPerKill = _shots/(_number-({side _x == east} count allUnits));
	};

	private _playerData = [];
	{
		private _text = "";
		if ((_x distance (getMarkerPos "respawn_west")) < 30) then {
			_text = "(KIA)";
		};
		_playerData pushBack [_x getVariable "H_playerName",_x getvariable "H_Kills",_x getVariable "H_individualShots",_text];
	} forEach allplayers;

	private _playerText = "";

	{
		private _text = format ["%1 - Kills: %2 - Shots: %3 %4<br/>",_x # 0, _x # 1, _x # 2,_x # 3];
		_playerText = _playerText + _text;
	} forEach _playerData;

	if (_win) then {	
		["Notification",["Mission Sucess","Building Clear, well done."]] spawn BIS_fnc_showNotification;
	} else {
		["Notification",["Mission Failed","We'll get 'em next time."]] spawn BIS_fnc_showNotification;
	};

	sleep 3;

	private _campos = [((getpos _building) # 0) + 50,((getpos _building) # 1) + 50,((getpos _building) # 2) + 50];

	forceRespawn player;
	waitUntil {player getVariable "H_respawned"};
	sleep 1;
	["Terminate"] call BIS_fnc_EGSpectator;
	private _camera = "camera" camcreate _campos;
	_camera cameraeffect ["internal", "back"];
	cameraEffectEnableHUD true;
	_camera camPrepareTarget _building;
	_camera camPrepareFOV 1;
	_camera camPreparePos _campos;
	_camera camCommitPrepared 2;
	waitUntil {camCommitted _camera};
	player setVariable ["H_respawned",false,true];
	[format ["%1 <br/>Shots fired: %2 <br/>Shots per kill: %3 <br/>Total Mission Time: %4<br/> Mission Time from First Shot: %5<br/> %6",_winText,_shots,_shotsPerKill,_totalTime,_shotsTime,_playerText],-1,SafeZoneY+(safeZoneH/10),settings_votetime - 2,1] spawn BIS_fnc_dynamicText;

	sleep settings_votetime;

	_camera cameraEffect ["terminate","back"];
};
if (isServer) then {
	[] spawn H_fnc_setUpMission;
};

