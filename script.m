
w = 200;
h = 200;
iterations = 5;

functions = randomPainter(0.01, 1);
img = makeImage(w, h, functions, iterations);
displayImage(img);