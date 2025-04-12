path = getDir("Location of Files");
saveloc = getDir("Save Here");
fileList = getFileList(path);

setBatchMode(true);

for (i=0; i<fileList.length; i++) {
	file = path + fileList[i];
	run("Bio-Formats Importer", "open=file autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	OG = File.nameWithoutExtension;
	name = getTitle();
	run("Z Project...", "projection=[Max Intensity]");
	selectWindow("MAX_" + name);
	saveAs("tiff", saveloc + "Max_" + OG);
	close("*");
	print(i+1+" of "+fileList.length+" completed");
	run("Collect Garbage"); //clears memory
}
print("Done!");
