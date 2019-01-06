function gaborArray = gaborFilterBank(u,v,m,n)
%   u	N o. of scales
%   v	No. o orientations
%  m	No.  rows in a 2-D Gabor filter
%   n	No of columns in a 2-D Gabor filter
% gaborArray = gaborFilterBank(5,8,39,39);
% img=imread('E:\woman_blonde.tif');
% featureVector = gaborFeatures(img,gaborArray,4,4);


% if (nargin ~= 4)    % Check correct number of arguments
%     error('There should be four inputs.')
% end

% Create Gabor filters
% Create u*v gabor filters each being an m*n matrix
gaborArray = cell(u,v);
fmax = 0.25;
gama = sqrt(2);
eta = sqrt(2);

for i = 1:u
    
    fu = fmax/((sqrt(2))^(i-1));
    alpha = fu/gama;
    beta = fu/eta;
    
    for j = 1:v
        tetav = ((j-1)/v)*pi;
        gFilter = zeros(m,n);
        
        for x = 1:m
            for y = 1:n
                xprime = (x-((m+1)/2))*cos(tetav)+(y-((n+1)/2))*sin(tetav);
                yprime = -(x-((m+1)/2))*sin(tetav)+(y-((n+1)/2))*cos(tetav);
                gFilter(x,y) = (fu^2/(pi*gama*eta))*exp(-((alpha^2)*(xprime^2)+(beta^2)*(yprime^2)))*exp(1i*2*pi*fu*xprime);
            end
        end
        gaborArray{i,j} = gFilter;
        
    end
end

% Show Gabor filters
% Show magnitudes of Gabor filters:
figure('NumberTitle','Off','Name','Magnitudes of Gabor filters');
for i = 1:u
    for j = 1:v        
        subplot(u,v,(i-1)*v+j);        
        imshow(abs(gaborArray{i,j}),[]);
    end
end

% Show real parts of Gabor filters:
figure('NumberTitle','Off','Name','Real parts of Gabor filters');
for i = 1:u
    for j = 1:v        
        subplot(u,v,(i-1)*v+j);        
        imshow(real(gaborArray{i,j}),[]);
    end
end