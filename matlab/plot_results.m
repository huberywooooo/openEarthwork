function plot_results(base, surface, grid, contour_points, params)
    % plot the results
    % input:
    %   base, surface - struct with x, y, z coordinates
    %   grid - struct with X, Y, Z_surface, Z_base
    %   params - struct with contour_level
    %   contour_points - boundary points coordinates
    %
    %   openEarthwork: An Open Source Library for Excavation Calculation
    %   Author(s): Hubery H.B. Woo (hbw8456@163.com)
    %   Copyright 2009-2024 Chongqing Three Gorges University

    % extract the coordinates
    x_surface = surface.x;
    y_surface = surface.y;
    x_base = base.x;
    y_base = base.y;
    X = grid.X;
    Y = grid.Y;
    Z_surface = grid.Z_surface;
    Z_base = grid.Z_base;
    contour_level = params.contour_level;
    
    figure('Position', [100, 100, 1200, 800]);
    
    % scatter points
    subplot(2,2,1)
    plot_points(x_surface, y_surface, x_base, y_base, contour_points);
    
    % surface contour
    subplot(2,2,2)
    plot_surface(X, Y, Z_surface, x_surface, y_surface, contour_points, ...
        contour_level);
    
    % base contour
    subplot(2,2,3)
    plot_base(X, Y, Z_base, x_base, y_base, contour_points, ...
        contour_level);
    
end % function plot_results


function plot_points(x_surface, y_surface, x_base, y_base, contour_points)
    % plot the scatter points
    scatter(x_surface, y_surface, 'filled'); hold on;
    scatter(x_base, y_base, 'filled');
    plot(contour_points(:,1), contour_points(:,2), 'g-', 'LineWidth', 2);
    title('scatter points');
end % function plotScatterPoints


function plot_surface(X, Y, Z_surface, x_surface, y_surface, contour_points, ...
    contour_level)
    % plot the surface contour
    contour(X, Y, Z_surface, contour_level, 'LineWidth', 1.5);
    hold on;
    scatter(x_surface, y_surface, 'filled');
    plot(contour_points(:,1), contour_points(:,2), 'g-', 'LineWidth', 2);
    title('surface contour');
end % function plot_surface

function plot_base(X, Y, Z_base, x_base, y_base, contour_points, ...
    contour_level)
    % plot the base contour
    contour(X, Y, Z_base, contour_level, 'LineWidth', 1.5);
    hold on;
    scatter(x_base, y_base, 'filled');
    plot(contour_points(:,1), contour_points(:,2), 'g-', 'LineWidth', 2);
    title( 'base contour');
end % function plot_base