function functions = randomPainter(maxNoise, reach)
	nCalls = zeros(3);

	if(nargin < 1)
		maxNoise = 0.01;
		reach = 2;
	elseif(nargin < 2)
		reach = 2;
	end;
	
	function pixel = randomPaint(img, i, j, k)
		% Deduce noise level from the number of calls
		nPixels = size(img, 1) * size(img, 2);
		nCalls(k) = nCalls(k) + 1;
		iteration = floor(nCalls(k) / nPixels) + 1;
		noise = maxNoise / (iteration .^ 2);
		r = rand();
		if(r <= noise)
			% Pure random
			%pixel = rand();
			% Random within a range
			pixel = getRandomColor(k);
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

function color = getRandomColor(k)
	if(k == 1) % Red
		color = getRandomNumber(1, 1);
	elseif(k == 2) % Green
		color = getRandomNumber(-1, 0.5);
	else % Blue
		color = getRandomNumber(0.2, 3);
	end;
	
	color = min(color, 1);
	color = max(color, 0);
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