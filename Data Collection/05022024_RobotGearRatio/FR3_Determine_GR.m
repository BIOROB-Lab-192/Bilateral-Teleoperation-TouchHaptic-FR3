% Purpose: Determine the gear ratio of the joints on the Franka Research 3. 
% Reason: OPC UA does not give the same torque as the Robot State "tau_J"

% Clear workspace and command window
clear;clc;close all

% Import the OPC UA Data 
FR3OPC_tau = readmatrix('FR3_JointTorqueOPC.csv');
% Load Franka MATLAB torque data
load FR3_MATLAB_tau_record.mat

sample =1:length(FR3OPC_tau);
N = 7;  % Number of Joints

% Pre-allocate arrays
tau_OPC_avg = zeros(1,N);
tau_ML_avg = zeros(1,N);
GR = zeros(1,N);
FR3_OPC_tau_scale = zeros(length(sample),N);

% Find the average torque of each joint motor (OPC UA)
for j = 1:7
    tau_OPC_avg(j) = mean(FR3OPC_tau(:,j));
end 
% Find the average torque of each joint (Franka MATLAB)
for k = 1:7
    tau_ML_avg(k) = mean(FR3_ML_tau(:,k));
end 

% Find the gear ratio of each robot joint
for m = 1:7
    GR(m) = tau_ML_avg(m)/tau_OPC_avg(m);
end

disp(GR)

for p = 1:7
    FR3_OPC_tau_scale(:,p) = GR(p)*FR3OPC_tau(:,p);
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

