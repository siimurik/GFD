clear
Z=peaks(50);

figure(34);clf;hold on
pcolor(peaks)
shading flat
contour( peaks, [-1 0 1 ],'edgecolor',[1 0.1 0.5]) %Last is RGB triplet 

figure(35);clf;hold on
dx = 1000; % km
dZdx = diff(Z,1,2)./dx;
pcolor(dZdx)
contour( Z, [-1 0 1 ],'edgecolor',[1 1 1]*0.9)
shading flat
%caxis([-1 1]*max(abs(dZdx(:))))
%caxis([min(dZdx(:))]  max(abs(dZdx(:))) )

%%
Z = peaks(50);

figure(33);clf;hold on
surf(Z)
%get(gca,'view')
