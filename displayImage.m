function displayImage(img)
	w = size(img, 2);
	h = size(img, 1);
	
	% Clamp
	img = min(1, img);
	img = max(0, img);
	
	imshow(img);
end