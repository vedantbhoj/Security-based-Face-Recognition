function inter=histmatch(A,B)

for i = 1:40
    
    inter(i) = histogram_intersection(A(:,i)',B(:,i)');
end