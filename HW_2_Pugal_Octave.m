% Siim Erik Pugal
clear
% Initial known variables
dt = 360;
t = 0:dt:(2*24*3600);
nt = length(t);
f = 2*(2*pi)/(24*3600); % 1/s
alfa = 10^-5;  % rad
g = 9.81; % m/s^2
A = -g*sin(alfa)/f; % s
a = 0.5;
%%
% Analytical solutions
u = -A*sin(f*t);
v = A-A*cos(f*t);
x = A/f*(cos(f*t)-1);
y = A*t - A/f*sin(f*t);
%%
% Initial values
u_ex = zeros(nt,1); x_ex = u_ex;
v_ex = zeros(nt,1); y_ex = v_ex;
u_im = zeros(nt,1); x_im = u_im;
v_im = zeros(nt,1); y_im = v_im;
u_semi = zeros(nt,1); x_semi = u_semi;
v_semi = zeros(nt,1); y_semi = v_semi;
for n = 1:(nt-1)
    % Explicit
    u_ex(n+1) = u_ex(n) + dt*(f*v_ex(n) + g*sin(alfa));
    v_ex(n+1) = v_ex(n) - dt*f*u_ex(n);
    % u = dx/dt  ~  (x(n+1) - x(n)  )/dt  = u(n)
    x_ex(n+1) = x_ex(n) + dt*u_ex(n);
    y_ex(n+1) = y_ex(n) + dt*v_ex(n);

    %Implicit
    u_im(n+1) = 1/(1+f^2*dt^2)*(u_im(n)+dt*(f*v_im(n)+g*sin(alfa)));
    v_im(n+1) = 1/(1+f^2*dt^2)*(v_im(n)-dt*f*u_im(n)-dt^2*f*g*sin(alfa)) ;
    x_im(n+1) = x_im(n) + dt*u_im(n);
    y_im(n+1) = y_im(n) + dt*v_im(n);

    %Semi-Implicit
    %u_semi(n+1) = ( u_semi(n)+dt*(f*((1-a)*u_semi(n)+a*(u_semi(n)-dt*f*(1-a)*u_semi(n)))+g*sin(alfa)) )/(1-dt^2*f^2*a^2);
    %v_semi(n+1) = ( u_semi(n)-dt*f*((1-a)*u_semi(n)-a*(u_semi(n)+dt*(f*((1-a))+g*sin(alfa)))) )/(1-dt^2*f^2*a^2);
    %u_semi(n+1) = ( u_semi(n)+dt*f*(1-a)*u_semi(n)+dt*f*a*u_semi(n)+a*dt^2*f^2*(1-a)*u_semi(n)+dt*g*sin(alfa)-g*sin(alfa)*a^2*dt^3*f^2)/(1-a^2*dt^2*f^2);
    %v_semi(n+1) = ( u_semi(n)+dt*f*(1-a)*u_semi(n)+dt*f*a*u_semi(n)+a*dt^2*f^2*(1-a)*u_semi(n)+g*sin(alfa)*a*dt^2*f)/(1-a^2*dt^2*f^2);
 %Alt   %u_semi(n+1) = ( u_ex(n)+dt*f*(1-a)*v_im(n)+dt*f*a*v_ex(n)+a*dt^2*f^2*(1-a)*u_im(n)+dt*g*sin(alfa))/(1-a^2*dt^2*f^2);
 %Alt   %v_semi(n+1) = ( v_ex(n)+dt*f*(1-a)*u_im(n)+dt*f*a*u_ex(n)+a*dt^2*f^2*(1-a)*v_im(n)+g*sin(alfa)*a*dt^2*f)/(1-a^2*dt^2*f^2);
    u_semi(n+1) = (u_semi(n) + v_semi(n)*f*dt - a*v_semi(n)*f*dt + a*v_semi(n)*f*dt - a*f^2*u_semi(n)*dt^2 + a^2*f^2*u_semi(n)*dt^2 + g*dt*sin(alfa))/(1 + a^2*f^2*dt^2);
    v_semi(n+1) = (v_semi(n) - a*u_semi(n)*f*dt - f*u_semi(n)*dt + a*f*u_semi(n)*dt - a*v_semi(n)*f^2*dt^2 + a^2*v_semi(n)*f^2*dt^2 - a*f*g*dt^2*sin(alfa))/(1 + a^2*f^2*dt^2);
    x_semi(n+1) = x_semi(n) + a*dt*u_semi(n+1) +(1-a)*dt*u_semi(n);
    y_semi(n+1) = y_semi(n) + a*dt*v_semi(n+1) +(1-a)*dt*v_semi(n);
    %x_semi(n+1) = x_semi(n) + dt*u_semi(n);    %testing
    %y_semi(n+1) = y_semi(n) + dt*v_semi(n);    %testing
