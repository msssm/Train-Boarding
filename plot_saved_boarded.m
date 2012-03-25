plot(timevector, (stat_boarded_per_door(1:step, :) > 0) .* stat_boarded_per_door(1:step, :))
xlabel('time')
ylabel('# boarded')
