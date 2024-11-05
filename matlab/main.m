%%%%-----------------------------openExcav--------------------------------------
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
%   openExcav: An Open Source Library for Excavation Calculation
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

% set the parameters
params = set_params();

% load the data(base data have a offset)
base = load_data('base.txt', 494400);
surface = load_data('surface.txt');

% calculate the boundary
contour_points = calc_bc(base, surface);

% create the grid and interpolate
gridd = clac_grid(base, surface, params);

% plot the results
plot_results(base, surface, gridd, params, contour_points);

% calculate the volume
volume = calc_volume(gridd, contour_points, params);

% print the results
print_results(volume);