 % save data
        % (mean) waiting time (standing still time)
        % Actiontime (deboard -> board again)
        % distance (int(ds)) und minimale Strecke (euclid-distance:startend)
        % Doordecision-changes (per person and per timestep)
        % in/out-door (per person)
        % Anteil laufende / Anteil wartende (per timestep)
        % durchschnittsgeschwindigkeit
 

stat_moving_agents(step) = sum(agent(:,agentSTATE)==agentSTATEmoving);

for iagent = 1 : agentcount
    if agent(iagent, agentSTATE) == agentSTATEmoving
        % calculate average distance
        stat_distance_to_go(step) = stat_distance_to_go(step) + (remainingdistance(iagent, agent(iagent,agentCDOOR))/stat_moving_agents(step));
        
        
        % count waiting agents
        if (remainingdistance(iagent, agent(iagent, agentCDOOR)) < 3*doorrange)
            % Differentiate between boarder and deboarder
            if agent(iagent, agentMODE) == agent_mode_enter_subway
                stat_waiting_agents(step,1) = stat_waiting_agents(step,1) + 1;
            else
                stat_waiting_agents(step,2) = stat_waiting_agents(step,2) + 1;
            end
                stat_sum_waiting(iagent) = stat_sum_waiting(iagent) + dt;
            else
        end

        % calculate min distance between startposition and heading door
        stat_min_distance(iagent) = norm(stat_start_position(iagent, :) - door(agent(iagent, agentCDOOR), [doorXPOS, doorYPOS]));
    end
end

for kdoor = 1:doorcount
    for iagent = 1:agentcount
        if (agent(iagent,agentSTATE) == agentSTATEmoving) && (agent(iagent,agentCDOOR) == kdoor)
            stat_approaching_to_door(step,kdoor) = stat_approaching_to_door(step,kdoor) + 1;
        end
    end
end

% if all agents boarded, save the time:
if (sum(agent(agent(:, agentMODE) ~= agent_mode_enter_subway, agentSTATE) ~= agentSTATEboarded) == 0) ...
        && (final_boarding_time == 0)
    final_boarding_time = t;
end

stat_boarded_per_door(step,:) = door(:, doorAGENT);
