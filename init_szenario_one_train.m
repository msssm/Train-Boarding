%simulate one train as on a platform in Sargans

% -------
% GENERAL
% -------

simulation_mode = simulationMODEonetrain;

% specify scenario (SI units)
border = [0,0,200,45]; %left, bottom, width, height

% time specification
tmax = TIMEMAX;
dt = TIMESTEP;
stepcount = tmax/dt;

% ------
% AGENTS
% ------

class_FIRST = 1;
class_SECOND = 2;
class_count = 2;

agent_type_BOARDING = 1;
agent_type_DEBOARDING = 2;
agent_type_count = 2;

% number of agents as summed up (for later use as index ranges)

agent_part_count = zeros(class_count, agent_type_count);
agent_part_sum = zeros(class_count, agent_type_count);

agent_part_count(class_FIRST, agent_type_BOARDING) = round(AGENTS_OP*PART_FC);
agent_part_count(class_FIRST, agent_type_DEBOARDING) = round(AGENTS_D*PART_FC);

agent_part_count(class_SECOND, agent_type_BOARDING) = round(AGENTS_OP*(1-PART_FC));
agent_part_count(class_SECOND, agent_type_DEBOARDING) = round(AGENTS_D*(1-PART_FC));

agent_part_sum(class_FIRST, agent_type_BOARDING) = agent_part_count(class_FIRST, agent_type_BOARDING);
agent_part_sum(class_FIRST, agent_type_DEBOARDING) = agent_part_count(class_FIRST, agent_type_DEBOARDING)   + agent_part_sum(class_FIRST, agent_type_BOARDING);

agent_part_sum(class_SECOND, agent_type_BOARDING) = agent_part_count(class_SECOND, agent_type_BOARDING)     + agent_part_sum(class_FIRST, agent_type_DEBOARDING);
agent_part_sum(class_SECOND, agent_type_DEBOARDING) = agent_part_count(class_SECOND, agent_type_DEBOARDING) + agent_part_sum(class_SECOND, agent_type_BOARDING);

agentcount = agent_part_sum(class_SECOND, agent_type_DEBOARDING);


% Array for agents
agent = zeros(agentcount, agentCOLCOUNT);
agentspace = FORCES_COEFF(FC_agentRetraction);    % extension of an agent (m)
agentmass = 80;       % mass of an agent (kg)

