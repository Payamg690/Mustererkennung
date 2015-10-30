function [trainImages, trainLabels, testImages, testLabels] = readMNISTFiles

%files have been uncompressed (they're not in .gz anymore)
%load all of the files
trainImages = fopen('train-images.idx3-ubyte');
trainLabels = fopen('train-labels.idx1-ubyte');
testImages = fopen('t10k-images.idx3-ubyte');
testLabels = fopen('t10k-labels.idx1-ubyte');

%Reading binary data with 'fread' is done 'piece by piece'
%the files are constructed as described here:
%http://martin-thoma.com/classify-mnist-with-pybrain/

%In images, first four pieces of data are:
%1. Magic number (for verification I think). We're not using it.
%2. number of images
%3. number of rows
%4. number of columns
% .. followed by all the pixels

magicNumber1 = fread(trainImages, 1, 'int32', 0, 'ieee-be');
numberOfImages = fread(trainImages, 1, 'int32', 0, 'ieee-be');
numberOfRows = fread(trainImages, 1, 'int32', 0, 'ieee-be');
numberOfColumns = fread(trainImages, 1, 'int32', 0, 'ieee-be');

magicNumber2 = fread(testImages, 1, 'int32', 0, 'ieee-be');
numberOfImagesTestSet = fread(testImages, 1, 'int32', 0, 'ieee-be');
numberOfRowsTestSet = fread(testImages, 1, 'int32', 0, 'ieee-be');
numberOfColumnsTestSet =fread(testImages, 1, 'int32', 0, 'ieee-be');

%In labels, first two pieces of data are:
%1. magic number (for verification I think). We're not using it.
%2. number of items
% .. followed by all the labels

magicNumber3 = fread(trainLabels, 1, 'int32', 0, 'ieee-be');
numberOftrainLabels = fread(trainLabels, 1, 'int32', 0, 'ieee-be');

magicNumber4 = fread(testLabels, 1, 'int32', 0, 'ieee-be');
numberOftestLabels = fread(testLabels, 1, 'int32', 0, 'ieee-be');


%Get and format labels
trainLabels = fread(trainLabels, inf, 'unsigned char');
testLabels = fread(testLabels, inf, 'unsigned char');



%Get and format image data

%put all the pixels in an (infinity x 1) array
trIm = fread(trainImages, inf, 'unsigned char');
testIm = fread(testImages, inf, 'unsigned char');

%reshape them into a (28 x 28 x #-of-examples) array
%where 28x28 are the dimensions of one image
trIm = reshape(trIm, numberOfRows, numberOfColumns, numberOfImages);
testIm = reshape(testIm, numberOfRowsTestSet, numberOfColumnsTestSet, numberOfImagesTestSet);
%change the order of subscrips needed to access given dimension
trIm = permute(trIm,[2 1 3]);
testIm = permute(testIm,[2 1 3]);

% reshape the images to put all pixels for one image in one row
%this gives an array of (pixels x #-of-examples) so (784 x #-of-examples)
trIm = reshape(trIm, size(trIm, 1) * size(trIm, 2), size(trIm, 3));
testIm = reshape(testIm, size(testIm, 1) * size(testIm, 2), size(testIm, 3));

% rescale: each pixel now has a value between 0 and 1, inclusive
trainImages = double(trIm) / 255;
testImages = double(testIm) / 255;

trainImages = trainImages';
testImages = testImages';
