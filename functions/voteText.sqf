titleText ["", "BLACK FADED", 0.4];
sleep 1;
waitUntil {player getVariable "H_respawned"};
sleep 1;
["Terminate"] call BIS_fnc_EGSpectator;
player setVariable ["H_respawned",false,true];
titleFadeOut 1;
while {true} do {
	waitUntil {(missionNameSpace getVariable "vote1")};
	player setVariable ["H_hasVoted",false,true];
	addMissionEventHandler ["MapSingleClick", {
		params ["_units", "_pos", "_alt", "_shift"];
		player setVariable ["H_hasVoted",true,true];
		private _distance = worldSize;
		private _closest = "";
		{
			private _thisDistance = (getMarkerPos _x) distance _pos;
			if (_thisDistance < _distance) then {
				_closest = _x;
				_distance = _thisDistance
			};
		} forEach H_markers;
		_closest setMarkerColorlocal "ColorGreen";
		_closest setMarkerAlphalocal 1;
		{
			if (_x != _closest) then {
				_x setMarkerAlphalocal 0.5;
				_x setMarkerColorlocal "ColorRED";
			};
		} forEach H_markers;
		player setvariable ["H_playerVoteChoice",_closest,true];
	}];
	openMap true;
	while {(missionNameSpace getVariable "vote1") || ({!(_x getVariable "H_hasVoted")} count allPlayers) == 0} do {
		private _time = round (settings_votetime - (Diag_tickTime - (missionNameSpace getVariable "H_voteStart")));
		[format ["<t shadow='2'>%1 seconds remaining, vote now!</t>", _time],-1,safezoneY + safezoneH - 0.3,0.5,0] spawn BIS_fnc_dynamicText;
		sleep 0.5;
	};



	waitUntil {(missionNameSpace getVariable "vote2")};
	while {(missionNameSpace getVariable "vote2") || ({!(_x getVariable "H_hasVoted")} count allPlayers) == 0} do {
		private _time = round (settings_votetime - (Diag_tickTime - (missionNameSpace getVariable "H_voteStart")));
		[format ["<t shadow='2'>%1 seconds remaining, vote now!</t>", _time],-1,safezoneY + safezoneH - 0.3,0.5,0] spawn BIS_fnc_dynamicText;
		sleep 0.5;
	};

	while {!(missionNameSpace getVariable "vote2") && !(missionNameSpace getVariable "vote3")} do {
		["<t shadow='2'>Selecting Starting Positions, Please Wait.</t>",-1,safezoneY + safezoneH - 0.3,0.5,0] spawn BIS_fnc_dynamicText;
		sleep 0.5;
	};

	while {(missionNameSpace getVariable "vote3") || ({!(_x getVariable "H_hasVoted")} count allPlayers) == 0} do {
		private _time = round (30 - (Diag_tickTime - (missionNameSpace getVariable "H_voteStart")));
		[format ["<t shadow='2'>%1 seconds remaining, vote now!</t>", _time],-1,safezoneY + safezoneH - 0.3,0.5,0] spawn BIS_fnc_dynamicText;
		sleep 0.5;
	};

	waitUntil {(missionNameSpace getVariable "vote4")};

	while {(missionNameSpace getVariable "vote4") || ({!(_x getVariable "H_hasVoted")} count allPlayers) == 0} do {
		private _time = round (30 - (Diag_tickTime - (missionNameSpace getVariable "H_voteStart")));
		[format ["<t shadow='2'>%1 seconds remaining, vote now!</t>", _time],-1,safezoneY + safezoneH - 0.3,0.5,0] spawn BIS_fnc_dynamicText;
		sleep 0.5;
	};

	waitUntil {(missionNameSpace getVariable "vote5") || ({!(_x getVariable "H_hasVoted")} count allPlayers) == 0};

	while {(missionNameSpace getVariable "vote5")} do {
		private _text = "<t shadow='2' size='0.5'>Ready Players:<br/>";
		{
			_text = _text + (format ["%1<br/>",_x]);
		} forEach (missionNameSpace getVariable "H_readyPlayers");
		_text = _text + "Unready Players:<br/>";
		{
			private _name = _x getVariable "H_playerName";
			if (!(_name in (missionNameSpace getVariable "H_readyPlayers"))) then {
				_text = _text + (format ["%1<br/>",_name]);
			};
		} forEach allPlayers;
		_text = _text + "</t>";
		[_text,safeZoneX+safeZoneW/1.5,safezoneY+(safeZoneH/9.09055),0.5,0] spawn BIS_fnc_dynamicText;
		sleep 0.5;
	};
	player setVariable ["H_hasVoted",false,true];
	private _a = 5;
	while {!(missionNameSpace getVariable "H_start")} do {
		[format ["<t shadow='2' size='2'>Mission starting in %1</t>",_a],-1,-1,1,0] spawn BIS_fnc_dynamicText;
		_a = _a - 1;
		sleep 1;
	};
};