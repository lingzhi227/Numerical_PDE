clear all; clc;
% Construct the grid
m = 60;
dx = 2/m; dy = 2/m;
x = -1-dx:dx:1+dx; y = -1-dy:dy:1+dy;
[xx,yy] = meshgrid(x,y);
g = 1; c = 0.5;
h = ones(size(xx));
h(xx>=-0.5 & xx<=0.5 & yy>=-0.5 & yy<=0.5) = 2;
% U is an unknown matrix.
U(:,:,1)=h,U(:,:2)=hu,U(:,:,3)=hv
U = zeros([size(h) 3]);
U(:,:,1) = h;
u = zeros(size(xx));
v = u;
% circular shift vectors
shiftp1 = circshift((1:length(x))’,1);
shiftm1 = circshift((1:length(x))’,-1);
mesh(x,y,U(:,:,1)), colormap jet, axis([-1 1 -1 1 0.5 2.5])
title(’hit enter to continue’)
xlabel x, ylabel y; zlabel h;
pause;
t = 0; dt = 0; tstop = 3.0;
ii = 1;
numplots = 3;
tplot = [1.35;3.0]; Uplot = zeros([size(U) length(tplot)+1]);
Uplot(:,:,:,1) = U; styles = {’k:’,’k--’,’k-’};
while t < tstop
Uold = U; uold = u; vold = v; told = t; t = t + dt;
% calculate lambda = |u| + sqrt(gh) using the computed value
of the flux
lambdau = 0.5*abs(uold+uold(:,shiftm1)) +...
sqrt(g*0.5*(Uold(:,:,1)+Uold(:,shiftm1,1)));
lambdav = 0.5*abs(vold+vold(shiftm1,:)) +...
sqrt(g*0.5*(Uold(:,:,1)+Uold(shiftm1,:,1)));
lambdamax = norm([lambdau(:); lambdav(:)],Inf);
dt = c*(dx/lambdamax);
% adjust dt to regenerate the graph
if (ii<=length(tplot) && tplot(ii)>=told && tplot(ii)<=t+dt)
dt = tplot(ii)-t;
ii = ii + 1;
end
huv = Uold(:,:,2).*Uold(:,:,3)./Uold(:,:,1);
ghh = 0.5*g*Uold(:,:,1).^2;
% compute (hu,hu^2+gh^2/2,huv)
lffu = cat(3,Uold(:,:,2),Uold(:,:,2).^2./Uold(:,:,1)+ghh,huv);
% compute (hv,huv,hv^2+gh^2/2)
lffv = cat(3,Uold(:,:,3),huv,Uold(:,:,3).^2./Uold(:,:,1)+ghh);
% compute the flux terms
fluxx = 0.5*(lffu+lffu(:,shiftm1,:)) - ...
0.5*bsxfun(@times,Uold(:,shiftm1,:)-Uold,lambdau);
fluxy = 0.5*(lffv+lffv(shiftm1,:,:)) - ...
0.5*bsxfun(@times,Uold(shiftm1,:,:)-Uold,lambdav);
% time step
U = Uold - (dt/dx)*(fluxx - fluxx(:,shiftp1,:)) ...
- (dt/dy)*(fluxy - fluxy(shiftp1,:,:));
% impose the boundary conditions on h
U(1:end,end,1)= U(1:end,end-1,1); U(1:end,1,1)= U(1:end,2,1);
U(end,1:end,1)= U(end-1,1:end,1); U(1,1:end,1)= U(2,1:end,1);
% on hu
U(1:end,end,2)=-U(1:end,end-1,2); U(1:end,1,2)=-U(1:end,2,2);
U(end,1:end,2)= U(end-1,1:end,2); U(1,1:end,2)= U(2,1:end,2);
% on hv
U(1:end,end,3)= U(1:end,end-1,3); U(1:end,1,3)=U(1:end,2,3);
U(end,1:end,3)=-U(end-1,1:end,3); U(1,1:end,3)=-U(2,1:end,3);
% u = hu./h; % v = hv./h;
u = U(:,:,2)./U(:,:,1); v = U(:,:,3)./U(:,:,1);
% display the animation
mesh(x,y,U(:,:,1)), colormap jet, axis([-1 1 -1 1 0 2.5])
title([’t = ’ num2str(t+dt)])
xlabel x, ylabel y, zlabel y, pause(0.001)
%if (ismember(t+dt,tplot))
if (any(tplot-t-dt==0))
Uplot(:,:,:,ii) = U; % store U for plotting
end
end