% Image parameters
w = 100;
h = 100;
iterations = 5;
noise = 0.001;
reach = 2;

functions = randomPainter(noise, reach);
functions{4} = @(x, y) (x > y);
img = makeImage(w, h, functions, iterations);
displayImage(img);