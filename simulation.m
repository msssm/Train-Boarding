% simulation

% set deboarding agents on the doorpoint
for iagent = 1:agentcount
    if agent(iagent, agentSTATE) == agentSTATEdeboarding
        agent(iagent, [agentXPOS, agentYPOS]) = door(agent(iagent, agentLDOOR), [doorXPOS, doorYPOS]);
    end
    stat_start_position(iagent, :) = agent(iagent, [agentXPOS, agentYPOS]);
end

%timestep iteration
for step = 1:stepcount
    t = step*dt;

    if t <= DOORS_DELAY
        train_entrance;
    end
    % random order for agents
    order = randperm(agentcount);
    doordecision_frequency;
    % decrement door state ("blocking" time)
    door(:,doorSTATE) = door(:,doorSTATE) - dt*ones(doorcount,1);
    calculate_distances;

    for i = 1:agentcount
        iagent = order(i);
        % people update in random order (board, deboard, status change)
        agent_update
        if agent(iagent, agentSTATE) == agentSTATEmoving
            door_decision;
            calculate_forces;
        end
    end
    % move agents simultaneously
    move_agents
        
    % draw
    paint
    video_capture
    pause(0.02)
    save_data
    data_export
       
end

                