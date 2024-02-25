clc
clear
close all 
%% Add Required Paths
AddRequiredPaths
Exper = 'POL';
%% load true pareto front dataset
load TP3
trueParetoFront = TP3_POL;

%% initialization
Initialization;
%% 
CalculateMetrics;

%% plotting 
PlotMetrics;
