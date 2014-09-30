function displayImage(img)
	w = size(img, 1);
	h = size(img, 2);
	
	image(img);
	axis equal;
	axis([0 w 0 h]);
end