function value = applyPotential(potential, mix, x, y, color)
% potential: Function(x, y) => [0, 1]
% mix: Function(level, rgbColor) => rgbColor

	% TODO: make customizable
	nLevels = 5;

	level = discretize(potential(x, y), nLevels);
	
	% Apply potential as a direct product
	value = mix(level, color);
end

function level = discretize(value, levels)
	level = round(value * levels) / levels;
end