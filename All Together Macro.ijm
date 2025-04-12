// select folder where images to be analyzed are located and create an output subfolder 
ORG_path = getDirectory("Choose a Directory of Original (.tif) Files"); 
newDir1 = ORG_path + "ROIs" + File.separator;
File.makeDirectory(newDir1); 
newDir2 = ORG_path + "ProcessedMasks" + File.separator;
File.makeDirectory(newDir2); 
newDir3 = ORG_path + "UnprocessedMasks" + File.separator;
File.makeDirectory(newDir3); 
newDir4 = ORG_path + "CompositeImages" + File.separator;
File.makeDirectory(newDir4); 

filelist1 = getFileList(ORG_path);
ChannelName1 = "AF488_ORG.tif";
ChannelName2 = "AF647_ORG.tif";

if (isOpen("ROI Manager")) {
     selectWindow("ROI Manager");
     run("Close");
  }
run("Close All");

//Part 1
// below is a loop that tells ImageJ to open a file, autothreshold, create a mask from the threshold, 
counter = 0;
for (i=0; i<filelist1.length; i++) { 
	file = ORG_path + filelist1[i];
	if(endsWith(filelist1[i], ChannelName1)) { 
		open(file);
		run("Enhance Contrast", "Auto");
		makeRectangle(20,20,4440, 4320);
		waitForUser("Rectangle Selection", "Move the rectangle to the area of interest");
		tempTitle = getTitle();
		roiManager("Add");
		roiManager("Select", (counter));
		roiManager("Rename", tempTitle);
		run("Duplicate...", "title=[]");
		saveAs("tif", newDir1 + "ROI_" + tempTitle); 
		close();
		selectWindow(tempTitle);
		close();
		counter = counter + 1;
	}
}
counter = 0;
for (i=0; i<filelist1.length; i++) { 
	file = ORG_path + filelist1[i];
	if(endsWith(filelist1[i], ChannelName2)) {
		open(file);
		tempTitle2 = getTitle();
		run("Enhance Contrast", "Auto");
		roiManager("Select", counter);
		run("Duplicate...", "title=[]");
		saveAs("tif", newDir1 + "ROI_" + tempTitle2); 
		close();
		selectWindow(tempTitle2);
		close();
		counter = counter + 1;
	}
}

selectWindow("ROI Manager");
roiManager("Deselect");
roiManager("Delete");
run("Close");
run("Close All");


//Part 2
filelist2 = getFileList(newDir1);
setBatchMode(true); //tells ImageJ you are analyzing many images and doesn't open them on screen
// below is a loop that tells ImageJ to open a file, autothreshold, create a mask from the threshold, 
for (i=0; i<filelist2.length; i++) { 
	counter = 1;
	file = newDir1 + filelist2[i];
	newtitle1 = "Mask_" + filelist2[i];
	newtitle2 = d2s(counter, 0) + "_MaskandProcessed_" + filelist2[i]; 
    if(endsWith(filelist2[i], ChannelName1)) { 
        open(file);
        setAutoThreshold("Triangle dark");
		run("Create Mask");
		saveAs("tif", newDir3 + newtitle1);
		run("Fill Holes");
		setOption("BlackBackground", true);
		run("Dilate");
		run("Fill Holes");
		run("Erode");
		saveAs("tif", newDir2 + newtitle2);
	}
	if(endsWith(filelist2[i], ChannelName2)) { 
        open(file);
        setAutoThreshold("Triangle dark");
		run("Create Mask");
		saveAs("tif", newDir3 + newtitle1);
		run("Fill Holes");
		setOption("BlackBackground", true);
		run("Dilate");
		run("Fill Holes");
		run("Erode");
		saveAs("tif", newDir2 + newtitle2);
	}
	counter = counter + 1;
} 

//Part 3
setBatchMode(false);
filelist3 = getFileList(newDir2);
numPairs = lengthOf(filelist3)/2;
for (i=0; i<(numPairs*2); i+=2) {
	file1 = newDir2 + filelist3[0+i];  //index 0 is the first file in the list, 1 is the second
	open(file1);
	titleLong = getTitle();
	fileNameShort = substring(titleLong,2,(lengthOf(titleLong)-(lengthOf(ChannelName1)+1)));
	rename("grChannel");
	file2 = newDir2 + filelist3[1+i];  //index 0 is the first file in the list, 1 is the second
	open(file2);
	rename("magenChannel");
	run("Merge Channels...", "c2=grChannel c6=magenChannel create");
	rename("Composite_" + fileNameShort);
	saveAs("tif", newDir4 + "Composite_" + fileNameShort);
	close();
}
run("Close All");

showStatus("Finished.");
Dialog.create("Success");
Dialog.addMessage("All Done!");
Dialog.show();
