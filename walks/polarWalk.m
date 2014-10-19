function points = polarWalk(w, h)
    centerI = (h+1) / 2;
    centerJ = (w+1) / 2;

    % List all the points we will have to walk
    [gridI, gridJ] = meshgrid(1:h, 1:w);
    gridI = reshape(gridI, numel(gridI), 1);
    gridJ = reshape(gridJ, numel(gridJ), 1);
    
    [thetas, radii] = cart2pol(gridJ - centerJ, gridI - centerI);
    sorted = sortrows([radii, thetas], [1 2]);

    [pointsJ, pointsI] = pol2cart(sorted(:, 2), sorted(:, 1));
    points = round([pointsI + centerI, pointsJ + centerJ]);
    % TODO: clip if necessary

end