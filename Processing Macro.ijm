path = getDirectory("Where are your images?"); //You will be prompted to select the folder containing your images to analyze
fileList = getFileList(path); 
path2 = getDirectory("Choose a place to save your masks"); // I recommend making you save folder first. You will be prompted to select the folder where you would like to save the thresholded masks

setBatchMode(true); //tells ImageJ you are analyzing many images
// below is a loop that tells ImageJ to open a file, autothreshold, create a mask from the threshold, 
for (i=0; i<fileList.length; i++) { 
	file = path + fileList[i];
	newtitle1 = "Mask" + fileList[i];
	newtitle2 = "MaskandProcessed_" + fileList[i]; 
        if(endsWith(fileList[i], ".tif")) { 
        	open(file);
                setAutoThreshold("Triangle dark");
		run("Create Mask");
		saveAs("tif", path2 + newtitle1);
		run("Fill Holes");
		setOption("BlackBackground", true);
		run("Dilate");
		run("Fill Holes");
		run("Erode");
		saveAs("tif", path2 + newtitle2);
		close(); 

        }
       
} 

