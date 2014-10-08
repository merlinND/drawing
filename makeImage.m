function img = makeImage(w, h, functions, iterations)
% Functions: cell array of three functions, one for each channel
% Each function is called as fun(img, i, j)

	if(nargin < 2)
		iterations = 10;
	end;
	
	r = functions{1};
	g = functions{2};
	b = functions{3};
	hasPotential = 0;
	if(size(functions, 1) >= 4)
		hasPotential = 1;
		potential = functions{4};
	end;
	
	greymap = linspace(0, 1, 255)';
	colormap([greymap greymap greymap]);

	img = rand(w, h, 3);
	%img = 1 * ones(w, h, 3);
	
	for it = 1:iterations
		for i = 1:w
			for j = 1:h
				color = [r(img, i, j) g(img, i, j) b(img, i, j)];
				if(hasPotential)
					color = applyPotential(potential, i, j, color);
				end
				
				img(i, j, :) = color;
			end;
		end;
	end;
end