% The purpose of this code is to test the derived dynamic equation of
% motion parameters for the Touch Haptic Device from the paper
% "Teleoperation with Inverse Dynamics Control for PHANToM Omni Haptic
% Device.
function [M,C,G] = testDynEM_paper1(q,qdot)

% Define constants k
k = 10^-3*[1.798,0.864,0.486,2.766,0.308,2.526,0.652,164.158,94.050,117.294];

% Inertia Matrix M
M11 = k(1) + k(2)*cos(2*q(2))+k(3)*cos(2*q(3))+ k(4)*cos(q(2))*sin(q(3));
M12 = k(5)*sin(q(2));
M13 = 0;
M21 = M12;
M22 = k(6);
M23 = -0.5*k(4)*sin(q(2))-q(3);
M31 = 0;
M32 = M23;
M33 = k(7);

M = [M11,M12,M13; M21,M22,M23; M31,M32,M33];

% Coriolis and Centrifugal Forces
C11 = -k(2)*qdot(2)*sin(2*q(2))-k(3)*qdot(3)*sin(2*q(3)) ...
    -0.5*k(4)*qdot(2)*sin(q(2))*sin(q(3))+ 0.5*k(4)*qdot(3)*cos(q(2))*cos(q(3));
C12 = -k(2)*qdot(1)*sin(2*q(2)) + k(5)*qdot(2)*cos(q(2)) ...
    -0.5*k(4)*sin(q(2))*sin(q(3));
C13 = -k(3)*qdot(1)*sin(2*q(3)) + 0.5*k(4)*qdot(1)*cos(q(2))*cos(q(3));
C21 = k(2)*qdot(1)*sin(2*q(2)) + 0.5*k(4)*qdot(1)*sin(q(2))*sin(q(3));
C22 = 0;
C23 = 0.5*k(4)*qdot(3)*cos(q(2)-q(3));
C31 = k(3)*qdot(1)*sin(2*q(3))+0.5*k(4)*qdot(1)*cos(q(2))*cos(q(3));
C32 = -0.5*k(4)*qdot(2)*cos(q(2)-q(3));
C33 = 0;

C = [C11,C12,C13; C21,C22,C23; C31,C32,C33];

% Gravity Terms
G11 = 0;
G12 = k(8)*cos(q(2))+k(10)*(q(2)-0.5*pi);
G13 = k(9)*sin(q(3));

G = [G11;G12;G13];
end