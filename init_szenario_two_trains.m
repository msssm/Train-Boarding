%simulate two parallel trains as in Zurich HB

% -------
% GENERAL
% -------

simulation_mode = simulationMODEtwotrains;

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

agent_type_BOARDING_A = 1;
agent_type_BOARDING_B = 2;
agent_type_DEBOARDING_A = 3;
agent_type_DEBOARDING_B = 4;
agent_type_CHANGING_A_B = 5;
agent_type_CHANGING_B_A = 6;
agent_type_count = 6;

% number of agents as summed up (for later use as index ranges)

agent_part_count = zeros(class_count, agent_type_count);
agent_part_sum = zeros(class_count, agent_type_count);

agent_part_count(class_FIRST, agent_type_BOARDING_A) = round(AGENTS_OP*PART_FC);
agent_part_count(class_FIRST, agent_type_BOARDING_B) = round(AGENTS_OP*PART_FC);
agent_part_count(class_FIRST, agent_type_DEBOARDING_A) = round(AGENTS_D*PART_FC/2);
agent_part_count(class_FIRST, agent_type_DEBOARDING_B) = round(AGENTS_D*PART_FC/2);
agent_part_count(class_FIRST, agent_type_CHANGING_A_B) = round(AGENTS_D*PART_FC/2);
agent_part_count(class_FIRST, agent_type_CHANGING_B_A) = round(AGENTS_D*PART_FC/2);

agent_part_count(class_SECOND, agent_type_BOARDING_A) = round(AGENTS_OP*(1-PART_FC));
agent_part_count(class_SECOND, agent_type_BOARDING_B) = round(AGENTS_OP*(1-PART_FC));
agent_part_count(class_SECOND, agent_type_DEBOARDING_A) = round(AGENTS_D*(1-PART_FC)/2);
agent_part_count(class_SECOND, agent_type_DEBOARDING_B) = round(AGENTS_D*(1-PART_FC)/2);
agent_part_count(class_SECOND, agent_type_CHANGING_A_B) = round(AGENTS_D*(1-PART_FC)/2);
agent_part_count(class_SECOND, agent_type_CHANGING_B_A) = round(AGENTS_D*(1-PART_FC)/2);


agent_part_sum(class_FIRST, agent_type_BOARDING_A) = agent_part_count(class_FIRST, agent_type_BOARDING_A);
agent_part_sum(class_FIRST, agent_type_BOARDING_B) = agent_part_count(class_FIRST, agent_type_BOARDING_B) + agent_part_sum(class_FIRST, agent_type_BOARDING_A);
agent_part_sum(class_FIRST, agent_type_DEBOARDING_A) = agent_part_count(class_FIRST, agent_type_DEBOARDING_A) + agent_part_sum(class_FIRST, agent_type_BOARDING_B);
agent_part_sum(class_FIRST, agent_type_DEBOARDING_B) = agent_part_count(class_FIRST, agent_type_DEBOARDING_B) + agent_part_sum(class_FIRST, agent_type_DEBOARDING_A);
agent_part_sum(class_FIRST, agent_type_CHANGING_A_B) = agent_part_count(class_FIRST, agent_type_CHANGING_A_B) + agent_part_sum(class_FIRST, agent_type_DEBOARDING_B);
agent_part_sum(class_FIRST, agent_type_CHANGING_B_A) = agent_part_count(class_FIRST, agent_type_CHANGING_B_A) + agent_part_sum(class_FIRST, agent_type_CHANGING_A_B);

agent_part_sum(class_SECOND, agent_type_BOARDING_A) = agent_part_count(class_SECOND, agent_type_BOARDING_A) + agent_part_sum(class_FIRST, agent_type_CHANGING_B_A);
agent_part_sum(class_SECOND, agent_type_BOARDING_B) = agent_part_count(class_SECOND, agent_type_BOARDING_B) + agent_part_sum(class_SECOND, agent_type_BOARDING_A);
agent_part_sum(class_SECOND, agent_type_DEBOARDING_A) = agent_part_count(class_SECOND, agent_type_DEBOARDING_A) + agent_part_sum(class_SECOND, agent_type_BOARDING_B);
agent_part_sum(class_SECOND, agent_type_DEBOARDING_B) = agent_part_count(class_SECOND, agent_type_DEBOARDING_B) + agent_part_sum(class_SECOND, agent_type_DEBOARDING_A);
agent_part_sum(class_SECOND, agent_type_CHANGING_A_B) = agent_part_count(class_SECOND, agent_type_CHANGING_A_B) + agent_part_sum(class_SECOND, agent_type_DEBOARDING_B);
agent_part_sum(class_SECOND, agent_type_CHANGING_B_A) = agent_part_count(class_SECOND, agent_type_CHANGING_B_A) + agent_part_sum(class_SECOND, agent_type_CHANGING_A_B);

