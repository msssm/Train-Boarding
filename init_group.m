% loop through all members of a group and init agent-values for XPOS,
% YPOS,GROUP and DECTIMES

for iagent = sagent:(sagent-1)+Size_group(igroup)
    % all agents of the group get grouped around a circle, that gets scaled
    % according to the number of people inside the group (10 people -> in
    % circle with diameter of 2 meters
    radius = Size_group(igroup)/10;
    % only master of group can decide
    if iagent ~= sagent
        agent(iagent, agentDECTIMES) = agentDECTIMESnone;
    else
        dspace = 1.5 * radius;
        set_agent_outside_of_any_obstacle;
        group_CENTER = agent(sagent, [agentXPOS, agentYPOS]);
    end
    agent(iagent, agentGROUP) = igroup;
    phi = 2*pi()*iagent/Size_group(igroup); % Angle to set group in a cyrcle
    agent(iagent, [agentXPOS, agentYPOS]) = group_CENTER + radius*[cos(phi), sin(phi)];
end
sagent = sagent + Size_group(igroup);
