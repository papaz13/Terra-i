# ---------------------------------------------------------------------------
# Generate Processed shapefile to add date field
# Created on: Dec 2018
# __Author__: Paula A. Paz
# ---------------------------------------------------------------------------

require(maptools)
require(shapefiles)
require(rgdal)
require(foreign)
library(tools)
require(raster)
require(dplyr)

#project
project = "HONDURAS"
TERRAI_version = "2004_01_01_to_2018_11_01"
change<- "decrease" # decrease or increase
master_path="T:/GISDATA_terra"
#dsn<- paste(master_path,"/",project,"/","geodata/input/proccessed/shp/honduras/terrai/",TERRAI_version,"/decrease/",sep="")
decrease_file<-paste0(master_path,"/outputs/",project,"/",TERRAI_version,"/","TIFF/GEOGRAPHIC/WGS84/",change,"/region/unclassified/",project,"_",change,"_",TERRAI_version,".tif")
filename_shape_wgs84=paste("honduras","_",change,"_",TERRAI_version,"_wgs84.shp",sep="")
filename_shape_utm_16N=paste(project,"_",change,"_",TERRAI_version,"_utm_16N.shp",sep="")    
output_path=paste0(master_path,"/projects/",project,"/","geodata/output/shp/honduras/LUCC/terrai","/",TERRAI_version,sep="")
dir.create(file.path(output_path), showWarnings = FALSE)


P4S.latlon <- CRS("+init=epsg:32616")
file=raster(decrease_file)
file[which(file[] < 1)] <- NA
y=rasterToPolygons(file, fun=NULL, n=4, na.rm=TRUE, digits=12, dissolve=FALSE)


#Load Tables with dates and area values
tables_path<-"T:/Documents_Terra/Tables"
dates=data.frame(read.csv(file=paste(tables_path,"/","Terra_Day.csv",sep=""),header = TRUE, dec = ".", sep = ",",comment.char = ""))

#Join Dates Data and ID_ICF
id_dates = match(y$HONDURAS_decrease_2004_01_01_to_2018_11_01, dates$TERRA) # Cambiar tipo de datos y fecha!!!!
xtra_dates = dates[id_dates,]
JD=xtra_dates$JULIAN_DATES
YEAR=xtra_dates$YEAR
DATE= xtra_dates$DATE

y=spCbind(y,JD)
y=spCbind(y,YEAR)
y=spCbind(y,DATE)
y <- y[order(as.integer(y$YEAR),(y$JD),decreasing = FALSE), ]
y$ID <- seq.int(nrow(y))
y$ID_ICF<- paste(y$YEAR,y$JD,y$ID, sep ="_") # add field id ICF


name_file = paste0(project,"_",change,"_terra_",TERRAI_version,"_wgs84",sep="")
writeOGR(obj =  y, dsn = output_path, layer = name_file , driver = 'ESRI Shapefile', overwrite_layer=TRUE)

