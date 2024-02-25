function  New_Sol = simplebounds(Sol,Lb,Ub)
%% This function to make sure that new fireflies are within the bounds/limits
New_Sol = Sol;
% Apply the lower bound
I = New_Sol < Lb;
New_Sol(I) = Lb(I);
% Apply the upper bounds
J = New_Sol > Ub;
New_Sol(J) = Ub(J);


