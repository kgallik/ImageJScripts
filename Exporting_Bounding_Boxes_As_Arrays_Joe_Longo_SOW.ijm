masks = getDir("Location of Masks");
C3 = getDir("Location of C3");
saveLocArrays = getDir("Save Arrays Here");
saveLocBoundingBox = getDir("Save Bounding Box Here");
fileListMasks = getFileList(masks);
fileListC3 = getFileList(C3);

setBatchMode(true);

for (i=0; i<fileListMasks.length; i++) {
	mask = masks + fileListMasks[i];
	channel = C3 + fileListC3[i];
	open(mask);
	run("Label image to ROIs", "rm=[RoiManager[size=6, visible=true]]");
	open(channel);
	name = getTitle();
	nameClean = File.nameWithoutExtension;
	for (x=0; x<roiManager("size"); x++){ 
		selectWindow(name);
		roiManager("Select", x);
		run("Duplicate...", "title=" + nameClean + "Cell "+x);
		saveAs("tiff", saveLocArrays + File.separator + nameClean + "Cell_" + x);
		run("Image to Results");
		saveAs("Results", saveLocArrays + File.separator + nameClean + "Object_" + x +".csv");
	}
	roiManager("deselect");
	roiManager("delete");
	close("*");
	print(i+1+" of "+fileListMasks.length+" completed");
	}

