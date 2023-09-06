R = 'L'; % Specify the shape of the domain
% Generate and display the grid
n = 32;
G = numgrid(R,n);
spy(G)
title('A finite difference grid')
% Show a smaller version as sample
g = numgrid(R,12)
D = delsq(G);
spy(D)
title('The 5-point Laplacian')
% Number of interior points
N = sum(G(:)>0)
rhs = ones(N,1);
if (R == 'N') % Specify boundary conditions
    spparms('autommd',0)
    u = D\rhs;
    spparms('autommd',1)
else
    u = D\rhs; % Useful in the case R==’L’
end
% Draw the contours of the solution
U = G;
U(G>0) = full(u(G(G>0)));
clabel(contour(U)); prism axis
square ij
colormap((cool+1)/2);
mesh(U)
axis([0 n 0 n 0 max(max(U))])
axis
square ij