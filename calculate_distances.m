% calculate the all pairs of distances between any person and any door

for iagent = 1:agentcount
	for idoor = 1:doorcount
		remainingdistance(iagent, idoor) = norm(agent(iagent, [agentXPOS, agentYPOS]) - door(idoor, [doorXPOS, doorYPOS]));
	end
end		
