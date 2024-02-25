clc
clear all
close all 
%% Add Required Paths
AddRequiredPaths
Exper = 'ZDT1';
%% load true pareto front dataset
load TP5
trueParetoFront = TP5_ZDT1;

%% initialization
Initialization;
%% 
CalculateMetrics;

%% plotting 
PlotMetrics;
