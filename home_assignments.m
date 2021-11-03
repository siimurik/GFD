clear
%% Plotting the function
% Initial data stored in x
x = 0.09:0.01:7;
% y stores the values of the exotic function. 
% Function defined in file cos_exp_sin.m
f = cos_exp_sin(x);
%Simple function used to plot the data
%plot(x, f, 'm', 'LineWidth',2)

%% Adding the legend, axis labels, title and grid
% Legend
legend({'f(x)'})
% Axis labels
xlabel('$$ 0.09 < x < 7.00 $$', 'Interpreter','latex') 
ylabel('$$ f(x)$$','Interpreter','latex') 
% Title
head = '$$ f(x)=\frac{1}{2 x} \cos 2 x+\mathrm{e}^{-2 x} \sin 4 x $$';
title(head,'interpreter','latex')
% Grid
grid on
%% Set ticks to x-axis
s = 4;
m = [0.09 0 0 0 0 7.00]';
for n = 1:s
    m(n+1) = (7-0.09)/5*n;
end
xticks(m)
xticklabels({'x(1) = 0.090','x(2) = 1.382','x(3) = 2.764' , ...
             'x(4) = 4.146','x(5) = 5.528','x(6) = 7.000'})