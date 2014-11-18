function functions = randomPainter(colorRanges, noise, reach)
	if(nargin < 1)
		colorRanges = [0 1; 0 1; 0 1];
	elseif(nargin < 2)
		noise = 0.01;
		reach = 2;
	elseif(nargin < 3)
		reach = 2;
	end;
	
	function pixel = randomPaint(img, points, p, k)
    % points: list of the points (order of walk)
    % p: current point's index in the list
		r = rand();
		if(r <= noise)
			% Random within the given range
			pixel = getRandomColor(k, colorRanges);
		else
			pixel = getRandomPreviousPixel(img, points, p, k, reach);
            %pixel = getRandomAdjacentPixel(img, points(p, 1), points(p, 2), k, reach);
		end;
	end

	functions = {
		@(img, points, p) randomPaint(img, points, p, 1);
		@(img, points, p) randomPaint(img, points, p, 2);
		@(img, points, p) randomPaint(img, points, p, 3)
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

function pixel = getRandomPreviousPixel(img, points, p, k, reach)
    i = points(p, 1);
    j = points(p, 2);
    
    % Add noise in the position in all four directions
	%deltaI = sign(rand() - 0.5) * randi([0 reach(1)]);
	%deltaJ = sign(rand() - 0.5) * randi([0 reach(2)]);
    
    % The last few points walked give an indication of the movement
    offset = ceil(mean(reach) * rand()) + 1;
    earliest = max(1, p - offset);
    % Vector towards the previous points
    earlier = points(earliest:p, :);
    delta = mean(earlier, 1) - [i j];
    delta = round(delta);
    % TODO: normalize delta
    
	pixel = getPixel(img, i + delta(1), j + delta(2), k);
end

% @deprecated (most likely)
function pixel = getRandomAdjacentPixel(img, i, j, k, reach)
	% Random in all four directions
	%deltaI = sign(rand() - 0.5) * randi([0 reach(1)]);
	%deltaJ = sign(rand() - 0.5) * randi([0 reach(2)]);
	% Random among the previous pixels
	deltaI = - round(reach(1) * rand());
	deltaJ = - round(reach(2) * rand());
    if(deltaI == 0 && deltaJ == 0)
		deltaI = -1;
		deltaJ = -1;
	end;
	
	pixel = getPixel(img, i + deltaI, j + deltaJ, k);
end