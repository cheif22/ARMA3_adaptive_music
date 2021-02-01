//preprocessFileLineNumbers
_stressCheck = compileFinal preprocessFileLineNumbers "stress.sqf";
_shotdetection = compileFinal preprocessFileLineNumbers "shotdetection.sqf";

//Stress modes
//stress represents min and will be main changer
private _stress = 0;

private _maxstress = 60;

private _lowerstress = -0.10;



//Is it day? (other tracks at night)
isDay = 1;

_stress = ["_stress", "changer"] Call _shotdetection;

//Every second
while {true} do
{//Main Loop
if (true) then    
	{
      //debug - show stress  
        hint ("Stress = " + (str _stress));

        //lower stress and pass values
        _stress = ["_lowerstress", "_stress", "_maxstress"] call _stressCheck;
    };
 
    sleep 0.2;
};

