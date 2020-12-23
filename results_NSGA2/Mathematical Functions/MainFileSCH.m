clc
clear all
close all 

Exper = 'SCH';
%% Add Required Paths
AddRequiredPaths

%% load true pareto front dataset
load TP1
trueParetoFront = TP1_SCH;

%% initialization
Initialization;
%% 
CalculateMetrics;

%% plotting 
PlotMetrics;
