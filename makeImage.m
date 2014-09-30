function img = makeImage(functions, iterations)
% Functions: cell array of three functions, one for each channel
% Each function is called as fun(img, i, j)

	if(nargin < 2)
		iterations = 10;
	end;
	
	r = functions{1};
	g = functions{2};
	b = functions{3};
	
	greymap = linspace(0, 1, 255)';
	colormap([greymap greymap greymap]);

	w = 100;
	h = 100;
	%img = rand(w, h, 3);
	img = 1 * ones(w, h, 3);
	
	for it = 1:iterations
		for i = 1:w
			for j = 1:h
				img(i, j, :) = [r(img, i, j) g(img, i, j) b(img, i, j)];
			end;
		end;
	end;
end