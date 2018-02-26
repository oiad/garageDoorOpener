/*
	Garage door opener script by salival (https://github.com/oiad)
*/

if (dayz_actionInProgress) exitWith {localize "str_player_actionslimit" call dayz_rollingMessages;};
dayz_actionInProgress = true;

private "_door";

_door = _this select 3;

if (isNull _door) exitWith {dayz_actionInProgress = false; systemChat "Selected door is NULL!";};

{DZE_myVehicle removeAction _x} count s_player_gdoor_opener;s_player_gdoor_opener = [];
s_player_gdoor_opener_ctrl = 1;
		
if (_door animationPhase "Open_door" == 0) then {
	systemChat localize "STR_CL_GDO_DOOR_OPEN";
	_door animate ["Open_door",1];
} else {
	systemChat localize "STR_CL_GDO_DOOR_CLOSE";
	_door animate ["Open_door",0];
};

s_player_gdoor_opener_ctrl = -1;
dayz_actionInProgress = false;
