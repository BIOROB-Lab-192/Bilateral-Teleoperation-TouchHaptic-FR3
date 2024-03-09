% The following function takes the modified Denavit-Hartenberg parameters
% and outputs the homogeneous tranformation matrix
function matrix = mod_DH(a,alpha,d,theta)
    T = [cos(theta), -sin(theta), 0,   a;
         sin(theta)*cos(alpha),  cos(theta)*cos(alpha),   -sin(alpha), -d*sin(alpha);
         sin(theta)*sin(alpha),  cos(theta)*sin(alpha),  cos(alpha),  d*cos(alpha);
         0,  0,   0,  1];
    matrix = T;
end 