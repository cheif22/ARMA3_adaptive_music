//Arma 3 Music Script
//Original Script made by Niklas Brettschneider
//Edits and fixes made by Cheif22

//For turning music Sound on and Off!
if (isMultiplayer) then
{

	if(isMusicActive == 1) then
	{
		isMusicActive = 0;
		player removeAction musicAction;
		musicAction = player addAction ["Turn Music On", "A3_Adapt\musicController.sqf"];
		1 fadeMusic 0;
		hint "Music disabled. 1";
	}

	else
	{
		if(isMusicActive == 0) then
		{
			isMusicActive = 1;
			player removeAction musicAction;
			musicAction = player addAction ["Turn Music Off", "A3_Adapt\musicController.sqf"];
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
		musicAction = player addAction ["Turn Music On", "A3_Adapt\musicController.sqf"];
		1 fadeMusic 0;
		hint "Music disabled. 1";
	}

	else
	{
		if(isMusicActive == 0) then
		{
			isMusicActive = 1;
			player removeAction musicAction;
			musicAction = player addAction ["Turn Music Off", "A3_Adapt\musicController.sqf"];
			1 fadeMusic Volume;
			hint "Music Enabled. 2";
		};
	};
};
