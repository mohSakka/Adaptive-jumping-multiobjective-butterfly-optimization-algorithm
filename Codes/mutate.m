function sol=mutate(sol,mutateRatio,Lb,Ub,unifMutProb,gausMutProp)
randIds= randi(length(sol),[1 round(length(sol)*mutateRatio)]);
sol(randIds) = Lb(randIds) + (Ub(randIds) - Lb(randIds)) .* rand(1,length(randIds));
end