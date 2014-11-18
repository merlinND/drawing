function points = columnWalk(w, h)
    [gridJ, gridI] = meshgrid(1:w, 1:h);
    gridI = reshape(gridI, numel(gridI), 1);
    gridJ = reshape(gridJ, numel(gridJ), 1);
    points = [gridI gridJ];
end