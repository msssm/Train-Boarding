% Start simulation here!
% Arrangment for simulation


init_globals;
init_main;
init_style;

% ------------------------------
% -----Standard-values----------

% Szenario
SZENARIO = TWO_TRAINS;                   % [TT]

% Crowdness
PART_FC = 0.2;                          % [FCR]
AGENTS_OP = MANY_AGENTS_OP;             % [PoP]
AGENTS_D = MANY_AGENTS_D;               % [Pd]
AGENTS_SEATED = MANY_AGENTS_SEATED;     % [Pas]

WAITING_AREA = BIG;                     % [WA]

% Behaviour
DOOR_DECISION_MODE = MIN_SUM;           % [DDM]
    LAZINESS = 0.5;                     % [LC]
PATIENCE = 0.9;                         % [P]
DECISION_STEPFREQ = 1;                  % [DSF]
DECISION_LIMIT = agentDECTIMESinfinite; % [DL]
VELOCITY = 1.5;                         % [VD]
    VELOCITY_VAR = 0.5;                 
GROUPING = 0;                           % [G]
    GROUP_SIZE = 10;                    % [GS]

% Time
AREA_DELAY = 5;                         % [TW]
DOORS_DELAY = 10;                       % [TD]

% Simulation Stability
TIMESTEP = 0.05;                        % [TS]
FORCES_COEFF = FC_STANDARD;
TIMEMAX = 90;

switch Testcase
    case 1
        SZENARIO = ONE_TRAIN;                   % [OT]
    case 2
        
    case 3
        SZENARIO = ONE_TRAIN;                  % [OT]
        AGENTS_OP = FEW_AGENTS_OP;             % [PoP]
        AGENTS_D = FEW_AGENTS_D;               % [Pd]
        AGENTS_SEATED = FEW_AGENTS_SEATED;     % [Pas]
    case 4
        AGENTS_OP = FEW_AGENTS_OP;             % [PoP]
        AGENTS_D = FEW_AGENTS_D;               % [Pd]
        AGENTS_SEATED = FEW_AGENTS_SEATED;     % [Pas]
    case 5
        SZENARIO = ONE_TRAIN;                  % [OT]
        AGENTS_OP = TOOMANY_AGENTS_OP;         % [PoP]
        AGENTS_D = TOOMANY_AGENTS_D;           % [Pd]
        AGENTS_SEATED = FEW_AGENTS_SEATED;     % [Pas]
    case 6
        AGENTS_OP = TOOMANY_AGENTS_OP;         % [PoP]
        AGENTS_D = TOOMANY_AGENTS_D;           % [Pd]
        AGENTS_SEATED = FEW_AGENTS_SEATED;     % [Pas]
    case 7
        DOOR_DECISION_MODE = MIN_WALK;         % [DDM]
    case 8
        DOOR_DECISION_MODE = MIN_QUEUE;        % [DDM]
    case 9
        DOOR_DECISION_MODE = MIN_WAIT;         % [DDM]
    case 10
        DOOR_DECISION_MODE = RANDOM;           % [DDM]
    case 11
        LAZINESS = 0.0;                        % [LC]
    case 12
        LAZINESS = 0.1;                        % [LC]
    case 13
        LAZINESS = 0.2;                        % [LC]
    case 14
        LAZINESS = 0.3;                        % [LC]
    case 15
        LAZINESS = 0.4;                        % [LC]
    case 16
        LAZINESS = 0.5;                        % [LC]
    case 17
        LAZINESS = 0.6;                        % [LC]
    case 18
        LAZINESS = 0.7;                        % [LC]
    case 19
        LAZINESS = 0.8;                        % [LC]
    case 20
        LAZINESS = 0.9;                        % [LC]
    case 21
        LAZINESS = 1.0;                        % [LC]
    case 22
        DECISION_STEPFREQ = 1*TIMESTEP;        % [DSF]
    case 23
        DECISION_STEPFREQ = 100*TIMESTEP;      % [DSF]
    case 24
        DECISION_LIMIT = 1;                    % [DL]
    case 25
        DECISION_LIMIT = 10;                   % [DL]
    case 26
        PATIENCE = 1;                         % [P]
    case 27
        PATIENCE = 0.5;                         % [P]
    case 28
        VELOCITY = 1;                         % [VD]
        VELOCITY_VAR = 0;
    case 29
        VELOCITY = 1.5;                         % [VD]
        VELOCITY_VAR = 0;
    case 30
        VELOCITY = 2.5;                         % [VD]
        VELOCITY_VAR = 1.5;
    case 31
        GROUPING = 0.2;                           % [G]
    case 32
        GROUPING = 0.5;                           % [G]
    case 33
        AREA_DELAY = 1;                         % [TW]
        DOORS_DELAY = 1;                       % [TD]
    case 34
        AREA_DELAY = 10;                         % [TW]
        DOORS_DELAY = 20;                       % [TD]
    case 35
        WAITING_AREA = SMALL;                         % [WA]
        SZENARIO = ONE_TRAIN;                       % [OT]
    case 36
        WAITING_AREA = SMALL;                         % [WA]
    otherwise
        'unknown testcase id'
        return;

end
        
switch SZENARIO
    case ONE_TRAIN
        init_szenario_one_train;
    case TWO_TRAINS
        init_szenario_two_trains;
end