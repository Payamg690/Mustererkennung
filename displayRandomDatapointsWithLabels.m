function [] = displayRandomDatapointsWithLabels(numberOfDatapoints, images, labels)

%TODO replace static 60000 with the size of image array
r = randi([1,60000],10,1);

i = numberOfDatapoints;
disp('click on the image to display the next one')

for x = 1:i
    img = images(r(x),:);
    img = reshape(img, 28, 28);
    imshow(img);
    label = labels(r(x),:)
    k = waitforbuttonpress;
end