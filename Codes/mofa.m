function f = mofa(inp)

if nargin < 1
    inp = [100 25;
        100 50 ;
        100 50;
        150 75;
        100 50;
        100 50;
        100 50;
        100 50;
        100 50
        ];
end

%% Parameters
h = waitbar(0,'...MOFA Working please wait....');
CurrentFolder = pwd;
CurrentFolder(CurrentFolder == '\') = '/';
%%%% Constant
n    = inp(1);
tMax = inp(2);
theta = 10^(-4/tMax);
alpha = 1.0;
alpha = alpha * theta;
beta0 = 1.0;
gamma = 0.1;

Minimization = inf;
Moved = 0;

m   = 2;        % number of objectives
RnD = zeros(n,2);
AllTestProblems = {'SCH','FON','POL','KUR','ZDT1','ZDT2','ZDT3','ZDT4','ZDT6'};
AllSeeds = 10;
AllIteration = length(AllTestProblems) * AllSeeds;
timer = 0;

for c=5:9
    TestProb =  AllTestProblems{c}
    n=inp(c,1);
    tMax=inp(c,2);
    [d,Lb,Ub] = RangeOfTestFunction(TestProb);
    scale = abs(Ub-Lb);
    for seed = 1 : AllSeeds
        rng(seed)
        %%%%
        timer = timer + 1;
        waitbar(timer/AllIteration)
        %%%%
        %% Generating the initial locations of n fireflies
        for i = 1 : n
            Sol(i,:) = Lb + (Ub - Lb) .* rand(1,d);
            f(i,:)   = TestFunctions(Sol(i,:),TestProb);
        end
        Leader = Lb + (Ub - Lb) .* rand(1,d);
        %figure
        %% % Update moves and move to the brighter/more attractive
        for t = 1 : tMax
            disp(t)
            Sol_old = Sol;
            f_old = f;
            for i = 1 : n
                for j = 1 : n
                    steps    = alpha .* (rand(1,d)-0.5) .* scale;
                    if all(f(i,:) <= f(j,:)) && any(f(i,:) < f(j,:))
                        r        = sqrt(sum((Sol(i,:) - Sol(j,:)).^2));
                        beta     = beta0 * exp(-gamma*r.^2);
                        Sol(i,:) = Sol(i,:) + beta * (Sol(j,:)-Sol(i,:)) + steps;
                        Sol(i,:) = simplebounds(Sol(i,:),Lb,Ub);
                        Moved = 1;
                    end
                end
                if Moved == 0   % if no one dominated solutions can be found
                    W = rand(1,m) / m;
                    W = W / sum(W);
                    for fi = 1 : n
                        fc(fi,:) = TestFunctions(Sol(fi,:),TestProb);
                        WW = W(1)*fc(fi,1) + W(2)*fc(fi,2);
                        if WW < Minimization
                            Minimization = WW;
                            gStar = Sol(fi,:);
                        end
                    end
                    Sol(i,:) = gStar + steps;
                    Sol(i,:) = simplebounds(Sol(i,:),Lb,Ub);
                    Minimization = inf;
                else
                    Moved = 0;  % Initilize for next firefly
                end
            end
            %Moved = 0;  % Initialize for next iteration
            %% Evalute the fitness/function values of the new population
            Sol_new = Sol; 
            for i = 1 :n
                f_new(i,:) = TestFunctions(Sol_new(i,:),TestProb);
            end
            %% It's very important to combine both populations, otherwise,
            % the results may look odd and will be very inefficient.     
            % The combined population consits of both the old and new solutions
            % So the total size of the combined population for sorting is 2*n
Sol_new
f_new
            X(1:n,:) = [Sol_new f_new];
            X((n+1):(2*n),:) = [Sol_old f_old];
            Sorted = solutions_sorting(X,m,d);
            %% Select n solutions among a combined population of 2*n solutions
            Sol_final = Select_pop(Sorted,m,d,n);
            % Decompose into solutions, fitness and ranking
            Sol = Sol_final(:,1:d);
            f   = Sol_final(:,(d+1):(d+m));
            Rnk = Sol_final(:,(d+m+1));
             pareto=Sol_final(Rnk==1,1:d);
            %% Running display at each 100 iterations
            %if ~mod(t,100), 
            %    disp(strcat('Iterations t=',num2str(t)));
            %    plot(f(:, 1), f(:, 2),'ro','MarkerSize',3); 
            %    axis([0 1 -0.8 1]);
            %    xlabel('f_1'); ylabel('f_2');
            %    title('MOFA')
            %    drawnow;
            %end    
        end % End of t loop (up to tMax) and end of the main MOFA loop
        save([fileparts(CurrentFolder) '/results2/MOFA_' TestProb '_' num2str(seed) '_results.mat'],'f','Sol','pareto');
        %saveas(gcf,['MOFA_' num2str(seed) '_.png'])
        %close(gcf)
    end % Intialize for next function 
    Sol = [];
    X = [];
    clc
end
close(h)
        
           
             
        
    
    
    
    
      
    

 















