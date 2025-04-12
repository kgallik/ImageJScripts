path = getDir("Location of Files");
c1SaveLoc = getDir("C1");
c2SaveLoc = getDir("C2");
c3SaveLoc = getDir("C3");
fileList = getFileList(path);

setBatchMode(true);

for (i=0; i<fileList.length; i++) {
	file = path + fileList[i];
	if(endsWith(fileList[i], ".czi")) {
		run("Bio-Formats Importer", "open=file autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
		name = getTitle();
		cleanName = File.nameWithoutExtension;
		run("Split Channels");
		selectWindow("C1-" + name);
		saveAs("Tiff", c1SaveLoc + "C1-" + cleanName);
		selectWindow("C2-" + name);
		saveAs("Tiff", c2SaveLoc + "C2-" + cleanName);
		selectWindow("C3-" + name);
		saveAs("Tiff", c3SaveLoc + "C3-" + cleanName);
		close("*");	
}}
