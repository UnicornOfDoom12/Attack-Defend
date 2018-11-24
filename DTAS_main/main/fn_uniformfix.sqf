while {true} do
{
	waitUntil {(uniform player isEqualTo "U_B_CTRG_Soldier_F") || (uniform player isEqualTo "U_I_CombatUniform_shortsleeve")};
	sleep 1;
    switch (true) do
    {
        case (uniform player isEqualTo "U_B_CTRG_Soldier_F"):
        {
            player setObjectTextureGlobal [0,"Textures\ctsfo_co.paa"];
        };
		case (uniform player isEqualTo "U_I_CombatUniform_shortsleeve"):
        {
            player setObjectTextureGlobal [0,"Textures\nca.paa"];
        };
	};
	waitUntil {(uniform player != "U_B_CTRG_Soldier_F") || (uniform player != "U_I_CombatUniform_shortsleeve")};
		
	
};

waitUntil {!isNil "currentUniform"};
while {true} do
{
	waitUntil {uniform player != currentUniform && alive player && gearAssigned};

	removeUniform player;
	player forceAddUniform currentUniform;
};

