function grav = loadRawBGM3(ship,fName,fPath)
d2s = 24*3600;
if contains(ship,'Thompson')
    fmt = '%2d/%2d/%4d%2d:%2d:%f%*d:%d%d%*[^\n]';
    sc = 5.003353363;
elseif contains(ship,'Atlantis')
    fmt = 'BGM%d/%d/%d%d:%d:%fBGM3%*d:%d%d%*[^\n]';
    sc = 4.994070552;
elseif contains(ship,'Revelle')
    fmt = '%4d-%2d-%2dT%2d:%2d:%9.6fZ%*d:%d%d%*[^\n]';
    sc = 4.99980755;
end
fid=fopen(fullfile(fPath,fName),'r');
C = textscan(fid,fmt,'delimiter',',');
fclose(fid);
[yr,mon,day,hh,mm,ss,cnts] = parsingRawBGM3(C);

grav.rgrav = sc * cnts;
grav.yr = yr;
grav.mon = mon;
grav.day = day;
grav.hh = hh;
grav.mm = mm;
grav.ss = ss;
grav.ts = datetime(yr,mon,day,hh,mm,ss);
grav.secTime = convertTo(grav.ts,'posixtime'); % numerical date in seconds
grav.numTime = grav.secTime/d2s; % numeric date in days




