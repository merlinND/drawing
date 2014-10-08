function result = hsvBlend(channel, level, color)
% channel 1, 2 or 3
	% Apply potential in HSV color space
	hsv = rgb2hsv(color);
	hsv(channel) = level * hsv(channel);
	result = hsv2rgb(hsv);
end