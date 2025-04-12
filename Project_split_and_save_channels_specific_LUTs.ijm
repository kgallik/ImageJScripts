path = getDir("Location of Files");
saveloc = getDir("Save Here");
fileList = getFileList(path);

setBatchMode(true);

for (i=0; i<fileList.length; i++) {
	file = path + fileList[i];
	if(endsWith(fileList[i], ".czi")) {
		run("Bio-Formats Importer", "open=file autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
		name = getTitle();
		Property.set("CompositeProjection", "null");
		Stack.setDisplayMode("color");
		Stack.setChannel(1);
		run("Magenta");
		Stack.setChannel(2);
		run("Yellow");
		Stack.setChannel(3);
		run("Cyan");
		run("Z Project...", "projection=[Max Intensity]");Stack.setChannel(1);
		Stack.setChannel(1);
		setMinAndMax(580, 2510);
		Stack.setChannel(2);
		setMinAndMax(65, 1564);
		Stack.setChannel(3);
		setMinAndMax(1, 2691);
		Property.set("CompositeProjection", "Sum");
		Stack.setDisplayMode("composite");
		run("Scale Bar...", "width=20 height=21 thickness=4 font=20 color=White background=None location=[Lower Right] horizontal bold overlay");
		saveAs("Tiff", saveloc + "Merged_" + name);
		saveAs("jpeg", saveloc + "Merged_" + name);
		name2 = getTitle();
		run("Split Channels");
		selectWindow("C1-" + name2);
		setMinAndMax(580, 2510);
		saveAs("Tiff", saveloc + "Color_circ3915_HiBiT_" + name);
		saveAs("jpeg", saveloc + "Color_circ3915_HiBiT_" + name);
		run("Grays");
		saveAs("Tiff", saveloc + "Grey_circ3915_HiBiT_" + name);
		saveAs("jpeg", saveloc + "Grey_circ3915_HiBiT_" + name);
		selectWindow("C2-" + name2);
		setMinAndMax(65, 1564);
		saveAs("Tiff", saveloc + "Color_SATB2_GFP_" + name);
		saveAs("jpeg", saveloc + "Color_SATB2_GFP_" + name);
		run("Grays");
		saveAs("Tiff", saveloc + "Grey_SATB2_GFP_" + name);
		saveAs("jpeg", saveloc + "Grey_SATB2_GFP_" + name);
		selectWindow("C3-" + name2);
		setMinAndMax(1, 2691);
		saveAs("Tiff", saveloc + "Color_DAPI-" + name);
		saveAs("jpeg", saveloc + "Color_DAPI-" + name);
		run("Grays");
		saveAs("Tiff", saveloc + "Grey_DAPI-" + name);
		saveAs("jpeg", saveloc + "Grey_DAPI-" + name);
		close("*");	
}}
