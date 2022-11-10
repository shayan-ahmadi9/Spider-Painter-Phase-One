clc
clear

y=800;
x=800;
language="eng";
parts=3;
% for ESLAB
p_n=[500,730,y];
% for shahrdari
% p_n=[490,y];
% p_n=[y];
%% Read image from File
RGB=imread('ESLAB.jpg');

%% resize the image
RGB_resized = imresize(RGB,[y x]);
I_gray = rgb2gray(RGB_resized);
%% Gaussian filtering
% Filter image with a 2-D Gaussian smoothing kernel with standard deviation of 0.5, and returns the filtered image in I_gauss.
I_gauss = imgaussfilt(I_gray);
%% Initial thresholding
% Calculate a 16-bin histogram for the image.
[counts,u] = imhist(I_gauss,16);
% Compute a global threshold using the histogram counts.
T = otsuthresh(counts);
% Create a binary image using the computed threshold and display the image.
I_bw = ~imbinarize(I_gauss,T+0.1); 
%% Calculate the perimeters of objects in the image
I_perim = bwperim(I_bw,4);
imwrite(~I_perim,'ESLAB800.jpg')
imshow(~I_perim);
%% tracing
if language=="eng"
    tracingENG(x,y,p_n,parts,I_perim)
elseif language=="per"
    tracingPER(x,y,p_n,parts,I_perim)
end


