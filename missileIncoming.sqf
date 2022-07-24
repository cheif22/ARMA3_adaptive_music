//Arma 3 Music Script
//Orignial Script made by Niklas Brettschneider
//Edits and fixes made by Cheif22

_unit = _this select 0; // Object - Object the event handler is assigned to
_ammo = _this select 1; //: String - Ammo type that was fired on the unit
_whoFired = _this select 2; //: Object - Object that fired the weapon 

[30, "missileIncoming"] execVM "A3_Adapt\battleIntensityChange.sqf";
