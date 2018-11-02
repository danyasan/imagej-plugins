// This macro measures all the images in a folder.
// It uses the IJ.redirectErrorMessages() function
// to prevent itself from being aborted if there is
// an error opening an image.
// Added in way to measure polygon ROI

    dir = getDirectory("Choose a Directory ");
    list = getFileList(dir);
    run("Close All");
    setOption("display labels", true);
    setBatchMode(false);
    for (i=0; i<list.length; i++) {
        path = dir+list[i];
        showProgress(i, list.length);
        IJ.redirectErrorMessages();
        open(path);
        if (nImages>0) {
        //choose green (tissue autofluorescence) channel, set brightness
        //weird workaround so the AutoThreshold command actually works
            Stack.setChannel(2);
            Stack.setChannel(1);
        //Green: usually between 2 and 58
            setAutoThreshold("Default dark");   
            run("Threshold...");
            waitForUser("Tissue autofluorescence looks okay?");
            run("Close");         
            setTool("polygon");
            waitForUser("Region of Interest looks okay?");            

// Need to have a way to show both images either at once, or switch between them, without adjusting the threshold.
// Maybe need to apply threshold permanently? then the image can be saved, including the drawn polygon, in a separate folder.
//	To record polygon coordinates:
//            run("Convex Hull");
//            getSelectionCoordinates(xpoints, ypoints);           
            run("Measure");
        }
        else {
            n = nResults();
            setResult("Label", n, list[i]);
            setResult("Mean", n, NaN);
            updateResults;
         }    
	}
/*	for (i=0; i<list.length; i++) {
        path = dir+list[i];
        showProgress(i, list.length);
        IJ.redirectErrorMessages();
        open(path);
        if (nImages>0) {
        //choose red (perfused lectin) channel, set brightness
            Stack.setChannel(2);
            //Red: usually between 7 and 38
  			setAutoThreshold("Default dark");   
            run("Threshold...");
            waitForUser("Vessels (lectin) look okay?");
            run("Close");         
            run("Measure");
        }
        else {
            n = nResults();
            setResult("Label", n, list[i]);
            setResult("Mean", n, NaN);
            updateResults;
         }
         run("Close All");
    }
*/