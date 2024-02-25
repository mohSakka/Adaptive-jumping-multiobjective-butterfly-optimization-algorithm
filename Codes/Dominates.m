function d=Dominates(sob1,sob2)
if all(sob1<=sob2) && any(sob1<sob2)
    d = true;
else
    d = false;
end
end