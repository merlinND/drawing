% TODO: wrap into a function

function img = makeImage()
	exploration = 0.5;
	
	greymap = linspace(0, 1, 255)';
	colormap([greymap greymap greymap]);

	w = 200;
	h = 200;
	%img = rand(w, h, 3);
	img = 0.5 * ones(w, h, 3);
	
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
					color = getPixel(img, x, y, k);
				end;
				img(i, j, k) = color;
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