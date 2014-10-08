function value = hyperboloid(w, h, a, b, i, j)
	cX = ((i / h) - 0.5);
	cY = ((j / w) - 0.5);
	value = (cX/a)^2 - (cY/b)^2;
end

