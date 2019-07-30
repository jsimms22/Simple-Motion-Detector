function security_cam()
%% Setup Image Acquisition
hCamera = webcam;

% Creat a handle to an imshow figure for faster updating
hShow = imshow(zeros(480,640,3,'uint8'));
title('Security Camera');

%% Acquire Reference Image
ref_vid_img = snapshot(hCamera);

%% Quantize images and outputing to the screen

frames = 2000;
for ii = 1:frames

    %Acquire an image from the webcam
    vid_img = snapshot(hCamera);
    
    %Call the live segmentation function
    object_detected = Segmentation_Fn2(vid_img, ref_vid_img);
    
    %Update the imshow handle with a new image
    set(hShow, 'CData', object_detected);
    drawnow;
end

%% Shutdown webcame by deleting handle