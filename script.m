addpath('./potentials')

% Image parameters
w = 50;
h = 50;
iterations = 5;
noise = 0.001;
reach = 2;

% TODO: arbitrary 'walk' function (top left to bottom right, from center)
% TODO: line levels

functions = randomPainter(noise, reach);
%functions = constantColor([0.5 0.5 1]);
functions{4} = @(i, j) circular(w, h, i, j);

img = makeImage(w, h, functions, iterations);
displayImage(img);