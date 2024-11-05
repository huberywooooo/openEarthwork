function contour_points = calc_bc(base, surface)
    % calculate the convex hull boundary of the data points
    % input:
    %   base, surface - struct with x, y, z coordinates
    % output:
    %   contour_points - boundary points coordinates
    %   hull_x, hull_y - convex hull x and y coordinates
    %
    %   openExcav: An Open Source Library for Excavation Calculation
    %   Author(s): Hubery H.B. Woo (hbw8456@163.com)
    %   Copyright 2009-2024 Chongqing Three Gorges University

    % extract the x, y coordinates
    x = [base.x; surface.x];
    y = [base.y; surface.y];

    % calculate the convex hull
    k = convhull(x, y);
    hull_x = x(k);
    hull_y = y(k);
    contour_points = [hull_x, hull_y];

end % function calc_bc