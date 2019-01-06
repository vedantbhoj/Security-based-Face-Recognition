function featureVector = gaborFeatures(img,gaborArray,gaborResult)

% featureVector = gaborFeatures(img,gaborArray,4,4);
% img=imread('E:\woman_blonde.tif');
% if (nargin ~= 2)    % Check correct number of arguments
%     error('Use correct number of input arguments!')
% end

% if size(img,3) == 3	% % Check if the input image is grayscale
%     img = rgb2gray(img);
% end
% img = double(img);
%% Feature Extraction
%       img         :	input image 
%       d1          :	The factor of downsampling along rows.
%       d2          :	The factor of downsampling along columns.               
% Extract feature vector from input image
d1=4;d2=4;
u=5;v=8;
[n,m] = size(img);
s = (n*m)/(d1*d2); %combined downsampling factor
l = s*u*v;
featureVector = zeros(l,1);
c = 0;
for i = 1:u
    for j = 1:v
        
        c = c+1;
        gaborAbs = abs(gaborResult{i,j});
        gaborAbs = downsample(gaborAbs,d1);
        gaborAbs = downsample(gaborAbs.',d2);
        gaborAbs = reshape(gaborAbs.',[],1);
        
        % Normalized to zero mean and unit variance.
        gaborAbs = (gaborAbs-mean(gaborAbs))/std(gaborAbs,1);
        
        featureVector(((c-1)*s+1):(c*s)) = gaborAbs;
        
    end
end


