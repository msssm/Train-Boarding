hold on
plot(1:agentcount, (agent(:, agentSTATE) == agentSTATEmoving) .* stat_sum_waiting, 'b.')
plot(1:agentcount, (agent(:, agentSTATE) == agentSTATEboarded) .* stat_sum_waiting, 'g.')
plot_separation_lines;
legend('moving', 'boarded')
hold off
xlabel('agent')
ylabel('time waited')
