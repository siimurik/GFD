clear
k=5;
v0=10;
g = 9.807;
fplot(@(x)1/k*(v0*sin(pi/4)+g/k)*(1-exp(-k*x))-g/k*x,[-0.5,2])
grid on
f=@(x)1/k*(v0*sin(pi/4)+g/k)*(1-exp(-k*x))-g/k*x;
x=0.9;
xvana=-2;
while abs(x-xvana)/abs(x) >= 1e-15
    xuus=x-f(x)*(x-xvana)/(f(x)-f(xvana));
    xvana=x;
    x=xuus;
end
disp('vastus')
disp(x)