function displayImage(img)
	w = size(img, 2);
	h = size(img, 1);
	
	% Clamp
	img = min(1, img);
	img = max(0, img);
	
	image(img);
	axis equal;
	axis([1 w 1 h]);
end