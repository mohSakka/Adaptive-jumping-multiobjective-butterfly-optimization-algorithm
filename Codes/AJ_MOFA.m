function f = cfmofa(inp)

if nargin < 1
    inp = [100 200
        ];
end

%% Parameters
h = waitbar(0,'...CFMOFA Working please wait....');
CurrentFolder = pwd;
CurrentFolder(CurrentFolder == '\') = '/';
%%%% Constant
n    = inp(1);
tMax = inp(2);
theta = 10^(-4/tMax);
alpha = 1;
alpha = alpha * theta;
beta0 = 1.0;
gamma = 0.1;
mutateRatio=0.5;

Minimization = inf;
Moved = 0;
CF = 2; % compansation factor 
jumbingCF=2; % jumping compansation factor
EA = [];

m   = 2;          % number of objectives
RnD = zeros(n,2);
AllTestProblems = {'SCH','FON','POL','KUR','ZDT1','ZDT2','ZDT3','ZDT4','ZDT6'};
AllSeeds = 10;
AllIteration = length(AllTestProblems) * AllSeeds;
timer = 0;
for c=1:9
    TestProb =  AllTestProblems{c}
    n=inp(c,1);
    [d,Lb,Ub] = RangeOfTestFunction(TestProb);
    scale = abs(Ub-Lb);
    for seed = 1:10
        waitbar(0,h,['problem: ' TestProb ' seed: ' num2str(seed)]);
        rng(seed)
        %%%%
        timer = timer + 1;
        waitbar(timer/AllIteration,h)
        %%%%
        %% Generating the initial locations of n fireflies and the leader
        for i = 1 : n
            Sol(i,:) = Lb + (Ub - Lb) .* rand(1,d);
            f(i,:)   = TestFunctions(Sol(i,:),TestProb);
        end
        Leader = Sol(randi(n),:);
        %figure
        %% % Update moves and move to the brighter/more attractive
        for t = 1 : inp(c,2)
            %            CF=exp(1/t);
            disp(t)
            Sol_old = Sol;
            f_old = f;
            for i = 1 : n
                for j = 1 : n
                    steps    = alpha .* (rand(1,d)-0.5) .* scale;
                    if all(f(i,:) <= f(j,:)) && any(f(i,:) < f(j,:))
                        r        = sqrt(sum((Sol(i,:) - Sol(j,:)).^2));
                        beta     = beta0 * exp(-gamma*r.^2);
                        Sol(i,:) = Sol(i,:) + CF * beta * (Sol(j,:)-Sol(i,:)) + steps;
                        Sol(i,:) = simplebounds(Sol(i,:),Lb,Ub);
                        Moved = 1;
                    end
                end
                if Moved == 0   % if no one dominated solutions can be found
                    for fi = 1 : n
                        fc(fi,:) = TestFunctions(Sol(fi,:),TestProb);
                    end
                    % new in AJ-MOFA
                    % select random objective and create pdf based on it
                    randObj=randi(m);
                    WW=fc(:,randObj);
                    WW=(WW-min(WW))./(max(WW)-min(WW));
                    idx=fortune_wheel(1./WW);
                    gStar=Sol(idx,:); % Gstar 
                % replace the following formula with jumping method
                    % Sol(i,:) =Sol(i,:)+ C(1) * gStar + C(2) * Leader + steps;
                    %%%%%%% jumping - new in AJ-MOFA
                    if rand<exp(1-10*(t/tMax))
                        Sol(i,:) =Sol(i,:)+ jumbingCF * rand(size(Sol(i,:))).* (gStar-Sol(i,:))  ;
                    else
                        Sol(i,:) =Sol(i,:)+ jumbingCF * rand(size(Sol(i,:))).* (Leader-Sol(i,:)) ;
                    end
                    Sol(i,:) = simplebounds(Sol(i,:),Lb,Ub);
                    Minimization = inf;
                else
                    Moved = 0;  % Initilize for next firefly
                end
                %% new added
                % novel uniform-gaussian mutation 
                mutateProb=exp(1-10*(t/tMax));
                if rand <mutateProb
                    Sol(i,:)=myMutation(Sol(i,:),mutateRatio,TestProb,Lb,Ub);
                end
                % gaussian mutation 
                if rand<mutateProb
                    Sol(i,:)=normrnd(Sol(i,:),(Ub-Lb)/20);
                    Sol(i,:) = simplebounds(Sol(i,:),Lb,Ub);
                end 
                %% end new added
            end % for i=1:n

            %% Evalute the fitness/function values of the new population
            Sol_new = Sol;
            for i = 1 :n
                f_new(i,:) = TestFunctions(Sol_new(i,:),TestProb);
            end
            %% It's very important to combine both populations, otherwise,
            % the results may look odd and will be very inefficient.
            % The combined population consits of both the old and new solutions
            % So the total size of the combined population for sorting is 2*n
            X(1:n,:) = [Sol_new f_new];
            X((n+1):(2*n),:) = [Sol_old f_old];
            Sorted = solutions_sorting(X,m,d);
            %% Select n solutions among a combined population of 2*n solutions
            Sol_final = Select_pop(Sorted,m,d,n);
            % Decompose into solutions, fitness and ranking
            Sol = Sol_final(:,1:d);
            f   = Sol_final(:,(d+1):(d+m));
            RnD = Sol_final(:,(d+m+1):end);
            %% External Archive
            NumOfRank1 = sum(RnD(:,1) == 1);
            EA = [EA ; Sol_final(1:NumOfRank1,:)];
            if t > 1
                Sorted = solutions_sorting(EA(:,1:d+m),m,d);
                NumOfRank1 = sum(Sorted(:,(end-1)) == 1);
                EA = Sorted(1:NumOfRank1,:);
                EA_Capacity = size(EA,1);
                if EA_Capacity > n
                    difference = EA_Capacity - n;
                    for diff = 1 : difference
                        % replacing the following formula by using 
                        % roulette wheel instead
                        % ~,I] =min(EA(:,end));
                        fff=1./EA(:,end);
                        fff=(fff-min(fff))./(max(fff)-min(fff));
                        I= fortune_wheel(1./EA(:,end)); % roulette wheel
                        I(I==-1)= randi(length(EA(:,end)));
                        EA(I,:) = [];
                    end
                end
            end
            Leader = EA(randi(size(EA,1)),1:d);
            %% Running display at each 100 iterations
            %if ~mod(t,100)
            %    disp(strcat('Iterations t=',num2str(t)));
            plot(EA(:, (d+1)), EA(:, (d+m)),'ro');
            %    axis([0 1 -0.8 1]);
            %    xlabel('f_1'); ylabel('f_2');
            %    title('CFMOFA')
            drawnow;
            %                hold on
            %end
        end % End of t loop (up to tMax) and end of the main CFMOFA loop
        
        dir=[cd '/../EXP_results/dev_mut_CFMOFA_' TestProb]
%         if ~exist(dir)
%             mkdir(dir);
%         end
%         
        save([dir '/seed-' num2str(seed) '.mat'],'f','Sol','EA');
        
        %saveas(gcf,['CFMOFA_' num2str(seed) '_.png'])
        %close(gcf)
        EA = [];
    end % Initialize for next function
    Sol = [];
    X   = [];
    clc
end
close(h)
