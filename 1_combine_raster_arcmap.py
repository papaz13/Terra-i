## extract by mask and convert
# Created on: Sept 2016
# __Author__: Paula Paz
#purpose: Combine rasters.
#-----------------------------------------------------------------------------

#Import modules
import os
import glob
import arcpy
from arcpy import env
from arcpy.sa import *

#Set the necessary product code
arcpy.SetProduct("ArcInfo")

#Check out any necessary licenses
arcpy.CheckOutExtension("spatial")

# Variables
#root = raw_input(r"Enter the root path of the update: ")#original
#decrease_path = root + "\\TIFF\\GEOGRAPHIC\\WGS84\\decrease\\region" #original
decrease_path = raw_input (r"Enter the path to the file to extract: ")

#Workspaces
tiff_path = raw_input(r"Enter the Masks (TIFF) path workspace: ")
#output_tbs = root +  "\\Tables\\raw\\region\\combine" #original
output_tbs = raw_input (r"Enter the path to the file to extract: ")
#ASCII_cellsize = input_file

#Combine raster
print "  "

print "starting combine raster"

print "  "

if not os.path.exists(output_tbs):
    os.makedirs(output_tbs)

for dirpath, dnames, fnames in os.walk(decrease_path):
    for f in fnames:
        if f.endswith(".tif"):
            raster = os.path.join(dirpath, f)
            print raster
            
            #tifs= arcpy.ListRasters()
            ##for tif in tifs:
            for tiff_file in glob.glob(os.path.join(tiff_path , '*.tif') ):
                TIFF_file_name = tiff_file[:-4].split('\\')[-1]
                print ""
                print TIFF_file_name
                print ""
                output = Combine([tiff_file,raster])
                #output.save(output_tbs + "\\" +dirpath.split('\\')[10][0] + "_" + TIFF_file_name + ".tif") #original
                output.save(output_tbs + "\\" + TIFF_file_name + ".tif")
                print "The file " + TIFF_file_name + " was created..."
            
                print " "
            
            print "combine completed"                


#for ASCII_file in glob.glob( os.path.join(ASCII_path, '*.tif') ):
    #ASCII_file_name = ASCII_file[:-4].split('\\')[-1]
    #arcpy.Overwriteoutput = True
    #arcpy.env.snapRaster = input_file
    #arcpy.env.cellSize = input_file
    #output = Combine([input_file, ASCII_file])
    #output.save(output_tbs + "\\" + ASCII_file_name + ".tif")
    #print "The file " + ASCII_file_name + " was created..."

#print " "

#print "extract by mask completed"
