function sol=myMutation(sol,mutateRatio,TestProb,Lb,Ub)
fOld=TestFunctions(sol,TestProb);
oldSol=sol;
randIds= randi(length(sol),[1 round(length(sol)*mutateRatio)]);
sol(randIds) = Lb(randIds) + (Ub(randIds) - Lb(randIds)) .* rand(1,length(randIds));
fnew=TestFunctions(sol,TestProb);
c=0;
if ~(all(fnew<=fOld) && any(fnew<fOld))
    sigma=(Ub-Lb).*0.05;
    sol=normrnd(sol,sigma);
    sol = simplebounds(sol,Lb,Ub);
end
% while ~(all(fnew<=fOld) && any(fnew<fOld))
%     sigma=(Ub-Lb).*0.1;
%     sol=normrnd(sol,sigma);
%     sol = simplebounds(sol,Lb,Ub);
%     fnew=TestFunctions(sol,TestProb);
%     c=c+1;
%     if c>10;      
%  sol(randIds) = Lb(randIds) + (Ub(randIds) - Lb(randIds)) .* rand(1,length(randIds));
% fnew=TestFunctions(sol,TestProb);
%     end
%     if c>100
%         break;
%     end
% end
% if ~(all(fnew<=fOld) && any(fnew<fOld))
%     sol=oldSol;
% end
end