addpath('./potentials')
addpath('./blends')

% ----- Image parameters
scale = 2.5;
% Image dimensions in pixels
w = 100 * scale;
h = 100 * scale;
% TODO: relate to scale?
iterations = 5;
% Less noise leads to more homogeneous images
noise = 0.0005 / (2 * scale);
% Larger reach allows for stroke interpenetration
reach = 2;
% Points used to generate the masking polygon (overall shape)
nPoints = 10;

usePotential = 0;

% TODO: arbitrary 'walk' function (top left to bottom right, from center)

% ----- Image generator
colorRanges = [
	0 1 % R
	0 1 % G
	0 1 % B
];
functions = randomPainter(colorRanges, noise, reach);
%functions = constantColor([0.5 0.5 1]);

% ----- Potential function
if(usePotential)
	%functions{4} = @(i, j) circular(w, h, i, j);
	%functions{4} = @(i, j) ellipsoid(w, h, 1.5, 0.5, i, j);
	%functions{4} = @(i, j) waves(w, h, 1, 3, i, j);
	%functions{4} = @(i, j) waves(w, h, 1, 3, i, j).^2;
	%functions{4} = @(i, j) modulo(w, h, 20, 20, i, j);
	%functions{4} = @(i, j) 1 - hyperboloid(w, h, 0.3, 0.8, i, j);
	%functions{4} = @(i, j) hyperboloid(w, h, 0.3, 0.8, i, j);

	%points = rand(nPoints, 2);
	points = getConvexPolygon(nPoints);
	mask = inPolygon(points, w, h);
	functions{4} = @(i, j) applyMask(mask, i, j);

	% ----- Potential application function
	functions{5} = @product;
	%functions{5} = @divide;
	%functions{5} = @(level, color) hsvBlend(2, level, color);
	%functions{5} = @(level, color) hsvBlend(1, level, color);
end;

% ----- Run
img = makeImage(w, h, functions, iterations);

% ----- Display
displayImage(img);