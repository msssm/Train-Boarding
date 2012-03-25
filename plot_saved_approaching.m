hold on
if(1 <= doorMODEsum)
    plot(timevector, stat_approaching_to_door(1:step, door(:, doorMODE)==1), '-')
end
if(2 <= doorMODEsum)
    plot(timevector, stat_approaching_to_door(1:step, door(:, doorMODE)==2), '-.')
end
if(3 <= doorMODEsum)
    plot(timevector, stat_approaching_to_door(1:step, door(:, doorMODE)==3), '--')
end
if(4 <= doorMODEsum)
    plot(timevector, stat_approaching_to_door(1:step, door(:, doorMODE)==4), ':')
end
if(5 <= doorMODEsum)
    plot(timevector, stat_approaching_to_door(1:step, door(:, doorMODE)==5), '-')
end
xlabel('time')
ylabel('# approaching')
hold off