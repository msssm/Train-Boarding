
dimension = axis;
for iclass = 1 : class_count
    for itype = 1 : agent_type_count
        plot([agent_part_sum(iclass,itype),agent_part_sum(iclass,itype)],[dimension(3), dimension(4)],'k');
    end
end
