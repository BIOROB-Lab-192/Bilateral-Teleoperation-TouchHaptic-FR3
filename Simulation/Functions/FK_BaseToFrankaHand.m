% The following function will provide the transformation matrix from the
% base of the FR3 robot to the E.E. mounting flange. Note that the joint
% angles must be in radians and in the form of a [7,1] vector.

% Modified Denavit-Hartenberg parameters for the Franka Research 3
function [pos,rot]= FK_BaseToFrankaHand(q)
d1 = 0.333; d3 = 0.316; d5 = 0.384; d_ee = 0.107; % Units = meters
a4 = 0.0825; a5 = -0.0825; a7 = 0.088; % Units = meters
% Homogeneous Transformation matrix for each joint
T_0 = eye(4);
T_01 = mod_DH(0,0,d1,q(1));
T_12 = mod_DH(0,-pi/2,0,q(2));
T_23 = mod_DH(0,pi/2,d3,q(3));
T_34 = mod_DH(a4,pi/2,0,q(4));
T_45 = mod_DH(a5,-pi/2,d5,q(5));
T_56 = mod_DH(0,pi/2,0,q(6));
T_67 = mod_DH(a7,pi/2,0,q(7));
T_7EE = mod_DH(0,0,d_ee,0);

% Transformation matrix from base to end-effector
T0EE = double(T_0*T_01*T_12*T_23*T_34*T_45*T_56*T_67*T_7EE);
pos =T0EE(1:3,4);
rot = T0EE;
end