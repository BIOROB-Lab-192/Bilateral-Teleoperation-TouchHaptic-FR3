% Joint Space Mapping Check JntSpcMap_TH_FR3(i,q_TH)
clear;clc

prompt = "Which joint are you interested in mapping? ";
i = input(prompt);
prompt_ang = "What angle (in degrees) would you like to map from the Touch Haptic to the FR3?";
q_TH = deg2rad(input(prompt_ang));

[q_FR3_rad,q_FR3_deg] = JntSpcMap_TH_FR3(i,q_TH);
disp("The mapped joint angle (deg) of the Franka Research 3 is");
disp(q_FR3_deg);


