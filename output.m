% TODO: wrap into a function

greymap = linspace(0, 1, 255)';
colormap([greymap greymap greymap]);

w = 200;
h = 200;
img = floor(255 * rand(w, h));

for i = 1:(w-1)
	for j = 1:(h-1)
		r = rand();
		if(r > 0.5)
			img(i, j) = img(i + round(rand()), j + round(rand()));
		end;
	end;
end;
image(img);
axis equal;
axis([0 w 0 h]);