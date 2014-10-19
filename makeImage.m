function img = makeImage(base, points, functions, iterations)
% points: list of points (coordinates) giving the walk order on the image
% functions: cell array of three functions, one for each channel
% Each function is called as fun(img, points, p)

	if(nargin < 3)
		iterations = 5;
	end;
	
	w = size(base, 2);
	h = size(base, 1);
	
	r = functions{1};
	g = functions{2};
	b = functions{3};
	hasPotential = 0;
	if(size(functions, 1) >= 4)
		hasPotential = 1;
		potential = functions{4};
		mix = functions{5};
	end;

	img = base;
    
    % Walk the image in the specified order
	for it = 1:iterations
		for p = 1:length(points)
            i = points(p, 1);
            j = points(p, 2);
            
            img(i, j, :) = [r(img, points, p) g(img, points, p) b(img, points, p)];
            %img(i, j, :) = [p p p] / numel(points);
		end;
	end;
	
    if(hasPotential)
        for p = 1:length(points)
            i = points(p, 1);
            j = points(p, 2);
            img(i, j, :) = applyPotential(potential, mix, i, j, img(i, j, :));
        end;
    end;
end