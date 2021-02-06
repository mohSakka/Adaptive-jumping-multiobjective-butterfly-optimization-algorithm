%% initialization
clc
clear
close all
addpath([cd '/Codes']);
TestProblems = {'SCH','FON','POL','KUR','ZDT1','ZDT2','ZDT3','ZDT4','ZDT6'};
%%%
%% select problem and scenario number 
pn=7; % problem number 
sn=10; % scenario number 
%% loading data
    TestProblem = TestProblems{pn};
    TP = load ([cd '/Data/' TestProblem]);
    TP = cell2mat(struct2cell(TP));
    load([cd '/results_NSGA22/Mathematical Functions/Experiment/'...
        TestProblem '/Scenario-' num2str(sn) '/Scenario-' ...
            num2str(sn) '_Benchmarck-NSGA-II.mat']);
        cfmofa=load(['fixed cf/CFMOFA_' TestProblem '_' num2str(sn) '_results']);
        dcf=load(['fixed AJ/dev_mut_CFMOFA_' TestProblem '/seed-' num2str(sn)]);
        mofa=load(['fixed results mofa/MOFA_' TestProblem '_' num2str(sn) '_results']);
        
        PF_N2 = paretoFront.solutionsObjectiveValues; % NSGA-II pareto
        fcf=DetermineDomination(cfmofa.f);
        PF_Cfmofa=fcf(fcf(:,end)==0,1:end-1);        % CF-MOFA pareto
        fd=DetermineDomination(dcf.f);
        PF_dmofa=fd(fd(:,end)==0,1:end-1);         % AJ-MOFA pareto
%         PF_dmofa = dcf.EA(:,end-3:end-2);
        ff=DetermineDomination(mofa.f);
        PF_MOFA=ff(ff(:,end)==0,1:end-1);       % MOFA pareto
    %% Plotting
    figure;
    plot(sort(PF_dmofa(:,1)),sort(PF_dmofa(:,2),'descend'),'r-o','linewidth',1.5);
    hold on;
    plot(sort(PF_N2(:,1)),sort(PF_N2(:,2),'descend'),'b-*','linewidth',1.5);
    plot(sort(PF_Cfmofa(:,1)),sort(PF_Cfmofa(:,2),'descend'),'g-s','linewidth',1.5);
    plot(sort(PF_MOFA(:,1)),sort(PF_MOFA(:,2),'descend'),'k-d','linewidth',1.5);
    Lgnd={'AJ-MOFA','NSGA-II','CF-MOFA','MOFA'};
    legend(Lgnd); title(['paretoFront-' TestProblem]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
