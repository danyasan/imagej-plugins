// @File(label = "Output directory", style = "directory") output
// @String(label = "Title contains") pattern

/* 
 *  Convert leica z-stack to max z-projection. 
 *  Open all desired images from .lif database file, then run
 *  All open images will be processed and saved in output folder.
 *  Set Pattern to something common to all filenames, e.g. HJn
 */


/*
 * Macro template to process multiple open images
 */
processOpenImages();

/*
 * Processes all open images. If an image matches the provided title
 * pattern, processImage() is executed.
 */
function processOpenImages() {
	n = nImages;
	setBatchMode(true);
	for (i=1; i<=n; i++) {
		selectImage(i);
		imageTitle = getTitle();
		imageId = getImageID();
		if (matches(imageTitle, "(.*)"+pattern+"(.*)"))
			processImage(imageTitle, imageId, output);
			//close();
	}
	setBatchMode(false);
	run("Close All");
}

/*
 * Processes the currently active image. Use imageId parameter
 * to re-select the input image during processing.
 */
function processImage(imageTitle, imageId, output) {
	// Do the processing here by adding your own code.
	// Leave the print statements until things work, then remove them.
	
	print("Processing: " + imageTitle);
	pathToOutputFile = output + File.separator + "MAX_" + imageTitle + ".tif";
	print("Saving to: " + pathToOutputFile);


	run("Z Project...", "projection=[Max Intensity]");
	//selectWindow("MAX_HJn_1-ctrl.lif - 4wk_hj2_1-ctrl_c1_002");
	//run("Channels Tool...");
	Stack.setChannel(1);
	//setMinAndMax(2, 50);
	Stack.setDisplayMode("color");
	run("Green");
	
	Stack.setChannel(2);
	//setMinAndMax(7, 38);
	run("Red");
	//run("Close");

	//run("Save", "save=[" + pathToOutputFile + "]");
	saveAs("Tiff", pathToOutputFile);
	close();
	
}
