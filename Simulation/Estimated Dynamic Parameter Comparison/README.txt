MATLAB Version: R2023b or later (student version)

Test Date: 12-06-2023

Purpose:The purpose of this simulation was to gather link-side torque information of Franka Reaserch 3 URDF provided by the Robotic Systems Toolbox robot library. The results will be compared to the data collected in the following path:
Data Collection/Robot_State_12062023

File Information:
1. FR3_EstDynParamComparison_Plot.m: Used to load the Franka Research 3 model using the Robotic Systems Toolbox library. 
   The waypoints are created and the simulink file "FR3_EstDynParamComparison.slx" is run. A plot of the resulting joint torque is created.

2. FR3_EstDynParamComparison.slx: This Simulink model has the Simscape Multibody representation of the Franka Research 3 with the appropriate inertia tensor properties manually populated. A trapezoidal joint space trajectory
   input into the robot and the acutator torques are automatically calculated.

3. FR3_EstDynParComp_Trajectory.mp4: Video of the Franka Research 3 data used to calculate the required actuator torque.

 
