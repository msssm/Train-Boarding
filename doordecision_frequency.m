% The frequency of redecision is checked
if agentDECstepfrequency <= 1
    if mod(step, 1/agentDECstepfrequency) < mod((step-1), 1/agentDECstepfrequency);
        Ndec = 0;
    else
        Ndec = 1;
    end
else
    if mod(step, agentDECstepfrequency) < mod((step-1), agentDECstepfrequency);
        Ndec = floor(agentDECstepfrequency) + 0;
    else
        Ndec = floor(agentDECstepfrequency) + 1;
    end
end

