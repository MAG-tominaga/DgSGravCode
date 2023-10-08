function  gm = applytimemask(timemask,t,g)
[nx,~] = size(timemask);

for i =1:nx
    t1 = timemask(i,1);
    t2 = timemask(i,2);
    k = find(t>=t1-240 & t<=t2+240);
    g(k) = NaN;
    clear k;
end
gm = g;
