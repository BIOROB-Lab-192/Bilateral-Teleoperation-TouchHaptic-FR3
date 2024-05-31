% The purpose of this script is to plot the data retrived during the
% "Pick and Place" test conducted on 04-27-2024 in ENGR 192. This data will
% be used to design the desired trajectory of the FR3 robot impedance cntlr

% The pick-and-place exercise is a 50mm x 250mm rectangle.

% Clear workspace and command window
clear;clc;close all

% Import data from desired CSV file
data = readmatrix('FR3_Data_PickandPlace_Rect.csv');
N_joints = 7;

% Extract data
for i = 1:7   % Joint positions
    q(:,i) = data(:,i);
end 

for k = 1:7  % Torque Data
    tau(:,k) = data(:,k+N_joints);
end

% Define time array
t_start = 0; t_step = 0.2; t_end = 20.0;
t = t_start:t_step:t_end;

% Plot the entire joint trajectory data
fig1=figure(1);
for w = 1:7
    plot(t,q(:,w)')
    hold on
end
hold off
legend("q_1","q_2","q_3","q_4","q_5","q_6","q_7",'Orientation','horizontal',"Location","southoutside")
xlabel("Time (seconds)","LineWidth",5);
ylabel("Joint Angle (Degrees) ","LineWidth",5)
title ("FR3 - Pick and Place - Data ")
% Modify and position Figure 1
fig1_pos = [0, 1000, 600, 500]; % [pos(x),pos(y),width,height
set(fig1, 'Position', fig1_pos);
set(gca,'FontSize',18);

% Plot the desired joint trajectory (in radians)
fig2 = figure(2);
t2 = t(:,9:55);
subplot(1,2,1)
for k = 1:7
    plot(t2,q(9:55,k)')
    hold on
end
hold off

legend("q_1","q_2","q_3","q_4","q_5","q_6","q_7",'Orientation','horizontal',"Location","southoutside",'NumColumns',4)
xlabel("Time (seconds)","LineWidth",5);
ylabel("Joint Angle (Degrees) ","LineWidth",5)
title ("FR3 - Desired PnP Trajectory - deg ")
set(gca,'FontSize',16);

subplot(1,2,2)
q_rad = deg2rad(q);
t3 = t2;
for m = 1:7
    plot(t3,q_rad(9:55,m)')
    hold on
end
hold off
legend("q_1","q_2","q_3","q_4","q_5","q_6","q_7",'Orientation','horizontal',"Location","southoutside",'NumColumns',4)
xlabel("Time (seconds)","LineWidth",5);
ylabel("Joint Angle (radians) ","LineWidth",5)
title ("FR3 - Desired PnP Trajectory - rad ")

% Modify and position Figure 2
fig2_pos = [700, 1000, 800, 500]; % [pos(x),pos(y),width,height
set(fig2, 'Position', fig2_pos);
set(gca,'FontSize',16);

