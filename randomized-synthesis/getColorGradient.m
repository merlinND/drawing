function rgbGradient = getColorGradient(w, h, v1, v2)
	if(nargin < 3)
		v1 = 1;
	end;
	if(nargin < 4)
		v2 = 1;
	end;
	
	% h, w are inverted because the result is rotated below
	hsvGradient = zeros(h, w, 3);
	
	% Generate a gradient with hue
	% One hue value per image pixel
	% Hue
	
	%hsvGradient(:, :, 1) = linspace(0, 1, h)' * linspace(0, 1, w);
	hsvGradient(:, :, 1) = (linspace(0.4, 0.50, h)' * linspace(0, 1, w)) .^ 0.5;
	%hsvGradient(:, :, 1) = v1;
	
	% Saturation
	%hsvGradient(:, :, 2) = linspace(0.5, 1, h)' * ones(1, w);
	hsvGradient(:, :, 2) = v1;
	
	% Value
	hsvGradient(:, :, 3) = v2;
	
	rgbGradient = hsv2rgb(imrotate(hsvGradient, 90));
end