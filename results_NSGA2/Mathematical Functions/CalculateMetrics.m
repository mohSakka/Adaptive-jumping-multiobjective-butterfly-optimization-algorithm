 path1 =[currentFolder 'Results\Mathematical Functions\Experiment\' Exper '\'];
for i =1 : numberOfExperiment
    scenarioName = ['Scenario-' num2str(i)];
    path2 =[currentFolder 'Results\Mathematical Functions\Experiment\' Exper '\' scenarioName '\'];
    addpath(path2)
    load([scenarioName '_DAES'])
    DAESParetoFront = paretoFront.solutionsObjectiveValues;
    DAESParetoFront = sortrows(DAESParetoFront,1);
    load([scenarioName '_MOGA'])
    MOGA_AQCDParetoFront = paretoFront.solutionsObjectiveValues;
    MOGA_AQCDParetoFront = sortrows(MOGA_AQCDParetoFront,1);
    
    load([scenarioName '_Benchmarck-NSGA-II'])
    NSGA2ParetoFront = paretoFront.solutionsObjectiveValues;
    NSGA2ParetoFront = sortrows(NSGA2ParetoFront,1);
    
    
    load([scenarioName '_NSGA-III'])
    %NSGA3ParetoFront = paretoFront.solutionsObjectiveValues;
    %NSGA3ParetoFront = sortrows(NSGA3ParetoFront,1);
  % load(['Scenario-' num2str(i) '_NSGA-III.mat']) 
    NSGA3ParetoFront=[];
 for j=1:length(F1)
    NSGA3ParetoFront = [NSGA3ParetoFront;F1(j).Cost];
  
 end    
    NSGA3ParetoFront=real(NSGA3ParetoFront); % add by yazen
    
    figure
    subplot(211)
    hold on
    plot(NSGA2ParetoFront(:,1),NSGA2ParetoFront(:,2),'*-b')
    plot(MOGA_AQCDParetoFront(:,1),MOGA_AQCDParetoFront(:,2),'o--r')
    plot(NSGA3ParetoFront(:,1),NSGA3ParetoFront(:,2),'sk')
    plot(DAESParetoFront(:,1),DAESParetoFront(:,2),'x-g')
    xlabel('F1')
    ylabel('F2')
    
    title('Pareto Front')
    legend('NSGA-II','MOGA-AQCD','NSGA-III','DAES')
    subplot(212)
        hold on
    %plot(NSGA2ParetoFront(:,1),NSGA2ParetoFront(:,2),'*-b')
    plot(MOGA_AQCDParetoFront(:,1),MOGA_AQCDParetoFront(:,2),'o--r')
    %plot(NSGA3ParetoFront(:,1),NSGA3ParetoFront(:,2),'sk')
    plot(DAESParetoFront(:,1),DAESParetoFront(:,2),'x-g')
    xlabel('F1')
    ylabel('F2')
    xlim([min(DAESParetoFront(:,1)) max(DAESParetoFront(:,1))]);
    ylim ([min(DAESParetoFront(:,2)) max(DAESParetoFront(:,2))]);
    title('Pareto Front')
    legend('MOGA-ACQD','DAES')
   % legend('NSGA II','MOGA','NSGA-III','MOGA2')
   path2(end)=[];
   res=['-m' num2str(resolution)];
    export_fig(path2,'-jpg',res)
    % Find HyperVolume
    NSGA2_HV(i) = HyperVolume(NSGA2ParetoFront) ;
    MOGA_AQCD_HV(i) = HyperVolume(MOGA_AQCDParetoFront) ;
    DAES_HV(i) = HyperVolume(DAESParetoFront) ;
    NSGA3_HV(i) = HyperVolume(NSGA3ParetoFront);
    % Find number of non dominated solutions
    NSGA2_NDS(i) = numberOfNonDominatedSolutions(NSGA2ParetoFront);
    MOGA_AQCD_NDS(i) = numberOfNonDominatedSolutions(MOGA_AQCDParetoFront);
    DAES_NDS(i) = numberOfNonDominatedSolutions(DAESParetoFront);
     NSGA3_NDS(i) = numberOfNonDominatedSolutions(NSGA3ParetoFront);
    % Find diversity by Delta metric
    NSGA2_DM(i) = Delta(NSGA2ParetoFront,extreameSolution1,extreameSolution2);
    MOGA_AQCD_DM(i) = Delta(MOGA_AQCDParetoFront,extreameSolution1,extreameSolution2);
    NSGA3_DM(i) = Delta(NSGA3ParetoFront,extreameSolution1,extreameSolution2);
    DAES_DM(i) = Delta(DAESParetoFront,extreameSolution1,extreameSolution2);

    
    % Find Convergence by Generational Distance (GD) Metric
    NSGA2_GD(i) = GenerationalDistance(NSGA2ParetoFront,trueParetoFront,2);
    MOGA_AQCD_GD(i) = GenerationalDistance(MOGA_AQCDParetoFront,trueParetoFront,2);
    DAES_GD(i) = GenerationalDistance(DAESParetoFront,trueParetoFront,2);
    NSGA3_GD(i) = GenerationalDistance(NSGA3ParetoFront,trueParetoFront,2);
    
    % Find set Coverage from  NSGA2 to MOGA_AQCD {Capacity metric}
    NSGA2_To_DAESSetCoverage(i) = SetCoverage2(NSGA2ParetoFront,DAESParetoFront);
    DAES_To_NSGA2SetCoverage(i) = SetCoverage2(DAESParetoFront,NSGA2ParetoFront);

    % Find set Coverage from  MOGA_AQCD to NSGA2 {Capacity metric}
    MOGA_AQCD_To_DAESSetCoverage(i) = SetCoverage2(MOGA_AQCDParetoFront,DAESParetoFront) ;
    DAES_To_MOGA_AQCDSetCoverage(i) = SetCoverage2(DAESParetoFront,MOGA_AQCDParetoFront) ;

    
   NSGA3_To_DAESSetCoverage(i) = SetCoverage2(NSGA3ParetoFront,DAESParetoFront);
    DAES_To_NSGA3SetCoverage(i) = SetCoverage2(DAESParetoFront,NSGA3ParetoFront);
    
    
end
