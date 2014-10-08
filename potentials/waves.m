function value = waves(w, h, tx, ty, i, j)
	cX = sin(tx * ((i / h) - 0.5));
	cY = cos(ty * ((j / w) - 0.5));
	value = cX + cY;
end
