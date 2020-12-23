
%% Average of HyperVolume

NSGA2AvergeHyperVolume= mean(NSGA2_HV);
MOGA_AQCDAvergeHyperVolume= mean(MOGA_AQCD_HV);
NSGA3AvergeHyperVolume= mean(NSGA3_HV);
DAESAvergeHyperVolume= mean(DAES_HV);
Lgnd={'NSGA-II','MOGA-AQCD','NSGA-III','DAES'};
xLabl='Method';
styledBar([NSGA2AvergeHyperVolume MOGA_AQCDAvergeHyperVolume NSGA3AvergeHyperVolume DAESAvergeHyperVolume]...
    ,Lgnd,xLabl,'Hyper Volume','Average Of Hyper Volume Metric',1.2,1);
    export_fig([path1 'Avr Hyper Volume'] ,'-jpg',res)

%% Average of NDS
NSGA2AvergeNDS= mean(NSGA2_NDS);
MOGA_AQCDAvergeNDS= mean(MOGA_AQCD_NDS);
DAESAvergeNDS= mean(DAES_NDS);
NSGA3AvergeNDS= mean(NSGA3_NDS);
styledBar([ NSGA2AvergeNDS MOGA_AQCDAvergeNDS NSGA3AvergeNDS  DAESAvergeNDS]...
        ,Lgnd,xLabl,'Number Of NDS','Avarage Number Of NDS',1.2,1);
 export_fig([path1 'Avr NDS'] ,'-jpg',res)
%% Average of Delta
NSGA2AvergeDelta= mean(NSGA2_DM);
MOGA_AQCDAvergeDelta = mean(MOGA_AQCD_DM);
NSGA3AvergeDelta = mean(NSGA3_DM);
DAESAvergeDelta = mean(DAES_DM);

styledBar([NSGA2AvergeDelta,MOGA_AQCDAvergeDelta,NSGA3AvergeDelta,DAESAvergeDelta]...
            ,Lgnd,xLabl,'Delta Metric','Avarage Of Delta Metric ',1.2,1);
 export_fig([path1 'Avr Delta'] ,'-jpg',res)
%% Average of GenerationalDistance
NSGA2AvergeGenerationalDistance = mean(NSGA2_GD);
MOGA_AQCDAvergeGenerationalDistance = mean(MOGA_AQCD_GD);
NSGA3AvergeGenerationalDistance = mean(NSGA3_GD);
DAESAvergeGenerationalDistance = mean(DAES_GD);

styledBar([NSGA2AvergeGenerationalDistance,MOGA_AQCDAvergeGenerationalDistance,NSGA3AvergeGenerationalDistance,DAESAvergeGenerationalDistance]...
                ,Lgnd,xLabl,'Generational Distance Metric','Avarage Of Generational Distance Metric  ',1.2,1);
 export_fig([path1 'Avr Generational Distance'] ,'-jpg',res)
%% Average of Set Coverage
averge_NSGA2_To_DAESSetCoverage = mean(NSGA2_To_DAESSetCoverage);
averge_DAES_To_NSGA2SetCoverage = mean(DAES_To_NSGA2SetCoverage);
averge_MOGA_AQCD_To_DAESSetCoverage = mean(MOGA_AQCD_To_DAESSetCoverage);
averge_DAES_To_MOGA_AQCDSetCoverage = mean(DAES_To_MOGA_AQCDSetCoverage);
averge_NSGA3_To_DAESSetCoverage = mean(NSGA3_To_DAESSetCoverage);
averge_DAES_To_NSGA3SetCoverage = mean(DAES_To_NSGA3SetCoverage);
lgnd={'NSGA-II TO DAES','DAES TO NSGA-II','MOGA-AQCD TO DAES','DAES TO MOGA-AQCD','NSGA-III TO DAES','DAES TO NSGA-III'};
styledBar([averge_NSGA2_To_DAESSetCoverage,averge_DAES_To_NSGA2SetCoverage,averge_MOGA_AQCD_To_DAESSetCoverage,averge_DAES_To_MOGA_AQCDSetCoverage,averge_NSGA3_To_DAESSetCoverage,averge_DAES_To_NSGA3SetCoverage]...
,lgnd,xLabl,'Set Coverage','Average Of Set Coverage',1.2,1)

 export_fig([path1 'Avr Set Coverage'] ,'-jpg',res)