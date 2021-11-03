% ADVECTION  DIFFUSION
% implement upwind advection scheme for negative velocity
% make sure the scheme and boundary conditions are mass conservative


dx=  1 ; % spatial discretization step
L=10;  % meters
xaxis= 0: dx : L ;
M=   length(xaxis) ;

T = xaxis * 0 ;

T(:) = 1;
T(2)=10;
TP=T;

figure(8); clf; hold on; plot(xaxis,T)

k=0.01; %0.0    %0.1
u=0.01 ;%0.1    %0.0
dt=1;

N= 25 ;   % time steps %20
% Make N time steps
for n=1:N

    % New values for interior points
    for i=2:M-1

% upwind
if u >= 0
  TP(i) = T(i) + dt * u *( - ( T(i) - T(i-1))/dx   ) + dt*k*( T(i+1) - 2*T(i)+ T(i-1))/dx^2 ;
elseif u < 0
%  for negative velocity
  %   TP(i) = home assignment

end
    end
% boundary
T_bc1=0;  % value at left-hand boundary
T_bc2=0;  % value at right-hand boundary
if u>=0  % Positive velocity
    TP(M) = T(M) + dt*u*(-( T_bc2 -T(M-1)))/dx      + k*dt/dx^2 *(  T(M) - 2*T(M)+ T(M-1) ) ;
    TP(1) = T(1) + dt*u*(-( T(1)  -T_bc1 ))/dx      + k*dt/dx^2 *(  T(2) - 2*T(1)+ T(1) ) ;
elseif u<0  % Negative velocity
   %  for negative velocity
  %   TP(i) = home assignment
end

figure(8); clf; hold on;
    plot(xaxis,T,'r-')
    plot(xaxis,TP,'b--')

    title(num2str(sum(TP*dx)))
%    title(num2str(sum(TP.^2 *dx)))
   %pause
   % return

    % Update new values and diagnose conservation at time step n by summing concentrations
T=TP;


end