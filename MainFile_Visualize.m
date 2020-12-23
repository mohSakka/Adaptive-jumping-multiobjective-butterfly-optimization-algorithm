%% initialization
clc
clear
close all
addpath([cd '/Codes']);
TestProblems = {'SCH','FON','POL','KUR','ZDT1','ZDT2','ZDT3','ZDT4','ZDT6'};
%%%
AllHV_CF = [];
AllHV_N2 = [];
AllHV_df = [];
AllHV_fa = [];
%%%
AllSC_cf_fa=[];
AllSC_fa_cf=[];
AllSC_N2_fa=[];
AllSC_fa_N2=[];
AllSC_N2_CF=[];
AllSC_CF_N2=[];
AllSC_cf_df=[];
AllSC_df_cf=[];
AllSC_fa_df=[];
AllSC_df_fa=[];
AllSC_df_n2=[];
AllSC_n2_df=[];
%%%
AllNDS_fa=[];
AllNDS_N2=[];
AllNDS_df=[];
AllNDS_CF=[];
%%%
AllDelta_CF=[];
AllDelta_fa=[];
AllDelta_df=[];
AllDelta_N2=[];
%%%
AllGenDis_fa=[];
AllGenDis_df=[];
AllGenDis_N2=[];
AllGenDis_CF=[];
%%%
%%
for ccc = 1:9
    TestProblem = TestProblems{ccc}
%     TestProblem = cell2mat(TestProblem)
    TP = load ([cd '/Data/' TestProblem]);
    TP = cell2mat(struct2cell(TP));
    for se = 1:10
        load([cd '/results_NSGA22/Mathematical Functions/Experiment/'   TestProblem '/Scenario-' num2str(se) '/Scenario-' ...
            num2str(se) '_Benchmarck-NSGA-II.mat'])
        PF_N2 = paretoFront.solutionsObjectiveValues;
        cfmofa=load(['results/CFMOFA_' TestProblem '_' num2str(se) '_results']);
        dcf=load(['EXP_results/dev_mut_CFMOFA_' TestProblem '/seed-' num2str(se)]);
        mofa=load(['results/MOFA_' TestProblem '_' num2str(se) '_results']);

