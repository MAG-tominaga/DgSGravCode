function tmask = maketimemask(secTime,dt0)
%% when diff(secTime)>=dt0, mask this section of data in gravity plot
%% because data is not real.
dt = diff(secTime);
k = find(dt>=dt0);
for i = 1:length(k)
    tmask(i,:) = [secTime(k(i)),secTime(k(i)+1)]; 
end