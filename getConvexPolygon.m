function points = getConvexPolygon(nPoints)
% points An n x 2 matrix of point coordinates taken in [0, 1]
% Note that the convex polygon is generated from the convex hull
% of nPoints points. The hull may contain less that nPoints.
	x = rand(nPoints, 1);
	y = rand(nPoints, 1);
	indices = convhull(x, y);
	
	points = [x(indices) y(indices)];
end