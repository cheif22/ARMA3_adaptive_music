//Arma 3 Music Script
//Made by Niklas Brettschneider

//For turning music Sound on and Off!
if (isMultiplayer) then
{

	if(isMusicActive == 1) then
	{
		isMusicActive = 0;
		player removeAction musicAction;
		musicAction = player addAction ["music on", "bf_Adapt\musicController.sqf"];
		1 fadeMusic 0;
		hint "Music disabled. 1";
	}

	else
	{
		if(isMusicActive == 0) then
		{
			isMusicActive = 1;
			player removeAction musicAction;
			musicAction = player addAction ["music off", "bf_Adapt\musicController.sqf"];
			1 fadeMusic Volume;
			hint "Music Enabled. 2";
		};
	};
}
else
{
	if(isMusicActive == 1) then
	{
		isMusicActive = 0;
		player removeAction musicAction;
		musicAction = player addAction ["music on", "bf_Adapt\musicController.sqf"];
		1 fadeMusic 0;
		hint "Music disabled. 1";
	}

	else
	{
		if(isMusicActive == 0) then
		{
			isMusicActive = 1;
			player removeAction musicAction;
			musicAction = player addAction ["music off", "bf_Adapt\musicController.sqf"];
			1 fadeMusic Volume;
			hint "Music Enabled. 2";
		};
	};
};