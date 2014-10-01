% Image parameters
w = 100;
h = 100;
iterations = 5;
noise = 0.001;
reach = 2;

functions = randomPainter(noise, reach);
img = makeImage(w, h, functions, iterations);
displayImage(img);