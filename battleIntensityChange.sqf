//Arma 3 Music Script
//Made by Niklas Brettschneider

//The change in battle intensity is monitored here

_changer = _this select 0; //to know how much the battleIntensity changes
_how = _this select 1;

if(battleIntensity <= maxBattleIntensity) then
{
	//if the changer is positive
	if(_changer >= 0) then
	{
		//see that the value doesn't get too big
		if(battleIntensity + _changer <= maxBattleIntensity) then
		{
			battleIntensity = battleIntensity + _changer;
		};
	
		if(battleIntensity + _changer > maxBattleIntensity) then
		{
			battleIntensity = maxBattleIntensity;
		};
	}
	else //if the changer is negative.
	{
		//see that the value is not too small
		if(battleIntensity + _changer >= 0) then
		{
			battleIntensity = battleIntensity + _changer;
		};
		
		if(battleIntensity + _changer < 0) then
		{
			battleIntensity = 0;
		};
	};
}
else
{
	battleIntensity = maxBattleIntensity;
};