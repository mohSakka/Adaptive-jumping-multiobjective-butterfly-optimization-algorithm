%% initialization
clc
clear
close all
addpath([cd '/Codes']);
TestProblems = {'SCH','FON','POL','KUR','ZDT1','ZDT2','ZDT3','ZDT4','ZDT6'};
%%%
%% select problem and scenario number 
pn=9; % problem number 
sn=5; % scenario number 
%% loading data
    TestProblem = TestProblems{pn};
    TP = load ([cd '/Data/' TestProblem]);
    TP = cell2mat(struct2cell(TP));
    load([cd '/results_NSGA22/Mathematical Functions/Experiment/'...
        TestProblem '/Scenario-' num2str(sn) '/Scenario-' ...
            num2str(sn) '_Benchmarck-NSGA-II.mat']);
        cfmofa=load(['results/CFMOFA_' TestProblem '_' num2str(sn) '_results']);
        dcf=load(['EXP_results/dev_mut_CFMOFA_' TestProblem '/seed-' num2str(sn)]);
        mofa=load(['results/MOFA_' TestProblem '_' num2str(sn) '_results']);
        
        PF_N2 = paretoFront.solutionsObjectiveValues; % NSGA-II pareto
        fcf=DetermineDomination(cfmofa.f);
        PF_Cfmofa=fcf(fcf(:,end)==0,1:end-1);        % CF-MOFA pareto
        fd=DetermineDomination(dcf.f);
        PF_dmofa=fd(fd(:,end)==0,1:end-1);         % AJ-MOFA pareto
        ff=DetermineDomination(mofa.f);
        PF_MOFA=ff(ff(:,end)==0,1:end-1);       % MOFA pareto
    %% Plotting
    figure;
    plot(PF_dmofa(:,1),PF_dmofa(:,2),'ro');
    hold on;
    plot(PF_N2(:,1),PF_N2(:,2),'bo');
    plot(PF_Cfmofa(:,1),PF_Cfmofa(:,2),'go');
    plot(PF_MOFA(:,1),PF_MOFA(:,2),'ko');
    Lgnd={'AJ-MOFA','NSGA-II','CF-MOFA','MOFA'};
    legend(Lgnd); title(['paretoFront-' TestProblem]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
