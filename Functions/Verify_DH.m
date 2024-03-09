% The following code is to verify the standard DH and modified DH
% tranformation matrices are correct. The Symbolic Math toolbox is required

% Clear Command Window and Workspace
clc;clear
% Define Denavit-Hartenberg parameters
a = sym("a");alpha = sym ("alpha");d = sym("d");theta = sym("theta");

% Homogeneous transformation matrices for Z-axis & X-axis 
Z_rot = [cos(theta),-sin(theta),0,0;
     sin(theta), cos(theta),0,0;
     0,0,1,0;
     0,0,0,1];
Z_trans = [1,0,0,0;
       0,1,0,0;
       0,0,1,d;
       0,0,0,1];
X_rot = [1,0,0,0;
     0,cos(alpha),-sin(alpha),0;
     0,sin(alpha),cos(alpha),0;
     0,0,0,1];

X_trans = [1,0,0,a;
       0,1,0,0;
       0,0,1,0;
       0,0,0,1];

%Z-Y-X, Yaw Pitch Roll (standard D-H transformation matrix)
std_DH = Z_rot*Z_trans*X_rot*X_trans;

% X-Y-Z, Roll Pitch Yaw (modified D-H transformation matrix)
mod_DH = X_rot*X_trans*Z_rot*Z_trans;

