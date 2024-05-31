% Clear variables
clear;clc;clf
load FR3_DataCollect_12062023_slow.mat

time = linspace(1,150,150);

plot(time,tau_FR3_traj123)
set(gcf,'Position',[100 100 500 500])
legend("\tau_1","\tau_2","\tau_3","\tau_4","\tau_5","\tau_6","\tau_7","FontSize",10,'Orientation','horizontal',"Location","southoutside")
xlabel("Point-to-Point Movement #","LineWidth",5,"FontSize",12);
ylabel("Torque (Nm)","LineWidth",5,"FontSize",12)
title ("FR3 - Torque vs. Point-to-Point Trajectory")
