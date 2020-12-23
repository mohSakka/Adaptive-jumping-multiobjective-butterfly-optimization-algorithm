clc
clear all
close all 
%% Add Required Paths
AddRequiredPaths
Exper = 'ZDT2';

%% load true pareto front dataset
load TP6
trueParetoFront = TP6_ZDT2;

%% initialization
Initialization;
%% 
CalculateMetrics;

%% plotting 
PlotMetrics;
