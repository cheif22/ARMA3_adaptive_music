//Arma 3 Music Script
//Made by Niklas Brettschneider

_vehicle = _this select 0; // Object - Object the event handler is assigned to
_damage = _this select 1; // Number - Damage inflicted to the object 

//hint format ["Shot fired with from %1\nwith Weapon %2\n from distance %3", _firer, _weapon, _distance];

[5, "nearExplosion"] execVM "musicHandler\battleIntensityChange.sqf";