%         PF_Cfmofa = EA(:,size(Sol,2)+1:size(Sol,2)+2);
        fcf=DetermineDomination(cfmofa.f);
        PF_Cfmofa=fcf(fcf(:,end)==0,1:end-1);
        fd=DetermineDomination(dcf.f);
        PF_dmofa=fd(fd(:,end)==0,1:end-1);
        ff=DetermineDomination(mofa.f);
        PF_MOFA=ff(ff(:,end)==0,1:end-1);
        %%
        %%%
        SC           =  SetCoverage2(PF_Cfmofa,PF_N2);
        AllSC_CF_N2     =  [AllSC_CF_N2 ; SC];
        SC           =  SetCoverage2(PF_N2,PF_Cfmofa);
        AllSC_N2_CF        =  [AllSC_N2_CF ; SC];
        SC           =  SetCoverage2(PF_MOFA,PF_N2);
        AllSC_fa_N2        =  [AllSC_fa_N2 ; SC];
        SC           =  SetCoverage2(PF_N2,PF_MOFA);
        AllSC_N2_fa        =  [AllSC_N2_fa ; SC];
        SC           =  SetCoverage2(PF_MOFA,PF_Cfmofa);
        AllSC_fa_cf        =  [AllSC_fa_cf ; SC];
        SC           =  SetCoverage2(PF_Cfmofa,PF_MOFA);
        AllSC_cf_fa        =  [AllSC_cf_fa ; SC];
        SC           =  SetCoverage2(PF_dmofa,PF_MOFA);
        AllSC_df_fa        =  [AllSC_df_fa ; SC];
        SC           =  SetCoverage2(PF_dmofa,PF_dmofa);
        AllSC_fa_df        =  [AllSC_fa_df ; SC];
        SC           =  SetCoverage2(PF_dmofa,PF_Cfmofa);
        AllSC_df_cf        =  [AllSC_df_cf ; SC];
        SC           =  SetCoverage2(PF_Cfmofa,PF_dmofa);
        AllSC_cf_df        =  [AllSC_cf_df ; SC];
        SC           =  SetCoverage2(PF_dmofa,PF_N2);
        AllSC_df_n2        =  [AllSC_df_n2 ; SC];
        SC           =  SetCoverage2(PF_N2,PF_dmofa);
        AllSC_n2_df        =  [AllSC_n2_df ; SC];
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        HV           =  HyperVolume(PF_N2);
        AllHV_N2        =  [AllHV_N2;HV];
        HV           =  HyperVolume(PF_Cfmofa);
        AllHV_CF     =  [AllHV_CF;HV];
        HV=HyperVolume(PF_MOFA);
        AllHV_fa      =[AllHV_fa;HV];
        HV=HyperVolume(PF_dmofa);
        AllHV_df     =[AllHV_df;HV];
        %%%
        NDS          =  numberOfNonDominatedSolutions(PF_N2);
        AllNDS_N2       =  [AllNDS_N2;NDS];
        NDS          =  numberOfNonDominatedSolutions(PF_Cfmofa);
        AllNDS_CF    =  [AllNDS_CF;NDS];
        NDS=numberOfNonDominatedSolutions(PF_MOFA);
        AllNDS_fa=[AllNDS_fa;NDS];
        NDS=numberOfNonDominatedSolutions(PF_dmofa);
        AllNDS_df=[AllNDS_df;NDS];
        %%%
        Delta        =  DeltaQuotMetric(PF_N2);
        AllDelta_N2     =  [AllDelta_N2;Delta];
        Delta        =  DeltaQuotMetric(PF_Cfmofa);
        AllDelta_CF  =  [AllDelta_CF;Delta];
        Delta= DeltaQuotMetric(PF_MOFA);
        AllDelta_fa  =  [AllDelta_fa;Delta];
        Delta= DeltaQuotMetric(PF_dmofa);
        AllDelta_df  =  [AllDelta_df;Delta];
        %%%
        GenDis       =  GenerationalDistance(PF_N2,TP,2);
        AllGenDis_N2    =  [AllGenDis_N2;GenDis];
        GenDis       =  GenerationalDistance(PF_Cfmofa,TP,2);
        AllGenDis_CF =  [AllGenDis_CF;GenDis];
        GenDis       =  GenerationalDistance(PF_MOFA,TP,2);
        AllGenDis_fa =  [AllGenDis_fa;GenDis];
        GenDis       =  GenerationalDistance(PF_dmofa,TP,2);
        AllGenDis_df =  [AllGenDis_df;GenDis];
    end
    %% ttest
    % ttest
     [~,p_d_f]=ttest(AllSC_df_fa,AllSC_fa_df);
     [~,p_d_c]=ttest(AllSC_df_cf,AllSC_cf_df);
     [~,p_d_n]=ttest(AllSC_df_n2,AllSC_n2_df);
    %% Plotting
    
    %% set coverage
    colors = [0 0 1; 0 1 0; 1 0 0; 0.6588 0.1961 0.5373;...
       1.0000 0.4157 0;0.3373 0.6588 0.5451];
    Lgnd={'C(AJ-MOFA,MOFA)','C(MOFA,AJ-MOFA)','C(AJ-MOFA,CF-MOFA)',...
        'C(CF-MOFA,AJ-MOFA)','C(AJ-MOFA,NSGA-II)','C(NSGA-II,AJ-MOFA)'};
    figure;
    boxplot([AllSC_df_fa,AllSC_fa_df,AllSC_df_cf,AllSC_cf_df,...
        AllSC_df_n2,AllSC_n2_df],'Labels',{},'Colors',colors);
   
    boxes = findobj(gca, 'Tag', 'Box');
    legend(boxes([end:-1:1]), Lgnd,'Location','NorthEastOutside');
    title(['Test Problem : ' TestProblem  '___SetCoverage']);  
