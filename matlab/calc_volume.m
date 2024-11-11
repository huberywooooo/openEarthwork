function volume = calc_volume(gridd, contour_points, params, output_file)
    % calculate the volume
    % input:
    %   gridd - struct with X, Y, Z_surface, Z_base
    %   params - struct with contour_level, grid_size
    %   contour_points - boundary points coordinates
    %   output_file - path to output file for grid volumes
    % output:
    %   volume - struct with exca_volume, fill_volume, grid_volume
    %
    %   openEarthwork: An Open Source Library for Excavation Calculation
    %   Author(s): Hubery H.B. Woo (hbw8456@163.com)
    %   Copyright 2009-2024 Chongqing Three Gorges University

    % extract the coordinates
    X = gridd.X;
    Y = gridd.Y;
    Z_surface = gridd.Z_surface;
    Z_base = gridd.Z_base;
    grid_size = params.grid_size;
    
    exca_volume = 0;
    fill_volume = 0;
    
    % create a new figure for displaying the volume calculation results
    subplot(2, 2, 4);
    title('volume calculation');
    hold on;
    
    % plot the boundary
    plot(contour_points(:,1), contour_points(:,2), 'g-', 'LineWidth', 2);
    
    % plot the grid points
    plot(X, Y, 'k.', 'MarkerSize', 1);
    
    % open output file for writing grid volumes
    fid = fopen(output_file, 'w');
    fprintf(fid, 'X,Y,Volume\n'); % write header
    
    for i = 1:size(X, 1)
        for j = 1:size(X, 2)
            % check if the grid center is inside the boundary (the smaller the grid, the more accurate)
            if inpolygon(X(i,j), Y(i,j), contour_points(:,1), contour_points(:,2))
                if ~isnan(Z_surface(i, j)) && ~isnan(Z_base(i, j))
                    delta_z = Z_surface(i, j) - Z_base(i, j);
                    grid_area = grid_size^2;
                    current_volume = delta_z * grid_area;
                    
                    % write grid volume to file
                    fprintf(fid, '%.3f,%.3f,%.3f\n', X(i,j), Y(i,j), current_volume);
                    
                    % calculate the total volume
                    if delta_z >= 0
                        exca_volume = exca_volume + current_volume;
                    else
                        fill_volume = fill_volume + abs(current_volume);
                    end
                    
                    % add the volume label
                    add_label(X(i,j), Y(i,j), current_volume);
                end
            end
        end
    end
    
    % close the output file
    fclose(fid);
    
    grid_volume = exca_volume - fill_volume;
    
    % store the results
    volume.exca_volume = exca_volume;
    volume.fill_volume = fill_volume;
    volume.grid_volume = grid_volume;

    % show the volume calculation results in the figure
    text(0.5, 0.5, sprintf('exca volume: %.2f\nfill volume: %.2f\ngrid volume: %.2f', ...
        exca_volume, fill_volume, grid_volume), ...
        'Units', 'normalized', 'VerticalAlignment', 'middle', 'HorizontalAlignment', 'center');
    
    % set the figure properties
    title('Volume Calculation Results');
    xlabel('X Coordinate');
    ylabel('Y Coordinate');
    axis equal;
    hold off;
    
    % add the legend
    legend('boundary', 'grid points', 'Location', 'best');

end % function calc_volume

function add_label(x, y, volume)
    % add the volume label
    % input:
    %   x, y - label position coordinates
    %   volume - volume value
    
    % set the display threshold, only display significant volume changes
    threshold = 10; % can be adjusted according to needs
    
    if abs(volume) > threshold
        % determine the text color and label
        if volume > 0
            color = [1 0 0]; % excavation is red
            label = sprintf('+%.0f', volume); % display positive values
        else
            color = [0 0 1]; % fill is blue
            label = sprintf('%.0f', volume); % display negative values
        end
        
        % add the text label
        text(x, y, label, ...
            'Color', color, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'middle', ...
            'FontSize', 8, ...
            'FontWeight', 'bold');
    end

end % function add_label