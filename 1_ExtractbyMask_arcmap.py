# ---------------------------------------------------------------------------
# Extract by mask Peru data
# Created on: May 2014
# __Author__: Paula Paz
# ---------------------------------------------------------------------------

#v. 10
import os, glob, arcpy, sys, string
from arcpy import env
from arcpy.sa import *

#check out any necessary licenses
arcpy.CheckOutExtension("spatial")

arcpy.env.overwriteOutput = 1

#input
dirbase = raw_input(r"Enter the root path of the update: ")
mask= "T:\GISDATA_terra\input\Mask\Mask_regions\peru_mask.asc"
mask_filename=mask[:-4].split('\\')[-1]
output = raw_input("Ingresar output tif path: ")
#output_asc = raw_input("Ingresar output asc path: ")


folder_list = os.listdir(dirbase)
for fl in folder_list:
    #comprobador de carpeta modelo salida
    #if not os.path.exists(output + "\\" + fl): os.mkdir(output + "\\" + fl)
    input = glob.glob(dirbase + "\\" + fl + "\\*.tif")

    #Process
    for ascii in input:
        input=ascii
        #tiff= output + "\\" + "peru" + "\\" + fl + "\\" + os.path.basename(ascii)[:-4] + ".tif"
        tiff= output + "\\" + "peru" + "\\" + fl + "\\" + mask_filename[:-5]+ "_"+ os.path.basename(ascii)[-37:-4] + ".tif"
        # Execute ExtractbyMask
        arcpy.env.snapRaster = input
        arcpy.env.cellSize = input
        arcpy.env.extent = mask
        crop_raster = ExtractByMask(input, mask)
        crop_raster.save(tiff)
        arcpy.management.DefineProjection(tiff, 4326)
print "The file " +  " was cropped using the mask of " + mask_filename
print "se procesaron los archivos"                

  
