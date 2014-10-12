function mask = inPolygon(points, w, h)
% points An n x 2 matrix of point coordinates taken in [0, 1]
% The ordering is significant
% Returns the mask giving the value corresponding to each pixel
	xPoints = w * points(:, 1);
	yPoints = h * points(:, 2);
	
	[xGrid, yGrid] = meshgrid(1:w, 1:h);
	xGrid = reshape(xGrid, numel(xGrid), 1);
	yGrid = reshape(yGrid, numel(yGrid), 1);
	
	indices = inpolygon(xGrid, yGrid, xPoints, yPoints);
	mask = zeros(h, w); % Mask is used as mask(i, j)
	in = reshape(indices, w, h)';
	mask(in) = 1;
end