%specify type of entering door (1 (subway), 2 (2nd class), 3 (1st class)
agent_mode_enter_subway = 1;
agent_mode_enter_second_class = 2;
agent_mode_enter_first_class = 3;

agent(1                                                       :   agent_part_sum(class_FIRST, agent_type_BOARDING), agentMODE) = agent_mode_enter_first_class;
agent(agent_part_sum(class_FIRST, agent_type_BOARDING)+1      :   agent_part_sum(class_FIRST, agent_type_DEBOARDING), agentMODE) = agent_mode_enter_subway;

agent(agent_part_sum(class_FIRST, agent_type_DEBOARDING)+1    :   agent_part_sum(class_SECOND, agent_type_BOARDING), agentMODE) = agent_mode_enter_second_class;
agent(agent_part_sum(class_SECOND, agent_type_BOARDING)+1     :   agent_part_sum(class_SECOND, agent_type_DEBOARDING), agentMODE) = agent_mode_enter_subway;

% Specify initial state (moving, deboarding)
agent(1                                                       :   agent_part_sum(class_FIRST, agent_type_BOARDING), agentSTATE) = agentSTATEmoving;
agent(agent_part_sum(class_FIRST, agent_type_BOARDING)+1      :   agent_part_sum(class_FIRST, agent_type_DEBOARDING), agentSTATE) = agentSTATEdeboarding;

agent(agent_part_sum(class_FIRST, agent_type_DEBOARDING)+1    :   agent_part_sum(class_SECOND, agent_type_BOARDING), agentSTATE) = agentSTATEmoving;
agent(agent_part_sum(class_SECOND, agent_type_BOARDING)+1   :   agent_part_sum(class_SECOND, agent_type_DEBOARDING), agentSTATE) = agentSTATEdeboarding;

%set leaving doors
agent(:, agentLDOOR) = zeros(agentcount, 1);

agent(agent_part_sum(class_FIRST, agent_type_BOARDING)+1      :   agent_part_sum(class_FIRST, agent_type_DEBOARDING), agentLDOOR)  ...
    = round(linspace(10,13,agent_part_count(class_FIRST, agent_type_DEBOARDING)));
agent(agent_part_sum(class_SECOND, agent_type_BOARDING)+1     :   agent_part_sum(class_SECOND, agent_type_DEBOARDING), agentLDOOR) ...
    = round(linspace(3,9,agent_part_count(class_SECOND, agent_type_DEBOARDING)));

%choice for entering door based on agentMODE
agent(:, agentCDOOR) = ones(agentcount,1);

agent(:, agentMAXV) = VELOCITY*ones(agentcount, 1) + VELOCITY_VAR * rand(agentcount, 1);
agent(:, agentPATIENT) = 0.9*ones(agentcount, 1);
agent(:, agentLAZY) = LAZINESS*ones(agentcount, 1);
agent(:, agentDMODE) = DOOR_DECISION_MODE*ones(agentcount, 1);
agentDECstepfrequency = DECISION_STEPFREQ;      % inicates the step-based freq. agent decides for best door
agent(:, agentDECTIMES) = DECISION_LIMIT*ones(agentcount, 1);
agent(:, agentGROUP) = agentGROUPnone*ones(agentcount, 1);


% -----
% DOORS
% -----
doorcount = 13; % 1 train, à 3x second class waggons, 1x Bistro (1 door), 2x first class, 2 exits

% Array for doors
door = zeros(doorcount, doorCOLCOUNT);
doorrange = 0.5;
doorstrength = FORCES_COEFF(FC_doorAttraction);
doors_opening_time = DOORS_DELAY;

% Exits
door(1, doorXPOS) = 85-30;
door(2, doorXPOS) = 85+30;

door(1:2, doorYPOS) = 15;
door(1:2, doorMODE) = agent_mode_enter_subway;
door(1:2, doorSTATE) = 0;
door(1:2, doorMEANFREQ) = 5; %more people than on the train
door(1:2, doorVARFREQ) = 0.1;
door(1:2, doorACTIVITY) = doorACTIVE;

% Train
door(3, doorXPOS) = 10+0*25+1.5;
door(4, doorXPOS) = 10+0*25+23.5;   % Second class
door(5, doorXPOS) = 10+1*25+1.5;
door(6, doorXPOS) = 10+1*25+23.5;
door(7, doorXPOS) = 10+2*25+1.5;
door(8, doorXPOS) = 10+2*25+23.5;
door(9, doorXPOS) = 10+3*25+1.5;    % Bistro
door(10, doorXPOS) = 10+4*25+1.5;   % First class
door(11, doorXPOS) = 10+4*25+23.5;
door(12, doorXPOS) = 10+5*25+1.5;
door(13, doorXPOS) = 10+5*25+23.5;

door(3:13, doorYPOS) = 19.9;
door(3:9, doorMODE) = agent_mode_enter_second_class;
door(10:13, doorMODE) = agent_mode_enter_first_class;
door(3:13, doorSTATE) = doors_opening_time; % wait for some seconds until people can de/board
door(3:13, doorMEANFREQ) = 0.7;
door(3:13, doorVARFREQ) = 0.1;
door(3:13, doorACTIVITY) = doorACTIVE;

doorMODEsum = max(door(:,doorMODE));

% Sum up number of leaving agents
for idoor = 1:doorcount
    door(idoor, doorAGENT) = -sum(agent(:, agentLDOOR)==idoor);
end


% ---------
% OBSTACLES
% ---------

traincount = 1;

obstaclecount = 5; %1 train, 1 waiting area, 1 building, 2 doublesubways

% Array for obstacles
obstacle = zeros(obstaclecount, obstacleCOLCOUNT);

obstacle(:, obstacleRANGE) = FORCES_COEFF(FC_obstacleRetraction)*ones(obstaclecount, 1);
obstacle(:, obstaclePASSABLE) = zeros(obstaclecount, 1);

obstacle(:, obstacleSTART) = 0;
obstacle(:, obstacleEND) = tmax;

% train
obstacle(1, [obstacleXCENTER, obstacleYCENTER]) = [95, 22.5];
obstacle(1, [obstacleWIDTH, obstacleHEIGHT]) = [170,5];

% start area
oSTARTAREA = 2;
obstacle(oSTARTAREA, [obstacleXCENTER, obstacleYCENTER]) = [85, 16];
obstacle(oSTARTAREA, [obstacleWIDTH, obstacleHEIGHT]) = WAITING_AREA(1,:);

obstacle(oSTARTAREA, obstacleSTART) = 0;
obstacle(oSTARTAREA, obstacleEND) = AREA_DELAY;

% building
obstacle(3, [obstacleXCENTER, obstacleYCENTER]) = [100, 5];
obstacle(3, [obstacleWIDTH, obstacleHEIGHT]) = [200,10];

% subways;
obstacle(4, [obstacleWIDTH, obstacleHEIGHT]) = [20,5];
obstacle(4, [obstacleXCENTER, obstacleYCENTER]) = ...
    door(1, [doorXPOS, doorYPOS]) + [obstacle(4, obstacleWIDTH)/2 + 1, 0];
obstacle(5, [obstacleWIDTH, obstacleHEIGHT]) = [20,5];
obstacle(5, [obstacleXCENTER, obstacleYCENTER]) = ...
    door(2, [doorXPOS, doorYPOS]) - [obstacle(4, obstacleWIDTH)/2 + 1, 0];


% -----------
% TRAIN SEATS
% -----------

trainseats = zeros(traincount,6*10,2);
% Restaurant Coach and first Class already half full
trainseats(:,31:60,1) = 4*ones(traincount,3*10,1);

% set people, that are already seated
trainseats(:,1:30,:) = round(AGENTS_SEATED / 90);
trainseats(:,31:60,2) = round(AGENTS_SEATED / 90);


% ---------------
% AGENT POSITIONS
% ---------------

% Set random position for boarding agents
% (debording agents are going to be reset on their startposition in
% "simulation.m")
dspace = 0.2;   % min space between obstacle and agent (and also STARTAREA and agent)

for iagent=1:agentcount
    % call of script that sets random position until outside of any
    % obstacle, that is not the starting area
    set_agent_outside_of_any_obstacle
end


% - - -
% Group
% - - -
% A group consists of a couple of boarding(!) agents. They are all heading
% to the same door, which only can be chosen by their group-master.

N_groups(class_FIRST) = round(GROUPING*PART_FC*AGENTS_OP/GROUP_SIZE);
N_groups(class_SECOND) = round(GROUPING*(1-PART_FC)*AGENTS_OP/GROUP_SIZE);
groupcount = N_groups(class_FIRST)+N_groups(class_SECOND);

Size_group = zeros(groupcount, 1);
Size_group(1:N_groups(class_FIRST)) = GROUP_SIZE;
Size_group(N_groups(class_FIRST)+1:groupcount) = GROUP_SIZE;

% First-Class Groups
sagent = 1;
sgroup = 1;
for igroup = sgroup:N_groups(class_FIRST)
    init_group
end

% Second-Class Groups
sgroup = sgroup + N_groups(class_FIRST);
sagent = agent_part_sum(class_FIRST, agent_type_DEBOARDING)+1;
for igroup = sgroup:(sgroup-1) + N_groups(class_SECOND)
    init_group
end


% remaining Time between agent and door
remainingdistance = zeros(agentcount, doorcount);
remainingwalktime = zeros(agentcount, doorcount);
remainingqueuetime = zeros(agentcount, doorcount);
placeinqueue = ones(agentcount, doorcount);

% load statistic variables
init_statistics

%start simulation

simulation
