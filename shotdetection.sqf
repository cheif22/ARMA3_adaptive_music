//To elevate stress levels if you are being shot at.

params ["_changer", "_stress"]

player addEventHandler
["firedNear",
    {
        _unit = _this select 0;
        if ((_unit getVariable ["_stress", 0]) < 100) then
        {
            _unit setVariable ["_stress", (_unit getVariable ["_stress", 0]) + 1];
        };
    }
];
player addEventHandler
["hit",
    {
        _unit = _this select 0;
        _unit setVariable ["_stress", 100];
    }
];

_changer