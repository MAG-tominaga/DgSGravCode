function dat = loadDatDGS(ship,fname,fpath)
    if contains(ship,'Thompson')
        fmt = ['%2d/%2d/%4d%2d:%2d:%f' repmat('%f',1,19) '%*[^\n]'];
    else
%         if contains(ship,'NBP') || contains(ship,'Atlantis') || contains(ship,'Revelle') || contains(ship,'Ride')
        % selected columns:
        % 1. uncorrected gravity
        % 2. ve,  3. vcc, 4. al, 5. ax
        % 6. lat, 7. lon
        % 8. year,  9. month,  10. day,  11. hour,  12. min,  13. sec
        fmt = '%*f%f%*f%*f%*f%*f%*f%*f%*f%*f%f%f%f%f%f%f%*f%*f%*f%d%d%d%d%d%f%*f'; 
    end
    %% Constant
    d2s = 24*3600; % day to secs
    fid=fopen(fullfile(fpath,fname),'r');
    C = textscan(fid,fmt,'delimiter',',');
    fclose(fid);
    [yr,mon,day,hh,mm,ss,rgrav,ve,vcc,al,ax,lat,lon] = parsingDatDGS(C,ship);
    dat.yr = yr;
    dat.mon = mon;
    dat.day = day;
    dat.hh = hh;
    dat.mm = mm;
    dat.ss = ss;
    dat.rgrav = rgrav;
    dat.vcc = -0.000029*vcc;
    dat.ve = 0.00001*ve;
    dat.al = 0.00001*al;
    dat.ax = 0.00001*ax;
    dat.lat = lat;
    dat.lon = lon;
    dat.ts = datetime(yr,mon,day,hh,mm,ss); % date string
    dat.secTime = convertTo(dat.ts,'posixtime'); % numerical date in seconds
    dat.numTime = dat.secTime/d2s; % numeric date in days
    


