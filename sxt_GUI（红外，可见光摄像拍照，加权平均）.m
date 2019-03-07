function varargout = sxt_GUI(varargin)
% SXT_GUI MATLAB code for sxt_GUI.fig
%      SXT_GUI, by itself, creates a new SXT_GUI or raises the existing
%      singleton*.
%
%      H = SXT_GUI returns the handle to a new SXT_GUI or the handle to
%      the existing singleton*.
%
%      SXT_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SXT_GUI.M with the given input arguments.
%
%      SXT_GUI('Property','Value',...) creates a new SXT_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sxt_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sxt_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sxt_GUI

% Last Modified by GUIDE v2.5 05-Mar-2019 15:15:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sxt_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @sxt_GUI_OutputFcn, ...
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


% --- Executes just before sxt_GUI is made visible.
function sxt_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sxt_GUI (see VARARGIN)

% Choose default command line output for sxt_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sxt_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sxt_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

set(handles.axes1,'visible','off'); %����ʾ�����
set(handles.axes2,'visible','off');
set(handles.axes3,'visible','off');





% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imaqhwinfo('winvideo');
global vid1;
global vid2;
vid1 = videoinput('winvideo', 1,'YUY2_640x480'); %����IDΪ1������ͷ����Ƶ������Ƶ��ʽ��YUY2_360x288�����ʾ��Ƶ�ķֱ���Ϊ360x288�������Ῠ YUY2_640x480
vid2 = videoinput('winvideo', 2,'YUY2_640x480'); %����IDΪ2������ͷ����Ƶ������Ƶ��ʽ��YUY2_640x480�����ʾ��Ƶ�ķֱ���Ϊ640x480�� 
set(vid1,'ReturnedColorSpace','rgb');               %���������ò�����ֺ�ɫ��Ƶ(���û���ճ�����Ƭ�Ǻ�ɫ��
set(vid2,'ReturnedColorSpace','grayscale');          %'grayscale'����Ƶ��Ϊ�ڰ�    
usbVidRes1=get(vid1,'videoResolution'); %��Ƶ�ֱ���
usbVidRes2=get(vid2,'videoResolution'); %��Ƶ�ֱ���
nBands1=get(vid1,'NumberOfBands');      %����ͷ���ݵ�ͨ����
nBands2=get(vid2,'NumberOfBands');      %����ͷ���ݵ�ͨ����
axes(handles.axes1);  
hImage1=imshow(zeros(usbVidRes1(2),usbVidRes1(1),nBands1));  %��hImage�ĳߴ���ʾ����ͷ����
preview(vid1,hImage1);
axes(handles.axes3);  
hImage2=imshow(zeros(usbVidRes2(2),usbVidRes2(1),nBands2));  %��hImage�ĳߴ���ʾ����ͷ����
preview(vid2,hImage2);



%while (1)
%    frame=getsnapshot(vid1);
%    frame=rgb2gray(frame);
%    axes(handles.axes2);
%    imshow(frame)
%end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)  %�洢��Ƶ���⣬���ַ���û����ɫͼcolormap
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global vid1;
%��Ƶ�ı���
filename = 'film';       %������Ƶ������
nframe = 120;            %��Ƶ��֡��
nrate = 25;              %ÿ���֡��          
%set(vid1,'ReturnedColorSpace','rgb');             %���ʲô�ð�

% �� f �������֣�һ����ɫ��colormap��һ������Ƶ��������
writerObj = VideoWriter( [filename '.avi'] );
writerObj.FrameRate = nrate;  
open(writerObj);
%f.colormap = colormap([]) ;     %������f.data����Ҳ��


%%��Ƶ����
%axes(handles.axes2);           %axes���Է����ⲻ�ü���ѭ���������а���
for ii = 1: nframe
    frame = getsnapshot(vid1);
    axes(handles.axes2);           
    imshow(frame); 
%    f.cdata = frame;             %�������ʲô��˼
%    writeVideo(writerObj,f);
    writeVideo(writerObj,frame);
end
close(writerObj);
%axes(handles.axes2);   %�����ʾһ������
%cla reset


   


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles) %�������
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid1;
    frame=getsnapshot(vid1);
    axes(handles.axes2);
    imshow(frame)
    imwrite(frame,['im','.jpg']);            %��ͼ'

    


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles) % ����������ͷ��Ȩƽ���ں�
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid1;
global vid2;
while(1)
frame1=getsnapshot(vid1);
frame2=getsnapshot(vid2);
frame1=rgb2gray(frame1);           %�����������ֺ�ɫ
I=imresize(frame1,[196,228]);      %����������ͷȫ����Ϊ196x228����
T=imresize(frame2,[196,228]);
im=I;
%[m,n]=size(I);    %��֪��Ϊʲô������
im=im2double(im);
I=im2double(I);
T=im2double(T);
for p=1:196
    for j=1:228
        im(p,j)=I(p,j)+T(p,j);
    end
end
pause(0.033);            %ֹͣ������һ����ʮ֡
axes(handles.axes2);
imshow(im)
end;

