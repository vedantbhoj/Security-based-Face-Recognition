
function hist_data = histo_gram(lbpfinal)
 

%HISTOGRAM

u=5;
v=8;

hist_data=zeros(256,40);
j=1;
for x = 1:u
    for y = 1:v 

        lbpmat=cell2mat(lbpfinal(x,y));
        
        z0(:,:,j)=imhist(lbpmat);
        
        
        hist_data(:,j)= imhist(lbpmat);
        j=j+1;
        if j==41
            break;
        end   
    end
        if j==41
            break;
        end
end

% % figure;
% for i = 1:40
% subplot(5,8,i)
% plot(z0(:,:,i))
%     axis tight
% end


for i=1:256
    for j=1:40
        hist1(i,j)=hist_data(i,j)/(512*512);  
    end
end

% figure(8);
% for i =1:40
%     subplot(5,8,i)
%     plot(hist1(:,i));
%     axis tight
% end
