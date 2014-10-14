function rgbGradient = getColorGradient(w, h, saturation, value)
	if(nargin < 3)
		saturation = 1;
	end;
	if(nargin < 4)
		value = 1;
	end;
	
	hsvGradient = zeros(w, h, 3);
	
	% Generate a gradient with hue
	% One hue value per image pixel
	%hsvGradient(:, :, 1) = linspace(0, 1, h)' * linspace(0, 1, w);
	hsvGradient(:, :, 1) = (linspace(0.4, 0.50, h)' * linspace(0, 1, w)) .^ 0.5;
	
	hsvGradient(:, :, 2) = saturation;
	hsvGradient(:, :, 3) = value;
	rgbGradient = hsv2rgb(imrotate(hsvGradient, 90));
end