function print_results(volume)
    % print the calculation results
    % input:
    %   volume - struct with exca_volume, fill_volume, grid_volume
    %
    %   openExcav: An Open Source Library for Excavation Calculation
    %   Author(s): Hubery H.B. Woo (hbw8456@163.com)
    %   Copyright 2009-2024 Chongqing Three Gorges University

    % extract the results
    exca_volume = volume.exca_volume;
    fill_volume = volume.fill_volume;
    total_volume = volume.grid_volume;
    
    % print the results
    format long g;
    fprintf('Excavation Volume: %.2f m³\n', exca_volume);
    fprintf('Fill Volume: %.2f m³\n', fill_volume);
    fprintf('Total Volume: %.2f m³\n', total_volume);

end % function print_results