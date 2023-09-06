% Define the geometry of the domain
g = [2; 1; 0; 1; 0; 0; 0; 1; 1; 1];

% Create a PDE model
model = createpde();

% Create a geometry object and import the geometry
geometryFromEdges(model, g);

% Specify the boundary conditions
applyBoundaryCondition(model, 'dirichlet', 'Edge', [1 2 3], 'u', 0);
applyBoundaryCondition(model, 'neumann', 'Edge', [4 5 6 7 8 9 10], 'g', 0);

% Generate the mesh with a boundary layer
hmax = 0.1;  % maximum element size
hmin = 0.001;  % minimum element size
b = 0.01;  % boundary layer thickness
generateMesh(model, 'Hmax', hmax, 'Hmin', hmin, 'GeometricOrder', 'linear', 'BoundaryLayer', 'on', 'BoundaryLayerThickness', b);

% Plot the mesh
pdeplot(model)