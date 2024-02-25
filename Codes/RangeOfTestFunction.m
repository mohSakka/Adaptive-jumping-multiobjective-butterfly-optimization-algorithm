function [d,Lb,Ub] = RangeOfTestFunction(TestFunctionType)
    switch (TestFunctionType)
        case {'SCH'}
            d = 1;
            Lb = -10^5 * ones(1,d);
            Ub =  10^5 * ones(1,d);
        case {'SCH2'}
            d = 1;
            Lb = -5 * ones(1,d);
            Ub = 10 * ones(1,d);
        case {'FON'}
            d  = 2;
            Lb = -4 * ones(1,d);
            Ub =  4 * ones(1,d);
        case{'POL'}
            d = 2;
            Lb = -pi * ones(1,d);
            Ub =  pi * ones(1,d);
        case{'KUR'}
            d = 3;
            Lb = -5 * ones(1,d);
            Ub =  5 * ones(1,d);
        case{'ZDT1','ZDT2','ZDT3'}
            d = 30;
            Lb = 0 * ones(1,d);
            Ub = 1 * ones(1,d);
        case{'ZDT4'}
            d = 10;
            Lb1 =  0 * ones(1,1);
            Ub1 =  1 * ones(1,1);
            Lb2 = -5 * ones(1,d-1);
            Ub2 =  5 * ones(1,d-1);
            Lb =   [Lb1 , Lb2];
            Ub =   [Ub1 , Ub2];
        case{'ZDT6'}
            d = 10;
            Lb = 0 * ones(1,d);
            Ub = 1 * ones(1,d);
    end

