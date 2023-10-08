

function [yr,mon,day,hh,mm,ss,rgrav,ve,vcc,al,ax,lat,lon] = parsingDatDGS(C,ship) 
    if contains(ship,'Thompson')
        yr = double(C{3});
        mon = double(C{1});
        day = double(C{2});
        hh = double(C{4});
        mm = double(C{5});
        ss = double(C{6});
%         ss = round(ss);
        rgrav= double(C{8});
        ve = double(C{17});
        vcc = double(C{18});
        al = double(C{19});
        ax = double(C{20});
        lat = double(C{21});
        lon = double(C{22});
    else
%         if contains(ship,'NBP')|| contains(ship,'Atlantis')|| contains(ship,'Revelle')|| contains(ship,'Ride')
    
        % selected columns:
        % 1. uncorrected gravity
        % 2. ve,  3. vcc, 4. al, 5. ax
        % 6. lat, 7. lon
        % 8. year,  9. month,  10. day,  11. hour,  12. min,  13. sec
        rgrav= C{1};
        ve = C{2};
        vcc = C{3};
        al = C{4};
        ax = C{5};
        lat = C{6};
        lon = C{7};
        yr = double(C{8});
        mon = double(C{9});
        day = double(C{10});
        hh = double(C{11});
        mm = double(C{12});
        ss = double(C{13});
%         ss = round(ss);
    end
    