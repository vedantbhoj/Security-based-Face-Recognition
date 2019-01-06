clc;
close all;
clear all;

load('TRAINING SET.mat')
u=5;
v=8;
hist_data1 = cell(1,1);
%gaborArray = gaborFilterBank(u,v,39,39);

match = zeros(200,40); 
min1 = zeros(200,1); 
%get File Browser
[filename,pathname]=uigetfile('*.*','Select an Image');
tic;
I=strcat(pathname,filename);
img=imread(I);
%img=robust_postprocessor(I1);
figure;
imshow(img); 
title('Input image');
 
img= imresize(img,[512 512]); 
gaborResult = gabor_conv(img,gaborArray);
featureVector = gaborFeatures(img,gaborArray,gaborResult);
lbpfinal = im_lbp(gaborResult);
hist_data1(1,1) = mat2cell(histo_gram(lbpfinal));

 A = cell2mat(hist_data1(1,1));
 for i=1:200    
  
     B = cell2mat(hist_data(1,i));
     
  match(i,:) = histmatch(A,B);
  min1(i,:) = mean(match((i),:));
 end
 
  min2 = min(min1);
  min3 = sort(min1);
  
for i=1:1    
    for j=1:200
    if min1(j)==min3(i)
        figure;
        imshow(strcat('TRAINING SET\a (',int2str(j),').bmp'));
         title(sprintf('Matched image'));
       display((j));
     end
    end
end
toc;