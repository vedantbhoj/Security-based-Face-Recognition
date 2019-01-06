clc;
clear all;
close all;
u=5;
v=8;
hist_data = cell(1,200);
gaborArray = gaborFilterBank(u,v,39,39);
% match = zeros(9,40); 
% min1 = zeros(9,1); 
% figure;
%  imshow( strcat('S4\1.bmp') ); 
%  title('Input image');
for X=1:1:200
    img = imread( strcat('TRAINING SET\a (',int2str(X),').bmp') ); 
    img= imresize(img,[512 512]); 
gaborResult = gabor_conv(img,gaborArray);
featureVector = gaborFeatures(img,gaborArray,gaborResult);
lbpfinal = im_lbp(gaborResult);
hist_data(1,X) = mat2cell(histo_gram(lbpfinal));
end

% A = cell2mat(hist_data(1,1));
% 
% for i=2:10    
%     
%     B = cell2mat(hist_data(1,i));
%     
%  match((i-1),:) = dist_chi(A,B);
%  min1((i-1),:) = min(match((i-1),:));
% end
% 
%  min2 = min(min1);
% 
% 
%  A = cell2mat(hist_data(1,1));
% 
% for i=2:10    
%     
%     B = cell2mat(hist_data(1,i));
%     
%  match((i-1),:) = histmatch(A,B);
%  min1((i-1),:) = min(match((i-1),:));
% end
% 
%  min2 = min(min1);
%  
%  
% 
% for i=1:9
%     
%     if min1(i)== min2
%         figure;
%         imshow( strcat('S4\',int2str(i+1),'.bmp') );
%          title('Matched image');
% %         sprintf('figure match is %d',(i+1));
%        display((i+1));
%      end
% end

% sh4=0;
%  for i=1:256
%      for j=1:256
%     
%      sh4 = sh6(i,j)+sh4;
%      
%      end
%  end
%  
%       sh8=0;
%  for i=1:256
%      for j=1:256
%     
%      sh8 = sh6(i,j)+sh8;
%      
%      end
%  end  
        

% for i=1:9
%     
%     match1(i)= mean2(match(i,:));
% end
%  match2=min(match1);