end
%%
% Plotting the trajectory
fig1 = figure(1); clf; hold on
plot(x, y,'k','LineWidth',1.5)
plot(x_ex,y_ex,'.b')
plot(x_im,y_im,'.r')
plot(x_semi,y_semi,'.g')
grid on
title('Trajectory','Interpreter','latex')
xlabel('$$ x \; [m] $$', 'Interpreter','latex')
ylabel('$$ y \; [m] $$','Interpreter','latex')
legend({'Analytical','Explicit', 'Implicit','Semi-Implicit'});
pbaspect([0.85 1 1])
print(fig1,'Coriolis_Trajectory_Siim_Erik_Pugal.png','-dpng','-r300');
%%
% Plotting the velocity
fig2 = figure(2); clf; hold on
plot(t,(u.^2 + v.^2),'k', 'LineWidth',1.5)
plot(t,(u_ex.^2 + v_ex.^2),'.b')
plot(t,(u_im.^2 + v_im.^2),'.r')
plot(t,(u_semi.^2 + v_semi.^2),'.g')
grid on
title('Velocity','Interpreter','latex')
xlabel('$$ t \; [s] $$', 'Interpreter','latex')
ylabel('$$ V^{2} \; [\frac{m^{2}}{s^2}] $$','Interpreter','latex')
legend({'Analytical','Explicit', 'Implicit','Semi-Implicit'});
print(fig2,'Coriolis_Velocity2_Siim_Erik_Pugal.png','-dpng','-r300');
%%
% Kinetic energy
% Initial values
func_ex(nt,1) = (1-f^2*dt^2)^1;
func_im(nt,1) = (1-f^2*dt^2)^-1;
for j = 1:nt
    func_ex(j) = (1-f^2*dt^2)^(j);
    func_im(j) = (1-f^2*dt^2)^(-j);
end
fig3 = figure(3); clf; hold on
plot(t, 1./func_ex, 'r', 'linewidth',1.5)
plot(t, 1./func_im, 'b', 'linewidth',1.5)
grid on
title('Property of kinetic energy', 'Interpreter','latex')
xlabel('$$ t \; [s] $$', 'Interpreter','latex')
ylabel('$$ E_{kin} \; [\emph{dimensionless}] $$','Interpreter','latex')
legend({'Explicit', 'Implicit'});
print(fig3,'Coriolis_Energy_Siim_Erik_Pugal.png','-dpng','-r300');
%%
% Hodograph
fig4 = figure(4); clf; hold on
plot(u,v, '-k', 'linewidth',2)
plot(u_ex, v_ex, '.b')
plot(u_im, v_im, '.r')
plot(u_semi, v_semi, '.g')
grid on
title('Hodograph','Interpreter','latex')
xlabel('$$ u \; [m/s] $$', 'Interpreter','latex')
ylabel('$$ v \; [m/s] $$','Interpreter','latex')
legend({'Analytical','Explicit', 'Implicit', 'Semi-Implicit'});
pbaspect([1 1 1])
print(fig4,'Coriolis_SpeedTrajectory_Siim_Erik_Pugal.png','-dpng','-r300');
%% Maximum displacement
disp('Maximum downhill displacement value (x):')
func_u = @(T) -A.*sin(f.*T);
x_max = integral(func_u,0,pi)
%% Maximum speed
% x' = u = 0
% -A*sin(f*t) = 0
% sin(f*t) = 0, % f is not equal to zero
n=1;
disp('Time in seconds, when max speed is reached:')
t_max = pi*n/f % z belongs to Z = 0,1,2,3,...
disp('Max speed (m/s) when n=1:')
C = sqrt((A*sin(f*t_max)).^2+(A-A*cos(f*t_max)).^2)
%% Speed peaks
disp('Speed peaks for analytical function:')
%peaks=findpeaks((u.^2 + v.^2),t)
data1 = u.^2 + v.^2; # Positive values
[pks_em idx_em] = findpeaks(data1)
disp('Speed peaks for implicit function:')
data2 = u_im.^2 + v_im.^2;
[peaks_im, time_im]=findpeaks(data2)
disp('Speed peaks for semi-implicit function:')
data3 = u_semi.^2 + v_semi.^2;
[peaks_semi, time_semi]=findpeaks(data3)
