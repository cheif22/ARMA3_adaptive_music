//Arma 3 Music Script
//Made by Niklas Brettschneider

//Events to check the fight add
//Get all the shots within a 69m range.
_eventForShotFiredNear = player addEventHandler ["FiredNear", {_this execVM "bf_Adapt\shotFiredNear.sqf"}];
_eventForTakingDamage = player addEventHandler ["Dammaged", {_this execVM "bf_Adapt\damageTaken.sqf"}];

waitUntil {!isNull player};
while {true} do {
  waitUntil {sleep 1.5; alive player};
musicAction = player addAction ["Disable music", "bf_Adapt\musicController.sqf"];
  waitUntil {sleep 1.5; !alive player};
};

_eventForExplosionsNearby = player addEventHandler ["Explosion", {_this execVM "bf_Adapt\explosionNear.sqf"}];
_eventForMissileIncoming = player addEventHandler ["IncomingMissile", {_this execVM "bf_Adapt\missileIncoming.sqf"}];

//Commented out because only close shots should be taken.
//_eventForShotFired = player addEventHandler ["Fired", {_this execVM "bf_Adapt\shotFiredNear.sqf"}];



//todo: consider something like long vehicle rides, maybe also show a menu for the players ...