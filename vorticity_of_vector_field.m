clear
xax=linspace(-1 ,1,50);yax=xax;

dx=xax(2)-xax(1);dy=dx;

[xax2, yax2]=meshgrid(xax,yax);
u=-(yax2).*cos(yax2);
v= (xax2).*cos(xax2);

nx = length(xax);
ny = length(yax);

vort=u*NaN;
%i=3; j=3;
%dv = v(j, i+1) - v(j, i )  / dx   % = 0.5 - (-0.5)  / 2*0.5   =1/1 =1
%du = u(j+1,i) - v(j, i)  / dy    %= -0.5 - (0.5)  / 2*0.5   =-1/1 =-1
%1- (-1) %=2   [m/s   /m   = 1/s]
%vort( j , i ) = v(j, i+1) - v(j, i )/dx - u(j+1,i) - v(j, i)  / dy  ;

for i = 2 : (nx - 1)
    for j = 2 : (ny - 1)
        vort(j ,i) = (v(j, i+1) - v(j, i ))/dx - (u(j+1,i) - u(j, i))/dy;
    end
end
%pcolor(vort)
%xlabel('x[m]')
%ylabel('y[m]')

figure(1);hold on;set(gcf,'color','w')
quiver( xax, yax, u,v   ,'color','k','linewidth',2)
%quiver( xax, yax, u*0,v,'color','r')
%quiver(xax,yax,u,v*0,'color','b')
grid on

figure(2)
pcolor(vort)
