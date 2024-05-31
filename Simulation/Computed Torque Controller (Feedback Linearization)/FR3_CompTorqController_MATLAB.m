% Clear workspace and command window
clc;clear

% Run MATLAB code "FR3_robot.m" to create rigidBodyTree
FR3_robot;

% Define proportional and derivative gains
K_p = [200,200,200,200,200,200,200,200,200]';
K_d = [10,10,10,10,10,10,10,10,10]';

% K_p = [50,100,100,50,50,50,30,30,30]';
% K_d = sqrt(K_p)*0.5;

% Create waypoints
q_home = [0,-pi/4,0,-3*pi/4,0,pi/2,pi/4,0,0]';
q_pos1 = [pi/2,-pi/2,0,-3*pi/4,0,pi/2,pi/4,0,0]';
q_pos2 = [-pi/2,-pi/2,0,-3*pi/4,0,pi/2,pi/4,0,0]';
rng default
frankaWaypoints = [q_home,q_pos1,q_pos2,q_home];

% Simulate Simscape Multibody Model
sim("FR3_CompTorqController.slx")

% Reshape Matrix
% q_d,qd_d,q_error,qdot_error,tau need to be reshaped
q_d = permute(q_d,[3,1,2]);
qd_d = permute(qd_d,[3,1,2]);
q_error = permute(q_error,[3,1,2]);
qdot_error = permute(qdot_error,[3,1,2]);
tau = permute(tau,[3,1,2]);
%% Plot data
% Plot torque data
plt_strt = 865;
q1to3 = 1:3;
q4to7 = 4:7;
figure(1)
plot(tout(plt_strt:end,:),tau(plt_strt:end,:))
legend("\tau_1","\tau_2","\tau_3","\tau_4","\tau_5","\tau_6","\tau_7","f_8","f_9","FontSize",10,'Orientation','horizontal',"Location","southoutside")
title("Computed Torque Controller - Torque/Force vs. Time","FontSize",16);
xlabel("Time (sec)"); 
ylabel("Torque(Nm) | Force (N)");

% Plot joint position error (Joints 1 to 3)
figure (2)
plot(tout(plt_strt:end,:),q_d(plt_strt:end,q1to3),"LineWidth",3)
hold on
plot(tout(plt_strt:end,:),q(plt_strt:end,q1to3),"LineWidth",3)
%title("Controller with Feedback Linearization - Joint Position Error (q_1 to q_3)","FontSize",16);
xlabel("Time (sec)");
ylabel("Joint Position (rad)");
grid on
set(gca,'FontSize',16)

yyaxis right
plot(tout(plt_strt:end,:),q_error(plt_strt:end,q1to3))
ylabel("Joint Position Error (rad)")
lgd = legend("q_{d,1}","q_{d,2}","q_{d,3}","q_1","q_2","q_3","e_1","e_2","e_3");
lgd.NumColumns = 2;

% Plot joint position error (Joints 4-7)
figure(3)
plot(tout(plt_strt:end,:),q_d(plt_strt:end,q4to7))
hold on
plot(tout(plt_strt:end,:),q(plt_strt:end,q4to7))
%title("Controller with Feedback Linearization - Joint Position Error (q_4 to q_7)","FontSize",16);
xlabel("Time (sec)");
ylabel("Joint Position (rad)");

yyaxis right
plot(tout(plt_strt:end,:),q_error(plt_strt:end,q4to7))
ylabel("Joint Position Error (rad)")
lgd = legend("q_{d,4}","q_{d,5}","q_{d,6}","q_{d,7}","q_4","q_5","q_6","q_7","e_4","e_5","e_6","e_7");
lgd.NumColumns = 3;