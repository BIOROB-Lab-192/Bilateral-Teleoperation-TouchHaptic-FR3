% Clear command window and workspace
clc;clear
% Import Franka Emika Panda URDF
FR3robot = loadrobot("frankaEmikaPanda",DataFormat="column");
FR3robot.Gravity = [0,0,-9.81] % Set gravity in RigidBodyTree to Z-axis
%% Import URDF into Simscape Mutlibody
robotSM = smimport(robot,ModelName="FR3_CompTorqCont");
%%
sm_mdl = get_param(robotSM,"Name");
