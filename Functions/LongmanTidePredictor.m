function Tide_pre =  LongmanTidePredictor(lon,lat,t)
% LongmanTide return tidal effect using the Longman algorithm
%Tide_pre =  LongmanTide(lon,lat,t)
%
% lon: longitude, degrees, POSITIVE East
% lat: latitude, degrees, POSITIVE North
% t: times in MATLAB datenum format
% NOTE: lat, lon can be scalars OR vectors of the same length as t
%
% Tide_pre: tidal EFFECT, in milliGals
%
% 
%**************************************************************************
RAD = pi/180;
Tide_pre = [];

% make sure everything is a column vector
lon = lon(:);
lat = lat(:);
t = t(:);
% dimensions check
if length(lon) ~= 1 || length(lat) ~= 1
    if length(lon) ~= length(lat) || ...
            length(lon) ~= length(t) || ...
            length(lat) ~= length(t)
        error('ERROR --- lengths of input vectors must be the same');
    end
end

% check for scalar lon, lat
if length(lon) == 1
    lon = lon * ones(length(t),1);
end
if length(lat) == 1
    lat = lat * ones(length(t),1);
end

DEGLON = -lon;
DEGLAT = lat;
DTL = 24*(t-floor(t));

% dref is Dec. 31, 1899 12:00:00
dref = 6.939615e+005;

DCENT=(t-dref)/36525;
DCENT2=DCENT.^2;
DCENT3 = DCENT.^3;

DS=4.720023434 + 8399.709299 * DCENT + 0.0000440696 * DCENT2;
DP=5.835124713 +71.01800936 * DCENT-0.000180545 * DCENT2- 0.00000021817 * DCENT3;
DH=4.88162792 + 628.3319509 * DCENT + 0.00000527962 * DCENT2;
DOLN=4.523588564 - 33.75715303 * DCENT + 0.000036749 * DCENT2;
DPS=4.908229461 + 0.03000526416 * DCENT + 0.000007902463 * DCENT2;
DES=0.01675104 - 0.0000418 * DCENT - 0.000000126 * DCENT2;
DSOLN=sin(DOLN);
DCI=0.91369 - 0.03569 * cos(DOLN);
DSI=sqrt(1 - DCI.^2) ;
DSN=0.08968 * DSOLN./DSI;
DCN=sqrt(1 - DSN.^2) ;
DTIT=0.39798*DSOLN ./(DSI.*(1 + cos(DOLN).*DCN+0.91739*DSOLN.*DSN));

DET=2*atan(DTIT);

DETlt0 = DET < 0;

DET(DETlt0) = DET(DETlt0)+6.2831852;


DOLM=DS - DOLN + DET + 0.10979944*sin(DS-DP) + 0.003767474*sin(2*(DS-DP)) + ...
    0.0154002*sin(DS-2*DH + DP) + 0.00769395*sin(2*(DS-DH));
DHA=(15*DTL-180-DEGLON)*RAD;
DCHI=DHA+DH-atan(DSN./DCN);
DAL=DEGLAT*RAD;
DCT=sin(DAL).*DSI.*sin(DOLM)+cos(DAL).*((1 +DCI).*cos(DOLM-DCHI)+(1 -DCI).*cos(DOLM+DCHI))/2;
DDA=2.60144+0.143250*cos(DS-DP)+0.0078644*cos(2*(DS-DP))+0.0200918 *cos(DS-2*DH+DP)+0.0146006*cos(2*(DS-DH));
DR=6.378388*ones(length(DAL),1)./sqrt(1 +0.00676902*(1 - cos(DAL).^2));
DGM=0.49049*DR.*(DDA.^3).*(3*(DCT.^2)-1)+0.00074*(DR.^2).*(DDA.^4) .*DCT.*(5*(DCT.^2)-3);
DOLS=DH+2*DES.*sin(DH-DPS);
DCHIS=DHA+DH;
DDS=0.668881*(1 + DES.*cos(DH-DPS))./(1 - (DES.^2));
DCF=0.39798*sin(DAL).*sin(DOLS)+cos(DAL).*(0.95869*cos(DOLS-DCHIS)+.0413*cos(DOLS+DCHIS));
DGS=13.2916*DR.*(3*(DCF.^2)-1).*(DDS.^3);
Tide_pre = (DGM+DGS)*0.00116;

