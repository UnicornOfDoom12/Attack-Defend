/*
@Uniform skining in here
@by Nuclear

DOESNT WORK YET WiP
*/
while {true} do
{
	waitUntil {(uniform player isEqualTo "U_B_CTRG_Soldier_F") || (uniform player isEqualTo "U_I_CombatUniform_shortsleeve")};
	sleep 1;
    //switch this to true if not*/
    if (playerSide == attackerSide) then
    {
        switch (true) do
        {
            case (uniform player isEqualTo "U_B_CTRG_Soldier_F"):
            {
                player setObjectTextureGlobal [0,"Textures\blue_attacker.paa"];
            };
            case (uniform player isEqualTo "U_I_CombatUniform_shortsleeve"):
            {
                player setObjectTextureGlobal [0,"Textures\nca.paa"];
            };
        };
    };

    if  (playerSide != attackerSide) then
    {
        switch (true) do
        {
            case (uniform player isEqualTo "U_B_CTRG_Soldier_F"):
            {
                player setObjectTextureGlobal [0,"Textures\Redemption_defender.paa"];
            };
        };
    };

    waitUntil {(uniform player != "U_B_CTRG_Soldier_F") || (uniform player != "U_I_CombatUniform_shortsleeve")};
	
};