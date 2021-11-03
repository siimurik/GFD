clear
t = 25;
v0 = 120; %m/s
phi1 = (51 + 31/60)* pi/180; %rad
phi2 = (68 + 52/60)* pi/180;
phi3 = (1 + 18/60)* pi/180;
Tday = 24*3600; %s
omega = 2*pi/Tday;
%f =  4* pi / Tday * sin(phi);%sin(phi) - latitude
f1 = sin(phi1)*2*omega; %rad/s
f2 = sin(phi2)*2*omega;
f3 = sin(-phi3)*2*omega;
%dt = 0:0.01:t;
y1 = -f1*v0*t^2/2   %m
y2 = -f2*v0*t^2/2
y3 = -f3*v0*t^2/2