function value = modulo(w, h, tw, th, i, j)
	tw = min(tw, w);
	th = min(th, h);

	cX = mod(i, tw);
	cY = mod(j, th);
	value = (cX + cY) / (tw + th);
end
