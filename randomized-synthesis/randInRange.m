function img = randInRange(w, h, colorRanges)
	img = rand(h, w, 3);
	d = colorRanges(:, 2) - colorRanges(:, 1);
	
	img(:, :, 1) = img(:, :, 1) * d(1) + colorRanges(1, 1);
	img(:, :, 2) = img(:, :, 2) * d(2) + colorRanges(2, 1);
	img(:, :, 3) = img(:, :, 3) * d(3) + colorRanges(3, 1);
end