agentcount = agent_part_sum(class_SECOND, agent_type_CHANGING_B_A);


% Array for agents
agent = zeros(agentcount, agentCOLCOUNT);
agentspace = FORCES_COEFF(FC_agentRetraction);    % extension of an agent (m)
agentmass = 80;       % mass of an agent (kg)

%specify type of entering door (1 (subway), 2 (A 2nd class), 3 (A 1st
%class), 4 (B 2nd class), 5 (B 1st class))
agent(:, agentMODE) = zeros(agentcount, 1);
agent(1                                                       :   agent_part_sum(class_FIRST, agent_type_BOARDING_A), agentMODE) = 3;
agent(agent_part_sum(class_FIRST, agent_type_BOARDING_A)+1    :   agent_part_sum(class_FIRST, agent_type_BOARDING_B), agentMODE) = 5;
agent(agent_part_sum(class_FIRST, agent_type_BOARDING_B)+1    :   agent_part_sum(class_FIRST, agent_type_DEBOARDING_A), agentMODE) = 1;
agent(agent_part_sum(class_FIRST, agent_type_DEBOARDING_A)+1  :   agent_part_sum(class_FIRST, agent_type_DEBOARDING_B), agentMODE) = 1;
agent(agent_part_sum(class_FIRST, agent_type_DEBOARDING_B)+1  :   agent_part_sum(class_FIRST, agent_type_CHANGING_A_B), agentMODE) = 5;
agent(agent_part_sum(class_FIRST, agent_type_CHANGING_A_B)+1  :   agent_part_sum(class_FIRST, agent_type_CHANGING_B_A), agentMODE) = 3;

agent(agent_part_sum(class_FIRST, agent_type_CHANGING_B_A)+1  :   agent_part_sum(class_SECOND, agent_type_BOARDING_A), agentMODE) = 2;
agent(agent_part_sum(class_SECOND, agent_type_BOARDING_A)+1   :   agent_part_sum(class_SECOND, agent_type_BOARDING_B), agentMODE) = 4;
agent(agent_part_sum(class_SECOND, agent_type_BOARDING_B)+1   :   agent_part_sum(class_SECOND, agent_type_DEBOARDING_A), agentMODE) = 1;
agent(agent_part_sum(class_SECOND, agent_type_DEBOARDING_A)+1 :   agent_part_sum(class_SECOND, agent_type_DEBOARDING_B), agentMODE) = 1;
agent(agent_part_sum(class_SECOND, agent_type_DEBOARDING_B)+1 :   agent_part_sum(class_SECOND, agent_type_CHANGING_A_B), agentMODE) = 4;
agent(agent_part_sum(class_SECOND, agent_type_CHANGING_A_B)+1 :   agent_part_sum(class_SECOND, agent_type_CHANGING_B_A), agentMODE) = 2;


% Specify initial state (moving, deboarding)
agent(1                                                       :   agent_part_sum(class_FIRST, agent_type_BOARDING_A), agentSTATE) = agentSTATEmoving;
agent(agent_part_sum(class_FIRST, agent_type_BOARDING_A)+1    :   agent_part_sum(class_FIRST, agent_type_BOARDING_B), agentSTATE) = agentSTATEmoving;
agent(agent_part_sum(class_FIRST, agent_type_BOARDING_B)+1    :   agent_part_sum(class_FIRST, agent_type_DEBOARDING_A), agentSTATE) = agentSTATEdeboarding;
agent(agent_part_sum(class_FIRST, agent_type_DEBOARDING_A)+1  :   agent_part_sum(class_FIRST, agent_type_DEBOARDING_B), agentSTATE) = agentSTATEdeboarding;
agent(agent_part_sum(class_FIRST, agent_type_DEBOARDING_B)+1  :   agent_part_sum(class_FIRST, agent_type_CHANGING_A_B), agentSTATE) = agentSTATEdeboarding;
agent(agent_part_sum(class_FIRST, agent_type_CHANGING_A_B)+1  :   agent_part_sum(class_FIRST, agent_type_CHANGING_B_A), agentSTATE) = agentSTATEdeboarding;

