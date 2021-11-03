clear
T0 = 18; %degrees
t_init = 0; %initial time [s]
t_end = 24*3600; %1 day [s]

dt = 1; % second
time_seconds = t_init: dt :t_end;

T = time_seconds * 0; %temperature

nt = length(time_seconds);

n = 1; % timestep; lets start from beginning
T(n) = T0;

for n=1 : nt-1 % bc T(n+1) = T(nt-1+1) = T(nt)
t = n * dt;
Q = -1e-4*cos(t*2*pi/(24*3600));    % [K/s] - we start with highest values (day-to-night)
T(n+1) = T(n) + dt*Q ;              % can try without the + (day-to-night)
end

%% 
figure(3)
plot(time_seconds, T)



