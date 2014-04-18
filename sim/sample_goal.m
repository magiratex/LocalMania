function pos = sample_goal(goal)

pos = mvnrnd(goal.pos, goal.afford);