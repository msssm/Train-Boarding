start_compartment = 10*(ccoach-1)+1;
end_compartment = 10*ccoach;

for icompartment = start_compartment : end_compartment
    for iside = 1 : 2
        if trainseats(ctrain, icompartment, iside) < 4
          trainseats(ctrain, icompartment, iside) = trainseats(ctrain, icompartment, iside) + 1;
          free_seat_found = 1;
          return;
        end
    end
    
end
    