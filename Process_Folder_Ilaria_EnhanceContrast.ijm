#@ File (label = "Input directory", style = "directory") input
#@ String(label = "File suffix", value = ".tif") suffix

// See also Process_Folder.py for a version of this code
// in the Python scripting language.
//newfolder = output + File.separator;
//newfolders = newfolder
//
processFolder(input);


// function to scan folders/subfolders/files to find files with correct suffix
function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + File.separator + list[i]))
			processFolder("" + input + File.separator + list[i]);
			newfolders = File.makeDirectory(input + File.separator + "Enhance_Contrast_Experiment_" + (i+1)); 
		if(endsWith(list[i], suffix))
			processFile(input, newfolders, file);
	}
}
//make several for loops for each new save location
//for (i=0; i<fileList.length; i++) { 
//	file = path + fileList[i];
processFile(input, newfolders, file) {
// Do the processing here by adding your own code.
	// Leave the print statements until things work, then remove them.
	setBatchMode(true);
	run("Bio-Formats", "open=[" + input + "/" + file +"] autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	run("Enhance Contrast...", "saturated=0.35");
	newname = "Enhance_Contrast_" + file;
	saveAs("tif", newfolders + File.separator + newname);
	close();
}

////Folder set 1
//path1 = getDir("Location of Files");
//saveloc1 = getDir("Save Here");
//fileList1 = getFileList(path1);
////Folder set 2
//path2 = getDir("Location of Files");
//saveloc2 = getDir("Save Here");
//fileList2 = getFileList(path2);
////Folder set 3
//path3 = getDir("Location of Files");
//saveloc3 = getDir("Save Here");
//fileList1 = getFileList(path3);
//
//setBatchMode(true);
//
//for (i=0; i<fileList1.length; i++) {
//	file = path1 + fileList1[i];
//	if(endsWith(fileList1[i], ".tif")) {
//		open(file);
//		name = getTitle();
//		run("Enhance Contrast...", "saturated=0.35");
//		saveAs("Tiff", saveloc1 + "Enhance_Contrast_" + name);
//	if i > fileList1.length {
//		break;
//}}}
//
//for (i=0; i<fileList2.length; i++) {
//	file = path2 + fileList2[i];
//	if(endsWith(fileList2[i], ".tif")) {
//		open(file);
//		name = getTitle();
//		run("Enhance Contrast");
//		saveAs("Tiff", saveloc2 + "Enhance_Contrast_" + name);
//	if i > fileList2.length {
//		break;
//}}}
//
//for (i=0; i<fileList3.length; i++) {
//	file = path3 + fileList3[i];
//	if(endsWith(fileList3[i], ".tif")) {
//		open(file);
//		name = getTitle();
//		run("Enhance Contrast");
//		saveAs("Tiff", saveloc3 + "Enhance_Contrast_" + name);
//	if i > fileList3.length {
//		break;
//}}}