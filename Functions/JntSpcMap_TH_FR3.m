% The following function will output the mapped joint angle of the Franka
% Research 3 based on the current position of the Touch Haptic Device.
% Please note that the input must be in radians.

function [q_FR3_r,q_FR3_deg] = JntSpcMap_TH_FR3(i,q_TH)
% Define the joint limits of the Touch Haptic Device and Franka Research 3
% in degrees
    q_TH_min_d = [-60,0,-100,-145,-70,-145];
    q_TH_max_d = [60,105,100,145,70,145];
    q_FR3_min_d = [-166,-105,-166,-176,-165,25,-175];
    q_FR3_max_d = [166,105,166,-7,165,265,175];

    % Convert from degrees to radians
    q_TH_min = deg2rad(q_TH_min_d);
    q_TH_max = deg2rad(q_TH_max_d);
    q_FR3_min = deg2rad(q_FR3_min_d);
    q_FR3_max = deg2rad(q_FR3_max_d);

    % Joint space mapping equation (Linear Min-Max Scaling)
    q_FR3_r = ((q_TH-q_TH_min(1,i))*((q_FR3_max(1,i)-q_FR3_min(1,i))/(q_TH_max(1,i)-q_TH_min(1,i))))+q_FR3_min(1,i);
    q_FR3_deg = rad2deg(q_FR3_r);
end 