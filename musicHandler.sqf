//Arma 3 Music Script
//Made by Niklas Brettschneider

//Debugging flag set to 1 will turn on HUD / Song change information. Set the flag to 0 to have it disabled.
debugging = 1;

if (isMultiplayer) then
{
isMusicActive = 1;
duration = 0;

durationSinceTrackWasStarted = 0;
wasInCarBefore = 0;
currentMusicState = "save";
isMusicCurrentlyPlaying = 0;

VehicleIamIn = -1;
//Is something going on right now?
currentTrack = "";

//How intense is the fight right now?
battleIntensity = 0;
//Max Wert, damit hier nichts aus dem Ruder läuft
maxBattleIntensity = 60;

//how much should it sink every second?
battleIntensityLowerer = -0.10;

//Is it day? (other tracks at night)
isDay = 1; 

//volume
Volume = 0.5;

ExecVm "bf_Adapt\addEventHandlerForMusic.sqf";

if(debugging == 1) then
{
	cutRsc ["DebugWindow","PLAIN"];
};



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
		[battleIntensityLowerer] ExecVm "bf_Adapt\battleIntensityChange.sqf";
		
		//Debug Display Battle Intensity
		if(debugging == 1) then
		{
			((uiNamespace getVariable "TAG_DebugWindow") displayCtrl -1) ctrlSetText format["BI: %1 Track: %2", battleIntensity, currentTrack];
		};
		
		execVM "bf_Adapt\musicPlayer.sqf";
		
	};
	sleep(0.2);
};
}
else
{
isMusicActive = 1;
duration = 0;

durationSinceTrackWasStarted = 0;
wasInCarBefore = 0;
currentMusicState = "save";
isMusicCurrentlyPlaying = 0;

VehicleIamIn = -1;
//Is something going on right now?
currentTrack = "";

//How intense is the fight right now?
battleIntensity = 0;
//Max Wert, damit hier nichts aus dem Ruder läuft
maxBattleIntensity = 60;

//how much should it sink every second?
battleIntensityLowerer = -0.10;

//Is it day? (other tracks at night)
isDay = 1; 

//volume
Volume = 0.5;

ExecVm "bf_Adapt\addEventHandlerForMusic.sqf";

if(debugging == 1) then
{
	cutRsc ["DebugWindow","PLAIN"];
};

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
		[battleIntensityLowerer] ExecVm "bf_Adapt\battleIntensityChange.sqf";
		
		//Debug Display Battle Intensity
		if(debugging == 1) then
		{
			((uiNamespace getVariable "TAG_DebugWindow") displayCtrl -1) ctrlSetText format["BI: %1 Track: %2", battleIntensity, currentTrack];
		};
		
		execVM "bf_Adapt\musicPlayer.sqf";
		
	};
	sleep(0.2);
};
};
