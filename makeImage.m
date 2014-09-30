% TODO: wrap into a function

function img = makeImage()
	exploration = 0.1;
	iterations = 2; %floor(5 * rand()) + 1;
	
	greymap = linspace(0, 1, 255)';
	colormap([greymap greymap greymap]);

	w = 200;
	h = 200;
	%img = rand(w, h, 3);
	img = 1 * ones(w, h, 3);
	
	for it = 1:iterations
		for i = 1:w
			for j = 1:w
				r = rand();
				for k = 1:3
					if(r <= exploration)
						x = i + round(rand());
						y = j + round(rand());
						color = (3 * rand() + getPixel(img, x, y, k)) / 4;
					else
						x = i + round(rand());
						y = j + round(rand());
						
						me = getPixel(img, i, j, k);
						neighbor = getPixel(img, x, y, k);
						color = me * neighbor; %(me + neighbor) / 2;
					end;
					img(i, j, k) = color;
				end;
			end;
		end;
	end;
end

function pixel = getPixel(img, x, y, k)
% Handles boundary conditions
% TODO: experiment with different boundary conditions
	coordinates = min([x y k], size(img));
	coordinates = max(coordinates, [1 1 1]);
	pixel = img(coordinates(1), coordinates(2), coordinates(3));
end