function varargout = BNAToolbox(varargin)
% BNATOOLBOX MATLAB code for BNAToolbox.fig
%      BNATOOLBOX, by itself, creates a new BNATOOLBOX or raises the existing
%      singleton*.
%
%      H = BNATOOLBOX returns the handle to a new BNATOOLBOX or the handle to
%      the existing singleton*.
%
%      BNATOOLBOX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BNATOOLBOX.M with the given input arguments.
%
%      BNATOOLBOX('Property','Value',...) creates a new BNATOOLBOX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BNAToolbox_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BNAToolbox_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BNAToolbox

% Last Modified by GUIDE v2.5 01-Feb-2016 16:48:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BNAToolbox_OpeningFcn, ...
                   'gui_OutputFcn',  @BNAToolbox_OutputFcn, ...
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


% --- Executes just before BNAToolbox is made visible.
function BNAToolbox_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BNAToolbox (see VARARGIN)


% Set the search path 
mfilename('fullpath');
strings = strsplit(mfilename('fullpath'), '\');
strrm = strings{end};
pathname = strrep(mfilename('fullpath'), strcat('\',strrm), '');
pathname = strcat(pathname, '\bin');
path(path, pathname);

% Choose default command line output for BNAToolbox
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BNAToolbox wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BNAToolbox_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbuttonResidualEstimation.
function pushbuttonResidualEstimation_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonResidualEstimation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ResidualEstimation;

% --- Executes on button press in pushbuttonBackgroundAnalysis.
function pushbuttonBackgroundAnalysis_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonBackgroundAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
BackgroundAnalysis;


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
clc;clear;close all;
fprintf('Bye for now...\n');