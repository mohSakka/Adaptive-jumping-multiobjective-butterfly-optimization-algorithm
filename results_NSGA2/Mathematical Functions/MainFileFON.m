clc
clear all
close all 

Exper = 'FON';
%% Add Required Paths
AddRequiredPaths

%% load true pareto front dataset
load TP2
trueParetoFront = TP2_FON;

%% initialization
Initialization;
%% 
CalculateMetrics;

%% plotting 
PlotMetrics;

