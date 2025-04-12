path = getDirectory("Images"); //You will be prompted to select the folder containing your images to analyze
fileList = getFileList(path); 
path2 = getDirectory("Processed"); // I recommend making you save folder first. You will be prompted to select the folder where you would like to save the thresholded masks

setBatchMode(true); //tells ImageJ you are analyzing many images
// below is a loop that tells ImageJ to open a file and apply a tophat and then 3D gaussian filter
// The image is then projected in Z and saved in a folder for CircleSkinner to be applied. 
for (i=0; i<fileList.length; i++) { 
	file = path + fileList[i];
	if(endsWith(fileList[i], "ics")) { //ics is the file type that what output from Huygens Deconvolution
        run("Bio-Formats Importer", "open=file autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYZCT");
        name = getTitle();
		run("Top Hat...", "radius=25 stack");
		run("Gaussian Blur 3D...", "x=2 y=2 z=2");
		//the below three lines take the middle section and the section after the middle section and project them togehter
		firstSlice = round(nSlices*0.5);
		lastSlice = round(nSlices*0.5) + 1;
		run("Z Project...", "start="+firstSlice+" stop="+lastSlice+" projection=[Max Intensity]");
		saveAs("tiff", path2 + "MiddleProjected_Filtered_" + name);
		close("*");}
}

print("Done!")