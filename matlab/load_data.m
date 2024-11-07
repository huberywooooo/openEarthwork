function data = load_data(filename, params)
    % load the data from the file and filter if needed
    % input:
    %   filename - data file name
    %   params - struct with min_value
    % output:
    %   data - struct with x, y, z coordinates
    %
    %   openEarthwork: An Open Source Library for Excavation Calculation
    %   Author(s): Hubery H.B. Woo (hbw8456@163.com)
    %   Copyright 2009-2024 Chongqing Three Gorges University

    % set the min_value, if not provided, set to 0
    if nargin > 1
        min_value = params.min_value;
    else
        min_value = 0;
    end

    % read the data from the file
    fid = fopen(filename, 'r');
    file_data = textscan(fid, '%s %s %f %f %f', 'Delimiter', ',');
    fclose(fid);
    
    % extract the coordinates
    data = struct();
    data.x = file_data{3};
    data.y = file_data{4};
    data.z = file_data{5};
    
    % if min_value is provided, filter the data
    keep_indices = data.x >= min_value;
    data.x = data.x(keep_indices);
    data.y = data.y(keep_indices);
    data.z = data.z(keep_indices);

end % function load_data