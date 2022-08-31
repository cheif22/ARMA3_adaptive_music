//Arma 3 Music Script
//Original script made by Niklas Brettschneider
//Music detection and script fixes made by Cheif22
//Other fixes and additions made by Phenosi

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
_vehiclecombatTracks = "'vehiclecombat' in getArray(_x >> 'parameters')" configClasses (configFile >> "CfgMusic");

 
//Everything below the line is the main guts that control the mod. If you want to test some different ideas or make edits, I am not responsible
//for it breaking.
//-------------------------------------------------------------------------------------

//change out of car. Best to leave this alone.
_CarTransition = ["Empty"];


if (isMultiplayer) then
{
isMusicActive = 1;
duration = 0;

debugging = 0;

durationSinceTrackWasStarted = 0;
wasInCarBefore = 0;
currentMusicState = "save";
isMusicCurrentlyPlaying = 0;

VehicleIamIn = -1;
//Is something going on right now?
currentTrack = "";

//How intense is the fight right now?
battleIntensity = 0;
//Max value, so that nothing gets out of hand here
maxBattleIntensity = 60;

//how much should it sink every second?
battleIntensityLowerer = -0.10;

//Is it day? (other tracks at night)
isDay = 1; 

//volume
Volume = 0.5;

ExecVm "A3_adapt\addEventHandlerForMusic.sqf";





//Every second
while{true} do
{//Main Loop
	if(isMusicActive == 1) then
	{
		//Check if day or night
		if(daytime > 19 || daytime < 6) then
		{
			isDay = 0;
			volume = 0.2;
		}
		else
		{
			isDay = 1;
			volume = 0.5;
		};
		
		//standart lower Battle intensity
		[battleIntensityLowerer] ExecVm "A3_adapt\battleIntensityChange.sqf";
		

		
		null = [_dayTracks, _nightTracks, _rainTracks, _fogTracks, _fallTracks, _scubaTracks, _carTracks, _tankTracks, _boatTracks, _subtracks, _heliTracks, _planeTracks, _infantrycombatTracks, _infantryfogcombatTracks, _vehiclecombatTracks] execVM "A3_adapt\musicPlayer.sqf";
		
	};
	sleep(0.2);
};
}
else
{
isMusicActive = 1;
duration = 0;

debugging = 0;

durationSinceTrackWasStarted = 0;
wasInCarBefore = 0;
currentMusicState = "save";
isMusicCurrentlyPlaying = 0;

VehicleIamIn = -1;
//Is something going on right now?
currentTrack = "";

//How intense is the fight right now?
battleIntensity = 0;
//Max value, so that nothing gets out of hand here
maxBattleIntensity = 60;

//how much should it sink every second?
battleIntensityLowerer = -0.10;

//Is it day? (other tracks at night)
isDay = 1; 

//volume
Volume = 0.5;

ExecVm "A3_adapt\addEventHandlerForMusic.sqf";



//Every second
while{true} do
{//Main Loop
	if(isMusicActive == 1) then
	{
		//Check if day or night
		if(daytime > 19 || daytime < 6) then
		{
			isDay = 0;
			volume = 0.2;
		}
		else
		{
			isDay = 1;
			volume = 0.5;
		};
		
		//standart lower Battle intensity
		[battleIntensityLowerer] ExecVm "A3_adapt\battleIntensityChange.sqf";
		
		
		null = [_dayTracks, _nightTracks, _rainTracks, _fogTracks, _fallTracks, _scubaTracks, _carTracks, _tankTracks, _boatTracks, _subtracks, _heliTracks, _planeTracks, _infantrycombatTracks, _infantryfogcombatTracks, _vehiclecombatTracks] execVM "A3_adapt\musicPlayer.sqf";
		
	};
	sleep(0.2);
};
};
