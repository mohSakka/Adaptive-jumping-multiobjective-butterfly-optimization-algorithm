clc
clear all
close all 
%% Add Required Paths
AddRequiredPaths
Exper = 'ZDT3';

%% load true pareto front dataset
load TP7
trueParetoFront = TP7_ZDT3;
%% initialization
Initialization;
%% 
CalculateMetrics;

%% plotting 
PlotMetrics;
