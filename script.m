addpath('./potentials');
addpath('./blends');
addpath('./walks');

% TODO: arbitrary 'walk' function (top left to bottom right, from center)

% ----- Image parameters
scale = 0.5;
% Image dimensions in pixels
w = 100 * scale;
h = 100 * scale;
iterations = 2;
% Less noise leads to more homogeneous images
noise = 0.01 / (2 * scale);
% Larger reach allows for stroke interpenetration
reach = [1 1];

usePotential = 0;
% Points used to generate the masking polygon (overall shape)
nPoints = 7;
useMask = 1;
useConvexHull = 1;

% ----- Color range
all = [0 1; 0 1; 0 1];
purple = 0.8 * [0 1; 0.3 0.3;  0.5 0.5];
pale = 1 * [0 1; 0.65 0.65;  0.88 0.88];
blueGrass = 1 * [0.35 0.35; 0.75 0.75;  0.2 1];
orange = 1 * [1 1; 0.58 0.58; 0 0.6];
colorRanges = purple;


% ----- Walk
points = lineWalk(w, h);
%points = polarWalk(w, h);


% ----- Image generator
functions = randomPainter(colorRanges, noise, reach);
%functions = constantColor([0.5 0.5 1]);


% ----- Base (zero state) image
%base = rand(h, w, 3);
%base = getColorGradient(w, h, 0.09);
%base = zeros(h, w, 3);
%base = ones(h, w, 3);
%base(1, 1, :) = rand(3, 1);
base = randInRange(w, h, colorRanges);

% ----- Potential function
if(usePotential)
	functions{4} = @(i, j) circular(w, h, i, j) .^ 5;
	%functions{4} = @(i, j) ellipsoid(w, h, 1.5, 0.5, i, j);
	%functions{4} = @(i, j) waves(w, h, 1, 3, i, j);
	%functions{4} = @(i, j) waves(w, h, 1, 3, i, j).^2;
	%functions{4} = @(i, j) modulo(w, h, 20, 20, i, j);
	%functions{4} = @(i, j) 1 - hyperboloid(w, h, 0.3, 0.8, i, j);
	%functions{4} = @(i, j) hyperboloid(w, h, 0.3, 0.8, i, j);
	%functions{4} = @(i, j) (1 - circular(w, h, i, j)) * 1 / (0.1 + hyperboloid(w, h, 0.3, 0.8, i, j));

	if(useMask)
		if(useConvexHull)
			points = getConvexPolygon(nPoints);
		else
			points = rand(nPoints, 2);
		end;
		mask = inPolygon(points, w, h);
		functions{4} = @(i, j) applyMask(mask, i, j);
	end;
	
	% ----- Potential application function
	functions{5} = @product;
	%functions{5} = @divide;
	%functions{5} = @(level, color) hsvBlend(2, level, color);
	%functions{5} = @(level, color) hsvBlend(1, level, color);
end;


% ----- Run
img = makeImage(base, points, functions, iterations);

% ----- Display
displayImage(img);