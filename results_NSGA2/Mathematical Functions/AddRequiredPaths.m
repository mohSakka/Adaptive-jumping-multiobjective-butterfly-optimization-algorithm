%% Add path
currentFolder = pwd;
while ~strcmp(currentFolder(end-1:end),'#\')
    currentFolder(end) = [];
end
addpath([currentFolder 'Codes\Evaluation Metrics'])
addpath([currentFolder 'Dataset\True pareto front data set'])
addpath([currentFolder 'Codes\Test problems (examples)'])
addpath([currentFolder 'Results\Mathematical Functions\export_fig-master'])
resolution =5;  % 1 is the original resoltion