addpath('./potentials')
addpath('./blends')

% Image parameters
w = 100;
h = 100;
iterations = 5;
noise = 0.001;
reach = 2;
% Points used to generate the convex polygon (overall shape)
nPoints = 10;

% TODO: arbitrary 'walk' function (top left to bottom right, from center)

% ----- Image generator
functions = randomPainter(noise, reach);
%functions = constantColor([0.5 0.5 1]);

% ----- Potential function
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

% ----- Run
img = makeImage(w, h, functions, iterations);

% ----- Display
displayImage(img);