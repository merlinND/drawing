% TODO: wrap into a function

function img = makeImage()
	maxNoise = 0.5;
	iterations = 5;
	
	greymap = linspace(0, 1, 255)';
	colormap([greymap greymap greymap]);

	w = 200;
	h = 200;
	%img = rand(w, h, 3);
	img = 1 * ones(w, h, 3);
	
	for it = 1:iterations
		noise = maxNoise / (it * it);
		for i = 1:w
			for j = 1:w
				for k = 1:3
					r = rand();
					if(r <= noise)
						color = rand;
					else
						color = getRandomAdjacentPixel(img, i, j, k);
					end;
					img(i, j, k) = color;
				end;
			end;
		end;
	end;
end

function pixel = getRandomAdjacentPixel(img, x, y, k)
	% deltaX = round(2 * rand() * sign(rand() - 0.5));
	% deltaY = round(2 * rand() * sign(rand() - 0.5));
	deltaX = sign(rand() - 0.5);
	deltaY = sign(rand() - 0.5);
	
	pixel = getPixel(img, x + deltaX, y + deltaY, k);
end