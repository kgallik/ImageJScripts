#@ DatasetIOService io
#@ CommandService command

""" This example runs stardist on all tif files in a folder

Full list of Parameters: 

res = command.run(StarDist2D, False,
			 "input", imp, "modelChoice", "Versatile (fluorescent nuclei)",
			 "modelFile","/path/to/TF_SavedModel.zip",
			 "normalizeInput",True, "percentileBottom",1, "percentileTop",99.8,
			 "probThresh",0.5, "nmsThresh", 0.3, "outputType","Label Image",
			 "nTiles",1, "excludeBoundary",2, "verbose",1, "showCsbdeepProgress",1, "showProbAndDist",0).get();			

nmsThresh is for overlap
Make sure the titles of folders and files do not start with numbers!
"""

from de.csbdresden.stardist import StarDist2D 
from glob import glob
import os
from ij import IJ
from ij.plugin.frame import RoiManager
from ij.gui import Roi
rm = RoiManager.getRoiManager()

# run stardist on all tiff files in <indir> and save the label image to <outdir>
indir   = os.path.expanduser("D:\VAI-Core_Projects\Pathology_Project\Tiles_156234_Copy")
outdir  = os.path.expanduser("D:\VAI-Core_Projects\Pathology_Project\Labels_156234")

for f in sorted(glob(os.path.join(indir,"*.tif"))):
	print "processing ", f
  
	imp = io.open(f)
  
	res = command.run(StarDist2D, False,
			"input", imp,
			"modelChoice", "Versatile (H&E nuclei)",
			"normalizeInput",True, "percentileBottom",1, "percentileTop",99.8,
			"probThresh",0.4, "nmsThresh", 0.3, "outputType","Both",
			"nTiles",1, "excludeBoundary",2,
			).get()
	label = res.getOutput("label")
  
	io.save(label, os.path.join(outdir,"label_"+os.path.basename(f)))
	rm.save(os.path.join(outdir,"ROIs_"+os.path.basename(f)+ ".zip"))
	rm.runCommand("Deselect")
	rm.runCommand("Delete")
