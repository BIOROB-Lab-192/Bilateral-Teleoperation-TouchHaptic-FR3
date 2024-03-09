% The following MATLAB code applies the estimated inertia tensor properties
% published in Identification of the Franka Emika PandaRobot With Retrieval 
% of Feasible Parameters Using Penalty-Based Optimization by: Claudio Gaz, 
% Marco Cognetti,Alexander Oliva,Paolo Robuffo Giordano, Alessandro de Luca

% The URDF for this model is from the Robotic Systems Toolbox Library

% Define the center of mass (CoM) of each link (x,y,z)
FR3_CoM = [ 0.041018,-0.00014,0.049974;           % link 0
            0.003875,0.002081,-0.04762;           % link 1
            -0.003141,-0.02872,0.003495;          % link 2
            2.7518e-02,3.9252e-02,-6.6502e-02;    % link 3
            -5.317e-02,1.04419e-01,2.7454e-02;    % link 4
            -1.1953e-02,4.1065e-02,-3.8437e-02;   % link 5
            6.0149e-02,-1.4117e-02, -1.0517e-02;  % link 6
            1.0517e-02 -4.252e-03 6.1597e-02;     % link 7
            -0.01, 0, 0.03;                       % Franka hand
            0,0,0;                                % left finger
            0,0,0;];                              % right finger


% Define mass of each link in kilograms (starting with at link 0)
FR3_mass = [0.629769;       % link 0
            4.970684;       % link 1
            0.646926;       % link 2
            3.228604;       % link 3
            3.587895;       % link 4
            1.225946;       % link 5
            1.666555;       % link 6
            7.35522e-01;    % link 7
            0.73;           % Franka Hand
            0.015;          % left finger
            0.015];         % right finger

% Define interia tensor of each link (I_xx,I_yy,I_zz,I_xy,I_xz,I_yz)
FR3_inertia = [0.00315,0.00388,0.004285,8.2904E-07,0.00015,8.2299E-06;                  % link 0
               0.70337,0.70661,0.0091170,-0.00013900,0.0067720,0.019169;                % link 1
               0.0079620,2.8110e-02,2.5995e-02,-3.9250e-3,1.0254e-02,7.0400e-04;        % link 2
               3.7242e-02,3.6155e-02,1.0830e-02,-4.7610e-03,-1.1396e-02,-1.2805e-02;    % link 3
               2.5853e-02,1.9552e-02,2.8323e-02,7.7960e-03,-1.3320e-03,8.6410e-03;      % link 4
               3.5549e-02,2.9474e-02,8.6270e-03,-2.1170e-03,-4.0370e-03,2.2900e-04;     % link 5
               1.9640e-03,4.3540e-03,5.4330e-03,1.0900e-04,-1.1580e-03,3.4100e-04;      % link 6
               1.2516e-02,1.0027e-02,4.8150e-03,-4.2800e-04,-1.1960e-03,-7.4100e-04;    % link 7
               0.001,0.0025,0.0017,0,0,0;                                               % Franka Hand
               2.3749999999999997e-06,2.3749999999999997e-06,7.5e-07,0,0,0;             % left finger
               2.3749999999999997e-06,2.3749999999999997e-06,7.5e-07,0,0,0;             % right finger
];

% Load robot from Robotic Systems Toolbox Library
FR3robot = importrobot("frankaEmikaPanda.urdf",DataFormat="column");


% Apply gravity (m/s^2) in the Z-direction
FR3robot.Gravity = [0,0,-9.81];
% Apply mass of each link FR3
for n  = 1:11
    FR3robot.Bodies{1,n}.Mass = FR3_mass(n,:);
end 
% Apply CoM information of each link FR3
for m = 1:11
    FR3robot.Bodies{1,m}.CenterOfMass = FR3_CoM(m,:);
end

% Apply inertia tensor information of each link FR3
for k = 1:11
    FR3robot.Bodies{1,k}.Inertia = FR3_inertia(k,:);
end
