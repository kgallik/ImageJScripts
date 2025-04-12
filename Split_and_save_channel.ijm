path = getDir("Location of Files");
saveloc = getDir("Save Here");
fileList = getFileList(path);

setBatchMode(true);

for (i=0; i<fileList.length; i++) {
	file = path + fileList[i];
	if(endsWith(fileList[i], ".tiff")) {
		run("Bio-Formats Importer", "open=file autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
		name = getTitle();
		run("Split Channels");
		selectWindow("C2-" + name);
		run("Z Project...", "projection=[Average Intensity]");
		selectWindow("AVG_C2-"+name);
		C2 = getTitle();
		saveAs("Tiff", saveloc + File.separator + C2);
		selectWindow("C3-" + name);
		run("Z Project...", "projection=[Average Intensity]");
		selectWindow("AVG_C3-"+name);
		C3 = getTitle();
		saveAs("Tiff", saveloc + File.separator + C3);
		selectWindow("C4-" + name);
		run("Z Project...", "projection=[Average Intensity]");
		selectWindow("AVG_C4-"+name);
		C4 = getTitle();
		saveAs("Tiff", saveloc + File.separator + C4);
		close("*");
}}
