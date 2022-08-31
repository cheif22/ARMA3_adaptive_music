class CfgPatches
{

	class A3_Adapt
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {"Extended_EventHandlers"};

	};
};
class CfgMusic
{
	//class Track_Name
	//{
	////name = "Track Name (Best left in Comment mode)";
	//sound[] = {"bf_Adapt\music\track_name.ogg",1.0,1.0};
	
	//duration=length of audio in seconds;
	//parameters[]    = {"parameter"}; 
	//};
	//
	//here are the list of parameters that can be used to create arrays
	
	//-- for infantry --
	//during daylight "daytime"
	//during night "nighttime"
	//during rain "rain"
	//during fog "fog"
	//during skydiving "skydive"
	//during scuba diving "scubadive"
	

	//-- for vehicles --
	//for cars "car"
	//for tanks "tank"
	//for boats "boat"
	//for submarines "submarine"
	//for helicopters "helicopter"
	//for planes "plane"
	//Turrets have been placed under day and night tracks.

	//-- for combat --
	//for infantry combat "infantrycombat"
	//for fog infantry combat "infantryfogcombat"
	//for get away or vehicle combat "vehiclecombat


	class Track_Name1
	{
	//name = "Track Name (Best left in Comment mode)";
	sound[] = {"bf_Adapt\music\track_name1.ogg",1.0,1.0};
	
	duration=length of audio in seconds;
	parameters[]    = {"daytime"}; 
	};

	class Track_Name2
	{
	//name = "Track Name (Best left in Comment mode)";
	sound[] = {"bf_Adapt\music\track_name2.ogg",1.0,1.0};
	
	duration=length of audio in seconds;
	parameters[]    = {"daytime", "car", "tank"}; 
	};

	class Track_Name3
	{
	//name = "Track Name (Best left in Comment mode)";
	sound[] = {"bf_Adapt\music\track_name3.ogg",1.0,1.0};
	
	duration=length of audio in seconds;
	parameters[]    = {"nighttime", "fog", "rain"}; 
	};

	class Track_Name4
	{
	//name = "Track Name (Best left in Comment mode)";
	sound[] = {"bf_Adapt\music\track_name4.ogg",1.0,1.0};
	
	duration=length of audio in seconds;
	parameters[]    = {"infantrycombat", "infantryfogcombat", "vehiclecombat"}; 
	};

	class Track_Name5
	{
	//name = "Track Name (Best left in Comment mode)";
	sound[] = {"bf_Adapt\music\track_name5.ogg",1.0,1.0};
	
	duration=length of audio in seconds;
	parameters[]    = {"scubadive", "submarine", "boat"}; 
	};

	class Track_Name6
	{
	//name = "Track Name (Best left in Comment mode)";
	sound[] = {"bf_Adapt\music\track_name6.ogg",1.0,1.0};
	
	duration=length of audio in seconds;
	parameters[]    = {"scubadive", "submarine", "boat"}; 
	};

	class Track_Name7
	{
	//name = "Track Name (Best left in Comment mode)";
	sound[] = {"bf_Adapt\music\track_name7.ogg",1.0,1.0};
	
	duration=length of audio in seconds;
	parameters[]    = {"helicopter", "plane", "skydive"}; 
	};

	class Track_Name8
	{
	//name = "Track Name (Best left in Comment mode)";
	sound[] = {"bf_Adapt\music\track_name8.ogg",1.0,1.0};
	
	duration=length of audio in seconds;
	parameters[]    = {"car", "tank", "plane"}; 
	};

	class Track_Name9
	{
	//name = "Track Name (Best left in Comment mode)";
	sound[] = {"bf_Adapt\music\track_name9.ogg",1.0,1.0};
	
	duration=length of audio in seconds;
	parameters[]    = {"scubadive", "rain", "fog"}; 
	};




};

class Extended_PostInit_EventHandlers
{
	A3_Adapt_Post_Init = "bf_Adapt_Post_Init_Var = [] execVM ""A3_Adapt\init.sqf""";
};

class Extended_PreInit_EventHandlers
{
	clientInit="call compilescript [""A3_adapt\CBAsetting.sqf""]";
};
