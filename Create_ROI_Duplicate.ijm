path = getDirectory("Images"); //You will be prompted to select the folder containing your images to analyze
fileList = getFileList(path); 
path2 = getDirectory("Processed"); // I recommend making you save folder first. You will be prompted to select the folder where you would like to save the thresholded masks

//tells ImageJ you are analyzing many images
// below is a loop that tells ImageJ to open a file and apply a tophat and then 3D gaussian filter
// The image is then projected in Z and saved in a folder for CircleSkinner to be applied. 
for (i=0; i<fileList.length; i++) { 
	file = path + fileList[i];
	if(endsWith(fileList[i], ".tif")) { 
        run("Bio-Formats Importer", "open=file autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYZCT");
        name = getTitle();
        makeRectangle(100, 100, 100, 100);
        waitForUser("Select ROI", "Press OKAY when done");
        run("Duplicate...");
        save(path2 + File.separator + "Cropped_" + name);
        close("*");}}