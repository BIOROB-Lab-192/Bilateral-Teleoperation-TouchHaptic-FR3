% Clear workspace and command window
clc;clear
% Run MATLAB code "FR3_robot.m" to create rigidBodyTree
FR3_robot;
% Create waypoints
q_home = [0,-pi/4,0,-3*pi/4,0,pi/2,pi/4,0,0]';
q_pos1 = [pi/2,-pi/2,0,-3*pi/4,0,pi/2,pi/4,0,0]';
q_pos2 = [-pi/2,-pi/2,0,-3*pi/4,0,pi/2,pi/4,0,0]';
rng default
frankaWaypoints = [q_home,q_pos1,q_pos2,q_home];
% Simulate Simscape Multibody Model
sim("FR3_EstDynParamComparison.slx")
% Plot data
figure
plot(tout,tau_sim_measured)
legend("\tau_1","\tau_2","\tau_3","\tau_4","\tau_5","\tau_6","\tau_7","FontSize",10,'Orientation','horizontal',"Location","southoutside")
xlabel("Simulation Time (seconds)"); ylabel("Torque (Nm)")
title ("Franka Research 3 - Torque vs. Time")