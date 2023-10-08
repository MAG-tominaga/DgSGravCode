function [secTime,lat,lon] = parsingINGGA(ship,C)

if contains(ship,'Thompson')
    time = datetime(double(C{3}),double(C{1}),double(C{2}),double(C{4}),double(C{5}),double(C{6}));
    secTime = convertTo(time,'posixtime');
    latD = double(C{7});
    latM = double(C{8});
    latNS = C{9};
    lat = latD + latM/60;
    k = strcmp(latNS,'S');
    if ~isempty(k)
        lat(k) = -lat(k);
    end
    clear k
    lonD = double(C{10});
    lonM = double(C{11});
    lonEW = C{12};
    lon = lonD + lonM/60;
    k = strcmp(lonEW,'W');
    if ~isempty(k)
        lon(k) = -lon(k);
    end
elseif contains(ship,'Ride')
    latD = double(C{2});
    latM = double(C{3});
    latNS = C{4};
    lat = latD + latM/60;
    k = strcmp(latNS,'S');
    if ~isempty(k)
        lat(k) = -lat(k);
    end
    clear k
    lonD = double(C{5});
    lonM = double(C{6});
    lonEW = C{7};
    lon = lonD + lonM/60;
    k = strcmp(lonEW,'W');
    if ~isempty(k)
        lon(k) = -lon(k);
    end
    for i = 1:length(lat)
        S = string(C{1}(i));
        secTime(i,1) = sscanf(S,'%f');
    end

end