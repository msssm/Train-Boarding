% agent's state update (board, deboard: status change)

% check if agent can debord
if agent(iagent, agentSTATE) == agentSTATEdeboarding;
    ldoor = agent(iagent, agentLDOOR);
    if door(ldoor, doorSTATE) <= 0;
        % let agent debord
        agent(iagent, agentSTATE) = agentSTATEmoving;
        stat_moving_time(iagent, stat_movSTART) = t;
        % block door for a moment
        door(ldoor, doorSTATE) = 1/(door(ldoor, doorMEANFREQ)+...
            randn(1)*door(ldoor, doorVARFREQ));
        % decrease counter of people left in door
        door(ldoor, doorAGENT) = door(ldoor, doorAGENT) - doorAGENTdebord;
    end
end

% check if agent can bord
if agent(iagent, agentSTATE) == agentSTATEmoving;
    cdoor = agent(iagent, agentCDOOR);
    if remainingdistance(iagent, cdoor) < doorrange & ...
            door(cdoor, doorSTATE) < 0
        % check whether there is a free seat in this coach
        agent_seat_search;
        if free_seat_found == 1
            % let agent board
            agent(iagent, agentSTATE) = agentSTATEboarded;
            stat_moving_time(iagent, stat_movEND) = t;
            stat_sum_distance(iagent) = stat_sum_distance(iagent) + norm(agent(iagent, [agentXPOS, agentYPOS]) - door(agent(iagent, agentCDOOR), [doorXPOS, doorYPOS]));
            % block door for a moment
            door(cdoor, doorSTATE) = 1/(door(cdoor, doorMEANFREQ)+...
                randn(1)*door(cdoor, doorVARFREQ));
            % increase counter of people borded
            door(cdoor, doorAGENT) = door(cdoor, doorAGENT) + doorAGENTbord;
        else
            % lock the door
            door(cdoor, doorACTIVITY) = doorINACTIVE;
            % give the agent a chance to possibly redecide for a new door
            if agent(iagent, agentDECTIMES) == agentDECTIMESnone
                agent(iagent, agentDECTIMES) = 1;
            end
        end
    end
end
