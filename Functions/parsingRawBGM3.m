function [yr,mon,day,hh,mm,ss,cnts] = parsingRawBGM3(C) 
if max(C{1})<=12
    mon = double(C{1});
    day = double(C{2});
    yr  = double(C{3});
else
    mon = double(C{2});
    day = double(C{3});
    yr  = double(C{1});  
end
hh = double(C{4});
mm = double(C{5});
ss = double(C{6});
cnts=double(C{7});