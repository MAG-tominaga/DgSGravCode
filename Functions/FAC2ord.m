function [FAC] = FAC2ord(phi, ht)

% FAC2ord - 2nd order free-air correction 
%
% [FAC] = FAC2ord(phi,ht)
% FAC: 2nd order free-air correction (add to theoretical gravity)
% phi = latitude, degrees
% ht = height, meters

sinphi = sind(phi);

s2phi = sinphi .^ 2;

FAC = -((0.3087691- 0.0004398*s2phi) .* ht) + 7.2125e-8 * (ht .* ht);
