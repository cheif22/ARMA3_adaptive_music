//Arma 3 Music Script
//Original script made by Niklas Brettschneider
//Fixes and edits made by Cheif22

//Here the shots near the player are monitored and processed.

_unit = _this select 0; // Object - Object the event handler is assigned to
_firer = _this select 1; // Object - Object which fires a weapon near the unit
_distance = _this select 2; // Number - Distance in meters between the unit and firer (max. distance ~69m)
_weapon = _this select 3; // String - Fired weapon
_muzzle = _this select 4; // String - Muzzle that was used
_mode = _this select 5; // String - Current mode of the fired weapon
_ammo = _this select 6; // String - Ammo use

//hint format ["Shot fired with from %1\nwith Weapon %2\n from distance %3", _firer, _weapon, _distance];

[1, "Shot"] execVM "A3_Adapt\battleIntensityChange.sqf";
