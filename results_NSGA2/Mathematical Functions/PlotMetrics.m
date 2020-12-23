
%% Hyper Volume
Lgnd={'NSGA-II','MOGA-AQCD','NSGA-III','DAES'};
xLabl={'Number of Experiment'};
styledBar2([NSGA2_HV'  MOGA_AQCD_HV' NSGA3_HV' DAES_HV'],Lgnd,xLabl,'Hyper Volume','Hyper Volume Metric',1.2,1)
    export_fig([path1 'Hyper Volume'] ,'-jpg',res)

%% NDS
styledBar2([NSGA2_NDS' MOGA_AQCD_NDS' NSGA3_NDS' DAES_NDS'],Lgnd,xLabl,'Number Of NDS','Number Of NDS',1.2,1)
    export_fig([path1 'NDS'] ,'-jpg',res)

%% Delta
styledBar2([NSGA2_DM' MOGA_AQCD_DM' NSGA3_DM' DAES_DM'],Lgnd,xLabl,'Delta','Delta',1.2,1)
    export_fig([path1 'Delta'] ,'-jpg',res)

%% GenerationalDistance (GD)
styledBar2([NSGA2_GD' MOGA_AQCD_GD' NSGA3_GD' DAES_GD'],Lgnd,xLabl,'Generational Distance ','Generational Distance',1.2,0.01)
    export_fig([path1 'Generational Distance'] ,'-jpg',res)

%% Set Coverage
lgnd={'NSGA-II TO DAES','DAES TO NSGA-II','MOGA-AQCD TO DAES','DAES TO MOGA-AQCD','NSGA-III TO DAES','DAES TO NSGA-III'};
styledBar2([NSGA2_To_DAESSetCoverage' DAES_To_NSGA2SetCoverage' MOGA_AQCD_To_DAESSetCoverage' DAES_To_MOGA_AQCDSetCoverage' NSGA3_To_DAESSetCoverage' DAES_To_NSGA3SetCoverage'],lgnd,xLabl,'Set Coverage','Set Coverage',1.2,1)

    export_fig([path1 'Set Coverage'] ,'-jpg',res)

%% plot average of metrics

PlotAverageMetrics;

%% Ttest
DAES_DM=DAES_DM';
MOGA_AQCD_DM=MOGA_AQCD_DM';
NSGA2_DM=NSGA2_DM';
NSGA3_DM=NSGA3_DM';
T_DM = table(DAES_DM,MOGA_AQCD_DM,NSGA2_DM,NSGA3_DM);
writetable(T_DM,[path1 'Ttest.xlsx'],'Sheet',1)
DAES_GD=DAES_GD';
MOGA_AQCD_GD=MOGA_AQCD_GD';
NSGA2_GD=NSGA2_GD';
NSGA3_GD=NSGA3_GD';
T_GD = table(DAES_GD,MOGA_AQCD_GD,NSGA2_GD,NSGA3_GD);
writetable(T_GD,[path1 'Ttest.xlsx'],'Sheet',2)

DAES_HV=DAES_HV';
MOGA_AQCD_HV=MOGA_AQCD_HV';
NSGA2_HV=NSGA2_HV';
NSGA3_HV=NSGA3_HV';
T_HV = table(DAES_HV,MOGA_AQCD_HV,NSGA2_HV,NSGA3_HV);
writetable(T_HV,[path1 'Ttest.xlsx'],'Sheet',3)

DAES_NDS=DAES_NDS';
MOGA_AQCD_NDS=MOGA_AQCD_NDS';
NSGA2_NDS=NSGA2_NDS';
NSGA3_NDS=NSGA3_NDS';
T_NDS = table(DAES_NDS,MOGA_AQCD_NDS,NSGA2_NDS,NSGA3_NDS);
writetable(T_NDS,[path1 'Ttest.xlsx'],'Sheet',4)


DAES_To_MOGA_AQCDSetCoverage=DAES_To_MOGA_AQCDSetCoverage';
DAES_To_NSGA2SetCoverage=DAES_To_NSGA2SetCoverage';
DAES_To_NSGA3SetCoverage=DAES_To_NSGA3SetCoverage';
MOGA_AQCD_To_DAESSetCoverage=MOGA_AQCD_To_DAESSetCoverage';
NSGA2_To_DAESSetCoverage=NSGA2_To_DAESSetCoverage';
NSGA3_To_DAESSetCoverage=NSGA3_To_DAESSetCoverage';
T_setCov=table(DAES_To_MOGA_AQCDSetCoverage,DAES_To_NSGA2SetCoverage,DAES_To_NSGA3SetCoverage,...
    MOGA_AQCD_To_DAESSetCoverage,NSGA2_To_DAESSetCoverage,NSGA3_To_DAESSetCoverage);

writetable(T_setCov,[path1 'Ttest.xlsx'],'Sheet',5)

