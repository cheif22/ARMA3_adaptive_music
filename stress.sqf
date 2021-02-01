//The change in battle intensity is monitored here

//_changer = _this select 0; //to know how much the _stress changes
//_how = _this select 1;

params ["_changer", "_stress", "_maxstress"];

if(_stress <= _maxstress) then
{
	//if the changer is positive
	if(_changer >= 0) then
	{
		//see that the value doesn't get too big
		if(_stress + _changer <= _maxstress) then
		{
			_stress = _stress + _changer;
		};
	
		if(_stress + _changer > _maxstress) then
		{
			_stress = _maxstress;
		};
	}
	else //if the changer is negative.
	{
		//see that the value is not too small
		if(_stress + _changer >= 0) then
		{
			_stress = _stress + _changer;
		};
		
		if(_stress + _changer < 0) then
		{
			_stress = 0;
		};
	};
}
else
{
	_stress = _maxstress;
};

_stress