# [EPOCH 1.0.7] Garage Door Opener
Garage Door Opener for Epoch 1.0.7 by salival updated by Airwaves Man (https://github.com/oiad)

* Discussion URL: https://epochmod.com/forum/topic/44544-release-garage-door-opener/

* Tested as working on a blank Epoch 1.0.7 server
* Original idea from Sandbird, requested rewrite by TheDuke

# REPORTING ERRORS/PROBLEMS

1. Please, if you report issues can you please attach (on pastebin or similar) your CLIENT rpt log file as this helps find out the errors very quickly. To find this logfile:

	```sqf
	C:\users\<YOUR WINDOWS USERNAME>\AppData\Local\Arma 2 OA\ArmA2OA.RPT
	```

# Install:

* This install basically assumes you have a custom variables.sqf, compiles.sqf and fn_selfActions.sqf.

**[>> Download <<](https://github.com/oiad/garageDoorOpener/archive/master.zip)**

# Mission folder install:

1. 	Open your fn_selfactions.sqf and search for:

	```sqf
	if (_inVehicle) then {
		DZE_myVehicle = _vehicle;
		if ((_vehicleOwnerID != "0") && _canDo) then {
			if (s_player_lockUnlockInside_ctrl < 0) then {
				local _totalKeys = call epoch_tempKeys;
				local _temp_keys = _totalKeys select 0;
				local _temp_keys_names = _totalKeys select 1;
				local _hasKey = _vehicleOwnerID in _temp_keys;
				local _oldOwner = (_vehicleOwnerID == _uid);
				local _unlock = [];

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

	Replace the code from above with the following code:

	```sqf	
	if (_inVehicle) then {
		DZE_myVehicle = _vehicle;
		if ((_vehicleOwnerID != "0") && _canDo) then {
			if (s_player_lockUnlockInside_ctrl < 0) then {
				local _totalKeys = call epoch_tempKeys;
				local _temp_keys = _totalKeys select 0;
				local _temp_keys_names = _totalKeys select 1;
				local _hasKey = _vehicleOwnerID in _temp_keys;
				local _oldOwner = (_vehicleOwnerID == _uid);
				local _unlock = [];

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

		local _doors = nearestObjects [DZE_myVehicle, ["CinderWallDoorLocked_DZ","Land_DZE_GarageWoodDoorLocked","Land_DZE_LargeWoodDoorLocked","WoodenGate_1_DZ","WoodenGate_2_DZ","WoodenGate_3_DZ","WoodenGate_4_DZ","Land_DZE_WoodGateLocked","CinderGateLocked_DZ","Land_DZE_WoodOpenTopGarageLocked","CinderGarageOpenTopLocked_DZ"], 30];

		if (count _doors > 0 && {driver DZE_myVehicle == player}) then {
			local _hasAccess = [player,_doors select 0] call FNC_check_access;
			if (s_player_gdoor_opener_ctrl < 0 && ((_hasAccess select 0) || (_hasAccess select 2) || (_hasAccess select 3) || (_hasAccess select 4))) then {
				local _door = DZE_myVehicle addAction [format["<t color='#0059FF'>%1</t>",localize "STR_CL_GDO_GARAGE"],"scripts\garageDoorOpener.sqf",_doors select 0, 1, false, true];
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
	
2. Open your variables.sqf and search for:

	```sqf
	s_bank_dialog3 = -1;
	s_player_checkWallet = -1;	
	```
	And add this below:
	
	```sqf
	s_player_gdoor_opener = [];
	s_player_gdoor_opener_ctrl = -1;
	```	

3. Copy the supplied <code>scripts</code> folder and all sub folders/files to your mission directory.



**** *For Epoch 1.0.6.2 only* ****
**[>> Download <<](https://github.com/oiad/garageDoorOpener/archive/refs/tags/Epoch_1.0.6.2.zip)**

Visit this link: https://github.com/oiad/garageDoorOpener/tree/Epoch_1.0.6.2	