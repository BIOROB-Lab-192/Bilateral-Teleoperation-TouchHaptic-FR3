% Purpose:collect data of the FR3 during its trajectory
% Define robot speeds
% Clear Data
clc;clear
slow_speed = 0.9; % 20 percent of max speed
med_speed = 0.5;  % 50 percent of max speed
fast_speed = 0.9; % 90 percent of max speed

% Set way points
q_init = [0,-pi/4,0,-3*pi/4,0,pi/2,pi/4];% Sets the intial joint positions
q_1 =[pi/2,-pi/2,0,-3*pi/4,0,pi/2,pi/4];
q_2 =[-pi/2,-pi/2,0,-3*pi/4,0,pi/2,pi/4];


N = 50; % Number of samples

% Create trajectory 1
q_traj1=[linspace(q_init(1,1),q_1(1,1),N);
    linspace(q_init(1,2),q_1(1,2),N);
    linspace(q_init(1,3),q_1(1,3),N);
    linspace(q_init(1,4),q_1(1,4),N);
    linspace(q_init(1,5),q_1(1,5),N);
    linspace(q_init(1,6),q_1(1,6),N);
    linspace(q_init(1,7),q_1(1,7),N)]';

% Create trajectory 2
q_traj2=[linspace(q_1(1,1),q_2(1,1),N);
    linspace(q_1(1,2),q_2(1,2),N);
    linspace(q_1(1,3),q_2(1,3),N);
    linspace(q_1(1,4),q_2(1,4),N);
    linspace(q_1(1,5),q_2(1,5),N);
    linspace(q_1(1,6),q_2(1,6),N);
    linspace(q_1(1,7),q_2(1,7),N)]';
% Create trajectory 3
q_traj3=[linspace(q_2(1,1),q_init(1,1),N);
    linspace(q_2(1,2),q_init(1,2),N);
    linspace(q_2(1,3),q_init(1,3),N);
    linspace(q_2(1,4),q_init(1,4),N);
    linspace(q_2(1,5),q_init(1,5),N);
    linspace(q_2(1,6),q_init(1,6),N);
    linspace(q_2(1,7),q_init(1,7),N)]';
% Return Home
franka_joint_point_to_point_motion('10.31.80.192',q_init,slow_speed);

for i =1:N
    franka_joint_point_to_point_motion('10.31.80.192',q_traj1(i,:),slow_speed);
    FR3_state = franka_robot_state('10.31.80.192');
    tau_FR3_traj1(i,:) = FR3_state.tau_J';
    q_FR3_traj1(i,:) = FR3_state.q';
    qd_FR3_traj1(i,:) = FR3_state.dq';
end

for i =1:N
    franka_joint_point_to_point_motion('10.31.80.192',q_traj2(i,:),slow_speed);
    FR3_state = franka_robot_state('10.31.80.192');
    tau_FR3_traj2(i,:) = FR3_state.tau_J';
    q_FR3_traj2(i,:) = FR3_state.q';
    qd_FR3_traj2(i,:) = FR3_state.dq';
end


for i =1:N
    franka_joint_point_to_point_motion('10.31.80.192',q_traj3(i,:),slow_speed);
    FR3_state = franka_robot_state('10.31.80.192');
    tau_FR3_traj_3(i,:) = FR3_state.tau_J';
    q_FR3_traj3(i,:) = FR3_state.q';
    qd_FR3_traj3(i,:) = FR3_state.dq';
end


