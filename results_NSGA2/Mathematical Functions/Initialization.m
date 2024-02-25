%% initialization
numberOfExperiment = 10; % Number of experiment

% HyperVolume metric
mogaHyperVolume = zeros(1,numberOfExperiment);
moga2HyperVolume = zeros(1,numberOfExperiment);
nsgaHyperVolume = zeros(1,numberOfExperiment);
HNSGAIII = zeros(1,numberOfExperiment);

% NDS metric
mogaNDS = zeros(1,numberOfExperiment);
moga2NDS = zeros(1,numberOfExperiment);
nsgaNDS = zeros(1,numberOfExperiment);
NSGAIIINDS = zeros(1,numberOfExperiment);

% Delta metric
mogaDelta = zeros(1,numberOfExperiment);
moga2Delta = zeros(1,numberOfExperiment);
nsgaDelta = zeros(1,numberOfExperiment);
DNSGAIII = zeros(1,numberOfExperiment);

% Generational Distance (GD) metric.
mogaGenerationalDistance = zeros(1,numberOfExperiment);
moga2GenerationalDistance = zeros(1,numberOfExperiment);
nsgaGenerationalDistance = zeros(1,numberOfExperiment);
GNSGAIII = zeros(1,numberOfExperiment);

% Set coverage metric.
nsga_To_moga2SetCoverage = zeros(1,numberOfExperiment);
moga_To_moga2SetCoverage = zeros(1,numberOfExperiment);
moga2_To_nsgaSetCoverage = zeros(1,numberOfExperiment);
moga2_To_mogaSetCoverage = zeros(1,numberOfExperiment);
NSGAIII_To_moga2SetCoverage = zeros(1,numberOfExperiment);
moga2_To_NSGAIIISetCoverage = zeros(1,numberOfExperiment);