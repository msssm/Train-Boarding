hold on
plot(1:agentcount, (agent(:, agentSTATE) == agentSTATEmoving) .* stat_sum_distance, 'b.')
plot(1:agentcount, (agent(:, agentSTATE) == agentSTATEboarded) .* stat_sum_distance, 'g.')
plot(1:agentcount, stat_min_distance, 'r.')
plot_separation_lines;
legend('moving', 'boarded', 'minimal-dist')
hold off
xlabel('agent')
ylabel('distance walked')
