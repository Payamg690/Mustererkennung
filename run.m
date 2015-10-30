[trainImages, trainLabels, testImages, testLabels] = readMNISTFiles;
 

%displayRandomDatapointsWithLabels(10, trainImages, trainLabels)

%the second-last point's label:
l = trainLabels(5999)