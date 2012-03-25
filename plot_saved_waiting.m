plot(timevector, stat_waiting_agents(1:step, :))
hold on
plot(timevector, sum(stat_waiting_agents(1:step, :)')', 'r')
hold off
legend('to subway', 'to train', 'sum')
xlabel('time')
ylabel('# waiting')
