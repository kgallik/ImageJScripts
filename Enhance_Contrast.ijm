

//processFolder(input);
//	
//// function to scan folders/subfolders/files to find files with correct suffix
//function processFolder(input) {
//	list = getFileList(input);
//	for (i = 0; i < list.length; i++) {
//		if(File.isDirectory(input + File.separator + list[i]))
//			processFolder("" + input + File.separator + list[i]);
//		if(endsWith(list[i], suffix))
//			processFile(input, output, list[i]);
//}}
//
//function processFile(input, output, file) {
//	setBatchMode(true);
//	open(file);
//	name = getTitle();
//	run("Enhance Contrast...", "saturated=0.35");
//	saveAs("tif", output + "Enhance_Contrast_" + name);






path = getDir("Location of Files");
saveloc = getDir("Save Here");


setBatchMode(true);
list = getFileList(path);
for (i = 0; i < list.length; i++) {
	if(File.isDirectory(path + File.separator + list[i]))
		processFolder("" + path + File.separator + list[i]);	
		file = path + list[i];
	if(endsWith(list[i], ".tif")) {
		open(file);
		name = getTitle();
		run("Enhance Contrast...", "saturated=0.35");
		saveAs("tif", saveloc + "Enhance_Contrast_" + name);
	
}}
//
//
//
//for (i = 0; i < list.length; i++) {
//		if(File.isDirectory(input + File.separator + list[i]))
//			processFolder("" + input + File.separator + list[i]);
////			newfolders = File.makeDirectory(newfolder + "Enhance_Contrast_Experiment_" + (i+1)); 
////		if(endsWith(list[i], suffix))