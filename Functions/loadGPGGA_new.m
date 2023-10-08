function dat = loadGPGGA_new(ship,fName,fPath)
d2s = 24*3600;
% ship = 'Atlantis';
% fPath = '/Users/jasmine/Projects/PFPE/Data/Atlantis/AT50_08B/NAV';
% fName = 'at20230301_0800.GPS';
fid=fopen(fullfile(fPath,fName),'r');
i = 1;
if contains(ship,'Atlantis')
    fmt = ['NAV%4d/%2d/%2d%2d:%2d:%f%*[^\n]'];
end  
while ~feof(fid)
    ln = fgetl(fid);
    n = strfind(ln,'$GPGGA');
    if n>0
        T = textscan(ln,fmt);
        C = strsplit(ln,',');
        l = sscanf(C{1,3},'%2d%f');
        lat(i,1) = l(1)+l(2)/60;
        if C{1,4}=='S'
            lat(i,1) = -lat(i,1);
        end
        l = sscanf(C{1,5},'%3d%f');
        lon(i,1) = l(1)+l(2)/60;
        if C{1,6}=='W'
            lon(i,1) = -lon(i,1);
        end
        yr(i,1) = double(T{1});
        mon(i,1) = double(T{2});
        days(i,1) = double(T{3});
        hh(i,1) = double(T{4});
        mm(i,1) = double(T{5});
        ss(i,1) = double(T{6});
        i = i+1;
    end
    
    
end
dat.ts = datetime(yr,mon,days,hh,mm,ss);
dat.secTime = convertTo(dat.ts,'posixtime'); % numerical date in seconds
dat.numTime = dat.secTime/d2s; % numeric date in days
dat.lon = lon;
dat.lat = lat;
