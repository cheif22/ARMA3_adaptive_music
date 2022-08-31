//Arma 3 Music Script
//CBA menu code added by Phenosi

["A3_adapt_setting", "CHECKBOX", "Enable Adaptive Music", ["Adaptive Music Mod Template", "Adaptive Music"], true, 0, {}, true] call CBA_fnc_addSetting;

["A3_adapt_debug", "CHECKBOX", "Enable debug mode", ["Adaptive Music Mod Template", "Adaptive Music"], false, 0, {}, true] call CBA_fnc_addSetting; 

["A3_adapt_SafeDuration", "SLIDER", "Safe track transition duration", ["Adaptive Music Mod Template", "Adaptive Music"], [1, 300, 15, 0], 0, {}, true] call CBA_fnc_addSetting;

["A3_adapt_CombatDuration", "SLIDER", "Combat track transition duration", ["Adaptive Music Mod Template", "Adaptive Music"], [1, 300, 5, 0], 0, {}, true] call CBA_fnc_addSetting;
