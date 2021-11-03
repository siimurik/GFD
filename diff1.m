function [dMdx] = diff1(M,dx)
% Write the description here
    disp('This is where the fun begins')
    n = length(M) ; %length of input
    dMdx = (M(2:n) - M(1:n-1))./dx;
end