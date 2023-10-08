function [ve,vn] = LatLon2VeVn(lat,lng)
% LatLon2VeVn: Lat-long position to velocity East and North at 1hz
%
% [ve,vn] = LatLon2VeVn(lat,lng)
% inputs:
%   lat: latitude, degrees, + north
%   lng: longitude, degrees, + east
% outputs:
%   ve: east velocity, meters/second
%   vn: north velocity, meters/second
%   first and last 5 values are filled with NaN t
%   assumes 1 Hz data, if not should be scaled
%
% constants:
    deg2rad= pi/180;
% WGS84 ellipsoid values *******
e2 = 6.694379990141089e-003;
a = 6378137;

% constants for radii of curvature
sin2lat = (sind(lat)).^2;
e2term = sqrt(1-e2*sin2lat);

% differentiate latitude and longitude using 10th order Taylor
dlat = deg2rad * convn(lat,tay10','same');
dlng = deg2rad * convn(lng,tay10','same');

% convert dlat/dt to vn using radius of curvature
vn = a * (1 - e2) * (dlat ./ (e2term .^ 3));
% same for dlong/dt
ve = a * dlng .* (cosd(lat) ./ e2term);

% set edges to NaN
vn(1:5) = NaN;
vn(end-4:end) = NaN;

ve(1:5) = NaN;
ve(end-4:end) = NaN;
