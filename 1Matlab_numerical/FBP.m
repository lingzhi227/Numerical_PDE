% Define problem parameters
R = 50;                 % radius of circle
N = 256;                % number of pixels in x and y directions
theta = 0:2:358;        % projection angles
Nt = numel(theta);      % number of projections

% Create phantom image (circle)
x = linspace(-R, R, N);
[X, Y] = meshgrid(x, x);
phantom = double(sqrt(X.^2 + Y.^2) < R);

% Compute projection data (sinogram)
sinogram = zeros(N, Nt);
for i = 1:Nt
    projection = radon(phantom, theta(i));
    sinogram(:, i) = projection;
end

% Filter the sinogram using a ramp filter
filtered_sinogram = ramp_filter(sinogram, theta);

% Backproject the filtered sinogram to reconstruct the image
reconstruction = zeros(N);
for i = 1:Nt
    projection = filtered_sinogram(:, i);
    image = iradon(projection, theta(i), 'linear', 'none', 1, N);
    reconstruction = reconstruction + image;
end

% Plot the results
figure;
subplot(2,2,1); imshow(phantom); title('Original image');
subplot(2,2,2); imshow(sinogram, []); title('Sinogram');
subplot(2,2,3); imshow(filtered_sinogram, []); title('Filtered sinogram');
subplot(2,2,4); imshow(reconstruction, []); title('Reconstructed image');

% Ramp filter function
function [filtered_data] = ramp_filter(data, theta)
    % Compute the Fourier transform of the data
    F = fftshift(fft(data, [], 1), 1);
    [N, Nt] = size(data);
    df = 1/N;
    f = linspace(-N/2, N/2-1, N)*df;
    % Apply the ramp filter
    H = abs(f);
    H(f==0) = 1e-6;
    H = repmat(H, [N, 1]);
    F = F .* H;
    % Compute the inverse Fourier transform
    filtered_data = real(ifft(ifftshift(F, 1), [], 1));
end