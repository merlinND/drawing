function points = lineWalk(w, h)
    [gridI, gridJ] = meshgrid(1:h, 1:w);
    gridI = reshape(gridI, numel(gridI), 1);
    gridJ = reshape(gridJ, numel(gridJ), 1);
    points = [gridI gridJ];
end