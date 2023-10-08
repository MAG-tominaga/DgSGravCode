function g = WGS84(lat)

sinlam = sind(lat);

sinsqlam = sinlam .^ 2;

num = 1 + 0.00193185265241 * sinsqlam;

den = sqrt(1 - 0.00669437999014 * sinsqlam);

g = 978032.53359 * (num ./ den);

end
