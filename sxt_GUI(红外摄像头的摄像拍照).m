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

% Last Modified by GUIDE v2.5 28-Feb-2019 21:05:52

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

set(handles.axes1,'visible','off');
set(handles.axes2,'visible','off');


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imaqhwinfo('winvideo');
global vid1;
vid1 = videoinput('winvideo', 1,'YUY2_360x240'); %创建ID为1的摄像头的视频对象，视频格式是YUY2_360x288，这表示视频的分辨率为360x288。其他会卡 YUY2_640x480
set(vid1,'ReturnedColorSpace','rgb');               %在这里设置不会出现红色视频
usbVidRes1=get(vid1,'videoResolution'); %视频分辨率
nBands1=get(vid1,'NumberOfBands');      %摄像头数据的通道数
axes(handles.axes1);  
hImage1=imshow(zeros(usbVidRes1(2),usbVidRes1(1),nBands1));  %以hImage的尺寸显示摄像头数据
preview(vid1,hImage1);

%while (1)
%    frame=getsnapshot(vid1);
%    frame=rgb2gray(frame);
%    axes(handles.axes2);
%    imshow(frame)
%end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global vid1;
%视频的保存
filename = 'film';       %保存视频的名字
nframe = 120;            %视频的帧数
nrate = 25;              %每秒的帧数          
set(vid1,'ReturnedColorSpace','rgb');

% 这 f 两个部分，一个是色域colormap，一个是视频数据内容
writerObj = VideoWriter( [filename '.avi'] );
writerObj.FrameRate = nrate;  
open(writerObj);
f.colormap = colormap([]) ;     %这句放在f.data后面也行


%%视频保存
%axes(handles.axes2);           %axes可以放在这不用加入循环（好像不行啊）
for ii = 1: nframe
    frame = getsnapshot(vid1);
    axes(handles.axes2);           %axes可以放在这不用加入循环
    imshow(frame); 
    f.cdata = frame;             %不懂这个什么意思
    writeVideo(writerObj,f);
end
close(writerObj);



   


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid1;
    frame=getsnapshot(vid1);
    axes(handles.axes2);
    imshow(frame)
    imwrite(frame,['im','.jpg']);            %存图'
    
