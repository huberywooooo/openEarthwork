function format_data(file_name1, file_name2)
    % format the data from the file
    % input:
    %   file_name1 - the name of the file to be formatted
    %   file_name2 - the name of the file to be saved
    % output:
    %   data - the formatted data
    %
    %   openExcav: An Open Source Library for Excavation Calculation
    %   Author(s): Hubery H.B. Woo (hbw8456@163.com)
    %   Copyright 2009-2024 Chongqing Three Gorges University

    % load the data
    fid = fopen(file_name1, 'r');
    data = textscan(fid, '%s %s %f %f %f', 'Delimiter', ',');
    fclose(fid);

    % extract the data
    names = data{1};
    empty_col = data{2};
    x = data{3};
    y = data{4};
    z = data{5};

    % create the new sequence number
    N = length(names);
    new_numbers = (1:N)';

    % create the output string array
    output = cell(N, 1);
    for i = 1:N
        output{i} = sprintf('%d,%s,%f,%f,%f', ...
            new_numbers(i), empty_col{i}, x(i), y(i), z(i));
    end

    % display the results
    disp('Modified data:');
    for i = 1:N
        disp(output{i});
    end

    % write the results to a new file
    fid = fopen(file_name2, 'w');
    for i = 1:N
        fprintf(fid, '%s\n', output{i});
    end
    fclose(fid);

end % function format_data