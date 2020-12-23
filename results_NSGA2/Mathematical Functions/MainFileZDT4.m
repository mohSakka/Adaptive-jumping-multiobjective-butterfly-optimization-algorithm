clc
clear all
close all 
%% Add Required Paths
AddRequiredPaths
Exper = 'ZDT4';
%% load true pareto front dataset
load TP8
trueParetoFront = TP8_ZDT4;

%% initialization
Initialization;
%% 
CalculateMetrics;

%% plotting 
PlotMetrics;
