%% Part 2

clear
fig2 = figure(2);clf;hold on
X = linspace(0,500,500);
Y = linspace(-100,100,500);
%[X, Y] = meshgrid(x,y);
[x,y]=meshgrid(X,Y);
k = 2*pi/30;
phi0 = 25*k;
l = 2*pi/30;
%f = @(x,y)2*cos(k.*x+phi0).*cos(l.*y)
z = 2.*cos(k.*x+phi0).*cos(l.*y);
%contour(x,y,z,50)
pcolor(x,y,z)
contour( x, y, z, [-1 0 1 ],'edgecolor','k')
shading flat
title('$$ f(x, y)=2 \cos \left(k x+\phi_{0}\right) \cos \left(ly\right) $$','interpreter','latex')
%% Add labels to x-, y-axis and colorbar
% Axis labels
xlabel('$$ 0 < x < 500 \; [km] $$', 'Interpreter','latex') 
ylabel('$$ -100 < y < 100 \; [km] $$','Interpreter','latex')
cb = colorbar;
set(get(cb, 'ylabel'), 'string', '$$ f(x,y)$$','Interpreter','latex')
%% Add black isolines for f(x,y) = -1, 0, 1.
% in function contour( x, y, z, [-1 0 1 ],'edgecolor','k')
%% Save figure with resolution 300 dpi
print(fig2,'Figure2_Siim_Erik_Pugal.png','-dpng','-r300');

%% 
% cos(),sin(), ... don't have units
% the partial derivative gives it a unit
fig3 = figure(3); clf; hold on
dz = -2.*k.*sin(k.*x+phi0).*cos(l.*y);
pcolor(x,y,dz)
contour( x, y, z, [-1 0 1 ],'edgecolor','k')
shading flat
title('$$ \partial_{x} f(x, y)= - 2 k \sin \left(k x+\phi_{0}\right) \cos \left(ly\right) $$','interpreter','latex')
xlabel('$$ 0 < x < 500 \; [km] $$', 'Interpreter','latex') 
ylabel('$$ -100 < y < 100 \; [km] $$','Interpreter','latex')
cb = colorbar;
set(get(cb, 'ylabel'), 'string', '$$ \partial_{x} f(x,y) [km^{-1}] $$','Interpreter','latex')
print(fig3,'Figure3_Siim_Erik_Pugal.png','-dpng','-r300');