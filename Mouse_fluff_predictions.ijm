#@ File (label = "Input directory", style = "directory") input_dir
#@ File (label = "Output directory", style = "directory") locROIs

processFolder(input_dir);

// function to scan folder to find files with correct suffix
function processFolder(input_dir) {
	suffix = ".h5";
	list = getFileList(input_dir);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		if(endsWith(list[i], suffix))
			processFile(input_dir, list[i]);
	}
}

function processFile(input, file) {
	inputFilePath = input + File.separator + file;
	print("Processing: " + inputFilePath);
	run("Import HDF5", "select=[" + inputFilePath + "] datasetname=/exported_data axisorder=yxc");
	rename("Mouse_"+ i);
		name = getTitle();
		run("Stack to Images");
		selectWindow("4");
		run("Duplicate...", " ");
		selectWindow("3");
		run("Duplicate...", " ");
		imageCalculator("Add create 32-bit", "4-1","3-1");
		selectWindow("Result of 4-1");
		setOption("ScaleConversions", true);
		run("16-bit");
		setAutoThreshold("Default dark");
		run("Create Mask");
		rename("Mouse_" + i + "_merged");
		run("Remove Outliers...", "radius=2 threshold=50 which=Bright");
		run("Analyze Particles...", "summarize add");
		roiManager("Save", locROIs + File.separator + name + "_merged.zip");
		roiManager("Deselect");
		roiManager("Delete");
		selectWindow("3");
		run("16-bit");
		setAutoThreshold("Default dark");
		run("Create Mask");
		run("Remove Outliers...", "radius=2 threshold=50 which=Bright");
		rename("Mouse_" + i + "_yellow");
		run("Analyze Particles...", "summarize add");
		roiManager("Save", locROIs + File.separator + name + "_yellow.zip");
		roiManager("Deselect");
		roiManager("Delete");
		selectWindow("4");
		run("16-bit");
		setAutoThreshold("Default dark");
		run("Create Mask");
		run("Remove Outliers...", "radius=2 threshold=50 which=Bright");
		rename("Mouse_" + i + "_agouti");
		run("Analyze Particles...", "summarize add");
		roiManager("Save", locROIs + File.separator + name + "_agouti.zip");
		roiManager("Deselect");
		roiManager("Delete");
		run("Close All");
    } 
selectWindow("Summary");
saveAs("Results", locROIs + File.separator + "Summary.csv");

		
