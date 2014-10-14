function functions = randomPainter(colorRanges, noise, reach)
	if(nargin < 1)
		colorRanges = [0 1; 0 1; 0 1];
	elseif(nargin < 2)
		noise = 0.01;
		reach = 2;
	elseif(nargin < 3)
		reach = 2;
	end;
	
	function pixel = randomPaint(img, i, j, k)
		r = rand();
		if(r <= noise)
			% Random within the given range
			pixel = getRandomColor(k, colorRanges);
		else
			pixel = getRandomAdjacentPixel(img, i, j, k, reach);
		end;
	end

	functions = {
		@(img, i, j) randomPaint(img, i, j, 1);
		@(img, i, j) randomPaint(img, i, j, 2);
		@(img, i, j) randomPaint(img, i, j, 3)
	};
end

function color = getRandomColor(k, colorRanges)
	color = getRandomNumber(colorRanges(k, 1), colorRanges(k, 2));
	color = min(max(color, 0), 1);
end

function x = getRandomNumber(a, b)
% Returns a random number in the range [a, b]
	x = a + (b - a) .* rand();
end

function pixel = getRandomAdjacentPixel(img, x, y, k, reach)
	% Random in all four directions
	%deltaX = round(reach * rand() * sign(rand() - 0.5));
	%deltaY = round(reach * rand() * sign(rand() - 0.5));
	% Random among the previous pixels
	deltaX = - round(reach * rand());
	deltaY = - round(reach * rand());
	
	pixel = getPixel(img, x + deltaX, y + deltaY, k);
end