% In this script, constants (valid for every scene) are defined

%set people (position, goal), doors (size, frequency, capacity), obstacles
%(rectangle position, size, inside/outisde, active/inactive), 

% To identify the column of the "people" Matrix,
% those indices are represented by these variables
 agentXPOS = 1;      % 1st column: x-position in meters
 agentYPOS = 2;      % 2nd col.: y-position in meters
 agentXVEL = 3;      % x-velocity in meters
 agentYVEL = 4;      % y-velocity in meters
 agentXFORCE = 5;    % Force acting on agent
 agentYFORCE = 6;    % ditto
 agentMODE = 7;      % Mode: Defines the mode of possible doordecision
 agentSTATE = 8;     % current state
    agentSTATEdeboarding = -1;
    agentSTATEmoving = 0;
    agentSTATEboarded = 1;
 agentLDOOR = 9;     % Leaving door
 agentCDOOR = 10;     % current chosen door for bording
 agentMAXV = 11;      % Maximal velocity
 agentPATIENT = 12;  % privilege factor for current door
 agentLAZY = 13;     % balance between movingtime (lazy) and queuetime (1-lazy)
 agentDMODE = 14;    % Mode of deciding for leaving door
    agentDMODEsum_lazy = 1;  % minimum sum of walk(lazy) + queue(1-lazy)
    agentDMODEsum = 2;  % agent decides for minimum sum of walk+queue
    agentDMODEwalk = 3; % agent decides for minimum walk
    agentDMODEqueue = 4;    % agent decides for minimum queue
    agentDMODEwait = 5; % minimum difference between walk and queue
    agentDMODErandom = 6;   % agent chooses randomly
 agentDECTIMES = 15; % Max. times of redecision
    agentDECTIMESnone = 0;
    agentDECTIMESinfinite = -1;
 agentGROUP = 16;    % 0 is independent
    agentGROUPnone = 0;
% Amount of columns for agent
 agentCOLCOUNT = agentGROUP;

% columns of "door" Matrix represent:
 doorXPOS = 1;        % 1st column: x-position in meters
 doorYPOS = 2;        % y-position
 doorMODE = 3;         % identifies a certain "group" of doors.
                            % can only be entered by people with same mode
 doorSTATE = 4;       % current time left, til next agent can enter
 doorMEANFREQ = 5;    % mean frequency of people entering
 doorVARFREQ = 6;     % variation of frequency
 doorACTIVITY = 7;     % state of the door (gets set to inactive if coach full)
    doorINACTIVE = 0;
    doorACTIVE = 1;
 doorAGENT = 8;       % amount of people enterred the door
                            % (negativ, while people still debording)
    doorAGENTbord = 1;
    doorAGENTdebord = -1;
% Amount of columns for door
 doorCOLCOUNT = doorAGENT;

% columns of "obstacle" Matrix represents:
 obstacleXCENTER = 1;
 obstacleYCENTER = 2;
 obstacleWIDTH = 3;
 obstacleHEIGHT = 4;
 obstacleSTART = 5;     % time value, when obstacle starts to be activated
 obstacleEND = 6;       % time value, when obstacle stops being activated
 obstacleRANGE = 7;     % distance in meters where the retracting force has abs = 1 
 obstaclePASSABLE = 8;  % should agents be able to move trough the obstacle borders

 % Amount of columns for obstacle
 obstacleCOLCOUNT = obstaclePASSABLE;
 
 % Direction iteration arrays (East, North, West, South)
 xdir = [1,0,-1,0];
 ydir = [0,1,0,-1];
 
 % Plotting Modes
 plotMAPview = 1;
 plotGRAPHview = 2;
 plotDEFAULT = 3;
 
 % Video Recording
 videoOFF = 0;
 videoON = 1;
 
 % Data Export
 data_export_OFF = 0;
 data_export_ON = 1;
 
 % time when last person boarded
 final_boarding_time = 0;
 
 % train entrance velocity
 trainVELOCITY = 3;
 
 % simulation modes
 simulationMODEtest = 0;
 simulationMODEonetrain = 1;
 simulationMODEtwotrains = 2;
 