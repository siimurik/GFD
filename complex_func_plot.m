clear
[x,y] = meshgrid(-10: 0.1: 10);
z = x + i*y;
%G  = abs(((z+2) ./ ((z.^2) + 6.*z + 18)));
%G = abs(z.^3 + conj(z));
G = abs(conj(z .* z) + 1 ./ z);
figure;
surf(x,y,G)