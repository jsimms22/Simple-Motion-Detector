function [ highlighted_img ] = Segmentation_Fn2( img2, img1 )
%% Convert to Black and White
img1BW = rgb2gray(img1);
img2BW = rgb2gray(img2);

%% Display Black and White Images
% figure
% imshow(img1BW);
% figure
% imshow(img2BW);

%% Subtract images
imgDiff = abs(img1BW - img2BW);
% imDiff = imsubtract(img1BW - img2BW);
% figure 
% imshow(imgDiff);

%% Find Maximum Location of Difference
% maxDiff = max(max(imgDiff));
% [iRow, iCol] = find(imgDiff == maxDiff);
% [m, n] = size(imgDiff);

% imshow(imgDiff)
% hold on
% plot(iCol, iRow, 'r*')

%% Use imtool to Determine Threshold and Lenght
% imtool(imgDiff)

%% Threshold Image
imgThresh = imgDiff > 7;
% figure 
% imshow(imgThresh)
% hold on
% plot(iCol,iRow,'r*')
% hold off

%% Fill in Regions
imgFilled = bwareaopen(imgThresh, 15);
% figure
% imshow(imgFilled)

%% Overlay onto Original Image
% utility from File Exchange

imgBoth = imoverlay(img2, imgFilled, [1 0 0]);
% figure
% imshow(imgBoth);
highlighted_img = imgBoth;

%% Only Care About Things Larger than length of 80 pixels

imageStats = regionprops(imgFilled, 'MajorAxisLength');

imgLengths = [imageStats.MajorAxisLength];
idx = imgLengths > 100;
imageStatsFinal = imageStats(idx);
disp(imageStatsFinal);

%% Determin if CHange is Significant

if isempty(imageStatsFinal)
    disp('Nothing Different Here')
else
    disp('Something is Here!')
end



end

