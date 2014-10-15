addpath('./potentials')
addpath('./blends')

% TODO: arbitrary 'walk' function (top left to bottom right, from center)

% ----- Image parameters
scale = 0.5;
% Image dimensions in pixels
w = 100 * scale;
h = 200 * scale;
iterations = 3;
% Less noise leads to more homogeneous images
noise = 0.00001 / (2 * scale);
% Larger reach allows for stroke interpenetration
reach = 1;

usePotential = 0;
% Points used to generate the masking polygon (overall shape)
nPoints = 10;
useConvexHull = 0;


% ----- Image generator
% Select color range
all = [0 1; 0 1; 0 1];
purple = 0.8 * [0 1; 0.3 0.3;  0.5 0.5];
pale = 1 * [0 1; 0.65 0.65;  0.88 0.88];
blueGrass = 1 * [0.35 0.35; 0.75 0.75;  0.2 1];

colorRanges = blueGrass;
functions = randomPainter(colorRanges, noise, reach);
%functions = constantColor([0.5 0.5 1]);


% ----- Base (zero state) image
%base = rand(h, w, 3);
%base = getColorGradient(w, h);
%base = zeros(h, w, 3);
%base(1, 1, :) = rand(3, 1);
base = randInRange(w, h, colorRanges);

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