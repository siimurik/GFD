clear
r = 0.0001; % 1 /s decay!
C0 = 1000; %cells
t_end = 1; % day
dt = 3600; % seconds
nt = t_end * 24*3600 / dt ; %one days worth of time inspected by 10 s inteval
C = zeros(nt, 1); % Cells
size(C)
C(1) = C0;
for n = 1:nt-1 ;
C(n+1) = C(n) - r * C(n) * dt;
end

%%
figure
plot(1:nt,C)

%% Plotting
fig = figure(2); clf; hold on
t = 1 : pi / 100 : 4*pi;
y = sin( t );
plot( t, y  ,'-k')
plot( t, cos(t)  ,'--or','markersize',10)
title('Title of the plot')
xlabel('Time-axis [s]')
ylabel('y-axis [units]')
grid on

%ax = gca; % get current axis

set(gca, 'XTick', [0, 1, pi, pi*2])
set(gca, 'XTickLabel', {'start','1', 'pi', 'pi*2'})
set(gca, 'YTick', -1:0.25:1)
xlim([pi 2*pi])
leg_hand = legend({'f1','f2 = cos(t)'});

%% 2D plots

fig = figure(3); clf; hold on
x = linspace(0, 1, 100);
y = x';
[xx, yy] = meshgrid(x,y);
zz = xx.*yy;

pcolor( xx, yy, zz )
%shading flat    %eliminates black border
shading interp
xlabel( 'x [m]' )
caxis([0.5 0.6])

cb = colorbar;
set(get(cb, 'ylabel'), 'string', 'ZZ [m*m]') 
contour( xx, yy, zz ,100)
C = 10;
contourf( xx, yy, zz ,[0:0.1:1])
shading flat
%cb. Label. String = 'Label'; % either this or previous

%print(fig, 'dpng', '-r300', 'Figure3_HR.png')
%{
x= linspace(0,1,100); y=0:0.01:1;  % careful!
    [xx,yy] = meshgrid(x,y);  
    zz=xx.*yy;  
pcolor( xx, yy, zz )
     shading flat
contour( xx, yy, zz ,N)
contourf( xx, yy, zz ,[0:0.1:1]*C)
     shading flat
surf( xx, yy, zz )
     shading flat
caxis([colormin colormax])
set(gca,'ytick',[0:0.1:1],'xtick',[0:0.5:1])
set( gca,'fontsize',12,'fontweight','b')
cb=colorbar;      set(get(cb,'ylabel'),'string',string_4_cb)
set(cb, 'position' ,  [x y   dx dy ]/figsize) 
colormap(jet(10))  % use colorbrewer 
%}