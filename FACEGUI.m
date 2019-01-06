function varargout = FACEGUI(varargin)

% Edit the above text to modify the response to help FACEGUI

% Last Modified by GUIDE v2.5 30-May-2015 23:01:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FACEGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @FACEGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before FACEGUI is made visible.
function FACEGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FACEGUI (see VARARGIN)

% Choose default command line output for FACEGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FACEGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FACEGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global gaborArray;
u=5;
v=8;
gaborArray = gaborFilterBank(u,v,39,39);
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

load('TRAINING SET.mat');
gaborArray = evalin('base', 'gaborArray'); 
gaborResult = evalin('base', 'gaborResult'); 
u=5;
v=8;
hist_data1 = cell(1,1);
%gaborArray = gaborFilterBank(u,v,39,39);

match = zeros(200,40); 
min1 = zeros(200,1); 
% get File Browser
[filename,pathname]=uigetfile('*.*','Select an Image');
tic;
I=strcat(pathname,filename);
img=imread(I);
axes(handles.axes3);
imshow(img); 
% figure;
% imshow(img); 
% title('Input image');
 
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
%         figure;
%         imshow(strcat('TRAINING SET\a (',int2str(j),').bmp'));
%          title(sprintf('Matched image'));
       display((j));
       k=j;
     end
    end
end
axes(handles.axes2);
imshow(strcat('TRAINING SET\a (',int2str(k),').bmp'));
toc;

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
[filename,pathname]=uigetfile('*.*','Select an Image');
tic;
I=strcat(pathname,filename);
img=imread(I);
gaborResult = evalin('base', 'gaborResult'); 

gaborArray = evalin('base', 'gaborArray'); 


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
 
        binval=subimg(1,1)*(2^0)+subimg(1,2)*(2^1)+subimg(1,3)*(2^2)+subimg(2,3)*(2^3)+subimg(3,3)*(2^4)+subimg(3,2)*(2^5)+subimg(3,1)*(2^6)+subimg(2,1)*(2^7);
        
        lbpimg(i-1,j-1)=binval;
    end
end
lbpimg=uint8(lbpimg);   
        lbpfinal{x,y}=lbpimg;
    end
end


% % DISPLAY
figure('NumberTitle','Off','Name','LBP PATTERN');
for x = 1:u
    for y = 1:v        
        subplot(u,v,(x-1)*v+y)    
        imshow(abs(lbpfinal{x,y}),[]);
    end
end

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

figure;
for i = 1:40
subplot(5,8,i)
plot(z0(:,:,i))
    axis tight
end

% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gaborArray = evalin('base', 'gaborArray'); 


%% Filtering
% Filter input image by each Gabor filter
u=5;
v=8;
[filename,pathname]=uigetfile('*.*','Select an Image');
tic;
I=strcat(pathname,filename);
img=imread(I);
img = double(img);

%% Filtering
% Filter input image by each Gabor filter
[u,v] = size(gaborArray);
gaborResult = cell(u,v);
for i = 1:u
    for j = 1:v
        gaborResult{i,j} = conv2(img,gaborArray{i,j},'same');
        % J{u,v} = filter2(G{u,v},I);
    end
end
% Show filtered images
% Show real parts of Gabor-filtered images
figure('NumberTitle','Off','Name','Real parts of Gabor filters');
for i = 1:u
    for j = 1:v        
        subplot(u,v,(i-1)*v+j)    
        imshow(real(gaborResult{i,j}),[]);
    end
end
% Show magnitudes of Gabor-filtered images
figure('NumberTitle','Off','Name','Magnitudes of Gabor filters');
for i = 1:u
    for j = 1:v        
        subplot(u,v,(i-1)*v+j)    
        imshow(abs(gaborResult{i,j}),[]);
    end
end