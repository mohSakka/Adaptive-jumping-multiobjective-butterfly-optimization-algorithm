function f = TestFunctions(x,TestFunctionType)
    n = length(x);
    switch (TestFunctionType)
        case {'SCH'}
            % Schaffer's Problem No.1 (SCH1)
            % CATEGORY: 1-DIMENSION
            % Number of objectives: 2
            % Objective: minimization
            % Range of initial points: -a <= x <= a , a is between 10 and 10^5 
            % Pareto optimal solutions: x = [0 2]
            % Pareto solutions relationship: f2=(sqrt(f1)-2)^2
            f(1) =  x^2;
            f(2) = (x-2)^2;
        case {'SCH2'}     
            % Schaffer's Problem No.2 (SCH2)
            % CATEGORY: 1-DIMENSION
            % Number of objectives: 2
            % Objective: minimization
            % Range of initial points: -5 <= x <= 10
            % Pareto optimal solutions: x = {[1 2]U[4 5]}
            f(1) = -x * (x <= 1) + (x - 2) * (1 < x & x <= 3) + (4 - x) * (3 < x & x <= 4) + (x - 4) * (x > 4);
            f(2) = (x - 5)^2;
        case {'FON'}
            % Fonseca-Fleming's Problem (FON)
            % CATEGORY: n-DIMENSIONS , n = 3
            % Number of objectives: 2
            % Objective: minimization
            % Range of initial points: -4 <= xj <= 4 , j=1,2,...,n
            % Pareto optimal solutions: xj = [-1/n 1/n] , j=1,2,...,n
            % Pareto solutions relationship: 0 =< f1 <= 1-exp(-4) , f2 = 1-exp(-(2-sqrt(-log2(1-f1)))^2) :
            f(1) = 1 - exp(-sum((x - 1/sqrt(n)).^2));
            f(2) = 1 - exp(-sum((x + 1/sqrt(n)).^2));
        case {'POL'}    
            % Poloni's Problem (POL)
            % CATEGORY: n-DIMENSIONS , n = 2
            % Number of objectives: 2
            % Objective: minimization
            % Range of initial points: -pi <= xj <= pi , j=1,..,n
            % Pareto-optimal solutions are hard to be obtained here
            a1 = 0.5*sin(1)-2*cos(1)+sin(2)-1.5*cos(2);
            a2 = 1.5*sin(1)-cos(1)+2*sin(2)-0.5*cos(2);
            b1 = 0.5.*sin(x(1))-2.*cos(x(1))+sin(x(2))-1.5.*cos(x(2));
            b2 = 1.5.*sin(x(1))-cos(x(1))+2.*sin(x(2))-0.5.*cos(x(2));
            %%%%
            f(1) =  1+(a1-b1).^2+(a2-b2).^2;
            f(2) = (x(1)+3).^2+(x(2)+1).^2;
        case {'KUR'}
            % Kurtosis's Problem (KUR)
            % CATEGORY: n-DIMENSIONS , n = 3
            % Number of objectives: 2
            % Objective: minimization
            % Range of initial points: -5 <= xj <= 5 , j=1,..,n
            f(1) = sum(-10*exp(-0.2*sqrt((x(1:n-1)).^2 + (x(2:n)).^2)));
            f(2) = sum((abs(x(1:n))).^0.8 + 5 * sin((x(1:n)).^3));
        case {'ZDT1'}
            % Zitzler-deb-thiele 1's Problem (ZDT1)
            % CATEGORY: n-DIMENSIONS , n = 30
            % Number of objectives: 2
            % Objective: minimization
            % Range of initial points: 0 <= xj <= 1 , j=1,..,n
            f(1) = x(1);
            g = 1 + (9 * sum(x(2:n))) / (n - 1);
            h = 1 - sqrt(f(1)/g);
            f(2) = g * h;
        case {'ZDT2'}
            % Zitzler-deb-thiele 2's Problem (ZDT2)
            % CATEGORY: n-DIMENSIONS , n = 30
            % Number of objectives: 2
            % Objective: minimization
            % Range of initial points: 0 <= xj <= 1 , j=1,..,n
            f(1) = x(1);
            g = 1 + (9 * sum(x(2:n))) / (n - 1);
            h = 1 - (f(1)/g)^2;
            f(2) = g*h;
        case {'ZDT3'}    
            % Zitzler-deb-thiele 3's Problem (ZDT3)
            % CATEGORY: n-DIMENSIONS , n = 30
            % Number of objectives: 2
            % Objective: minimization
            % Range of initial points: 0 <= xj <= 1 , j=1,..,n
            f(1) = x(1);
            g = 1 + 9 * sum(x(2:n)) / (n - 1);
            h = 1 - sqrt(f(1)/g) - f(1) / g * sin(10*pi*f(1));
            f(2) = g*h;
        case {'ZDT4'}
            % Zitzler-deb-thiele 4's Problem (ZDT4)
            % CATEGORY: n-DIMENSIONS , n = 10
            % Number of objectives: 2
            % Objective: minimization
            % Range of initial points:  0 =< x1 <= 1, -5 <= xj <= 5 , j=2,..,n
            f(1) = x(1);
            x2 = x(2:n);
            g = 1 + 10*(n -1) + sum(x2.^2 - 10*cos(4*pi*x2));
            h = 1-sqrt(x(1)/g);
            f(2) = g * h;
        case{'ZDT6'}
            % Zitzler-deb-thiele 6's Problem (ZDT4)
            % CATEGORY: n-DIMENSIONS , n = 10
            % Number of objectives: 2
            % Objective: minimization
            % Range of initial points:  0 =< xj <= 1 , j=1,..,n
            f(1) = 1 - exp(-4*x(1)) * (sin(6*pi*x(1)))^6;
            g = 1 + 9*(sum(x(2:n)) /(n-1))^0.25;
            h = 1 - (f(1)/g)^2;
            f(2) = h*g;        
    end