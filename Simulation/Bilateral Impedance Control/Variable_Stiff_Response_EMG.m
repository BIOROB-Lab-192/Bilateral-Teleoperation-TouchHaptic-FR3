clear;clc
% The purpose of this MATLAB code is to test varying impedance parameters
% and tracking performance in the presence of environmental force.

% Section 1: Setup
% Run MATLAB code "FR3_robot.m" to create rigidBodyTree
FR3_ULRehab_robot;
N_joints = 7;
% Import data from EMG testing
EMG_data1 = readmatrix("PickAndPlace_EMG_HighStiff_NoUser.csv");
EMG_data2 = readmatrix("PickAndPlace_EMG_HighStiff_UserFollow.csv");
EMG_data3 = readmatrix("PickAndPlace_EMG_HighStiff_UserResist.csv");

% Extract data 
q_d = deg2rad(EMG_data1(:,1:7));

% Define time data
t_step = 0.2;
t_dur = t_step*length(q_d); 
t_sim = 0.2:t_step:t_dur;

% Define Impedance Gains for the Franka Research 3
i = 1;
switch i
    case 1
        K = [800,800,800,800,500,300,100]';
        D = [50,50,50,50,30,25,15]';
    case 2
        K = [50,50,50,50,50,25,12.5]';
        D = [50,50,50,50,30,25,15]';
end

% Trajectory Generation
q_home = q_d(1,:)';
q_traj1 = q_d';
q_traj2 = (deg2rad(EMG_data2(:,1:7)))';
q_traj3 = (deg2rad(EMG_data3(:,1:7)))';
frankaWaypoints  = [q_traj1];
frankaTimepoints = t_sim;

% Polynomial Trajectory Parameters
v_BC = zeros(N_joints,length(q_d));

% Environment Setup
Force_External = [0;0;0;0;0;0]; % (Fx,Fy,Fz,Tx,Ty,Tz)

% Read Human Torque 
tau_hum = readmatrix("Human_Torque.xlsx");
tau_hum = [tau_hum(:,1),tau_hum(:,2:4)*10;];

% Forward Kinematics from EMG Testing 
for i = 1:length(q_d)
pos_q1(:,i)= FK_BaseToFrankaHand(q_traj1(:,i));
pos_q2(:,i)= FK_BaseToFrankaHand(q_traj2(:,i));
pos_q3(:,i)= FK_BaseToFrankaHand(q_traj3(:,i));
end
shift = [zeros(1,length(q_d));zeros(1,length(q_d));0.005*ones(1,length(q_d))];

% Shift desired trajectory z-axis
pos_q1_shift = pos_q1-shift;

% Trajectory Error from EMG Testing
traj2_err = pos_q1_shift - pos_q2;
traj3_err = pos_q1_shift - pos_q3;

% Plot data from EMG Testing
fig1=figure(1);
fig1_pos = [0, 1000, 800, 900]; % [pos(x),pos(y),width,height
set(fig1, 'Position', fig1_pos);

subplot(3,1,1)
plot(pos_q1_shift(2,:),pos_q1_shift(3,:),"Color","black",LineWidth=8)
hold on
plot(pos_q2(2,:),pos_q2(3,:),"LineStyle","--","Color","red",LineWidth=3)
plot(pos_q3(2,:),pos_q3(3,:),"LineStyle",":","Color","blue","LineWidth",1)
xlabel("Horizontal Position (meters)");ylabel("Veritcal Position (meters)")
legend("Desired Trajectory","Patient Following","Patient Resisting","Location","southoutside","NumColumns",3)
set(gca,'FontSize',16)

subplot(3,1,2)
plot(t_sim,traj2_err(2,:),LineWidth=2)
hold on
plot(t_sim,traj3_err(2,:),LineWidth=2)
legend("Error (Patient Follow)","Error (Patient Resist)","Location","southoutside","NumColumns",2)
xlabel("Time (seconds)");ylabel("Error (meters)")
title("Trajectory Error-Horizontal")
set(gca,'FontSize',16)

subplot(3,1,3)
plot(t_sim,traj2_err(3,:),LineWidth=2)
hold on
plot(t_sim,traj3_err(3,:),LineWidth=2)
legend("Error (Patient Follow)","Error (Patient Resist)","Location","southoutside","NumColumns",2)
xlabel("Time (seconds)");ylabel("Error (meters)")
title("Trajectory Error- Vertical")
set(gca,'FontSize',16)

% Create wrench forces as time series
F_x = [t_sim',EMG_data3(:,15)];
F_y = [t_sim',EMG_data3(:,16)];
F_z = [t_sim',EMG_data3(:,17)];
tau_x = [t_sim',EMG_data3(:,18)];
tau_y = [t_sim',EMG_data3(:,19)];
tau_z = [t_sim',EMG_data3(:,20)];



% Run simulation
for i = 1:2
end 
sim("Bilat_Imp_Cntrl_FR3_Corrected")

%% Plot Data
POS = squeeze(POS);
POS_d = squeeze(POS_d);

fig4=figure(4);
fig4_pos = [0, 1000, 800, 900]; % [pos(x),pos(y),width,height
set(fig4, 'Position', fig4_pos);
figure(4)
subplot(3,1,1)
plot(POS_d(2,:),POS_d(3,:),"LineWidth",2)
hold on
plot(POS(2,:),POS(3,:),"LineWidth",2,"LineStyle",":")
grid on
xlabel("Horizontal Position (meters)");ylabel("Vertical Position (meters)")
legend("traj_d","Resisted traj_{sim}")
set(gca,'FontSize',16)


error = POS_d - POS;

subplot(3,1,2)
plot(tout,error(2,:),"LineStyle",":",LineWidth=3)
hold on
plot(t_sim,traj3_err(2,:),"Color","r",LineWidth=2)
grid on
xlabel("Time (seconds)");ylabel("Horizontal Error (meters)")
legend("Patient Resist (real)","Patient Resist (sim)")
set(gca,'FontSize',16)

subplot(3,1,3)
plot(tout,error(3,:),"LineStyle",":",LineWidth=3)
hold on
plot(t_sim,traj3_err(3,:),"Color","g",LineWidth=2)
grid on
xlabel("Time (seconds)");ylabel("Vertical Error (meters)")
legend("Patient Resist (real)","Patient Resist (sim)")
set(gca,'FontSize',16)

