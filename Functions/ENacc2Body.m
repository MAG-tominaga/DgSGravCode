function [ac,al] = RotAccENtoCL(alpha, acce, accn)
% rotate accelerations from E-N to C-L
%
% [ac al] = RotAccENtoCL(alpha, acce, accn)
%
% alpha: course (degrees, + clockwise from N)
% acce: east acceleration
% accn: north acceleration
% 
% ac: cross accleration
% al: long acceleration

cosa = cosd(alpha);
sina = sind(alpha);
ac = (acce .* cosa) - (accn .* sina);
al = (acce .* sina) + (accn .* cosa);


end

