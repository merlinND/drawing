function displayImage(img)
	w = size(img, 1);
	h = size(img, 2);
	
	image(img);
	axis equal;
	axis([1 w 1 h]);
end