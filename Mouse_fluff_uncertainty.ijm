path = getDir("Location of Files");
saveloc = getDir("Save Here");
fileList = getFileList(path);

for (i=0; i<fileList.length; i++) {
	file = path + fileList[i];
	if(endsWith(fileList[i], ".tiff")) {
		run("Bio-Formats Importer", "open=file autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
		run("16-bit");
		setAutoThreshold("Default dark");
		run("Create Mask");
		rename("Mouse_" + i + "_uncertainty");
		name = getTitle();
		run("Remove Outliers...", "radius=2 threshold=50 which=Bright");
		run("Analyze Particles...", "summarize add");
		roiManager("Save", saveloc + File.separator + name + ".zip");
		roiManager("Deselect");
		roiManager("Delete");
		run("Close All");
	}
}
		
selectWindow("Summary");
saveAs("Results", saveloc + File.separator + "Summary_Uncertainty.csv");