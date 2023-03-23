%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%
% schemas numeriques pour le probleme de Riemann avec l'equation de Burgers
% u,t + 4u(2-u),x = 0
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% lg = longueur du domaine
lg = 7. ;
% nx = nombre de mailles
nx = 100 ;
% dx = pas d'espace
dx = lg/nx ;
% etat gauche et droit
ul = 1 ;
umid = 1/2;
ur = 3/2 ;
% condition cfl
cfl = dx/max(max(abs(ul),abs(ur)),abs(umid)) ;
tt=3;

x=zeros(1,nx) ;
u=zeros(1,nx) ;
v=zeros(1,nx) ;
w=zeros(1,nx) ;
up=zeros(1,nx) ;
um=zeros(1,nx) ;
% x = points du maillage
% u = donnee initiale



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nouveau schema: Godunov avec cfl=0.99 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
% initialisation
%
x=zeros(1,nx) ;
u=zeros(1,nx) ;
v=zeros(1,nx) ;
w=zeros(1,nx) ;
f=zeros(1,nx) ;
sigma=zeros(1,nx) ;
for i=1:nx
  x(i) = ((i-1)*dx)-1  ;
  if x(i) < 1
     u(i) = ul ;
  elseif x(i) < 3
     u(i) = umid ;
  else
    u(i) = ur;
  end
end
w = u ;

plot(x,u) ;
title('Godunov, cfl=0.99')

pause(1) ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% marche en temps : Godunov
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
t=0;

while (t<tt)

cfl = dx/max(abs(fprime(u))) ;
dt = 0.95*cfl ;
t=t+dt;

% evaluation du flux a l'interface
f = flux(u) ;
up = wshift2('1D',u,+1) ;
for i=1:nx
    fu = flux(u(i));
    fp = flux(up(i));
if u(i) < up(i)
% choc
     sigma = (flux(u(i))-flux(up(i)))/(u(i)-up(i)); 
     if sigma < 0.
        f(i) = flux(up(i)) ;
     end
     if sigma == 0.
         f(i) = 0.5*(flux(up(i))+flux(up(i)));
     end
elseif u(i) > up(i)
% detente
     if fprime(u(i)) < 0.
        f(i) = flux(up(i)) ;
     elseif fprime(up(i)) > 0.
        f(i) = flux(u(i)) ;
     else 
        f(i) = 0.0;
     end
end
end
fm = wshift2('1D',f,-1) ;
v = u -(dt/dx)*(f-fm) ;
u = v ; 
drawnow
plot(x,u,'*',x,u,':') ;
title('Finite volume solution at cfl=0.99')
xlabel('x')
ylabel('u')
pause(0) ;
end
%
%end
