function [crse,vel] = VeVn2CseVel(ve,vn)

rad2deg = 180 / pi;
crse = rad2deg * atan2(ve,vn);
vel=sqrt(ve.^2+vn.^2);
