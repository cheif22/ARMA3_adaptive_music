//Arma 3 Music Script
//Original script Made by Niklas Brettschneider
//Cheif22 - created Multiplayer Function, Fixed and corrected "{}" placements, feature enhancements.
//Der Kroi - The Wizard who has resolved the infamous black error box pre-launch and helped with correcting some of the detection lines.


//The Playset lines below are where the music classnames will go. Enter 


//---------------------- As infantry soldier (Non-combat)---------------------------

//Daytime peace tracks
//_dayTracks = "'daytime' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//night tracks
//_nightTracks = "'nighttime' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//These tracks will play when player encounters medium to heavy rain.
//_rainTracks = "'rain' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//These tracks will play when player enters fog area.
//_fogTracks = "'fog' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//These tracks will play when Skydiving over 100 meters in the air above any surface. it will auto transition when you enter parachute and land. (Parachutes are using the helicopter music set for now)
//_fallTracks = "'skydive' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//These tracks will play when player goes below five meters under water.
//_scubaTracks = "'scubadive' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//---------------------- In vehicle (Non-combat) --------------------------

//Tracks that play when player enters a car. APCs are apparently cars in arma
//_carTracks = "'car' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//Tank tracks that play in no combat. Artilary tanks apply to this.
//_tankTracks = "'tank' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//Tracks that play when player is in a boat / submarine when on the surface of the water.
//_boatTracks = "'boat' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//Tracks that play when Submarine reaches below 5 meters below the water line.
//_subtracks = "'submarine' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//Tracks that play when you are in a helicopter. Parachutes are apparently helicopters in arma, Working on this.
//_heliTracks = "'helicopter' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//Tracks that play when you are in a plane type aircraft.
//_planeTracks = "'plane' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

//---------------------- Combat Playsets ---------------------------------

//night or day combat
//_infantrycombatTracks = "'infantrycombat' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");
 
//infantry fog combat
//_infantryfogcombatTracks = "'infantryfogcombat' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");


 
//These tracks are when you are under attack in a vehicle. If you are not under attack, it will then follow back to your vehicle's corosponding playset.
//_vehiclecombatTracks = "'vehiclecombat' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

 
//Everything below the line is the main guts that control the mod. If you want to test some different ideas or make edits, I am not responsible
//for it breaking.
//-------------------------------------------------------------------------------------

//change out of car. Best to leave this alone.
_CarTransition = ["Empty"];
_TransitionDuration = [0];
 

 
 
