function value = circular(w, h, i, j)
	cX = (i / h) - 0.5;
	cY = (j / w) - 0.5;
	value = 1 - sqrt(cX^2 + cY^2);
end

