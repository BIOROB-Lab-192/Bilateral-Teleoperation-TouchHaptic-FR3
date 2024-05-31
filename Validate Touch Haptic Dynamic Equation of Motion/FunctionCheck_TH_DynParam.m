clear;clc

q=[pi/4;pi/2;pi/3];
qdot = [0;0;0];

[M,C,G]= testDynEM_paper1(q,qdot);
[M2,C2,G2]= testDynEM_paper2(q,qdot);