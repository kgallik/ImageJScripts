directory = getDir("Images");
roiLoc = getDir("ROIs");
maskLoc = getDir("Masks");

filelist = getFileList(directory);
setBatchMode(true); 
for (i = 0; i < filelist.length; i++) {
	file = directory + filelist[i];
    if (endsWith(filelist[i], ".svs")) { 
		run("Bio-Formats Importer", "open=[file] autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT series_2");
		run("Set Measurements...", "area display redirect=None decimal=3");
		name = getTitle();
		run("RGB Color");
		run("Set Scale...", "distance=1 known=1.9768 unit=um");
		run("HSB Stack");
		run("Stack to Images");
		selectWindow("Saturation");
		//run("Threshold...");
		setAutoThreshold("Triangle dark");
		run("Create Mask");
		run("Fill Holes");
		run("Dilate");
		run("Dilate");
		run("Fill Holes");
		run("Erode");
		run("Erode");
		rename("mask_" + name);
		run("Analyze Particles...", "size=5000000-Infinity display add");
		roiManager("save", roiLoc + File.separator + name + ".zip");
		roiManager("delete");
		saveAs("tiff", maskLoc + File.separator + "mask_" + name);
		close("*");
    }}

selectWindow("Results");
saveAs("Results", roiLoc + File.separator + "Area_Summary.csv");
		
//run("Bio-Formats Importer", "open=[D:/Steensma Lab/Menusha/PBC_Aperio_Images/138829.svs] autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT series_2");				