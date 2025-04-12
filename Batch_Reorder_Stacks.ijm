path = getDir("Location of Files");
saveloc = getDir("Save Here");
fileList = getFileList(path);

setBatchMode(true);

for (i=0; i<fileList.length; i++) {
	file = path + fileList[i];
	open(file);
	OG = File.nameWithoutExtension;
	numSlices = nSlices;
	zStack = numSlices/3;
	run("Stack to Hyperstack...", "order=xyzct channels=3 slices=zStack frames=1 display=Color");
	saveAs("tiff", saveloc + OG + "_Reordered");
	close("*");
	print(i+1+" of "+fileList.length+" completed");
	run("Collect Garbage"); //clears memory
}
print("Done!");