%     saveas(gcf,['images/' TestProblem '_SetCoverage.png'])
%     close(gcf)
%% ttest
lgnd={'ttest(C(AJ-MOFA,MOFA),(MOFA,AJ-MOFA))',...
    'ttest(C(AJ-MOFA,CF-MOFA),(CF-MOFA,AJ-MOFA))',...
    'ttest(C(AJ-MOFA,NSGA-II),(NSGA-II,AJ-MOFA))'};
xLabl='algorithm';
yLabl='ttest';
Titl=['SetCoverage_ttest____Test Problem :' TestProblem]  ;
bdata=[p_d_f,p_d_c,p_d_n];
styledBar(bdata,xLabl,yLabl,Titl,lgnd);
%% HV
Lgnd={'AJ-MOFA','MOFA','CF-MOFA','NSGA-II'};
    figure
    boxplot([AllHV_df,AllHV_fa,AllHV_CF,AllHV_N2],'Colors',colors);
boxes = findobj(gca, 'Tag', 'Box');
    legend(boxes([end:-1:1]), Lgnd,'Location','NorthEastOutside');
    title(['Test Problem : ' TestProblem  '___HV']);
    %     saveas(gcf,['images/' TestProblem '_HyperVolume.png'])
%     %     close(gcf)
%% NDS
    figure
    boxplot([AllNDS_df,AllNDS_fa,AllNDS_CF,AllNDS_N2],'Colors',colors);
boxes = findobj(gca, 'Tag', 'Box');
    legend(boxes([end:-1:1]), Lgnd,'Location','NorthEastOutside');
    title(['Test Problem : ' TestProblem  '___NDS']);
%     saveas(gcf,['images/' TestProblem '_Number of non dominated solutions.png'])
%     %     close(gcf)
%% Delta
    figure
    boxplot([AllDelta_df,AllDelta_fa,AllDelta_CF,AllDelta_N2],'Colors',colors);
boxes = findobj(gca, 'Tag', 'Box');
    legend(boxes([end:-1:1]), Lgnd,'Location','NorthEastOutside');
    title(['Test Problem : ' TestProblem  '___Delta Measure']);
%     saveas(gcf,['images/' TestProblem '_DeltaQuotMetric.png'])
%     %     close(gcf)
%% GD
    figure
    boxplot([AllGenDis_df,AllGenDis_fa,AllGenDis_CF,AllGenDis_N2],'Colors',colors);
boxes = findobj(gca, 'Tag', 'Box');
    legend(boxes([end:-1:1]), Lgnd,'Location','NorthEastOutside');
    title(['Test Problem : ' TestProblem  '___GD']);
    
    %%
     h = findobj('tag','Box');
    n=length(h);
    for k=1:n
    set(h(k),'linewidth',2);
    end
%     
%     %     saveas(gcf,['images/' TestProblem '_GenerationalDistance.png'])
%     %     close(gcf)
%%
AllHV_CF = [];
AllHV_N2 = [];
AllHV_df = [];
AllHV_fa = [];
%%%
AllSC_cf_fa=[];
AllSC_fa_cf=[];
AllSC_N2_fa=[];
AllSC_fa_N2=[];
AllSC_N2_CF=[];
AllSC_cf_df=[];
AllSC_df_cf=[];
AllSC_fa_df=[];
AllSC_df_fa=[];
AllSC_df_n2=[];
AllSC_n2_df=[];
AllSC_CF_N2=[];
%%%
AllNDS_fa=[];
AllNDS_N2=[];
AllNDS_df=[];
AllNDS_CF=[];
%%%
AllDelta_CF=[];
AllDelta_fa=[];
AllDelta_df=[];
AllDelta_N2=[];
%%%
AllGenDis_fa=[];
AllGenDis_df=[];
AllGenDis_N2=[];
AllGenDis_CF=[];
%%%
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
