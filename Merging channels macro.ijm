path = getDirectory("Where do you want to save your composite images?");

run("Merge Channels...", "green= <processed 488 mask> magenta= <processed 647 mask> create");
//need to add in some condition to select the correct images to merge. 
//Could be added to the end of the mask processing macro?