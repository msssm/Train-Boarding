% tries to find a free seat for iagent starting from its current chosen
% door

% important note: this file is specifically designed for the two train
% station layouts and needs to be updated if any door-configuration gets
% changed
free_seat_found = 0;
% making szenario-specific-separations
if simulation_mode == simulationMODEonetrain
    if cdoor <= 2
        free_seat_found = 1;
        return;
    end
    % each door of second class coach and bistro wagon
    ctrain = 1;
    if (cdoor <= 9)
        ccoach = (cdoor - mod(cdoor+1,2) - 1) / 2;
    % first class coaches
    else
        ccoach = (cdoor - mod(cdoor,2)) / 2;
    end
end

if simulation_mode == simulationMODEtwotrains
    if cdoor <= 3
        free_seat_found = 1;
        return;
    end
    % each door of second class coach and bistro wagon
    if (cdoor <= 10)
        ctrain = 1;
        ccoach = (cdoor - mod(cdoor,2) - 2) / 2;
    % first class coaches
    elseif (cdoor <= 14)
        ctrain = 1;
        ccoach = (cdoor - mod(cdoor+1,2) -1) / 2;
   
    elseif (cdoor <= 21)
        ctrain = 2;
        ccoach = (cdoor - mod(cdoor+1,2) -1) / 2 - 6;
    else
        ctrain = 2;
        ccoach = (cdoor - mod(cdoor,2)) / 2 - 6;
    end
      
end
coach_seat_search;
