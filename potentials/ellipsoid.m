function value = ellipsoid(w, h, ri, rj, i, j)
	cX = ri * ((i / h) - 0.5);
	cY = rj * ((j / w) - 0.5);
	value = 1 - sqrt(cX^2 + cY^2);
end

