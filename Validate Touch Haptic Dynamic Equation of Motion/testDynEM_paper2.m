% The purpose of this code is to test the derived dynamic equation of
% motion parameters for the Touch Haptic Device from the paper
% "On the robustness of force estimation methods for robot manipulators: 
% An experimental study"

function [M,C,G,FRC] = testDynEM_paper2(q,qdot)

c2 = cos(q(2));
c3 = cos(q(3));
s2 = sin(q(2));
s3 = sin(q(3));
c23 = cos(q(2)+q(3));
s23 = sin(q(2)+q(3));
g = 9.81;

% Define constants phi

phi = 10^-3*[4.53641;0.341864;4.503919;1.373760;1.188021;0.553657;4.948273;12.955526];

% Inertia Matrix 

M11 = c2^2*phi(1)+c2*c23*phi(2)+s23^2*phi(3);
M12 = 0;
M13 = 0;
M21 = 0;
M22 = phi(1)+2*c3*phi(2)+phi(3);
M23 = c3*phi(2) + phi(3);
M31 = 0;
M32 = c3*phi(2)+phi(3);
M33 = phi(3);

M = [M11,M12,M13;M21,M22,M23;M31,M32,M33];

% Coriolis and Centrifugal Forces
C11 = -c2*s2*qdot(2)*phi(1)- 0.5*(c2*s23*(qdot(2)+ qdot(3))...
       +s2*c23*qdot(2))*phi(2)+c23*s23*(qdot(2)+qdot(3))*phi(3);
C12 = -c2*s2*qdot(1)*phi(1)-0.5*(s2*c23+c2*s23)*qdot(1)*phi(2) + ...
      s23*c23*qdot(1)*phi(3);
C13 = -0.5*c2*s23*qdot(1)*phi(2)+c23*s23*qdot(1)*phi(3);
C21 = c2*s2*qdot(1)*phi(1)+0.5*(s2*c23+c2*s23)*qdot(1)*phi(2)- s23*c23*qdot(1)*phi(3);
C22 = -s3*qdot(3)*phi(2);
C23 = -s3*(qdot(2)+qdot(3))*phi(2);
C31 = 0.5*c2*s23*qdot(1)*phi(2) - c23*s23*qdot(1)*phi(3);
C32 = s3*qdot(2)*phi(2);
C33 = 0;

C = [C11,C12,C13; C21,C22,C23; C31,C32,C33];

% Gravity Terms
G11 = 0;
G12 = g*(c2*phi(7)+c23*phi(8));
G13 = g*c23*phi(8);

G = [G11;G12;G13];

% Friction Terms
FRC11 = phi(4)*qdot(1);
FRC21 = phi(5)*qdot(2);
FRC31 = phi(6)*qdot(3);

FRC = [FRC11;FRC21;FRC31]

end