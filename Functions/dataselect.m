% function metadat = dataselect(ship,cruise,filename,bias)

% path0 = fullfile('~/Projects/PFPE/Data', ship ,cruise);
% dgs_path = fullfile(path0, 'gravimeter/DGS');
% dgs_fn = strcat(fn, '.dat');
% nav_path = fullfile(path0, 'NAV');
% nav_fn = fn;
% 
% switch ship
%     case 'Atlantis'
%         
% 
% %%-----------------------------------------------------
% % ship = 'Ride'; %% other options: "Ride" "Revelle" "NBP" "Thompson"
% % cruise = 'SR2302';
% % fn = '*20230205*';
% 
% % ship = 'Revelle'; %% other options: "Ride" "Revelle" "NBP" "Thompson"
% % cruise = 'RR2212';
% % fn = '*20221102*';
% % % fn = '*20220101*'
% 
% % ship = 'NBP'; %% other options: "Ride" "Revelle" "NBP" "Thompson"
% % cruise = '2301';
% % fn = '*20230110*';
% 
% % ship = 'Atlantis'; %% other options: "Ride" "Revelle" "NBP" "Thompson"
% % cruise = 'AT50_08B';
% % fn = '*20230304*';
% 
% ship = 'Thompson'; %% other options: "Ride" "Revelle" "NBP" "Thompson"
% cruise = 'TN400';
% fn = '*2022*';
% 
% %%-----------------------------------------------------
% path0 = fullfile('~/Projects/PFPE/Data', ship ,cruise);
% dgs_path = fullfile(path0, 'gravimeter/DGS');
% dgs_fn = strcat(fn, '.dat');
% bgm_rgs_path = fullfile(path0, 'gravimeter/BGM3/logs');
% bgm_rgs_fn = strcat(fn, '.RGS')
% bgm_raw_path = fullfile(path0, 'gravimeter/BGM3/serial');
% bgm_raw_fn = fn;
% nav_path = fullfile(path0, 'NAV');
% nav_fn = fn;
% if contains(ship,'Atlantis')
%     bias_dgs = 969758.4968;
%     bias_bgm = 855580.65; %AT50-05 
% elseif contains(ship,'Thompson')
%     dgs_fn = strcat('*PROC', fn);
%     bias_dgs = 969527.3497; %% 2022/03/06 20:32:01
%     bias_bgm = 855489.8; %% 2022/03/06
% elseif contains(ship,'Revelle')
%     datestr = strrep(fn,'*','');
%     t=datetime(datestr,'InputFormat','yyyyMMdd');
%     bgm_raw_fn = strcat('*',string(t,'yyyy-MM-dd'),'*');
%     nav_fn = bgm_raw_fn;
%     bias_dgs = 968888.6465;
%     bias_bgm = 855240.81987; 
% elseif contains(ship,'NBP') %% no BGM3
%     bgm_raw_fn = '';
%     datestr = strrep(fn,'*','');
%     t=datetime(datestr,'InputFormat','yyyyMMdd');
%     days = day(t,'dayofyear');
%     nav_fn = ['*.d' num2str(days,'%03.f')];
%     bias_dgs = 968634.2514;
% elseif contains(ship,'Ride') %% no BGM3
%     bgm_raw_fn = '';
%     bias_dgs = 968895.7718; %2023-02-15
% end