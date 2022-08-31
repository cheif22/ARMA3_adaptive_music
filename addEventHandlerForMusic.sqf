//Arma 3 Music Script
//Original Script made by Niklas Brettschneider
//Edits and fixes made by Cheif22
//Other edits made by Phenosi

//Events to check the fight add
//Get all the shots within a 69m range.
_eventForShotFiredNear = player addEventHandler ["FiredNear", {_this execVM "A3_Adapt\shotFiredNear.sqf"}];
_eventForTakingDamage = player addEventHandler ["Dammaged", {_this execVM "A3_Adapt\damageTaken.sqf"}];



_eventForExplosionsNearby = player addEventHandler ["Explosion", {_this execVM "A3_Adapt\explosionNear.sqf"}];
_eventForMissileIncoming = player addEventHandler ["IncomingMissile", {_this execVM "A3_Adapt\missileIncoming.sqf"}];

