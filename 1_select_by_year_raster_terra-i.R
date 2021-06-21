# ---------------------------------------------------------------------------
# Slipt the classified Terra-i's raster by period and years
# Created on: Jan 2019
# __Author__: Paula A. Paz
# ---------------------------------------------------------------------------

require(raster)
require(rgdal)

project = "HONDURAS"
change<- "increase" # decrease or increase
TERRAI_version = "2004_01_01_to_2018_11_01"
ft_period <- "2004_01_01_to_2015_12_31"
s_period <- "2016_01_01_to_2016_12_31"
t_period <- "2017_01_01_to_2017_12_31"
f_period <- "2018_01_01_to_2018_11_01"

master_path="T:/GISDATA_terra"
terra<-raster(paste0(master_path,"/outputs/",project,"/",TERRAI_version,"/","ASCII/",change,"/region/classified/",project,"_", change,"_",TERRAI_version,".asc"))
name_ft_file=paste("honduras","_",change,"_",ft_period,".asc",sep="")
name_s_file=paste("honduras","_",change,"_",s_period,".asc",sep="")
name_t_file=paste("honduras","_",change,"_",t_period,".asc",sep="")
name_f_file=paste("honduras","_",change,"_",f_period,".asc",sep="")
output_file<-paste(master_path,"/outputs/",project,"/",TERRAI_version,"/","ASCII/",change,"/region/classified/","/",sep="")



terra[!terra >= 2004 | !terra <= 2015] = NA

rf <- writeRaster(terra, filename=paste0(output_file,name_ft_file), format="ascii", overwrite=TRUE)

terra<-raster(paste0(master_path,"/outputs/",project,"/",TERRAI_version,"/","ASCII/",change,"/region/classified/",project,"_", change,"_",TERRAI_version,".asc"))

terra[!terra == 2016] = NA

rf <- writeRaster(terra, filename=paste0(output_file,name_s_file), format="ascii", overwrite=TRUE)

terra<-raster(paste0(master_path,"/outputs/",project,"/",TERRAI_version,"/","ASCII/",change,"/region/classified/",project,"_", change,"_",TERRAI_version,".asc"))

terra[!terra == 2017] = NA

rf <- writeRaster(terra, filename=paste0(output_file,name_t_file), format="ascii", overwrite=TRUE)

terra<-raster(paste0(master_path,"/outputs/",project,"/",TERRAI_version,"/","ASCII/",change,"/region/classified/",project,"_", change,"_",TERRAI_version,".asc"))

terra[!terra == 2018] = NA

rf <- writeRaster(terra, filename=paste0(output_file,name_f_file), format="ascii", overwrite=TRUE)
