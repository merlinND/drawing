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
		iteration = floor(nCalls(k) / nPixels);
		noise = maxNoise / (iteration .^ 2);
		
		r = rand();
		if(r <= noise)
			% TODO: pick pixel color
			pixel = min(1.5 * rand(), 1);
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

function pixel = getRandomAdjacentPixel(img, x, y, k, reach)
	% Random in all four directions
	%deltaX = round(reach * rand() * sign(rand() - 0.5));
	%deltaY = round(reach * rand() * sign(rand() - 0.5));
	% Random among the previous pixels
	deltaX = - round(reach * rand());
	deltaY = - round(reach * rand());
	
	pixel = getPixel(img, x + deltaX, y + deltaY, k);
end