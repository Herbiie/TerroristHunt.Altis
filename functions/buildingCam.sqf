params ["_building"];
private _campos = [((getpos _building) # 0) + 350,((getpos _building) # 1) + 350,((getpos _building) # 2) + 300];
private _camera = "camera" camcreate _campos;
_camera cameraeffect ["internal", "back"];
cameraEffectEnableHUD true;
_camera camPrepareTarget _building;
_camera camPrepareFOV 1;
_camera camPreparePos _campos;
_camera camCommitPrepared 0;
addMissionEventHandler ["Draw3D", {
	drawIcon3D ["\A3\ui_f\data\map\markers\military\objective_CA.paa", 	[0.5,0,0,1],position (missionNameSpace getVariable "H_targetBuilding"),1,1,0,"Target Building"];
}];

waitUntil {!(missionNameSpace getVariable "vote2")};

waitUntil {(missionNameSpace getVariable "vote3")};
addMissionEventHandler ["Draw3D", {
	drawIcon3D ["\A3\ui_f\data\map\markers\military\start_CA.paa", 	[0,0.3,0.6,1] ,(missionNameSpace getVariable "H_pos1"),1,1,0,"Start Location 1"];
	drawIcon3D ["\A3\ui_f\data\map\markers\military\start_CA.paa", 	[0,0.3,0.6,1] ,(missionNameSpace getVariable "H_pos2"),1,1,0,"Start Location 2"];
	drawIcon3D ["\A3\ui_f\data\map\markers\military\start_CA.paa", 	[0,0.3,0.6,1] ,(missionNameSpace getVariable "H_pos3"),1,1,0,"Start Location 3"];
}];

waitUntil {(missionNameSpace getVariable "vote4")};
removeAllMissionEventHandlers "Draw3D";
addMissionEventHandler ["Draw3D", {
	drawIcon3D ["\A3\ui_f\data\map\markers\military\objective_CA.paa", 	[0.5,0,0,1],position (missionNameSpace getVariable "H_targetBuilding"),1,1,0,"Target Building"];
	drawIcon3D ["\A3\ui_f\data\map\markers\military\start_CA.paa", 	[0,0.3,0.6,1] ,(missionNameSpace getVariable "H_startpos"),1,1,0,"Start Location"];
}];


waitUntil {(missionNameSpace getVariable "vote5")};
sleep 2;
_camera camPreparePos (position player);
_camera camPrepareTarget player;
_camera camCommitPrepared 5;
waitUntil {camCommitted _camera};
removeAllMissionEventHandlers "Draw3D";
_camera cameraEffect ["terminate","back"];
["Notification",["Mission Set Up","Use the action on the satellite dish when you're ready to begin."]] spawn BIS_fnc_showNotification;