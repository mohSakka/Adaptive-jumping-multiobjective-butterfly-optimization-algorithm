function new_Sol = Select_pop(firefly, m, ndim, npop)
% The input population to this part has twice (ntwice) of the needed 
% population size (npop). Thus, selection is done based on ranking and 
% crowding distances, calculated from the non-dominated sorting
ntwice= size(firefly,1);
% Ranking is stored in column Krank
Krank=m+ndim+1;
% Sort the population of size 2*npop according to their ranks
[~,Index] = sort(firefly(:,Krank)); 
sorted_firefly=firefly(Index,:);
% Get the maximum rank among the population
RankMax=max(firefly(:,Krank)); 

%% Main loop for selecting solutions based on ranks and crowding distances
K = 0;  % Initialization for the rank counter 
% Loop over all ranks in the population
for i =1:RankMax,  
    % Obtain the current rank i from sorted solutions
    RankSol = max(find(sorted_firefly(:, Krank) == i));
    % In the new solutions, there can be npop solutions to fill
    if RankSol<npop,
       new_Sol(K+1:RankSol,:)=sorted_firefly(K+1:RankSol,:);
    end 
    % If the population after addition is large than npop, re-arrangement
    % or selection is carried out
    if RankSol>=npop
        % Sort/Select the solutions with the current rank 
        candidate_firefly=sorted_firefly(K + 1 : RankSol, :);
        [~,tmp_Rank]=sort(candidate_firefly(:,Krank+1),'descend');
        % Fill the rest (npop-K) fireflies/solutions up to npop solutions 
        for j = 1:(npop-K), 
            new_Sol(K+j,:)=candidate_firefly(tmp_Rank(j),:);
        end
    end
    % Record and update the current rank after adding new solutions
    K = RankSol;
    if size(new_Sol,1) == npop
        break
    end
end
