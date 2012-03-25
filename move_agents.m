% move agents: a -> dv -> v -> ds -> s

for iagent = 1:agentcount
    dv = agent(iagent, [agentXFORCE, agentYFORCE])/agentmass;
    
    agent(iagent, [agentXVEL, agentYVEL]) = ...
        agent(iagent, [agentXVEL, agentYVEL]) + dv*dt;

    if norm(agent(iagent, [agentXVEL, agentYVEL])) > agent(iagent, agentMAXV)
		agent(iagent, [agentXVEL, agentYVEL]) = agent(iagent, [agentXVEL, agentYVEL]) / norm(agent(iagent, [agentXVEL, agentYVEL])) * agent(iagent, agentMAXV);
    end
    
    if agent(iagent, agentSTATE) == agentSTATEmoving
        ds = (agent(iagent, [agentXVEL, agentYVEL])) * dt;
    else
        ds = [0, 0];
    end
    
    % sum distance per agent
    stat_sum_distance(iagent) = stat_sum_distance(iagent) + norm(ds);
    
    agent(iagent, [agentXPOS, agentYPOS]) = agent(iagent, [agentXPOS, agentYPOS]) + ds;
end