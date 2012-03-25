% initialistation of saved statistic data
%--------
% Arrays for saving data
%--------

% # agents heading to spec. door
stat_approaching_to_door = zeros(stepcount,doorcount);
% # agents on platform
stat_moving_agents = zeros(stepcount, 1);
% mean distance of all moving agents to their door
stat_distance_to_go = zeros(stepcount, 1);
% # agents boarded on spec. door
stat_boarded_per_door = zeros(stepcount, doorcount);
% start end end time of moving
stat_moving_time = zeros(agentcount, 2);
    stat_movSTART = 1;
    stat_movEND = 2;
% # agents waiting in queue
stat_waiting_agents = zeros(stepcount, 2);
% sum. waiting time
stat_sum_waiting = zeros(agentcount, 1);
% walking distance per agent
stat_sum_distance = zeros(agentcount, 1);
% min. distance between leavingdoor and chosendoor
stat_min_distance = zeros(agentcount, 1);
% startpostion (is needed to calculate stat_min_distance
stat_start_position = zeros(agentcount, 2); % set in simulation.m
% sum of redecicions
stat_sum_decision = zeros(agentcount, 1);



