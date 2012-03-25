% Szenario
ONE_TRAIN = 1;
TWO_TRAINS = 2;

% Crowdness
FEW_AGENTS_OP = 50;
MANY_AGENTS_OP = 100;
TOOMANY_AGENTS_OP = 200;
FEW_AGENTS_D = 25;
MANY_AGENTS_D = 50;
TOOMANY_AGENTS_D = 100;
FEW_AGENTS_SEATED = 50;
MANY_AGENTS_SEATED = 200;
TOOMANY_AGENTS_SEATED = 300;

SMALL_AREA_OT = [50, 5];
SMALL_AREA_TT = [50, 5];
SMALL = [SMALL_AREA_OT; SMALL_AREA_TT];
BIG_AREA_OT = [100,7];
BIG_AREA_TT = [150,9];
BIG = [BIG_AREA_OT; BIG_AREA_TT];

% Behaviour (Agents)
MIN_WALK = agentDMODEwalk;      % equal to "SUM" with lazy = 1;
MIN_SUM = agentDMODEsum_lazy;
MIN_QUEUE = agentDMODEqueue;    % equal to "SUM" with lazy = 0;
MIN_WAIT = agentDMODEwait;
RANDOM = agentDMODErandom;

% Time

% Stability
FC_STANDARD = ones(5,1);
    FC_obstacleRetraction = 1;
    FC_agentAttraction = 2;
    FC_agentAttractionGroup = 3;
    FC_agentRetraction = 4;
    FC_doorAttraction = 5;

    
FC_STANDARD(FC_obstacleRetraction) = 10000;
FC_STANDARD(FC_agentAttraction) = 1000;
FC_STANDARD(FC_agentAttractionGroup) = 2000;
FC_STANDARD(FC_agentRetraction) = 2;
FC_STANDARD(FC_doorAttraction) = 20000;
