%%%%-----------------------------openEarthwork--------------------------------------
%
%       Description: Main function for calculating the volume of excavation
%       function:
%           format_data: format the data from the file
%           set_params: set the parameters for the excavation calculation
%           load_data: load the data from the file
%           calc_bc: calculate the boundary of the excavation
%           calc_grid: create the grid and interpolate the data
%           plot_results: plot the results
%           calc_volume: calculate the volume of the excavation
%           print_results: print the results
%
%   openEarthwork: An Open Source Library for Excavation Calculation
%   Author(s): Hubery H.B. Woo (hbw8456@163.com)
%   Copyright 2009-2024 Chongqing Three Gorges University

% add the working path of matlab
% addpath

% main function for calculating the volume of excavation
clear; clc; close all;

% format the data
% format_data('base.txt', 'base1.txt');
% format_data('surface.txt', 'surface1.txt');
% format_data('rockbase.txt', 'rockbase1.txt');

%--------------------------------------------------------------------------
%             P R E P R O C E S S 
%--------------------------------------------------------------------------
% set the parameters
params = set_params();

% load the data(base data have a offset)
base = load_data('base.txt', params);
surface = load_data('rockbase.txt', params);
% surface = load_data('surface.txt', params);

% calculate the boundary
contour_points = calc_bc(surface, surface);

%--------------------------------------------------------------------------
%             C A L C U L A T E   G R I D 
%--------------------------------------------------------------------------
% create the grid and interpolate
gridd = clac_grid(base, surface, params);

% plot the results
plot_results(base, surface, gridd, contour_points, params);

% calculate the volume
volume = calc_volume(gridd, contour_points, params, 'earthwork.txt');

%--------------------------------------------------------------------------
%             P O S T P R O C E S S 
%--------------------------------------------------------------------------
% output the figure
output_figure('earthwork.png');

% print the results
print_results(volume);