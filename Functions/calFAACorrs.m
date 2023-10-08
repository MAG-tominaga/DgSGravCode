function corrs = calFAACorrs(lat,lon,t)
%% corrections used to calculate FAA
% t: secs
    d2s = 24*3600;
    ndata = length(t);
    elipsoidheight=zeros(ndata,1);
    latCorr=-WGS84(lat)-FAC2ord(deg2rad(lat),elipsoidheight);
    Eotvos_Full=calc_eotvos_full(lat,lon,elipsoidheight,1);
    eCorr=Eotvos_Full'; % Eotvos full includes eotvos and vertical acceleration
    tideCorr=LongmanTidePredictor(lon,lat,t/d2s);
    corrs = latCorr + tideCorr + eCorr;
    