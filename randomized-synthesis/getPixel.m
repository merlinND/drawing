function pixel = getPixel(img, i, j, k)
% Handles boundary conditions
% TODO: experiment with different boundary conditions
	coordinates = min([i j k], size(img));
	coordinates = max(coordinates, [1 1 1]);
	pixel = img(coordinates(1), coordinates(2), coordinates(3));
end