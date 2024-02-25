function sol=GaussianMutation(sol,sigma)
for j=1:length(sol)
        sol(j)=normrnd(sol(j),sigma(j));    
end
