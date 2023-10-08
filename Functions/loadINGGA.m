function gps = loadINGGA(ship,fName,fPath)
if contains(ship,'Thompson')
	fmt = '%2d/%2d/%4d%2d:%2d:%f$INGGA%*s%2d%f%s%3d%f%s%*[^\n]';
    
elseif contains(ship,'Ride')
    fmt = '%s%*f%2d%f%s%3d%f%s%*[^\n]';
end
secTime  = [];
lat = [];
lon = [];
fid=fopen(fullfile(fPath,fName),'r');
C = textscan(fid,fmt,'Delimiter',',');
fclose(fid);

[secTime0,lat0,lon0] = parsingINGGA(ship,C);
secTime = [secTime;secTime0];
lat  = [lat;lat0];
lon  = [lon;lon0];  
[~, ind] = unique(secTime); 
gps.secTime = secTime(ind);
gps.lon = lon(ind);
gps.lat = lat(ind);


