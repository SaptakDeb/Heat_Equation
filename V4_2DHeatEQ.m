clear;
clc;
close all;

% Simulation Parameters

Nx = 60;
Ny = 60;

dx = 0.01;
dy = 0.01;

dt = 0.02;
steps = 500;

boundary = 'neumann';          % 'dirichlet' or 'neumann'
initialCondition = 'hotspot';    % 'hotspot', 'gradient', 'random'

% Variable Thermal Diffusivity

% Approximate Thermal Diffusivities (m²/s)
%
% Air              : 2.0e-5
% Water            : 1.4e-7
% Glass            : 4.0e-7
% Concrete         : 8.0e-7
% Stainless Steel  : 4.0e-6
% Titanium         : 9.0e-6
% Carbon Steel     : 1.2e-5
% Brass            : 3.4e-5
% Aluminum         : 9.7e-5
% Copper           : 1.1e-4
% Silver           : 1.7e-4

% Base material
alpha = 1e-4 * ones(Nx,Ny);

% Circle disc with low alpha
cx = 30;
cy = 30;
radius = 10;

for i = 1:Nx
    for j = 1:Ny
        if (i-cx)^2 + (j-cy)^2 <= radius^2
            alpha(i,j) = 2e-5;
        end
    end
end

% Stability Check

alphaMax = max(alpha(:));

r = alphaMax * dt * (1/dx^2 + 1/dy^2);

if r > 0.5
    error('Simulation unstable! Reduce dt.');
end

% Material Distribution

%figure;

%imagesc(alpha);

%axis equal;
%xis tight;

%colormap(parula);
%colorbar;

%title('Material Thermal Diffusivity Distribution');

% Initial Temperature

T = zeros(Nx,Ny);

switch initialCondition

    case 'hotspot'

        T(8:15,8:15) = 100;

    case 'gradient'

        for i = 1:Nx
            T(i,:) = 100*(i/Nx);
        end

    case 'random'

        T = 100*rand(Nx,Ny);

    otherwise

        error('Unknown initial condition.');

end

% Internal Heat Source

Q = zeros(Nx,Ny);

% Continuous heater
Q(20,30) = 40;

% Probe Locations

probeA = [10 30 ];
probeB = [30 30];

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

            T(i,j) = Told(i,j) ...
                   + alpha(i,j)*dt*(d2x+d2y) ...
                   + Q(i,j)*dt;

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

    if mod(n,5)==0

        imagesc(T);

        hold on;

        theta = linspace(0,2*pi,200);

        plot(cy + radius*cos(theta), ...
             cx + radius*sin(theta), ...
             'c','LineWidth',2);

        text(cy,cx,'Low \alpha', ...
            'Color','w', ...
            'HorizontalAlignment','center');

        plot(probeA(2),probeA(1),'bo','MarkerSize',8);
        plot(probeB(2),probeB(1),'go','MarkerSize',8);

        hold off;

        axis equal;
        axis tight;

        colormap(hot);
        colorbar;

        caxis([0 100]);

        title(['Composite Material | ' boundary ...
               ' | Step ' num2str(n)]);

        drawnow;

    end

end
% Results

fprintf('Final Total Heat = %.2f\n', heatHistory(end));

% Heat History

figure;

plot(1:steps, heatHistory, 'LineWidth', 2);

grid on;

xlabel('Time Step');
ylabel('Total Heat');

title('Total Heat in System');

% Probe Temperatures

figure;

plot(1:steps, probe1, 'b', 'LineWidth', 2);

hold on;

plot(1:steps, probe2, 'g', 'LineWidth', 2);

grid on;

xlabel('Time Step');
ylabel('Temperature');

legend('Probe A','Probe B');

title('Temperature History at Probe Locations');

% Final Temperature Field

figure;

imagesc(T);

hold on;

theta = linspace(0,2*pi,200);

plot(cy + radius*cos(theta), ...
     cx + radius*sin(theta), ...
     'c','LineWidth',2);

plot(probeA(2),probeA(1),'bo','MarkerSize',8);
plot(probeB(2),probeB(1),'go','MarkerSize',8);

hold off;

axis equal;
axis tight;

colormap(hot);
colorbar;

caxis([0 100]);

title('Final Temperature Distribution');

