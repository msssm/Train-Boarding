 % move agent randomly inside the StartArea until a minimal distance of ...
 % 'dspace' to every other obstacle and the border of the startarea is garanteed 

 % Consider also, that a person will not start from a position too far from
 % its desteny, i.e. that a first-class passenger is rather startig from a
 % point not so far from the nearest first-class entrance.

%agent(iagent, agentXPOS) = obstacle(oSTARTAREA, obstacleXCENTER) - obstacle(oSTARTAREA, obstacleWIDTH)/2 + ...
%    (obstacle(oSTARTAREA, obstacleWIDTH)-2*dspace)*rand(1,1)+dspace;
%agent(iagent, agentYPOS) = obstacle(oSTARTAREA, obstacleYCENTER) - obstacle(oSTARTAREA, obstacleHEIGHT)/2 + ...
%    (obstacle(oSTARTAREA, obstacleHEIGHT)-2*dspace)*rand(1,1)+dspace;

is_agentPOSok = 0;
while is_agentPOSok == 0
    agent(iagent, agentXPOS) = obstacle(oSTARTAREA, obstacleXCENTER) - obstacle(oSTARTAREA, obstacleWIDTH)/2 + ...
        (obstacle(oSTARTAREA, obstacleWIDTH)-2*dspace)*rand(1,1)+dspace;
    agent(iagent, agentYPOS) = obstacle(oSTARTAREA, obstacleYCENTER) - obstacle(oSTARTAREA, obstacleHEIGHT)/2 + ...
        (obstacle(oSTARTAREA, obstacleHEIGHT)-2*dspace)*rand(1,1)+dspace;

    is_agentPOSok = 1;  % assuming pos is ok
    
    % Check if agent ist not too far away from its nearest possible door
    for idoor = 1:doorcount
		remainingdistance(iagent, idoor) = norm(agent(iagent, [agentXPOS, agentYPOS]) - door(idoor, [doorXPOS, doorYPOS]));
	end
    min_remainingdistance_MODE = min(remainingdistance(iagent, door(:, doorMODE) == agent(iagent, agentMODE)));
    if min_remainingdistance_MODE > border(3)/4     % more than quarter scene?
        is_agentPOSok = 0;
        
    end
    
    % now check for obstacles
    for iobstacle = 1:obstaclecount
        if iobstacle ~= oSTARTAREA   % dont check start area
            if agent(iagent, agentXPOS) > (obstacle(iobstacle, obstacleXCENTER) - obstacle(iobstacle, obstacleWIDTH)/2 - dspace)
                if agent(iagent, agentXPOS) < (obstacle(iobstacle, obstacleXCENTER) + obstacle(iobstacle, obstacleWIDTH)/2 + dspace)
                    if agent(iagent, agentYPOS) > (obstacle(iobstacle, obstacleYCENTER) - obstacle(iobstacle, obstacleHEIGHT)/2 - dspace)
                        if agent(iagent, agentYPOS) < (obstacle(iobstacle, obstacleYCENTER) + obstacle(iobstacle, obstacleHEIGHT)/2 + dspace)
                            is_agentPOSok = 0;   % Position was NOT ok
                            %agent(iagent, agentXPOS) = obstacle(oSTARTAREA, obstacleXCENTER) - obstacle(oSTARTAREA, obstacleWIDTH)/2 + ...
                            %    (obstacle(oSTARTAREA, obstacleWIDTH)-2*dspace)*rand(1,1)+dspace;
                            %agent(iagent, agentYPOS) = obstacle(oSTARTAREA, obstacleYCENTER) - obstacle(oSTARTAREA, obstacleHEIGHT)/2 + ...
                            %    (obstacle(oSTARTAREA, obstacleHEIGHT)-2*dspace)*rand(1,1)+dspace;
                        end
                    end
                end
            end
        end
    end
end


    
    