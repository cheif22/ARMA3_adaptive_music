//Arma 3 Music Script
//Original script idea made by Niklas Brettschneider
//Cheif22 - Rewritten the script with Switch command optimizations.
//Der Kroi - The Wizard who has resolved the infamous black error box pre-launch and helped with correcting some of the detection lines.


//The Playset lines below are where the music classnames will go. Enter 


//---------------------- As infantry soldier (Non-combat)---------------------------

//Daytime peace tracks
_dayTracks = "'daytime' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//night tracks
_nightTracks = "'nighttime' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//These tracks will play when player encounters medium to heavy rain.
_rainTracks = "'rain' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//These tracks will play when player enters fog area.
_fogTracks = "'fog' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//These tracks will play when Skydiving over 100 meters in the air above any surface. it will auto transition when you enter parachute and land. (Parachutes are using the helicopter music set for now)
_fallTracks = "'skydive' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//These tracks will play when player goes below five meters under water.
_scubaTracks = "'scubadive' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//---------------------- In vehicle (Non-combat) --------------------------

//Tracks that play when player enters a car. APCs are apparently cars in arma
_carTracks = "'car' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//Tank tracks that play in no combat. Artilary tanks apply to this.
_tankTracks = "'tank' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//Tracks that play when player is in a boat / submarine when on the surface of the water.
_boatTracks = "'boat' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//Tracks that play when Submarine reaches below 5 meters below the water line.
_subtracks = "'submarine' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//Tracks that play when you are in a helicopter. Parachutes are apparently helicopters in arma, Working on this.
_heliTracks = "'helicopter' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//Tracks that play when you are in a plane type aircraft.
_planeTracks = "'plane' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//---------------------- Combat Playsets ---------------------------------

//night or day combat
_infantrycombatTracks = "'infantrycombat' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");
 
//infantry fog combat
_infantryfogcombatTracks = "'infantryfogcombat' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");


 
//These tracks are when you are under attack in a vehicle. If you are not under attack, it will then follow back to your vehicle's corosponding playset.
//_vehiclecombatTracks = "'vehiclecombat' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

 
//Everything below the line is the main guts that control the mod. If you want to test some different ideas or make edits, I am not responsible
//for it breaking.
//-------------------------------------------------------------------------------------
[]spawn
{
While (true) do
{

	Switch (true) do
	{
		Switch (true) do
		//Check if player is in combat
		case (battleIntensity > 10):
		//peacetime
		{
		_selecter = 0;
		isMusicCurrentlyPlaying == 0
			Switch (true) do
			//checks if player is in vehicle
			{
				case (vehicle player != player):
				//Player in vehicle
				{
				wasInCarBefore = 1;
				
					switch (true) do
					//Controls vehcile playsets
					{
						case (vehicle player isKindOf "car"):
						{
						
						};
						
						case (vehicle player isKindOf "tank"):
						{
						
						};
						
						case (vehicle player isKindOf "ship"):
						{
						
						};
						
						case (((vehicle player) Iskindof "ship") && (((getPosASL (vehicle player)) select 2) <= -5)):
						{
						
						};
						
						case (vehicle player isKindOf "helicopter"):
						{
						
					
						};
						
						case (vehicle player isKindOf "plane"):
						{
						
					
						};
						
						case (vehicle player isKindOf "StaticWeapon"):
						//Turrets will follow infantry tracks.
						{
							Switch (true) do
							{
							
								case (isDay == 0):
								{
								
								};
								
								case (isDay == 1):
								{
								
								};
							
							
							};
					
						};
						

						
						
						
						
					};				
				};
				case (vehicle player == player):
				//Player not in vehicle
				{
				wasInCarBefore = 0;
					switch (true) do
					//Controls infantry playsets
					{
						case (isDay == 0):
						{
						
						};
						
						case (isDay ==1):
						{
						
						};
						
						case (fog >= 0.3):
						{
						
						};
						
						case (rain >= 0.5):
						{
						
						};
						
						case (getPosATL player select 2 >= 100):
						{
						
					
						};

						case (getPosASL player select 2 <= -5):
						{
						
					
						};
						
				
					};
				
				};
			
			};
		durationSinceTrackWasStarted = 0;
		isMusicCurrentlyPlaying = 1;
		};
		case (battleIntensity < 10):
		//combat
		{
		_selecter = 0;
		isMusicCurrentlyPlaying == 0
		
		};



	};
	
        //Get into the vehicle
        if(vehicle player != player && wasInCarBefore == 0) then
        	{  
            	VehicleIamIn = vehicle player;
            	//change into the vehicle
           
            	if(debugging == 1) then
            		{
               			hint "adding event handler for vehicle";
            		};
            	_eventForShotFiredNear = VehicleIamIn addEventHandler ["FiredNear", {_this execVM "bf_Adapt\shotFiredNear.sqf"}];
            	_eventForTakingDamage = VehicleIamIn addEventHandler ["Dammaged", {_this execVM "bf_Adapt\damageTaken.sqf"}];
           	_eventForExplosionsNearby = VehicleIamIn addEventHandler ["Explosion", {_this execVM "bf_Adapt\explosionNear.sqf"}];
            	_eventForMissileIncoming = VehicleIamIn addEventHandler ["IncomingMissile", {_this execVM "bf_Adapt\missileIncoming.sqf"}];
             
 
        	VehicleIamIn setVariable ["DK_zikIdEh", [_eventForShotFiredNear, _eventForTakingDamage, _eventForExplosionsNearby, _eventForMissileIncoming]];
         
        	_getOut = VehicleIamIn addEventHandler["GetOut",
        		{
            			if(debugging == 1) then
            				{
                			hint "removing event handler for vehicle";
            				};
 
            			params ["_veh"];
 
            			private _DK_zikIdEh = _veh getVariable ["DK_zikIdEh", []];
           			_DK_zikIdEh params ["_eventForShotFiredNear", "_eventForTakingDamage", "_eventForExplosionsNearby", "_eventForMissileIncoming"];
 
            			if (!isNil "_eventForShotFiredNear") then
            				{
                				_veh removeEventHandler ["FiredNear", _eventForShotFiredNear];
            				};
           			if (!isNil "_eventForTakingDamage") then
            				{
                				_veh removeEventHandler ["Dammaged", _eventForTakingDamage];
            				};
            			if (!isNil "_eventForExplosionsNearby") then
            				{
                				_veh removeEventHandler ["Explosion", _eventForExplosionsNearby];
            				};
           			 if (!isNil "_eventForMissileIncoming") then
            				{
                				_veh removeEventHandler ["IncomingMissile", _eventForMissileIncoming];
            				};
 
            			_veh setVariable ["DK_zikIdEh", nil];
 
           
            			wasInCarBefore = 1;         
		   
		   
        		};
		};
Sleep 0.2;
};
};