agent(agent_part_sum(class_FIRST, agent_type_CHANGING_B_A)+1  :   agent_part_sum(class_SECOND, agent_type_BOARDING_A), agentSTATE) = agentSTATEmoving;
agent(agent_part_sum(class_SECOND, agent_type_BOARDING_A)+1   :   agent_part_sum(class_SECOND, agent_type_BOARDING_B), agentSTATE) = agentSTATEmoving;
agent(agent_part_sum(class_SECOND, agent_type_BOARDING_B)+1   :   agent_part_sum(class_SECOND, agent_type_DEBOARDING_A), agentSTATE) = agentSTATEdeboarding;
agent(agent_part_sum(class_SECOND, agent_type_DEBOARDING_A)+1 :   agent_part_sum(class_SECOND, agent_type_DEBOARDING_B), agentSTATE) = agentSTATEdeboarding;
agent(agent_part_sum(class_SECOND, agent_type_DEBOARDING_B)+1 :   agent_part_sum(class_SECOND, agent_type_CHANGING_A_B), agentSTATE) = agentSTATEdeboarding;
agent(agent_part_sum(class_SECOND, agent_type_CHANGING_A_B)+1 :   agent_part_sum(class_SECOND, agent_type_CHANGING_B_A), agentSTATE) = agentSTATEdeboarding;


%set leaving doors
agent(:, agentLDOOR) = zeros(agentcount, 1);

agent(1                                                       :   agent_part_sum(class_FIRST, agent_type_BOARDING_A), agentLDOOR)  ...
    = 0;
agent(agent_part_sum(class_FIRST, agent_type_BOARDING_A)+1    :   agent_part_sum(class_FIRST, agent_type_BOARDING_B), agentLDOOR)   ...
    = 0;
agent(agent_part_sum(class_FIRST, agent_type_BOARDING_B)+1    :   agent_part_sum(class_FIRST, agent_type_DEBOARDING_A), agentLDOOR) ...
    = round(linspace(11,14,agent_part_count(class_FIRST, agent_type_DEBOARDING_A)));
agent(agent_part_sum(class_FIRST, agent_type_DEBOARDING_A)+1  :   agent_part_sum(class_FIRST, agent_type_DEBOARDING_B), agentLDOOR) ...
    = round(linspace(22,25,agent_part_count(class_FIRST, agent_type_DEBOARDING_B)));
agent(agent_part_sum(class_FIRST, agent_type_DEBOARDING_B)+1  :   agent_part_sum(class_FIRST, agent_type_CHANGING_A_B), agentLDOOR) ...
    = round(linspace(11,14,agent_part_count(class_FIRST, agent_type_CHANGING_A_B)));
agent(agent_part_sum(class_FIRST, agent_type_CHANGING_A_B)+1  :   agent_part_sum(class_FIRST, agent_type_CHANGING_B_A), agentLDOOR) ...
    = round(linspace(22,25,agent_part_count(class_FIRST, agent_type_CHANGING_B_A)));

agent(agent_part_sum(class_FIRST, agent_type_CHANGING_B_A)+1  :   agent_part_sum(class_SECOND, agent_type_BOARDING_A), agentLDOOR)  ...
    = 0;
agent(agent_part_sum(class_SECOND, agent_type_BOARDING_A)+1   :   agent_part_sum(class_SECOND, agent_type_BOARDING_B), agentLDOOR)  ...
    = 0;
agent(agent_part_sum(class_SECOND, agent_type_BOARDING_B)+1   :   agent_part_sum(class_SECOND, agent_type_DEBOARDING_A), agentLDOOR) ...
    = round(linspace(4,10,agent_part_count(class_SECOND, agent_type_DEBOARDING_A)));
