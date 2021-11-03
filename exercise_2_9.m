clear
x0=0; y0=0;

dt=360;
time=0:dt:(3*24*3600); % s
nt=length(time);
% Initiate variables
u_num=time*NaN; v_num=u_num; x_num=u_num; y_num=v_num;crat=u_num; fac=u_num;
u_numi=time*NaN; v_numi=u_num; x_numi=u_num; y_numi=v_num;
u_num(1)=0;v_num(1)=0;x_num(1)=x0; y_num(1)=y0;
u_numi(1)=0;v_numi(1)=0;x_numi(1)=x0; y_numi(1)=y0;

f=2*(2*pi)/(24*3600);%1 coriolis = 2* Omega = 2* (2*pi /T)

a=5.7296e-04;  % degree
g=9.81 % m/s2
A=g*sind(a)/f;
figure(43);clf;hold on

% Analytical solutions
u_an= A*sin(f*time);
v_an= -A+A*cos(f*time);
x_an= -A/f*cos(f*time) + A/f;
y_an= -A*time +A/f*sin(f*time);
plot(x_an, y_an,'-k' ,'linewidth',2)
% ( u(n+1) - u(n)  )/dt  - f v(n+1)  = 0
% ( v(n+1) - v(n)  )/dt  + f u(n+1)  = 0

% Time loop
for i=1:nt-1%f=(f+1e-7);
    % Explicit sol.
u_num(i+1) = u_num(i)+  dt*( f* v_num(i)  + g*sind(a));
v_num(i+1) = v_num(i) + dt*( - f* u_num(i));
x_num(i+1)=x_num(i)+dt*(u_num(i));
y_num(i+1)=y_num(i)+dt*(v_num(i));



cn=sqrt(u_num(i)^2  + v_num(i) ^2 );
cnp1=sqrt( u_num(i+1)^2  + v_num(i+1) ^2 );
crat(i)=cn/cnp1;
fac(i)=(1-f^2*dt^2).^i;


% Implicit sol.
%u_numi(i+1) =1./(1+f^2*dt^2) *( u_numi(i) +dt*f*v_numi(i)    +dt*g*sind(a)    ) ;
%v_numi(i+1) = 1./(1+f^2*dt^2)*( v_numi(i) -dt*f*( u_numi(i) +dt*g*sind(a)) ) ;
u_numi(i+1) =1./(1+f^2*dt^2) *( u_numi(i) +dt*f*v_numi(i)    +dt*g*sind(a)    ) ;
v_numi(i+1) = 1./(1+f^2*dt^2)*( v_numi(i) -dt*f*( u_numi(i) +dt*g*sind(a)) ) ;


x_numi(i+1)=x_numi(i)+dt*(u_numi(i));
y_numi(i+1)=y_numi(i)+dt*(v_numi(i));



end

%plot(x(i),y(i),'.r')
plot(x_num,y_num,'--b','linewidth',2)
plot(x_numi,y_numi,'--r','linewidth',2)
xlabel('X');ylabel('Y')
set(gcf,'color','w')
grid on
%title(time(i));axis([-1 1 -2 1]*100)
pause(0.01)

figure(4);clf;hold on
plot(time,(u_an.^2 + v_an.^2),'k')
plot(time,(u_num.^2 + v_num.^2),'--b')
plot(time,(u_numi.^2 + v_numi.^2),'--r')
legend({'an','num expl','num impl'}); title('velocity')