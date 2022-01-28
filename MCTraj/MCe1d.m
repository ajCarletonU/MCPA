
%1D electron simulation tool
%ELEC4700 - PA3 winter 2022
%Alina Jacobson


function [] = MCe1d()

clear all;
close all;

set(0,'DefaultFigureWindowStyle','docked')
global C

addpath ../geom2d/geom2d

%initialize global constants
C.q_0 = 1.60217653e-19;             % electron charge
C.hb = 1.054571596e-34;             % Dirac constant
C.h = C.hb * 2 * pi;                 % Planck constant
C.m_0 = 9.10938215e-31;             % electron mass
C.kb = 1.3806504e-23;               % Boltzmann constant
C.eps_0 = 8.854187817e-12;          % vacuum permittivity
C.mu_0 = 1.2566370614e-6;           % vacuum permeability
C.c = 299792458;                    % speed of light
C.g = 9.80665;                      %metres (32.1740 ft) per s²
    
    
nTime = 500;            %length of steps for the movie
dt = 1; 
forces = 1;
m=1;
time = 0;
prob_scat = 0.05;       %probably scatter
drift_v =0;             %drift velocity


% initialize position x = 0 and  velocity  v = 0;
x = 0;
v_x = 0;


%advance the electron in time - update the position and velocity
%and plot Position and Velocity as a movie
for i=2:nTime


    %Using rand() decide if it scattered during the last time step and if so set v back to 0. 
    scatter_s = rand();
    
    if(scatter_s <= prob_scat)
        v_x(i) = 0;
    else
        %calc velocity = F/m*delat t + Vn-1
        v_x(i) = v_x(i-1) + (forces/m)*dt;    
    end
    
    %Calculate the drift velocity and display it in the title.
    drift_v(i) = mean(v_x);         %the average of the velocity of the electron
    
    %calc deltaL = F/m * delta t^2/2 + Vn-1*delta t
    x(i) = x(i-1) + v_x(i-1)*dt + ((forces/(m*2))*dt^2);   %Position from velocity and acceleration
    time(i) = time(i-1) + dt;                          %increment through
     
  
    
    %plot the particle velcity and position 
    subplot(2,1,1); 
    hold on;
    plot(time,v_x,'r');             %red dash mark on velocity line
    plot(time,drift_v,'go');        %green o dash
    xlabel('Time (sec)');
    ylabel('Velocity (m/s)');
    title(sprintf('Velocity vs Time  [Average = %0.5f ]',drift_v(i)));
    
    
    subplot(2,1,2);
    hold on;
    plot(time,x,'b-.');              %blue dash dot line
    xlabel('Time (sec)');
    ylabel('distance (meters)');
    title('Position of the Particle');
   

    pause(0.01);
    
    
end 

