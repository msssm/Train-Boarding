hold on
plot(1:agentcount, (agent(:, agentSTATE) == agentSTATEmoving) .* stat_sum_decision, 'b.')
plot(1:agentcount, (agent(:, agentSTATE) == agentSTATEboarded) .* stat_sum_decision, 'g.')
plot_separation_lines;
legend('moving', 'boarded')
hold off
xlabel('agent')
ylabel('redecisions')
