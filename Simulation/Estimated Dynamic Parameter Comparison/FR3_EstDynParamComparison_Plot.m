% Clear workspace and command window
clc;clear
% Run MATLAB code "FR3_robot.m" to create rigidBodyTree
FR3_robot;

% Specify sampling time and sampling duration
t_step = 10/150;
t_total = 10 - t_step;

% Create waypoints
q_home = [0,-pi/4,0,-3*pi/4,0,pi/2,pi/4,0,0]';
q_pos1 = [pi/2,-pi/2,0,-3*pi/4,0,pi/2,pi/4,0,0]';
q_pos2 = [-pi/2,-pi/2,0,-3*pi/4,0,pi/2,pi/4,0,0]';
rng default
frankaWaypoints = [q_home,q_pos1,q_pos2,q_home];

% Simulate Simscape Multibody Model
sim("FR3_EstDynParamComparison.slx")
%% Plot data
figure (1)
plot(tout,tau_sim_measured)
legend("\tau_1","\tau_2","\tau_3","\tau_4","\tau_5","\tau_6","\tau_7","FontSize",10,'Orientation','horizontal',"Location","southoutside")
xlabel("Simulation Time (seconds)"); ylabel("Torque (Nm)")
title ("Franka Research 3 - Torque vs. Time")

% Plot data comparing Simulation and Actual Robot
load FR3_DataCollect_12062023_slow_2.mat tau_FR3_traj123 

figure(2)
plot(tout,tau_sim_measured(:,1:7),LineStyle = "--",LineWidth=2)
hold on
grid on
plot(tout,tau_FR3_traj123(:,1:7))
% plot(tout,tau_sim_measured(:,2:2:4),LineStyle = "--",LineWidth=2)
% hold on
% plot(tout,tau_FR3_traj123(:,2:2:4))
legend("\tau_1 (sim)","\tau_2(sim)","\tau_3 (sim)","\tau_4 (sim)",...
    "\tau_5 (sim)","\tau_6(sim)","\tau_7 (sim)","\tau_1 (P2P Traj)",...
    "\tau_2 (P2P Traj)","\tau_3(P2P Traj)","\tau_4 (P2P Traj)","\tau_5 (P2P Traj)",...
    "\tau_7 (P2P Traj)","\tau_7 (P2P Traj)","FontSize",18,'Orientation','horizontal',"Location","southoutside","NumColumns",3)
xlabel("Time (seconds)"); ylabel("Torque (Nm)")
fontsize(16,"points")
%title ("Franka Research 3 - Point-to-Point Trajectory vs. Simulation - Joint 2 and 4")
hold off