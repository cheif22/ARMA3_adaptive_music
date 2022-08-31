//Arma 3 Music Script
// Init file updated by Phenosi.

if (A3_adapt_setting) then { ExecVm "A3_adapt\musicHandler.sqf"; } else { hint "Adaptive Music is not enabled" };
sleep 1;
if (A3_adapt_debug) then { ExecVm "A3_adapt\Debugmode.sqf"; } else { hint "Adaptive Music Debug mode is disabled" };
