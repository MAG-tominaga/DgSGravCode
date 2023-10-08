function dat = loadRawDGS(ship,fName,fPath)
d2s = 24*3600;
g0 = 10000;
if contains(ship,'Thompson')
	fmt = ['%2d/%2d/%4d%2d:%2d:%f%*s%f' repmat('%*s',1,6) repmat('%f',1,4) '%*[^\n]'];
    GravCal = 414125;
% elseif contains(ship,'Armstrong')
%     fmt = ['DGS %04d/%02d/%02d %02d:%02d:%f DgS %s' repmat('%d',1,13) repmat('%f',1,5) '%*[^\n]'];
elseif contains(ship,'Atlantis')
    fmt = ['DGS %04d/%02d/%02d %02d:%02d:%f DGS %*s %d ' repmat('%*s',1,6) repmat('%d',1,4) '%*[^\n]'];
%     fmt = ['DGS %04d/%02d/%02d %02d:%02d:%f DGS ' repmat('%*s',1,18) '%s'];
    GravCal = 435834;
elseif contains(ship,'Revelle')
    fmt = ['%04d-%02d-%02dT%02d:%02d:%7.4f%*s%f' repmat('%*s',1,6) repmat('%f',1,4) '%*[^\n]'];
%     fmt = ['%04d-%02d-%02dT%02d:%02d:%7.4f%*s%f' repmat('%*s',1,6) repmat('%*s',1,4) '%*[^\n]'];
    GravCal = 424044;
end

fid=fopen(fullfile(fPath,fName),'r');
C = textscan(fid,fmt,'delimiter',',');
fclose(fid);
[yr,mon,day,hh,mm,ss,grav,rvcc,rve,ral,rax] = parsingRawDGS(ship,C);
s = grav+rvcc+rve+ral+rax;
% s = grav;
k = find(~isnan(s));

% waitbar(1,f,'Finishing');
% pause(1)
% close(f)
dat.yr = yr(k);
dat.mon = mon(k);
dat.day = day(k);
dat.hh = hh(k);
dat.mm = mm(k);
dat.ss = ss(k);
dat.rgrav = GravCal/8388607*grav(k)+g0;
dat.vcc = rvcc(k);
dat.ve = rve(k);
dat.al = ral(k);
dat.ax = rax(k);
dat.ts = datetime(dat.yr,dat.mon,dat.day,dat.hh,dat.mm,dat.ss); % date string
dat.numTime = datenum(dat.ts); % numeric date in days
dat.secTime = dat.numTime*d2s; % numerical date in seconds
% [dat.doy,~] = date2doy(dat.numTime); % day of year




 
