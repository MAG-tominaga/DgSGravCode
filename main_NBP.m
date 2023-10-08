%% dgs data QA on R/V NBP
% input data file format preference:
% DGS: .dat file
% Data folders structure:
% DGS Proc:     Ship/Cruise/gravimeter/DGS
% DGS serial:   Ship/Cruise/gravimeter/DGS/serial
% NAV:          Ship/Cruise/NAV 

clear;
d2s = 24*3600; %% day to sec
ship = "NBP"; 

%% STEP0 Parameters in this block need to be updated 
bias = 968634.2514;
path0 = '~/Projects/PFPE/Data/NBP/2301/';

dgs_path = fullfile(path0, 'gravimeter/DGS');
dgs_fn = 'AT1M-27*.dat';
nav_path = fullfile(path0, 'NAV');
nav_fn = 'NBP*';
keyword = 'GPGGA';
    
% -------------------------------------------


%% STEP1 Load Navigation Data
fp = fullfile(nav_path,nav_fn);
d=dir(fp);
if isempty(d) % has to use gps from .dat file which can't distinguish negative lon or lat.  
    lonsign = []; 
    latsign = [];
else
    for i = 1:numel(d)
        fn = d(i).name;
        fpath = d(i).folder;
        g = loadNAV(ship,fn,fpath,keyword);
        fields = fieldnames(g);
        S(i) = g;
        clear g;
    end
    for k = 1:numel(fields)
        aField  = fields{k};
        f = [];
        for i = 1:numel(d)
            f = [f;S(i).(aField)];
        end
        gps.(aField) = f;
        clear f;
    end
end
clear d S

%% STEP2 Load DGS 
fp = fullfile(dgs_path,dgs_fn);
d=dir(fp);
if ~isempty(d)
    for i = 1:numel(d)
        fn = d(i).name;
        fpath = d(i).folder;
        g = loadDatDGS(ship,fn,fpath);
        g.grav = g.rgrav + bias;
        fields = fieldnames(g);
        S(i) = g;
        clear g;
    end
    
    for k = 1:numel(fields)
        aField  = fields{k};
        f = [];
        for i = 1:numel(d)
            f = [f;S(i).(aField)];
        end
        dgs.(aField) = f;
        clear f;
    end
    clear d S
else
    disp('No DgS meter.')
end


%% STEP3 Calculate FAA
% replace dgs's long & lat with that from gps.
if exist('gps','var') 
    [~,ig] = unique(gps.secTime);
    dgs.lon_new = interp1(gps.secTime(ig),gps.lon(ig),dgs.secTime,'linear','extrap');
    dgs.lat_new = interp1(gps.secTime(ig),gps.lat(ig),dgs.secTime,'linear','extrap');
else
    dgs.lon_new = dgs.lon; %% cautions
    dgs.lat_new = dgs.lat;
end
gcorrs = calFAACorrs(dgs.lat_new,dgs.lon_new,dgs.secTime);
dgs.faa = dgs.grav + gcorrs;

% filter
fl = 240;
[~,gf] = gaussfilt(dgs.secTime,dgs.faa,fl);
gf = gf(fl+100:end)';
ts = dgs.ts(fl+100:end);

%% STEP4 Plot FAA
figure(1)
clf

plot(ts,gf,'b','linewidth',1)
hold on
legend('DGS')
ylabel('Grav (mGal)','FontSize',14)
xlabel('Date','FontSize',14)
title(['FAA ' num2str(dgs.yr(1)) '-' num2str(dgs.mon(1)) '-' num2str(dgs.day(1))])
% % figname = ['FAA-' num2str(dgs.yr(1)) '-' num2str(dgs.mon(1)) '-' num2str(dgs.day(1))];
% % % eval(['print -d' pstr ' ' figname '.' fext]);
% % set(gcf,'PaperOrientation','landscape');
% % print(figname,'-dpdf','-bestfit')
