
function lbpfinal = im_lbp(gaborResult)

u=5;
v=8;
m =512;
n =512;
for x = 1:u
    for y = 1:v        
        
%temp= imresize(gaborResult{x,y}, [256 256]);
gaborResult1=padarray(gaborResult{x,y},[1 1]); 

[w,z] =size(gaborResult1);

img3=gaborResult1;

%[m,n] = size(temp);

for i=2:m+1
   for j=2:n+1 
%     subimg1=imgpad((i-1:i+1),(j-1:j+1));
%     figure;
%     imshow(subimg1); 
%     subimg=subimg1; 
    for p=(i-1:i+1)
        for q=(j-1:j+1)
                
                if img3(p,q)>img3(i,j)
                    
                    subimg(p-i+2,q-j+2)=1;
                    
                else
                    
                   subimg(p-i+2,q-j+2)=0;
                    
                end
            end
    end
        %conv of bin to dec.
        binval=subimg(1,1)*(2^0)+subimg(1,2)*(2^1)+subimg(1,3)*(2^2)+subimg(2,3)*(2^3)+subimg(3,3)*(2^4)+subimg(3,2)*(2^5)+subimg(3,1)*(2^6)+subimg(2,1)*(2^7);
        
        lbpimg(i-1,j-1)=binval;
    end
end
lbpimg=uint8(lbpimg);   
        lbpfinal{x,y}=lbpimg;
    end
end


% % DISPLAY
% figure('NumberTitle','Off','Name','LBP PATTERN');
% for x = 1:u
%     for y = 1:v        
%         subplot(u,v,(x-1)*v+y)    
%         imshow(abs(lbpfinal{x,y}),[]);
%     end
% end


% figure;
% imhist(temp1);