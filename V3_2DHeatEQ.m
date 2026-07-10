clear;
clc;
close all;

% Simulation Parameters

Nx = 60;
Ny = 60;

dx = 0.01;
dy = 0.01;

dt = 0.10;
steps = 500;

boundary = 'dirichlet';          % 'dirichlet' or 'neumann'
initialCondition = 'hotspot';    % 'hotspot', 'gradient', 'random'

alpha = 1e-4 * ones(Nx, Ny);

% Make right half conduct heat faster
%alpha(:,31:end) = 2e-4; INOP

% Stability Check

alphaMax = max(alpha(:));

r = alphaMax * dt * (1/dx^2 + 1/dy^2);

if r > 0.5
    error('Simulation unstable! Reduce dt.');
end

% Initial Temperature

T = zeros(Nx,Ny);

switch initialCondition

    case 'hotspot'
        T(26:35,26:35) = 100;

    case 'gradient'
        for i = 1:Nx
            T(i,:) = 100 * (i/Nx);
        end

    case 'random'
        T = 100 * rand(Nx,Ny);

    otherwise
        error('Unknown initial condition.');

end

% Internal Heat Source

Q = zeros(Nx,Ny);

% Continuous heater
Q(45:50,15:20) = 40;

% Probe Locations

probeA = [20 20];
probeB = [45 45];

probe1 = zeros(steps,1);
probe2 = zeros(steps,1);

% Heat History

heatHistory = zeros(steps,1);

% Simulation

figure;

for n = 1:steps

    Told = T;

    for i = 2:Nx-1
        for j = 2:Ny-1

            d2x = (Told(i+1,j)-2*Told(i,j)+Told(i-1,j))/dx^2;
            d2y = (Told(i,j+1)-2*Told(i,j)+Told(i,j-1))/dy^2;

            T(i,j) = Told(i,j) + alpha(i,j)*dt*(d2x+d2y) + Q(i,j)*dt;

        end
    end

    %% Boundary Conditions

    if strcmp(boundary,'dirichlet')

        T(1,:)   = 0;
        T(end,:) = 0;
        T(:,1)   = 0;
        T(:,end) = 0;

    elseif strcmp(boundary,'neumann')

        T(1,:)   = T(2,:);
        T(end,:) = T(end-1,:);

        T(:,1)   = T(:,2);
        T(:,end) = T(:,end-1);

    else

        error('Unknown boundary condition.');

    end

    %% Record Data

    probe1(n) = T(probeA(1),probeA(2));
    probe2(n) = T(probeB(1),probeB(2));

    heatHistory(n) = sum(T(:));

    %% Plot

    if mod(n,5) == 0

        imagesc(T);

        hold on;
        plot(probeA(2),probeA(1),'bo','markersize',8);
        plot(probeB(2),probeB(1),'go','markersize',8);
        hold off;

        axis equal;
        axis tight;

        colormap(hot);
        colorbar;

        caxis([0 max(100,max(T(:)))]);

        title([boundary ' Boundary | Step ' num2str(n)]);

        drawnow;

    end

end

%% Results

fprintf('Final Total Heat = %.2f\n', heatHistory(end));

%% Heat History Plot

figure;
plot(1:steps, heatHistory, 'LineWidth', 2);
grid on;
xlabel('Time Step');
ylabel('Total Heat');
title('Heat Conservation');

%% Probe Temperature Plot

figure;
plot(1:steps, probe1, 'LineWidth', 2);
hold on;
plot(1:steps, probe2, 'LineWidth', 2);
grid on;
xlabel('Time Step');
ylabel('Temperature');
legend('Probe A','Probe B');
title('Temperature History at Probe Locations');
