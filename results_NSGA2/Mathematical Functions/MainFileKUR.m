clc
clear all
close all 

%% Add Required Paths
AddRequiredPaths
Exper = 'KUR';

%% load true pareto front dataset
load TP4
trueParetoFront = TP4_KUR;

%% initialization
Initialization;

%% 
CalculateMetrics;

%% plotting 
PlotMetrics;

