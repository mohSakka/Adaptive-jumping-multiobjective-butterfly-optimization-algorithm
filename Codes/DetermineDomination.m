%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA121
% Project Title: Multi-Objective Particle Swarm Optimization (MOPSO)
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function f=DetermineDomination(f)
f=[f zeros(size(f,1),1)];
    nPop=size(f,1);
    tmp=zeros(size(f,1),1);
  
    for i=1:nPop-1
        for j=i+1:nPop
            
            if Dominates(f(i,1:end-1),f(j,1:end-1))
               tmp(j,end)=1;
            end
            
            if Dominates(f(j,1:end-1),f(i,1:end-1))
                tmp(i,end)=1;
            end
            
        end
    end
f(:,end)=tmp;
end