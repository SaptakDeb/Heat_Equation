clear;
clc;
close all;

% Parameters
  N = 50;          % Plate size
  alpha = 0.2;     % Diffusion rate (0 < alpha <= 0.25)
  steps = 200;     % Number of iterations

% Initial temperature field
  T = zeros(N,N);

% Heat source
%  T(25,25) = 100; %center heat
  T(12,12)=200;
  T(37,37)=200;
  
% Time step for loop to map heat diffusion
  for step = 1:steps

    T_old = T;

    for i = 2:N-1
        for j = 2:N-1

            T(i,j) = T_old(i,j) + alpha * ( ...
                T_old(i-1,j) + ...
                T_old(i+1,j) + ...
                T_old(i,j-1) + ...
                T_old(i,j+1) - ...
                4*T_old(i,j));

        end
    end

% Plot

imagesc(T)
axis equal
colorbar
title(["Heat Diffusion - Step", num2str(step)])
drawnow
pause(0.005)
end

totalheat=sum(T(:));  %total heat verification in console
disp(totalheat)






