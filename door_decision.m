% choose best door for the current moving agents

for idec = 1:Ndec   
    if agent(iagent,agentSTATE) == agentSTATEmoving
        if agent(iagent, agentDECTIMES) ~= agentDECTIMESnone
             placeinqueue(iagent, :) = ones(1, doorcount);
             for kagent = 1:agentcount
                 if agent(kagent,agentSTATE) == agentSTATEmoving
                     kdoor = agent(kagent,agentCDOOR);
                     if(remainingdistance(kagent,kdoor) < remainingdistance(iagent,kdoor))
                         % agents in the same group are not considered
                         if ((agent(kagent, agentGROUP) ~= agent(iagent, agentGROUP)) || (agent(iagent, agentGROUP) == agentGROUPnone))
                             placeinqueue(iagent, kdoor) = placeinqueue(iagent, kdoor) + 1;
                         end
                     end
                 end
             end

             % calculate expected remaining time
             for idoor = 1:doorcount
                 if ((agent(iagent, agentMODE) == door(idoor, doorMODE)) && (agent(iagent, agentLDOOR) ~= idoor) && (door(idoor,doorACTIVITY) == doorACTIVE))
                     remainingwalktime(iagent, idoor) = remainingdistance(iagent, idoor) / agent(iagent, agentMAXV);
                     remainingqueuetime(iagent, idoor) = placeinqueue(iagent, idoor)/door(idoor, doorMEANFREQ);
                 else
                     remainingwalktime(iagent, idoor) = 9999; %%%%%%% NOT PROPER
                     remainingqueuetime(iagent, idoor) = 9999999; %%%%%% NEITHER
                 end
             end

             % prefer current decision with the patient factor
             remainingwalktime(iagent, agent(iagent, agentCDOOR)) = remainingwalktime(iagent, agent(iagent, agentCDOOR)) * (agent(iagent, agentPATIENT));
             remainingqueuetime(iagent, agent(iagent, agentCDOOR)) = (remainingqueuetime(iagent, agent(iagent, agentCDOOR))) * (agent(iagent, agentPATIENT));

             % Choose appropriate door (depending choosing-mode)
             switch agent(iagent, agentDMODE)
                 case agentDMODEsum_lazy
                     [remainingtime(iagent), newdoor] = min(remainingwalktime(iagent, :)*agent(iagent, agentLAZY) + remainingqueuetime(iagent, :)*(1-agent(iagent, agentLAZY)));
                 case agentDMODEsum
                     [remainingtime(iagent), newdoor] = min(remainingwalktime(iagent, :) + remainingqueuetime(iagent, :));
                 case agentDMODEwalk
                     [remainingtime(iagent), newdoor] = min(remainingwalktime(iagent, :));
                 case agentDMODEqueue
                     [remainingtime(iagent), newdoor] = min(remainingqueuetime(iagent, :));
                 case agentDMODEwait
                     [remainingtime(iagent), newdoor] = min(abs(remainingqueuetime(iagent, :) - remainingwalktime(iagent, :)));
                 case agentDMODErandom
                     [remainingtime(iagent), newdoor] = max(rand(doorcount,1) .* (remainingwalktime(iagent, :)' < 9000*ones(doorcount,1)));
             end


             if agent(iagent, agentCDOOR) ~= newdoor
                 % decrease number of possible redicisiontimes left
                 if agent(iagent, agentDECTIMES) ~= agentDECTIMESinfinite;
                     agent(iagent, agentDECTIMES) = agent(iagent, agentDECTIMES) - 1;
                 end
                 % All members of a group to the same door
                 igroup = agent(iagent, agentGROUP);
                 if (igroup ~= agentGROUPnone)
                     agent(agent(:, agentGROUP)==igroup, agentCDOOR) = newdoor;
                     stat_sum_decision(agent(:, agentGROUP)==igroup) = stat_sum_decision(agent(:, agentGROUP)==igroup) + 1;
                 else
                     agent(iagent, agentCDOOR) = newdoor;
                     stat_sum_decision(iagent) = stat_sum_decision(iagent) + 1;
                 end
             end
        end
    end
end
