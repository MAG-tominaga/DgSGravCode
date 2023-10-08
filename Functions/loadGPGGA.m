function dat = loadGPGGA(fName,fPath)
d2s = 24*3600;
% ship = 'NBP';
% fPath = '/Users/jasmine/Projects/PFPE/Data/NBP/2301/Nav';
% fName = 'NBP2301s380.d009';
fid=fopen(fullfile(fPath,fName),'r');
k = 1;

C = textscan(fid,'%s%s\n','Delimiter',' ');
totalrec = length(C{1,2});
for i = 1:totalrec
    if contains(C{1,2}{i},'$GPGGA')
        temp = strsplit(C{1,2}{i},',');
        l = sscanf(temp{3},'%2d%f');
        lat(k,1) = l(1) + l(2)/60;
        if strcmp(temp{4},'S')
            lat(k,1) = -lat(k,1);
        end
        l = sscanf(temp{5},'%3d%f');
        lon(k,1) = l(1) + l(2)/60;
        if strcmp(temp{6},'W')
            lon(k,1) = -lon(k,1);
        end
        clear temp
        temp = sscanf(C{1,1}{i},'%2d+%3d:%2d:%2d:%f');
        yr(k,1) = 2000+temp(1);
        doy(k,1) = temp(2);
        hh(k,1) = temp(3);
        mm(k,1) = temp(4);
        ss(k,1) = temp(5);
        k = k+1;
    end
end
dat.ts = datetime(yr,1,doy,hh,mm,ss);
dat.numTime = datenum(dat.ts); % numeric date in days
dat.secTime = dat.numTime*d2s;
dat.lon = lon;
dat.lat = lat;
