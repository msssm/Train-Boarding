% calculate the resulting force acting on "iagent"

% temporary sum of forces
agentforce = [0,0];
doorforce = [0,0];
obstacleforce = [0,0];
% people attraction and retraction
for kagent = 1:agentcount
    if (kagent ~= iagent & agent(kagent, agentSTATE) == agentSTATEmoving)
        vec_agentdist = agent(kagent, [agentXPOS, agentYPOS]) - ...
            agent(iagent, [agentXPOS, agentYPOS]);
        norm_agentdist = norm(vec_agentdist);
        
        % group people keep more together
        if (agent(iagent, agentGROUP) == agent(kagent, agentGROUP) & ...
                agent(iagent, agentGROUP) > 0)
            strength = FORCES_COEFF(FC_agentAttractionGroup);
        else
            strength = FORCES_COEFF(FC_agentAttraction);
        end
        
        agentforce = agentforce - strength/(norm_agentdist)^3 ...
            * vec_agentdist/norm_agentdist;
        % agent attraction
        agentforce = agentforce + (strength/agentspace)/(norm_agentdist^2) ...
            * vec_agentdist/norm_agentdist;
    end
end

% Door attraction and retraction
vec_doordist = door(agent(iagent, agentCDOOR), [doorXPOS, doorYPOS]) - ...
    agent(iagent, [agentXPOS, agentYPOS]);
norm_doordist = norm(vec_doordist);

% door attraction
doorforce = vec_doordist/norm_doordist;
% door retraction while occupied
if door(agent(iagent, agentCDOOR), doorSTATE) > 0
    doorforce = doorforce - doorrange/norm_doordist * ...
        vec_doordist/norm_doordist;
end
doorforce = doorstrength * doorforce;


% Obstacle retraction
for kobstacle = 1:obstaclecount
iforce = [0,0];

    if obstacle(kobstacle,obstacleSTART) <= t && obstacle(kobstacle,obstacleEND) >= t
        agentx = agent(iagent, agentXPOS);
        agenty = agent(iagent, agentYPOS);
        obstaclex = obstacle(kobstacle, obstacleXCENTER);
        obstacley = obstacle(kobstacle, obstacleYCENTER);
        obstaclew = obstacle(kobstacle, obstacleWIDTH);
        obstacleh = obstacle(kobstacle, obstacleHEIGHT);
        %if inside obstacle
        if (abs(agentx - obstaclex) < obstaclew/2) && (abs(agenty - obstacley) < obstacleh/2)

            mindistance = max([obstaclew, obstacleh]);
            closestwall = 0;
            for idir = 1:4
                % orthogonal distance to the closest wall
                distance = abs(xdir(idir)) * abs(obstaclex+xdir(idir)*obstaclew/2 - agentx) + abs(ydir(idir)) * abs(obstacley+ydir(idir)*obstacleh/2 - agenty);
                                
                if mindistance > distance
                    mindistance = distance;
                    closestwall = idir;
                end
            end
            
            iforce(1) = (-xdir(closestwall)*obstacle(kobstacle,obstacleRANGE))/mindistance;
            iforce(2) = (-ydir(closestwall)*obstacle(kobstacle,obstacleRANGE))/mindistance;
            
            obstacleforce = obstacleforce + iforce;
                   
        %outside of the obstacle
        else
            xdelta = 0; ydelta = 0;
            if agentx > obstaclex + obstaclew/2
                xdelta = 1;
            end
            if agentx < obstaclex - obstaclew/2
                xdelta = -1;
            end
            if agenty > obstacley + obstacleh/2
                ydelta = 1;
            end
            if agenty < obstacley - obstacleh/2
                ydelta = -1;
            end
            
            edge = [0,0];
   
            %nearest point is an edge
            if (xdelta ~= 0) && (ydelta ~= 0)
                edge(1) = obstaclex + xdelta*obstaclew/2;
                edge(2) = obstacley + ydelta*obstacleh/2;
             
            %neares point is a side
            else
                if xdelta ~= 0
                    edge(1) = obstaclex + xdelta*obstaclew/2;
                    edge(2) = agenty;
                else
                    edge(1) = agentx;
                    edge(2) = obstacley + ydelta*obstacleh/2;
                end
            end
            
            %calculate distance and resulting force
            vec_diff = agent(iagent, [agentXPOS, agentYPOS]) - edge;
            iforce = vec_diff/norm(vec_diff) * obstacle(kobstacle,obstacleRANGE)/norm(vec_diff);
            obstacleforce = obstacleforce + iforce;

        end
    end
end

% Correction Force (helps to avoid obstacles)
if (abs(doorforce(1) + obstacleforce(1)) < 1000  && remainingdistance(iagent, agent(iagent, agentCDOOR)) > 5*doorrange) ...
    % "cross product" between obstacleforce and doorforce
    cross_OxD = obstacleforce(1)*doorforce(2)-obstacleforce(2)*doorforce(1);
    orth_O = obstacleforce*[0, -1; 1, 0];
    %orth_O = [obstacleforce(2), -obstacleforce(1)];
    corrforce = sign(cross_OxD) * 999999999*orth_O;  %very high
    % For Agents entering Train inverse way round
    if agent(iagent, agentMODE) ~= agent_mode_enter_subway;
        corrforce = -corrforce;
    end
else
    corrforce = [0, 0];
end

agent(iagent, [agentXFORCE, agentYFORCE]) = doorforce + agentforce + obstacleforce + corrforce;
