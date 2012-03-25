% let train drive into its final position before the doors open

if step == 1
    % set initial position of train and doors
    obstacle(1:traincount, obstacleXCENTER) = obstacle(1:traincount, obstacleXCENTER) - DOORS_DELAY * trainVELOCITY;
    door(door(:,doorMODE) ~= agent_mode_enter_subway, doorXPOS) = door(door(:,doorMODE) ~= agent_mode_enter_subway, doorXPOS) - DOORS_DELAY * trainVELOCITY;
end
obstacle(1:traincount, obstacleXCENTER) = obstacle(1:traincount, obstacleXCENTER) + dt * trainVELOCITY;
door(door(:,doorMODE) ~= agent_mode_enter_subway, doorXPOS) = door(door(:,doorMODE) ~= agent_mode_enter_subway, doorXPOS) + dt * trainVELOCITY;