function output_figure(filename)
    % output the figure
    % input:
    %   filename - filename of the figure
    %
    %   openEarthwork: An Open Source Library for Excavation Calculation
    %   Author(s): Hubery H.B. Woo (hbw8456@163.com)
    %   Copyright 2009-2024 Chongqing Three Gorges University

    % set the figure size
    % set(gcf, 'Units', 'Inches');
    % pos = get(gcf, 'Position');
    % set(gcf, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos(3), pos(4)]);

    % output the figure
    print(filename, '-dpng', '-r300');

end % function output_figure