clc
clear all
close all 
%% Add Required Paths
AddRequiredPaths
Exper = 'ZDT6';
%% load true pareto front dataset
load TP9
trueParetoFront = TP9_ZDT6;

%% initialization
Initialization;
%% 
CalculateMetrics;

%% plotting 
PlotMetrics;
