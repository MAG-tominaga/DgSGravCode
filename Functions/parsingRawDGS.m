% ---------------------------

function [yr,mon,day,hh,mm,ss,grav,rvcc,rve,ral,rax] = parsingRawDGS(ship,C)
% function [yr,mon,day,hh,mm,ss,grav] = parsingRawDGS(ship,C)
if contains(ship,'Thompson')
    mon = double(C{1});
    day = double(C{2});
    yr  = double(C{3});
elseif contains(ship,'Atlantis') || contains(ship,'Revelle')
    yr  = double(C{1});
    mon = double(C{2});
    day = double(C{3});
end
hh = double(C{4});
mm = double(C{5});
ss = double(C{6});
grav=double(C{7});   
rvcc=double(C{8});        % mGal vcc monitor
rve=double(C{9});        % mGal ve monitor
ral=double(C{10});        % mGal al monitor
rax=double(C{11});

%-------------------------------------