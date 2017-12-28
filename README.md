# [EPOCH 1.0.6.1] Garage Door Opener
Garage Door Opener by salival (https://github.com/oiad)

* Discussion URL: https://epochmod.com/forum/topic/44544-release-garage-door-opener/

* Tested as working on a blank Epoch 1.0.6.1 server
* Original idea from Sandbird, requested rewrite by TheDuke

# REPORTING ERRORS/PROBLEMS

1. Please, if you report issues can you please attach (on pastebin or similar) your CLIENT rpt log file as this helps find out the errors very quickly. To find this logfile:

	```sqf
	C:\users\<YOUR WINDOWS USERNAME>\AppData\Local\Arma 2 OA\ArmA2OA.RPT
	```

# Install:

* This install basically assumes you have NO custom variables.sqf or compiles.sqf or fn_selfActions.sqf, I would recommend diffmerging where possible.

**[>> Download <<](https://github.com/oiad/garageDoorOpener/archive/master.zip)**

# Mission folder install (fresh epoch install):

1. In mission\init.sqf find: <code>call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\variables.sqf";</code> and add directly below:

	```sqf
	call compile preprocessFileLineNumbers "dayz_code\init\variables.sqf";
	```
	
2. In mission\init.sqf find: <code>call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\compiles.sqf";</code> and add directly below:

	```sqf
	call compile preprocessFileLineNumbers "dayz_code\init\compiles.sqf";
	```

3. Copy the supplied <code>dayz_code</code> and <code>scripts</code> folder and all sub folders/files to your mission directory.

# Mission folder install (existing epoch install):

1. Copy the supplied <code>dayz_code</code> and <code>scripts</code> folder and all sub folders/files to your mission directory.
2. In your custom <code>variables.sqf</code> find the following lines:
	```sqf
	vectorActions = -1;
	s_player_manageDoor = -1;
	```
	Add these lines below:
	```sqf
	s_player_gdoor_opener = [];
	s_player_gdoor_opener_ctrl = -1;
	```

3. Add <code>,"_door","_doors"</code> to the end of your private array in your custom <code>fn_selfActions.sqf</code> so it looks like this for example:
	```sqf
	"_allowed","_hasAccess","_uid","_myCharID","_isLocked","_door","_doors"];
	```

4. Find this code block in your <code>dayz_code\compile\fn_selfActions.sqf</code>:
	```sqf
	if (_inVehicle) then {
		DZE_myVehicle = _vehicle;
		if (_vehicleOwnerID != "0" && _canDo) then {
			if (s_player_lockUnlockInside_ctrl < 0) then {
				_totalKeys = call epoch_tempKeys;
				_temp_keys = _totalKeys select 0;
				_temp_keys_names = _totalKeys select 1;	
				_hasKey = _vehicleOwnerID in _temp_keys;
				_oldOwner = (_vehicleOwnerID == _uid);
			
				_text = getText (configFile >> "CfgVehicles" >> (typeOf DZE_myVehicle) >> "displayName");
				if (locked DZE_myVehicle) then {
					if (_hasKey || _oldOwner) then {
						_unlock = DZE_myVehicle addAction [format[localize "STR_EPOCH_ACTIONS_UNLOCK",_text], "\z\addons\dayz_code\actions\unlock_veh.sqf",[DZE_myVehicle,(_temp_keys_names select (_temp_keys find _vehicleOwnerID))], 2, false, true];
						s_player_lockUnlockInside set [count s_player_lockUnlockInside,_unlock];
						s_player_lockUnlockInside_ctrl = 1;
					} else {
						if (_hasHotwireKit) then {
							_unlock = DZE_myVehicle addAction [format[localize "STR_EPOCH_ACTIONS_HOTWIRE",_text], "\z\addons\dayz_code\actions\hotwire_veh.sqf",DZE_myVehicle, 2, true, true];
						} else {
							_unlock = DZE_myVehicle addAction [format["<t color='#ff0000'>%1</t>",localize "STR_EPOCH_ACTIONS_VEHLOCKED"], "",DZE_myVehicle, 2, true, true];
						};
						s_player_lockUnlockInside set [count s_player_lockUnlockInside,_unlock];
						s_player_lockUnlockInside_ctrl = 1;
					};
				} else {
					if (_hasKey || _oldOwner) then {
						_lock = DZE_myVehicle addAction [format[localize "STR_EPOCH_ACTIONS_LOCK",_text], "\z\addons\dayz_code\actions\lock_veh.sqf",DZE_myVehicle, 1, false, true];
						s_player_lockUnlockInside set [count s_player_lockUnlockInside,_lock];
						s_player_lockUnlockInside_ctrl = 1;
					};
				};
			};
		} else {
			{DZE_myVehicle removeAction _x} count s_player_lockUnlockInside;s_player_lockUnlockInside = [];
			s_player_lockUnlockInside_ctrl = -1;
		};
	} else {
		{DZE_myVehicle removeAction _x} count s_player_lockUnlockInside;s_player_lockUnlockInside = [];
		s_player_lockUnlockInside_ctrl = -1;
	};
	```
	Replace it with this code block:
	```sqf
	if (_inVehicle) then {
		DZE_myVehicle = _vehicle;
		if (_vehicleOwnerID != "0" && _canDo) then {
			if (s_player_lockUnlockInside_ctrl < 0) then {
				_totalKeys = call epoch_tempKeys;
				_temp_keys = _totalKeys select 0;
				_temp_keys_names = _totalKeys select 1;	
				_hasKey = _vehicleOwnerID in _temp_keys;
				_oldOwner = (_vehicleOwnerID == _uid);
			
				_text = getText (configFile >> "CfgVehicles" >> (typeOf DZE_myVehicle) >> "displayName");
				if (locked DZE_myVehicle) then {
					if (_hasKey || _oldOwner) then {
						_unlock = DZE_myVehicle addAction [format[localize "STR_EPOCH_ACTIONS_UNLOCK",_text], "\z\addons\dayz_code\actions\unlock_veh.sqf",[DZE_myVehicle,(_temp_keys_names select (_temp_keys find _vehicleOwnerID))], 2, false, true];
						s_player_lockUnlockInside set [count s_player_lockUnlockInside,_unlock];
						s_player_lockUnlockInside_ctrl = 1;
					} else {
						if (_hasHotwireKit) then {
							_unlock = DZE_myVehicle addAction [format[localize "STR_EPOCH_ACTIONS_HOTWIRE",_text], "\z\addons\dayz_code\actions\hotwire_veh.sqf",DZE_myVehicle, 2, true, true];
						} else {
							_unlock = DZE_myVehicle addAction [format["<t color='#ff0000'>%1</t>",localize "STR_EPOCH_ACTIONS_VEHLOCKED"], "",DZE_myVehicle, 2, true, true];
						};
						s_player_lockUnlockInside set [count s_player_lockUnlockInside,_unlock];
						s_player_lockUnlockInside_ctrl = 1;
					};
				} else {
					if (_hasKey || _oldOwner) then {
						_lock = DZE_myVehicle addAction [format[localize "STR_EPOCH_ACTIONS_LOCK",_text], "\z\addons\dayz_code\actions\lock_veh.sqf",DZE_myVehicle, 1, false, true];
						s_player_lockUnlockInside set [count s_player_lockUnlockInside,_lock];
						s_player_lockUnlockInside_ctrl = 1;
					};
				};
			};
		} else {
			{DZE_myVehicle removeAction _x} count s_player_lockUnlockInside;s_player_lockUnlockInside = [];
			s_player_lockUnlockInside_ctrl = -1;
		};
		_doors = nearestObjects [DZE_myVehicle, ["CinderWallDoorLocked_DZ","Land_DZE_GarageWoodDoorLocked"], 30];

		if (count _doors > 0 && {driver DZE_myVehicle == player}) then {
			_hasAccess = [player,_doors select 0] call FNC_check_access;
			if (s_player_gdoor_opener_ctrl < 0 && ((_hasAccess select 0) || (_hasAccess select 2) || (_hasAccess select 3) || (_hasAccess select 4))) then {
				_door = DZE_myVehicle addAction ["Garage Door Opener","scripts\garageDoorOpener.sqf",_doors select 0, 1, false, true];
				s_player_gdoor_opener set [count s_player_gdoor_opener,_door];
				s_player_gdoor_opener_ctrl = 1;
			};
		} else {
			{DZE_myVehicle removeAction _x} count s_player_gdoor_opener;s_player_gdoor_opener = [];
			s_player_gdoor_opener_ctrl = -1;
		};
	} else {
		{DZE_myVehicle removeAction _x} count s_player_lockUnlockInside;s_player_lockUnlockInside = [];
		s_player_lockUnlockInside_ctrl = -1;
		{DZE_myVehicle removeAction _x} count s_player_gdoor_opener;s_player_gdoor_opener = [];
		s_player_gdoor_opener_ctrl = -1;
	};
	```