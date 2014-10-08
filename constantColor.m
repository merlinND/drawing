function functions = constantColor(color)
% color RGB vector
	functions = {
		@(img, i, j) color(1);
		@(img, i, j) color(2);
		@(img, i, j) color(3)
	};
end