addpath('./potentials')

% Image parameters
w = 100;
h = 100;
iterations = 5;
noise = 0.001;
reach = 2;

% TODO: arbitrary 'walk' function (top left to bottom right, from center)

functions = randomPainter(noise, reach);
%functions = constantColor([0.5 0.5 1]);
%functions{4} = @(i, j) ellipsoid(w, h, 1.5, 0.5, i, j);
%functions{4} = @(i, j) waves(w, h, 1, 3, i, j);
%functions{4} = @(i, j) waves(w, h, 1, 3, i, j).^2;
%functions{4} = @(i, j) modulo(w, h, 20, 20, i, j);
%functions{4} = @(i, j) 1 - hyperboloid(w, h, 0.3, 0.8, i, j);
%functions{4} = @(i, j) 1 - hyperboloid(w, h, 0.3, 0.8, i, j);

img = makeImage(w, h, functions, iterations);
displayImage(img);