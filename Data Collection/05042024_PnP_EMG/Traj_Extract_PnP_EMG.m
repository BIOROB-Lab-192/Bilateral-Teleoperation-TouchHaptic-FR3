% The purpose of this script is to export the desired joint space
% trajectory for the Franka Research 3 (with Upper Limb Rehab EE).

% The pick-and-place exercise is a 50mm x 250mm rectangle.

% Clear workspace and command window
clear;clc;close all

% Import data from desired CSV file. In this file, the desired set of joint
% data for the desired trajectory has been identified in EXCEL.
data = readmatrix('FR3_PnP_EMG_NoUser_HighStiff.csv');

% Define desired rows of data extraction
row_start = 30;
row_end = 77;
% Extract joint data for Pick-and-place 
n_joints = 7;
for i = 1:n_joints
    q(:,i)= data(row_start:row_end,i);
end
% Convert the joint angles to radians
q_rad = deg2rad(q);

% Specify a file name
filename = 'q_traj_Ellipse_rad.csv';
filename2 = 'q_traj_Ellipse_deg.csv';

% Write the joint trajectory to a CSV file
writematrix(q_rad,filename)
writematrix(q,filename2)