agent(agent_part_sum(class_SECOND, agent_type_DEBOARDING_A)+1 :   agent_part_sum(class_SECOND, agent_type_DEBOARDING_B), agentLDOOR) ...
    = round(linspace(15,21,agent_part_count(class_SECOND, agent_type_DEBOARDING_B)));
agent(agent_part_sum(class_SECOND, agent_type_DEBOARDING_B)+1 :   agent_part_sum(class_SECOND, agent_type_CHANGING_A_B), agentLDOOR) ...
    = round(linspace(4,10,agent_part_count(class_SECOND, agent_type_CHANGING_A_B)));
agent(agent_part_sum(class_SECOND, agent_type_CHANGING_A_B)+1 :   agent_part_sum(class_SECOND, agent_type_CHANGING_B_A), agentLDOOR) ...
    = round(linspace(15,21,agent_part_count(class_SECOND, agent_type_CHANGING_B_A)));

%choice for entering door based on agentMODE
agent(:, agentCDOOR) = ones(agentcount,1);

agent(:, agentMAXV) = VELOCITY*ones(agentcount, 1) + VELOCITY_VAR * rand(agentcount, 1);
agent(:, agentPATIENT) = 0.9*ones(agentcount, 1);
agent(:, agentLAZY) = LAZINESS*ones(agentcount, 1);
agent(:, agentDMODE) = DOOR_DECISION_MODE*ones(agentcount, 1);
agentDECstepfrequency = DECISION_STEPFREQ;  % inicates the step-based freq. agent decides for best door
agent(:, agentDECTIMES) = DECISION_LIMIT*ones(agentcount, 1);
agent(:, agentGROUP) = agentGROUPnone*ones(agentcount, 1);




% -----
% DOORS
% -----
doorcount = 25; % 2 trains, each 3x second class, 1x Bistro (1 door), 2x first class, 3 exits

% Array for doors
door = zeros(doorcount, doorCOLCOUNT);
doorrange = 0.5;
doorstrength = FORCES_COEFF(FC_doorAttraction);
doors_opening_time = DOORS_DELAY;


% Exits
door(1, doorXPOS) = 49.9;
door(2, doorXPOS) = 155.1;
door(3, doorXPOS) = 195;

door(1:3, doorYPOS) = 20;
agent_mode_enter_subway = 1;
door(1:3, doorMODE) = agent_mode_enter_subway;
door(1:3, doorSTATE) = 0;
door(1:3, doorMEANFREQ) = 10; %more people than on the train
door(1:3, doorVARFREQ) = 0.1;
door(1:3, doorACTIVITY) = doorACTIVE;

% First Train
door(4, doorXPOS) = 15+0*25+1.5;
door(5, doorXPOS) = 15+0*25+23.5;   % Second class
door(6, doorXPOS) = 15+1*25+1.5;
door(7, doorXPOS) = 15+1*25+23.5;
door(8, doorXPOS) = 15+2*25+1.5;
door(9, doorXPOS) = 15+2*25+23.5;
door(10, doorXPOS) = 15+3*25+1.5;    % Bistro
door(11, doorXPOS) = 15+4*25+1.5;   % First class
door(12, doorXPOS) = 15+4*25+23.5;
door(13, doorXPOS) = 15+5*25+1.5;
door(14, doorXPOS) = 15+5*25+23.5;

door(4:14, doorYPOS) = 24.9;
door(4:10, doorMODE) = 2;
door(11:14, doorMODE) = 3;
door(4:14, doorSTATE) = doors_opening_time; % wait for some seconds until people can de/board
door(4:14, doorMEANFREQ) = 0.7;
door(4:14, doorVARFREQ) = 0.1;
door(4:14, doorACTIVITY) = doorACTIVE;

% Second Train
door(15, doorXPOS) = 15+0*25+1.5;
door(16, doorXPOS) = 15+0*25+23.5;   % Second class
door(17, doorXPOS) = 15+1*25+1.5;
door(18, doorXPOS) = 15+1*25+23.5;
door(19, doorXPOS) = 15+2*25+1.5;
door(20, doorXPOS) = 15+2*25+23.5;
door(21, doorXPOS) = 15+3*25+1.5;    % Bistro
door(22, doorXPOS) = 15+4*25+1.5;   % First class
door(23, doorXPOS) = 15+4*25+23.5;
door(24, doorXPOS) = 15+5*25+1.5;
door(25, doorXPOS) = 15+5*25+23.5;

