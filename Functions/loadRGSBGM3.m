function grav = loadRGSBGM3(ship,fName,fPath)
% if contains(ship,'NBP')
%     fmt = '%s%4d/%2d/%2d%2d:%2d:%f%f%*[^\n]';
%     
% elseif contains(ship,'Atlantis')
if contains(ship,'Atlantis')
    fmt = '%s%4d/%2d/%2d%2d:%2d:%f%f%*d%*f%*f%*f%*s%*s%*s%f%f%*[^\n]';

% elseif contains(ship,'Revelle')
%     fmt = '%4d-%2d-%2dT%2d:%2d:%9.6fZ%*d:%d%d%*[^\n]';
%     sc = 4.99980755;
end

d2s = 24*3600;

fid=fopen(fullfile(fPath,fName),'r');
C = textscan(fid,fmt,'delimiter',' ');
fclose(fid);
k = find(strcmp(C{1,1},'RGS'));
grav.yr = double(C{1,2}(k));
grav.mon = double(C{1,3}(k));
grav.day = double(C{1,4}(k));
grav.hh = double(C{1,5}(k));
grav.mm = double(C{1,6}(k));
grav.ss = double(C{1,7}(k));
grav.grav = double(C{1,8}(k));
grav.lat = double(C{1,9}(k));
grav.lon = double(C{1,10}(k));


grav.ts = datetime(grav.yr,grav.mon,grav.day,grav.hh,grav.mm,grav.ss);
grav.secTime = convertTo(grav.ts,'posixtime'); % numerical date in seconds
grav.numTime = grav.secTime/d2s;

   


