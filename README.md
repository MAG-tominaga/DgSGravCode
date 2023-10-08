# DgS_Processing_Pkg
This matlab code is particularly designed to process the gravity data collected from DgS gravimeters installed on UNOLS' research vessels,
inlcuding R/V Atlantis, Thompson, Revelle, NBP, and Ride. In future there will be more ships included.

Data are REQUIRED to store in the following tree
   Ship's name/Cruise#/gravimeter/DGS         (Processed DgS data (*PROC* in R/V Thompson and .dat for the other ships))
   Ship's name/Cruise#/gravimeter/DGS/serial  (DGS serial data)
   Ship's name/Cruise#/NAV                    (Navigation, prefer POSMV INGGA) 
   e.g., 
   Path2Here/TGT/TN400/gravimeter/DGS

Each ship has her own main script because of different data format. TWO parameters will need to be updated for each cruise: (1) path to the data files, and (2) meter bias (gravity tie).