door(15:25, doorYPOS) = 15.1;
door(15:21, doorMODE) = 4;
door(22:25, doorMODE) = 5;
door(15:25, doorSTATE) = doors_opening_time; % wait for some seconds until people can de/board
door(15:25, doorMEANFREQ) = 0.7;
door(15:25, doorVARFREQ) = 0.1;
door(15:25, doorACTIVITY) = doorACTIVE;

doorMODEsum = max(door(:,doorMODE));

% Sum up number of leaving agents
for idoor = 1:doorcount
    door(idoor, doorAGENT) = -sum(agent(:, agentLDOOR)==idoor);
end


% ---------
% OBSTACLES
% ---------

traincount = 2;

obstaclecount = 9; %2 trains, 2 triple subway entrances, 1 start area

% Array for obstacles
obstacle = zeros(obstaclecount, obstacleCOLCOUNT);

obstacle(:, obstacleSTART) = 0;
obstacle(:, obstacleEND) = tmax;

obstacle(:, obstacleRANGE) = FORCES_COEFF(FC_obstacleRetraction)*ones(obstaclecount, 1);
obstacle(:, obstaclePASSABLE) = zeros(obstaclecount, 1);

% trains
obstacle(1, [obstacleXCENTER, obstacleYCENTER]) = [100, 27.5];
obstacle(1, [obstacleWIDTH, obstacleHEIGHT]) = [170,5];
obstacle(2, [obstacleXCENTER, obstacleYCENTER]) = [100, 12.5];
obstacle(2, [obstacleWIDTH, obstacleHEIGHT]) = [170,5];

% subway entrances
obstacle(3, [obstacleXCENTER, obstacleYCENTER]) = [55, 20];
obstacle(3, [obstacleWIDTH, obstacleHEIGHT]) = [9.5, 5];
obstacle(4, [obstacleXCENTER, obstacleYCENTER]) = [150, 20];
obstacle(4, [obstacleWIDTH, obstacleHEIGHT]) = [9.5, 5];

% further small obstacles
obstacle(5, [obstacleXCENTER, obstacleYCENTER]) = [80, 20];
obstacle(5, [obstacleWIDTH, obstacleHEIGHT]) = [3, 1.5];
obstacle(6, [obstacleXCENTER, obstacleYCENTER]) = [105, 20];
obstacle(6, [obstacleWIDTH, obstacleHEIGHT]) = [3, 1.5];
obstacle(7, [obstacleXCENTER, obstacleYCENTER]) = [130, 20];
obstacle(7, [obstacleWIDTH, obstacleHEIGHT]) = [3, 1.5];
obstacle(8, [obstacleXCENTER, obstacleYCENTER]) = [30, 20];
obstacle(8, [obstacleWIDTH, obstacleHEIGHT]) = [3, 1.5];


%start area
oSTARTAREA = 9;
obstacle(oSTARTAREA, [obstacleXCENTER, obstacleYCENTER]) = [90, 20];
obstacle(oSTARTAREA, [obstacleWIDTH, obstacleHEIGHT]) = WAITING_AREA(2,:);

obstacle(oSTARTAREA, obstacleSTART) = 0;
obstacle(oSTARTAREA, obstacleEND) = AREA_DELAY;


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
dspace = 0.2;   % min space between obstacle and agent

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

N_groups(class_FIRST) = round(GROUPING*PART_FC*AGENTS_OP*2/GROUP_SIZE);
N_groups(class_SECOND) = round(GROUPING*(1-PART_FC)*AGENTS_OP*2/GROUP_SIZE);
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
sgroup = sgroup + N_groups(class_FIRST);

% Second-Class Groups
sagent = agent_part_sum(class_FIRST, agent_type_CHANGING_B_A)+1;
for igroup = sgroup:(sgroup-1) + N_groups(class_SECOND)
    init_group
end


% ----------


% remaining Time between agent and door
remainingdistance = zeros(agentcount, doorcount);
remainingwalktime = zeros(agentcount, doorcount);
remainingqueuetime = zeros(agentcount, doorcount);
placeinqueue = ones(agentcount, doorcount);



% load statistic variables
init_statistics

%start simulation
simulation
