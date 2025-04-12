path = getDirectory("Where do you want to save your ROIs?");

//run("Brightness/Contrast...");
run("Enhance Contrast", "Auto");
makeRectangle(0,0,4440, 4320);
waitForUser("Rectangle Selection", "Move the rectangle to the area of interest");
title1 = getTitle();
roiManager("Add");
run("Duplicate...", " ");
saveAs("tif", path + title1);
waitForUser("Rectangle Selection", "Select the other channel and bring up the ROI");
title2 = getTitle();
run("Duplicate...", " "); //how to add in title based on selected image?
saveAs("tif", path + title2);
//saveAs("Tiff", "D:/Henderson Lab/Colocalization/2022_07_21__th_chat_81A_3/ROIs/2022_07_21__th_chat_81A_3_AF488_ORG-1.tif");
//selectWindow("2022_07_21__th_chat_81A_3_AF488_ORG.tif");