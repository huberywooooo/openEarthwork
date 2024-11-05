function grid = clac_grid(base, surface, params)
    % create the grid and interpolate
    % input:
    %   surface, base - struct with x, y, z coordinates
    %   params - struct with grid_size and contour_level
    % output:
    %   X, Y - grid coordinates
    %   Z_surface, Z_base - interpolated elevation data
    %
    %   openExcav: An Open Source Library for Excavation Calculation
    %   Author(s): Hubery H.B. Woo (hbw8456@163.com)
    %   Copyright 2009-2024 Chongqing Three Gorges University

    % extract the coordinates
    x_surface = surface.x;
    y_surface = surface.y;
    z_surface = surface.z;
    x_base = base.x;
    y_base = base.y;
    z_base = base.z;
    grid_size = params.grid_size;
    
    % determine the calculation area boundary
    xmin = min([min(x_surface), min(x_base)]) - grid_size;
    xmax = max([max(x_surface), max(x_base)]) + grid_size;
    ymin = min([min(y_surface), min(y_base)]) - grid_size;
    ymax = max([max(y_surface), max(y_base)]) + grid_size;
    
    % create the grid
    [grid.X, grid.Y] = meshgrid(xmin:grid_size:xmax, ymin:grid_size:ymax);
    
    % interpolate
    grid.Z_surface = griddata(x_surface, y_surface, z_surface, grid.X, grid.Y, 'natural');
    grid.Z_base = griddata(x_base, y_base, z_base, grid.X, grid.Y, 'natural');

end % function clac_grid