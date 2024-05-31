% Clear command window and workspace
clc;clear

% Define the center of mass (CoM) of each link (x,y,z)
FR3_ULRehab_CoM = [0.003875,0.002081,-0.04762;           % link 1
                    -0.003141,-0.02872,0.003495;          % link 2
                    2.7518e-02,3.9252e-02,-6.6502e-02;    % link 3
                    -5.317e-02,1.04419e-01,2.7454e-02;    % link 4
                    -1.1953e-02,4.1065e-02,-3.8437e-02;   % link 5
                    6.0149e-02,-1.4117e-02, -1.0517e-02;  % link 6
                    1.0517e-02 -4.252e-03 6.1597e-02;     % link 7
                    0.03149,0,0.0616;                     % Upper Limb Rehab EE
                    ];                              
% Define mass of each link in kilograms (starting with at link 0)
FR3_ULRehab_mass = [4.970684;       % link 1
                    0.646926;       % link 2
                    3.228604;       % link 3
                    3.587895;       % link 4
                    1.225946;       % link 5
                    1.666555;       % link 6
                    7.35522e-01;    % link 7
                    0.210;           % Upper Limb Rehab EE
                    ];

% Define interia tensor of each link (I_xx,I_yy,I_zz,I_xy,I_xz,I_yz)
FR3_ULRehab_inertia = [0.70337,0.70661,0.0091170,-0.00013900,0.0067720,0.019169;                % link 1
                       0.0079620,2.8110e-02,2.5995e-02,-3.9250e-3,1.0254e-02,7.0400e-04;        % link 2
                       3.7242e-02,3.6155e-02,1.0830e-02,-4.7610e-03,-1.1396e-02,-1.2805e-02;    % link 3
                       2.5853e-02,1.9552e-02,2.8323e-02,7.7960e-03,-1.3320e-03,8.6410e-03;      % link 4
                       3.5549e-02,2.9474e-02,8.6270e-03,-2.1170e-03,-4.0370e-03,2.2900e-04;     % link 5
                       1.9640e-03,4.3540e-03,5.4330e-03,1.0900e-04,-1.1580e-03,3.4100e-04;      % link 6
                       1.2516e-02,1.0027e-02,4.8150e-03,-4.2800e-04,-1.1960e-03,-7.4100e-04;    % link 7
                       5.365E-04,16.854E-04,16.993E-04,1.357E-04,0.001E-04,0;                   % Upper Limb Rehab EE         
                       ];

% Import robot as a rigidBodyTree
FR3_Rehab_robot = importrobot("FR3_UpperLimbRehab.urdf",DataFormat="column");

N_link = 8;
% Apply gravity (m/s^2) in the Z-direction
FR3_Rehab_robot.Gravity = [0,0,-9.81];
% Apply mass of each link FR3
for n  = 1:N_link
    FR3_Rehab_robot.Bodies{1,n}.Mass = FR3_ULRehab_mass(n,:);
end 
% Apply CoM information of each link FR3
for m = 1:N_link
    FR3_Rehab_robot.Bodies{1,m}.CenterOfMass = FR3_ULRehab_CoM(m,:);
end

% Apply inertia tensor information of each link FR3
for k = 1:N_link
    FR3_Rehab_robot.Bodies{1,k}.Inertia = FR3_ULRehab_inertia(k,:);
end