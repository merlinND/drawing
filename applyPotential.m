function value = applyPotential(potential, x, y, color)
% potential: Function(x, y) => [0, 1]
	level = discretize(potential(x, y), 2);	
	value = level * color;
end

function level = discretize(value, levels)
	level = round(value * levels) / levels;
end