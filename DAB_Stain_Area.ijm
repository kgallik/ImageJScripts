directory = getDir("Where are the files?");
roiLoc = getDir("ROIs");
maskLoc = getDir("Masks");

filelist = getFileList(directory);
 
for (i = 0; i < filelist.length; i++) {
	file = directory + filelist[i];
    if (endsWith(filelist[i], ".svs")) { 
		run("Bio-Formats Importer", "open=file autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT series_1");
		title = getTitle();
		run("Split Channels");
		selectWindow("C2-" + title);
		run("Grays");
		makeRectangle(0,0,10000, 10000);
		waitForUser("Rectangle Selection", "Move the rectangle to the area of interest");
		run("Duplicate...", " ");
		duplicate = getTitle();
		setAutoThreshold("Triangle");
		run("Create Mask");
		run("Fill Holes");
		run("Dilate");
		run("Dilate");
		run("Fill Holes");
		run("Erode");
		run("Erode");
		saveAs("tiff", maskLoc + File.separator + title + "_Area");
		run("Analyze Particles...", "size=100000-Infinity exclude include summarize add");
		roiManager("Save", roiLoc + File.separator + title + "_Area.zip");
		roiManager("Deselect");
		roiManager("Delete");
		selectWindow(duplicate);
		setAutoThreshold("Minimum");
		run("Create Mask");
		saveAs("tiff", maskLoc + File.separator + title + "_DAB");
		run("Analyze Particles...", "size=0-Infinity exclude summarize add");
		roiManager("Save", roiLoc + File.separator + title + "_DAB.zip");
		roiManager("Deselect");
		roiManager("Delete");
		run("Close All");
    }}
 
selectWindow("Summary");
saveAs("Results", roiLoc + File.separator + "Area_Summary.csv");
print("DONE!");
