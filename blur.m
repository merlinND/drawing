function img = blur(original, side)
% Apply blurring
% TODO: gaussian blur
	if(nargin < 2)
		side = 3;
	end;
	
	n = side * side;
	s = floor(side / 2);
	
	img = zeros(size(original));
	
	for i = 1:size(original, 1)
		for j = 1:size(original, 2)
			for k = 1:3
				acc = 0;
				for x = (i-s):(i+s)
					for y = (j-s):(j+s)
						acc = acc + getPixel(original, x, y, k);
					end;
				end;
				img(i, j, k) = acc / n;
			end;
		end;
	end;
	
end