if (isMultiplayer) then
{
//see if the song is over
durationSinceTrackWasStarted = durationSinceTrackWasStarted + 0.2;
if(durationSinceTrackWasStarted > duration - 5) then
{
    2 fadeMusic 0;
};
if(durationSinceTrackWasStarted > duration - 2) then
{
    isMusicCurrentlyPlaying = 0;
};
   
 
 
//in the fight
if(battleIntensity > 10 ) then
{
    //If there was no fight before or music ended, new games
    if(currentMusicState != "combat" || isMusicCurrentlyPlaying == 0) then
    {
        currentMusicState = "combat";
        if(vehicle player != player) then
        {
            //Fight in the vehicle
            _selecter = configName selectRandom _vehiclecombatTracks;
            playMusic _selecter;
            duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
           
            if(debugging == 1) then
            {
                hint format ["Changed music to InVehicleFightMusic Trackname: %1", (_selecter)];
            };
        }
        else
        {
			if(isDay == 0 or isDay == 1)then
			{
				//Fight on foot
				wasInCarBefore = 0;
				_selecter = configName selectRandom _infantrycombatTracks;
				playMusic _selecter;
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
			   
				if(debugging == 1) then
				{
					hint format ["Changed music to NormalFightMusic Trackname: %1", (_selecter)];
				};
			};
			
			if(fog >= 0.3) then
			{
				//playing fog fight music
				wasInCarBefore = 0;
				_selecter = configName selectRandom _infantryfogcombatTracks;
				playMusic _selecter;
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
              
				if(debugging == 1) then
				{
					hint format ["Changed music to Fog combat Music Trackname: %1", (_selecter)];
				};

			};	
        };
        2 fadeMusic Volume;
        isMusicCurrentlyPlaying = 1;
        durationSinceTrackWasStarted = 0;
    };
    if(vehicle player != player && wasInCarBefore == 0) then
    {  
        VehicleIamIn = vehicle player;
        //Fight in the vehicle
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
 
/*          _this execVM "bf_Adapt\shotFiredNear.sqf",
            _this execVM "bf_Adapt\damageTaken.sqf",
            _this execVM "bf_Adapt\explosionNear.sqf",
            _this execVM "bf_Adapt\missileIncoming.sqf",
*/      }];
       
        wasInCarBefore = 1;
        //Fight in the vehicle

    };

}
else
{//outside of the fight
    _selecter = 0;
    if(battleIntensity <= 10) then
    {
			if(currentMusicState != "nonCombat" || isMusicCurrentlyPlaying == 0) then
			{
			currentMusicState = "nonCombat";
            


			if(vehicle player != player) then
            {
				wasInCarBefore = 1;
               

			if ( vehicle player isKindOf "car") then
				{
			   //in car based vehicles
                _selecter = configName selectRandom _carTracks ;
                playMusic _selecter;
                duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
           
               if(debugging == 1) then
                {
					hint format ["Changed music to InCarSafeMusic Trackname: %1", (_selecter)];
				};
				};
    
			if ( vehicle player isKindOf "tank") then
				{
			   //in tank based vehicles
                _selecter = configName selectRandom _tankTracks;
				playMusic _selecter;
                duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
           
               if(debugging == 1) then
                {
					hint format ["Changed music to InTankSafeMusic Trackname: %1", (_selecter)];
				};
				};
    
				
			if ( vehicle player isKindOf "ship") then
				{
			   //in boat based vehicles
				_selecter = configName selectRandom _boatTracks;
				playMusic _selecter;
                _duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
           
               if(debugging == 1) then
                {
                   hint format ["Changed music to InboatSafeMusic Trackname: %1", (_selecter)];
                };
				};
				 

				 if ( ((vehicle player) Iskindof "ship") && (((getPosASL (vehicle player)) select 2) <= -5) ) then
				{
			   //in submarine based vehicles
				_selecter = configName selectRandom _subtracks;
				playMusic _selecter;
                duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
           
               if(debugging == 1) then
                {
                   hint format ["Changed music to InsubmarineSafeMusic Trackname: %1", (_selecter)];
                };
				};
				
			if ( vehicle player isKindOf "helicopter") then
				{
			   //in helicopter vehicles
				_selecter = configName selectRandom _heliTracks;
				playMusic _selecter;
                duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
           
               if(debugging == 1) then
                {
                   hint format ["Changed music to InhelicopterSafeMusic Trackname: %1", (_selecter)];
                };
				};
				
			if ( vehicle player isKindOf "plane") then
				{
			   //in plane vehicles
				_selecter = configName selectRandom _tensionTracks;
				playMusic _selecter;
                duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
           
               if(debugging == 1) then
                {
                   hint format ["Changed music to InplaneSafeMusic Trackname: %1", (_selecter)];
                };
				};

			if ( vehicle player isKindOf "StaticWeapon") then
				{
					if(isDay == 0)then
					{
						//playing stealth music at night
						
						_selecter = configName selectRandom _nightTracks;
						playMusic _selecter;
						duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
					   
						if(debugging == 1) then
						{
							hint format ["Changed music to night Trackname: %1", (_selecter)];						
						};
					   
					};
					if(isDay == 1) then
					{
							//Normal music
							
							_selecter = configName selectRandom _dayTracks;
							playMusic _selecter;
							duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
						
							if(debugging == 1) then
							{
								hint format ["Changed music to day Trackname: %1", (_selecter)];							
							};
					};
				};
				
				
			}
			else
			{


            if(isDay == 0)then
            {
                //playing stealth music at night
				wasInCarBefore = 0;
				_selecter = configName selectRandom _nightTracks;
				playMusic _selecter;
                duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
               
                if(debugging == 1) then
                {
                    hint format ["Changed music to night Trackname: %1", (_selecter)];                
				};
               
            };
            if(isDay == 1) then
            {
					//Normal music
					wasInCarBefore = 0;
					_selecter = configName selectRandom _dayTracks;
					playMusic  _selecter;
					duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
				
					if(debugging == 1) then
					{
						hint format ["Changed music to day Trackname: %1", (_selecter)];					
					};
			};
			
			if(fog >= 0.3) then
			{
				//playing fog music
				wasInCarBefore = 0;
				_selecter = configName selectRandom _fogTracks;
				playMusic _selecter;
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
              
				if(debugging == 1) then
				{
					hint format ["Changed music to Fog Music Trackname: %1", (_selecter)];				
				};

			};
			
			if(rain >= 0.5) then
			{
				//playing rain music
				wasInCarBefore = 0;
				_selecter = configName selectRandom _tensionTracks;
				playMusic _selecter;
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
              
				if(debugging == 1) then
				{
					hint format ["Changed music to Rain Music Trackname: %1", (_selecter)];				
				};

			};
			
			if ( getPosATL player select 2 >= 100) then
			{
				//playing Skydiving songs
				wasInCarBefore = 0;
				_selecter = configName selectRandom _fallTracks;
				playMusic _selecter;
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
              
				if(debugging == 1) then
				{
					hint format ["Changed music to Skydiving Music Trackname: %1", (_selecter)];				
				};

			};
		
			//if (getPosASL player select 2 <= -5 or (getPosASL player select 2 <= -5 && getPosATL player select 2 >= 100)) then
			if ( getPosASL player select 2 <= -5) then
			{
				//playing scubadiving songs
				wasInCarBefore = 0;
				_selecter = configName selectRandom _scubaTracks;
				playMusic _selecter;
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
              
				if(debugging == 1) then
				{
					hint format ["Changed music to Scubadiving Music Trackname: %1", (_selecter)];				
				};

			};
		
		
		};
			2 fadeMusic volume;
			isMusicCurrentlyPlaying = 1;
			durationSinceTrackWasStarted = 0;
        };          
	
	   
	   
	   
        //Get into the vehicle without a fight
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
 
/*          _this execVM "bf_Adapt\shotFiredNear.sqf",
            _this execVM "bf_Adapt\damageTaken.sqf",
            _this execVM "bf_Adapt\explosionNear.sqf",
            _this execVM "bf_Adapt\missileIncoming.sqf",
*/      }];
           
            wasInCarBefore = 1;         
		   
		   
        };

    };
};
}
else
{
//see if the song is over
durationSinceTrackWasStarted = durationSinceTrackWasStarted + 0.2;
if(durationSinceTrackWasStarted > duration - 5) then
{
    2 fadeMusic 0;
};
if(durationSinceTrackWasStarted > duration - 2) then
{
    isMusicCurrentlyPlaying = 0;
};
   
 
 
//in the fight
if(battleIntensity > 10 ) then
{
    //If there was no fight before or music ended, new games
    if(currentMusicState != "combat" || isMusicCurrentlyPlaying == 0) then
    {
        currentMusicState = "combat";
        if(vehicle player != player) then
        {
            //Fight in the vehicle
            _selecter = configName selectRandom _vehiclecombatTracks;
            playMusic _selecter;
            duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
           
            if(debugging == 1) then
            {
                hint format ["Changed music to InVehicleFightMusic Trackname: %1", (_selecter)];
            };
        }
        else
        {
			if(isDay == 0 or isDay == 1)then
			{
				//Fight on foot
				wasInCarBefore = 0;
				_selecter = configName selectRandom _infantrycombatTracks;
				playMusic _selecter;
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
			   
				if(debugging == 1) then
				{
					hint format ["Changed music to NormalFightMusic Trackname: %1", (_selecter)];
				};
			};
			
			if(fog >= 0.3) then
			{
				//playing fog fight music
				wasInCarBefore = 0;
				_selecter = configName selectRandom _infantryfogcombatTracks;
				playMusic _selecter;
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
              
				if(debugging == 1) then
				{
					hint format ["Changed music to Fog combat Music Trackname: %1", (_selecter)];
				};

			};	
        };
        2 fadeMusic Volume;
        isMusicCurrentlyPlaying = 1;
        durationSinceTrackWasStarted = 0;
    };
    if(vehicle player != player && wasInCarBefore == 0) then
    {  
        VehicleIamIn = vehicle player;
        //Fight in the vehicle
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
 
/*          _this execVM "bf_Adapt\shotFiredNear.sqf",
            _this execVM "bf_Adapt\damageTaken.sqf",
            _this execVM "bf_Adapt\explosionNear.sqf",
            _this execVM "bf_Adapt\missileIncoming.sqf",
*/      }];
       
        wasInCarBefore = 1;
        //Fight in the vehicle

    };

}
else
{//outside of the fight
    _selecter = 0;
    if(battleIntensity <= 10) then
    {
			if(currentMusicState != "nonCombat" || isMusicCurrentlyPlaying == 0) then
			{
			currentMusicState = "nonCombat";
            


			if(vehicle player != player) then
            {
				wasInCarBefore = 1;
               

			if ( vehicle player isKindOf "car") then
				{
			   //in car based vehicles
                _selecter = configName selectRandom _carTracks ;
                playMusic _selecter;
                duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
           
               if(debugging == 1) then
                {
					hint format ["Changed music to InCarSafeMusic Trackname: %1", (_selecter)];
				};
				};
    
			if ( vehicle player isKindOf "tank") then
				{
			   	//in tank based vehicles
                		_selecter = configName selectRandom _tankTracks;
				playMusic _selecter;
               			 duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
           
               if(debugging == 1) then
                {
					hint format ["Changed music to InTankSafeMusic Trackname: %1", (_selecter)];
				};
				};
    
				
			if ( vehicle player isKindOf "ship") then
				{
			   //in boat based vehicles
				_selecter = configName selectRandom _boatTracks;
				playMusic _selecter;
                _duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
           
               if(debugging == 1) then
                {
                   hint format ["Changed music to InboatSafeMusic Trackname: %1", (_selecter)];
                };
				};
				 

				 if ( ((vehicle player) Iskindof "ship") && (((getPosASL (vehicle player)) select 2) <= -5) ) then
				{
			   //in submarine based vehicles
				_selecter = configName selectRandom _subtracks;
				playMusic _selecter;
                		duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
           
               if(debugging == 1) then
                {
                   hint format ["Changed music to InsubmarineSafeMusic Trackname: %1", (_selecter)];
                };
				};
				
			if ( vehicle player isKindOf "helicopter") then
				{
			   //in helicopter vehicles
				_selecter = configName selectRandom _heliTracks;
				playMusic _selecter;
               			duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
           
               if(debugging == 1) then
                {
                   hint format ["Changed music to InhelicopterSafeMusic Trackname: %1", (_selecter)];
                };
				};
				
			if ( vehicle player isKindOf "plane") then
				{
			   //in plane vehicles
				_selecter = configName selectRandom _tensionTracks;
				playMusic _selecter;
                duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
           
               if(debugging == 1) then
                {
                   hint format ["Changed music to InplaneSafeMusic Trackname: %1", (_selecter)];
                };
				};

			if ( vehicle player isKindOf "StaticWeapon") then
				{
					if(isDay == 0)then
					{
						//playing stealth music at night
						
						_selecter = configName selectRandom _nightTracks;
						playMusic _selecter;
						duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
					   
						if(debugging == 1) then
						{
							hint format ["Changed music to night Trackname: %1", (_selecter)];						
						};
					   
					};
					if(isDay == 1) then
					{
							//Normal music
							
							_selecter = configName selectRandom _dayTracks;
							playMusic _selecter;
							duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
						
							if(debugging == 1) then
							{
								hint format ["Changed music to day Trackname: %1", (_selecter)];							
							};
					};
				};
				
				
			}
			else
			{


            if(isDay == 0)then
            {
                //playing stealth music at night
				wasInCarBefore = 0;
				_selecter = configName selectRandom _nightTracks;
				playMusic _selecter;
                duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
               
                if(debugging == 1) then
                {
                    hint format ["Changed music to night Trackname: %1", (_selecter)];                
				};
               
            };
            if(isDay == 1) then
            {
					//Normal music
					wasInCarBefore = 0;
					_selecter = configName selectRandom _dayTracks;
					playMusic  _selecter;
					duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
				
					if(debugging == 1) then
					{
						hint format ["Changed music to day Trackname: %1", (_selecter)];					
					};
			};
			
			if(fog >= 0.3) then
			{
				//playing fog music
				wasInCarBefore = 0;
				_selecter = configName selectRandom _fogTracks;
				playMusic _selecter;
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
              
				if(debugging == 1) then
				{
					hint format ["Changed music to Fog Music Trackname: %1", (_selecter)];				
				};

			};
			
			if(rain >= 0.5) then
			{
				//playing rain music
				wasInCarBefore = 0;
				_selecter = configName selectRandom _tensionTracks;
				playMusic _selecter;
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
              
				if(debugging == 1) then
				{
					hint format ["Changed music to Rain Music Trackname: %1", (_selecter)];				
				};

			};
			
			if ( getPosATL player select 2 >= 100) then
			{
				//playing Skydiving songs
				wasInCarBefore = 0;
				_selecter = configName selectRandom _fallTracks;
				playMusic _selecter;
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
              
				if(debugging == 1) then
				{
					hint format ["Changed music to Skydiving Music Trackname: %1", (_selecter)];				
				};

			};
		
			if ( getPosASL player select 2 <= -5) then
			{
				//playing scubadiving songs
				wasInCarBefore = 0;
				_selecter = configName selectRandom _scubaTracks;
				playMusic _selecter;
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration");
              
				if(debugging == 1) then
				{
					hint format ["Changed music to Scubadiving Music Trackname: %1", (_selecter)];				
				};

			};
		
		
		};
			2 fadeMusic volume;
			isMusicCurrentlyPlaying = 1;
			durationSinceTrackWasStarted = 0;
        };          
	
	   
	   
	   
        //Get into the vehicle without a fight
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
 
/*          _this execVM "bf_Adapt\shotFiredNear.sqf",
            _this execVM "bf_Adapt\damageTaken.sqf",
            _this execVM "bf_Adapt\explosionNear.sqf",
            _this execVM "bf_Adapt\missileIncoming.sqf",
*/      }];
           
            wasInCarBefore = 1;         
		   
		   
        };

    };
};
};