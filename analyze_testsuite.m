test_case_count = 36;
sample_count = 5;

for Testcase = 1:test_case_count
    datestr(now)
    Testcase

    % create file header
    value_names = {'final_boarding_time mean_boarding_time	std_dev_boarding_time   mean_distance	std_dev_distance	mean_waiting_time	std_dev_waiting_time	mean_decisions	std_dev_decisions	std_dev_boarded_per_door	unboarded'};
    dlmwrite(strcat('results/textfiles/analyzed/', int2str(Testcase), '.txt'),strcat('Testcase Nr. ', int2str(Testcase)), 'delimiter', '');
    dlmwrite(strcat('results/textfiles/analyzed/', int2str(Testcase), '.txt'),value_names(1), 'delimiter', '','-append');
    
    for isample = 1:sample_count
        isample
        %clear('global')
        load(strcat('results/workspace/', int2str(Testcase), '_', int2str(isample), '.mat'));
        
        % collect single value results
        moving_agents = (agent(:,agentSTATE) ~= agentSTATEmoving)
        boarding_agents = (agent(:,agentMODE) ~= agent_mode_enter_subway)
        selected_agents = (boarding_agents & moving_agents)

        final_boarding_time = max(stat_moving_time(selected_agents,stat_movEND))
        mean_boarding_time = mean(stat_moving_time(selected_agents,stat_movEND) - stat_moving_time(selected_agents,stat_movSTART))
        stddev_boarding_time = std(stat_moving_time(selected_agents,stat_movEND) - stat_moving_time(selected_agents,stat_movSTART))
        mean_distance = mean(stat_sum_distance(selected_agents,1))  
        stddev_distance = std(stat_sum_distance(selected_agents,1)) 
        mean_waiting_time = mean(stat_sum_waiting(selected_agents,1))  
        stddev_waiting_time = std(stat_sum_waiting(selected_agents,1))  
        mean_decision = mean(stat_sum_decision(selected_agents,1))
        stddev_decision = std(stat_sum_decision(selected_agents,1))  
        stddev_boarded_per_door = std(stat_boarded_per_door(step,door(:,doorMODE) ~= agent_mode_enter_subway))
        unboarded = sum(agent(:,agentSTATE) == agentSTATEmoving)
        dlmwrite(strcat('results/textfiles/analyzed/', int2str(Testcase), '.txt'), [final_boarding_time, mean_boarding_time, stddev_boarding_time, mean_distance, stddev_distance, mean_waiting_time, stddev_waiting_time, mean_decision, stddev_decision, stddev_boarded_per_door, unboarded], 'delimiter', '\t','-append');
        
    end
end

