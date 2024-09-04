% code for rref 
% (Gauss-Jordan Elimination Method for producing 
% row-reduced echelon form of an augmented matrix.)

A = input('Enter your coefficient matrix: ')
b = input('Enter your source vector: ')
N = length(b); % no. of unknonws
X = zeros(N, 1);
Aug = [A b]

for j = 1:N % columns
    Aug(j,:) = Aug(j,:)/Aug(j,j)
    for i = 1:N % rows
        if i ~= j 
            m = Aug(i,j)
            Aug(i,:) = Aug(i,:) - m*Aug(j,:)
        end 
    end 
end
