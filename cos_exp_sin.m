function [y] = cos_exp_sin(x)
    y = 1./(2.*x).*cos(2.*x)+exp(-2.*x).*sin(4.*x);
end