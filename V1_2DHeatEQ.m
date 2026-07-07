clear;
clc;
close all;

%% Simulation Parameters

Nx = 60;          % Grid points in x
Ny = 60;          % Grid points in y

dx = 0.01;        % Grid spacing (m)
dy = 0.01;

alpha = 1e-4;     % Thermal diffusivity (m^2/s)

dt = 0.20;        % Time step (s)
steps = 500;

%% Stability Check

r = alpha * dt * (1/dx^2 + 1/dy^2);

if r > 0.5
    error("Simulation unstable! Reduce dt or increase dx.");
end

fprintf("Stability number = %.3f\n", r);

%% Initial Temperature Field

T = zeros(Nx,Ny);

% Hot square in the centre
T(26:35,26:35) = 100;

%% Plot Setup

figure;

for n = 1:steps

    Told = T;

    %% FTCS Update
    for i = 2:Nx-1
        for j = 2:Ny-1

            d2Tdx2 = (Told(i+1,j)-2*Told(i,j)+Told(i-1,j))/dx^2;

            d2Tdy2 = (Told(i,j+1)-2*Told(i,j)+Told(i,j-1))/dy^2;

            T(i,j) = Told(i,j) + alpha*dt*(d2Tdx2 + d2Tdy2);

        end
    end

    %% Plot every 5 iterations
    if mod(n,5)==0

        imagesc(T);

        axis equal
        axis tight

        colorbar
        colormap(hot)

        caxis([0 100])

        title(sprintf("2D Heat Equation (FTCS)\nTime Step = %d",n))

        drawnow

    end

end
