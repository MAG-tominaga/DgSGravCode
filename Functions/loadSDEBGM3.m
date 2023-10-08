function grav = loadSDEBGM3(ship,fName,fPath)
d2s = 24*3600;
fid=fopen(fullfile(fPath,fName),'r');
C = textscan(fid,'%s','delimiter','\n');
fclose(fid);
if contains(ship,'NBP')
    sc = 4.990626252;
    j = 1;
    for i = 1:length(C{1})
        if count(C{1}(i),' ')==4
            S(j,:) = sscanf(char(C{1}(i)),'SDE %4d/%2d/%2d %2d:%2d:%f %*d:%d %*d');
            j = j+1;
        end
    end
    grav.yr = S(:,1);
    grav.mon = S(:,2);
    grav.day = S(:,3);
    grav.hh = S(:,4);
    grav.mm = S(:,5);
    grav.ss = S(:,6);
    grav.rgrav = S(:,7)*sc;
end

grav.ts = datetime(grav.yr,grav.mon,grav.day,grav.hh,grav.mm,grav.ss);
grav.numTime = datenum(grav.ts);
grav.secTime = grav.numTime * d2s;




