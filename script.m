addpath('./potentials')
addpath('./blends')

% TODO: arbitrary 'walk' function (top left to bottom right, from center)

% ----- Image parameters
scale = 2;
% Image dimensions in pixels
w = 100 * scale;
h = 100 * scale;
iterations = 1;
% Less noise leads to more homogeneous images
noise = 0.1 / (2 * scale);
% Larger reach allows for stroke interpenetration
reach = 2;

usePotential = 0;
% Points used to generate the masking polygon (overall shape)
nPoints = 10;
useConvexHull = 0;

% ----- Base (zero state) image
%base = rand(w, h, 3);
base = getColorGradient(w, h);
%base = zeros(h, w, 3);
%base(1, 1, :) = rand(3, 1);


% ----- Image generator
% Select color range
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

	if(useConvexHull)
		points = getConvexPolygon(nPoints);
	else
		points = rand(nPoints, 2);
	end;
	mask = inPolygon(points, w, h);
	functions{4} = @(i, j) applyMask(mask, i, j);

	% ----- Potential application function
	functions{5} = @product;
	%functions{5} = @divide;
	%functions{5} = @(level, color) hsvBlend(2, level, color);
	%functions{5} = @(level, color) hsvBlend(1, level, color);
end;


% ----- Run
img = makeImage(base, functions, iterations);

% ----- Display
displayImage(img);