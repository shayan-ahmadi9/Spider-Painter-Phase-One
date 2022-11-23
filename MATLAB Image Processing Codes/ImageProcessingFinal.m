clc
clear

y=800;
x=800;
file='ESLAB'
language='eng';
parts=3;
% for ESLAB
p_n=[500,730,y];
% UT512
% p_n=[125,220,270,473,500,600,800];
% p_n=[y];
% hi
% p_n=[110,240,360,435,530,630,800];
% hello
% p_n=[130,190,250,300,360,400,800];
% azadi
% p_n=[280,360,800];
%caltech
% p_n=[150,270,525,800];
%nyutwo
% p_n=[325,380,650,800];
%wlf
% p_n=[210,275,340,375,410,460,540,620,800];
%%poem
% p_n=[340,y];
%starryNight
% p_n=[130,280,495,585,800];


%% Read image from File
RGB=imread(char(string('')+file+string('.jpg')));

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
% imshow(~I_bw);
%% Calculate the perimeters of objects in the image
I_perim = bwperim(I_bw,4);
imwrite(~I_perim,char(string('')+file+string('800.jpg')))
imshow(~I_perim);
%% tracing
if language=='eng'
    tracingENG(x,y,p_n,parts,I_perim,file)
elseif language=='per'
    tracingPER(x,y,p_n,parts,I_perim,file)
end


