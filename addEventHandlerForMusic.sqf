//Arma 3 Music Script
//Made by Niklas Brettschneider

//Events to check the fight add
//Get all the shots within a 69m range.
_eventForShotFiredNear = player addEventHandler ["FiredNear", {_this execVM "A3_Adapt\shotFiredNear.sqf"}];
_eventForTakingDamage = player addEventHandler ["Dammaged", {_this execVM "A3_Adapt\damageTaken.sqf"}];



_eventForExplosionsNearby = player addEventHandler ["Explosion", {_this execVM "A3_Adapt\explosionNear.sqf"}];
_eventForMissileIncoming = player addEventHandler ["IncomingMissile", {_this execVM "A3_Adapt\missileIncoming.sqf"}];

//Commented out because only close shots should be taken.
//_eventForShotFired = player addEventHandler ["Fired", {_this execVM "A3_Adapt\shotFiredNear.sqf"}];

waitUntil {!isNull player};
while {true} do {
  waitUntil {sleep 1.5; alive player};
musicAction = player addAction ["Turn Off Music", "A3_Adapt\musicController.sqf"];
hudAction = player addAction ["Music HUD On", "A3_Adapt\hudController.sqf"];
  waitUntil {sleep 1.5; !alive player};
};
