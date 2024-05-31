% Purpose: Determine the gear ratio of the joints on the Franka Research 3. 
% Reason: OPC UA does not give the same torque as the Robot State "tau_J"
% Method: Put the FR3 in different poses and record data in MATLAB and OPC

% Clear workspace and command window
clear;clc;close all

% Import the OPC UA Data 
FR3OPC_tau_pose1 = readmatrix('GearRatioPose1.csv');
FR3OPC_tau_pose2 = readmatrix('GearRatioPose2.csv');
FR3OPC_tau_pose3 = readmatrix('GearRatioPose3.csv');
% Load Franka MATLAB torque data
load tau_pose1_GR.mat 
load tau_pose2_GR.mat 
load tau_pose3_GR.mat
% Get average torques of all three poses (MATLAB data collection)
ML_pose1_avg = mean(tau_pose1_GR);
ML_pose2_avg = mean(tau_pose2_GR);
ML_pose3_avg = mean(tau_pose3_GR);
% Get average torques of all three poses (OPC Data Collection)
OPC_pose1_avg = mean(FR3OPC_tau_pose1(:,8:14));
OPC_pose2_avg = mean(FR3OPC_tau_pose2(:,8:14));
OPC_pose3_avg = mean(FR3OPC_tau_pose3(:,8:14));

% Get gear ratios for all 3 poses
for i = 1:7
    GR_pose1(i) = ML_pose1_avg(i)/OPC_pose1_avg(i)
    GR_pose2(i) = ML_pose2_avg(i)/OPC_pose2_avg(i)
    GR_pose3(i) = ML_pose3_avg(i)/OPC_pose3_avg(i)
end
%% sample =1:length(FR3OPC_tau);
N = 7;  % Number of Joints

% Pre-allocate arrays
tau_OPC_avg = zeros(1,N);
tau_ML_avg = zeros(1,N);
GR = zeros(1,N);
FR3_OPC_tau_scale = zeros(length(sample),N);

% Find the average torque of each joint motor (OPC UA)
for j = 1:7
    tau_OPC_avg(j) = mean(FR3OPC_tau_pose1(:,j));
end 
% Find the average torque of each joint (Franka MATLAB)
for k = 1:7
    tau_ML_avg(k) = mean(tau_pose1.(:,k));
end 

% Find the gear ratio of each robot joint
for m = 1:7
    GR(m) = tau_ML_avg(m)/tau_OPC_avg(m);
end

disp(GR)

for p = 1:7
    FR3_OPC_tau_scale(:,p) = GR(p)*FR3OPC_tau_pose1(:,p);
end 


fig1 = figure(1);
fig1_pos = [0,0, 800, 1000]; % [pos(x),pos(y),width,height
set(fig1, 'Position', fig1_pos);
for i = 1:4
    subplot(4,1,i);
    plot(sample,FR3_OPC_tau_scale(:,i),"Color","green")
    hold on
    plot(sample,FR3_ML_tau(:,i),"Color","blue","LineStyle","-.")
    title ("Joint Torque", num2str(i),"LineWidth",2,"LineStyle","-")
    ylabel("Torque (Nm)")
    set(gca,'FontSize',15);
end

fig2 = figure(2);
fig2_pos = [1000,0, 800, 1000]; % [pos(x),pos(y),width,height
set(fig2, 'Position', fig2_pos);
for i = 5:7
    subplot(4,1,i-4);
    plot(sample,FR3_OPC_tau_scale(:,i),"Color","green")
    hold on
    plot(sample,FR3_ML_tau(:,i),"Color","blue","LineStyle","-.")
    title ("Joint Torque", num2str(i),"LineWidth",2,"LineStyle","-")
    ylabel("Torque (Nm)")
    set(gca,'FontSize',15);
end