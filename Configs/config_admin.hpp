/*
    File: config_admin.hpp
    Author: Sig

    Description: Admin config
*/

class adminWhiteList {
  class adminLevelOne {
    playerids[] = { "", "", "", "", "", "" };
  };

  class adminLevelTwo {
    playerids[] = { "", "", "" };
  };

  class adminLevelThree {
    playerids[] = { "76561198090120592","76561198110128838", "76561198051160316", "", "" };
  };
};

class adminCommands {
  class forceStart {
    level = 2;
    displayName = "Force Round Start";
    action = "call DTAS_fnc_forceRoundStart";
    condition = "!roundInProgress && !forceRoundStart";
    picture = "\a3\ui_f\data\IGUI\Cfg\Actions\ico_on_ca.paa";
  };

  class pauseStart {
    level = 1;
    displayName = "Pause Round Start";
    action = "call DTAS_fnc_pauseRoundStart";
    condition = "!adminPaused";
    picture = "\a3\ui_f\data\IGUI\Cfg\Actions\Obsolete\ui_action_deactivate_ca.paa";
  };

  class unPauseStart {
    level = 1;
    displayName = "Unpause Round Start";
    action = "call DTAS_fnc_unPauseRoundStart";
    condition = "adminPaused";
    picture = "\a3\ui_f\data\IGUI\Cfg\Actions\settimer_ca.paa";
  };

  class moveObj {
    level = 3;
    displayName = "Relocate Objective";
    action = "call DTAS_fnc_relocate";
    condition = "!roundInProgress";
    picture = "\a3\ui_f\data\GUI\Cfg\Cursors\move_gs.paa";
  };
};
