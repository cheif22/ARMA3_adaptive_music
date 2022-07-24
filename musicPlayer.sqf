//Arma 3 Music Script
//Original script Made by Niklas Brettschneider
//Cheif22 - created Multiplayer Function, Fixed and corrected "{}" placements, feature enhancements.
//Der Kroi - The Wizard who has resolved the infamous black error box pre-launch and helped with correcting some of the detection lines.


params ["_dayTracks", "_nightTracks", "_rainTracks", "_fogTracks", "_fallTracks", "_scubaTracks", "_carTracks", "_tankTracks", "_boatTracks", "_subtracks", "_heliTracks", "_planeTracks", "_infantrycombatTracks", "_infantryfogcombatTracks", "_vehiclecombatTracks"];


//Transition values will delay the song changes in seconds

//transition between out of combat tracks.
_safeTransitionDuration = 15;
//transition between in combat tracks
_combatTransitionDuration = 5;

 
 
if (isMultiplayer) then
{
//see if the song is over
durationSinceTrackWasStarted = durationSinceTrackWasStarted + 0.2;

if(durationSinceTrackWasStarted > duration - 2) then
{
    isMusicCurrentlyPlaying = 0;
};
   
 
 
//in the fight
if(battleIntensity > 10 ) then
{
if(durationSinceTrackWasStarted > duration - 10) then
{
    2 fadeMusic 0;
};


    //If there was no fight before or music ended, new games
    if(currentMusicState != "combat" || isMusicCurrentlyPlaying == 0) then
    {
        currentMusicState = "combat";
        if(vehicle player != player) then
        {
            //Fight in the vehicle
            _selecter = configName selectRandom _vehiclecombatTracks;
            playMusic _selecter;
            duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _combatTransitionDuration;
           
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
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _combatTransitionDuration;
			   
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
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _combatTransitionDuration;
              
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
        _eventForShotFiredNear = VehicleIamIn addEventHandler ["FiredNear", {_this execVM "A3_Adapt\shotFiredNear.sqf"}];
        _eventForTakingDamage = VehicleIamIn addEventHandler ["Dammaged", {_this execVM "A3_Adapt\damageTaken.sqf"}];
        _eventForExplosionsNearby = VehicleIamIn addEventHandler ["Explosion", {_this execVM "A3_Adapt\explosionNear.sqf"}];
        _eventForMissileIncoming = VehicleIamIn addEventHandler ["IncomingMissile", {_this execVM "A3_Adapt\missileIncoming.sqf"}];
         
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
if(durationSinceTrackWasStarted > duration - 20) then
{
    2 fadeMusic 0;
};
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
                duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
           
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
                duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
           
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
                _duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
           
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
                duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
           
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
                duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
           
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
                duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
           
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
						duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
					   
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
						duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
						
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
                duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
               
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
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
				
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
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
              
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
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
              
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
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
              
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
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
              
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
            _eventForShotFiredNear = VehicleIamIn addEventHandler ["FiredNear", {_this execVM "A3_Adapt\shotFiredNear.sqf"}];
            _eventForTakingDamage = VehicleIamIn addEventHandler ["Dammaged", {_this execVM "A3_Adapt\damageTaken.sqf"}];
            _eventForExplosionsNearby = VehicleIamIn addEventHandler ["Explosion", {_this execVM "A3_Adapt\explosionNear.sqf"}];
            _eventForMissileIncoming = VehicleIamIn addEventHandler ["IncomingMissile", {_this execVM "A3_Adapt\missileIncoming.sqf"}];
             
 
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

if(durationSinceTrackWasStarted > duration - 2) then
{
    isMusicCurrentlyPlaying = 0;


};
   
 
 
//in the fight
if(battleIntensity > 10 ) then
{
if(durationSinceTrackWasStarted > duration - 10) then
{
    2 fadeMusic 0;
};
    //If there was no fight before or music ended, new games
    if(currentMusicState != "combat" || isMusicCurrentlyPlaying == 0) then
    {
        currentMusicState = "combat";
        if(vehicle player != player) then
        {
            //Fight in the vehicle
            _selecter = configName selectRandom _vehiclecombatTracks;
            playMusic _selecter;
            duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _combatTransitionDuration;
           
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
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _combatTransitionDuration;
			   
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
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _combatTransitionDuration;
              
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
        _eventForShotFiredNear = VehicleIamIn addEventHandler ["FiredNear", {_this execVM "A3_Adapt\shotFiredNear.sqf"}];
        _eventForTakingDamage = VehicleIamIn addEventHandler ["Dammaged", {_this execVM "A3_Adapt\damageTaken.sqf"}];
        _eventForExplosionsNearby = VehicleIamIn addEventHandler ["Explosion", {_this execVM "A3_Adapt\explosionNear.sqf"}];
        _eventForMissileIncoming = VehicleIamIn addEventHandler ["IncomingMissile", {_this execVM "A3_Adapt\missileIncoming.sqf"}];
         
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
 
/*          _this execVM "A3_Adapt\shotFiredNear.sqf",
            _this execVM "A3_Adapt\damageTaken.sqf",
            _this execVM "A3_Adapt\explosionNear.sqf",
            _this execVM "A3_Adapt\missileIncoming.sqf",
*/      }];
       
        wasInCarBefore = 1;
        //Fight in the vehicle

    };

}
else
{//outside of the fight
if(durationSinceTrackWasStarted > duration - 20) then
{
    2 fadeMusic 0;
};
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
                duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
           
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
               			 duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
           
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
                _duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + 15;
           
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
                		duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
           
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
               			duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
           
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
                duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
           
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
						duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
					   
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
							duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
						
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
                duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
               
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
					duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
				
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
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
              
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
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
              
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
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
              
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
				duration =  getNumber (configFile >> "CfgMusic" >> _selecter >> "duration") + _safeTransitionDuration;
              
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
            _eventForShotFiredNear = VehicleIamIn addEventHandler ["FiredNear", {_this execVM "A3_Adapt\shotFiredNear.sqf"}];
            _eventForTakingDamage = VehicleIamIn addEventHandler ["Dammaged", {_this execVM "A3_Adapt\damageTaken.sqf"}];
            _eventForExplosionsNearby = VehicleIamIn addEventHandler ["Explosion", {_this execVM "A3_Adapt\explosionNear.sqf"}];
            _eventForMissileIncoming = VehicleIamIn addEventHandler ["IncomingMissile", {_this execVM "A3_Adapt\missileIncoming.sqf"}];
             
 
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
 
/*          _this execVM "A3_Adapt\shotFiredNear.sqf",
            _this execVM "A3_Adapt\damageTaken.sqf",
            _this execVM "A3_Adapt\explosionNear.sqf",
            _this execVM "A3_Adapt\missileIncoming.sqf",
*/      }];
           
            wasInCarBefore = 1;         
		   
		   
        };

    };
};
};
