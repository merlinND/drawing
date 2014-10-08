function value = applyPotential(potential, x, y, color)
% potential: Function(x, y) => [0, 1]
	% TODO: make customizable
	nLevels = 5;

	level = discretize(potential(x, y), nLevels);
	value = level * color;
end

function level = discretize(value, levels)
	level = round(value * levels) / levels;
end