clear;
clc;
close all;

%% Simulation Parameters

Nx = 60;
Ny = 60;

dx = 0.01;
dy = 0.01;

alpha = 1e-4;

dt = 0.20;
steps = 500;

% boundary condition

boundary = "dirichlet";    % "dirichlet" or "neumann"


%% Stability Check


r = alpha*dt*(1/dx^2 + 1/dy^2);

if r > 0.5
    error("Simulation unstable!");
end

%% Initial Temperature


T = zeros(Nx,Ny);

T(26:35,26:35)=100;

%% Simulation

figure

for n=1:steps

    Told=T;

    for i=2:Nx-1
        for j=2:Ny-1

            d2x=(Told(i+1,j)-2*Told(i,j)+Told(i-1,j))/dx^2;
            d2y=(Told(i,j+1)-2*Told(i,j)+Told(i,j-1))/dy^2;

            T(i,j)=Told(i,j)+alpha*dt*(d2x+d2y);

        end
    end

    %% Boundary Conditions

    if boundary=="dirichlet"   % Fixed temperature (0°C)

        T(1,:)   = 0;
        T(end,:) = 0;
        T(:,1)   = 0;
        T(:,end) = 0;

    elseif boundary=="neumann"  % Zero temperature gradient

        T(1,:)   = T(2,:);
        T(end,:) = T(end-1,:);

        T(:,1)   = T(:,2);
        T(:,end) = T(:,end-1);

    end

    %% Plot

    if mod(n,5)==0

        imagesc(T)

        axis equal
        axis tight

        colormap(hot)
        colorbar
        caxis([0 100])

        title(sprintf("%s Boundary\nStep %d",boundary,n))

        drawnow

    end

end

%% Total Heat Remaining


fprintf("Total Heat = %.2f\n",sum(T(:)));


