function functions = randomPainter()
	functions = {
		@(img, i, j) randomPaint(img, i, j, 1);
		@(img, i, j) randomPaint(img, i, j, 2);
		@(img, i, j) randomPaint(img, i, j, 3)
	};
end

function pixel = randomPaint(img, i, j, k)
	% TODO: make customizable
	reach = 2;
	noise = 0.01;

	r = rand();
	if(r <= noise)
		pixel = rand;
	else
		pixel = getRandomAdjacentPixel(img, i, j, k, reach);
	end;
end

function pixel = getRandomAdjacentPixel(img, x, y, k, reach)
	deltaX = round(reach * rand() * sign(rand() - 0.5));
	deltaY = round(reach * rand() * sign(rand() - 0.5));
	
	pixel = getPixel(img, x + deltaX, y + deltaY, k);
end