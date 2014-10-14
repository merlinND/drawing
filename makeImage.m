function img = makeImage(w, h, functions, iterations)
% Functions: cell array of three functions, one for each channel
% Each function is called as fun(img, i, j)

	if(nargin < 4)
		iterations = 5;
	end;
	
	r = functions{1};
	g = functions{2};
	b = functions{3};
	hasPotential = 0;
	if(size(functions, 1) >= 4)
		hasPotential = 1;
		potential = functions{4};
		mix = functions{5};
	end;

	%img = rand(w, h, 3);
	img = getColorGradient(w, h);
	%img = zeros(h, w, 3);
	%img(1, 1, :) = rand(3, 1);
	
	for it = 1:iterations
		for i = 1:w
			for j = 1:h
				img(j, i, :) = [r(img, i, j) g(img, i, j) b(img, i, j)];
			end;
		end;
	end;
	
	for i = 1:w
		for j = 1:h
			if(hasPotential)
				img(j, i, :) = applyPotential(potential, mix, i, j, img(i, j, :));
			end
		end;
	end;
end