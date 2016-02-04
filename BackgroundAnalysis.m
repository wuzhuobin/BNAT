function varargout = BackgroundAnalysis(varargin)
% BACKGROUNDANALYSIS MATLAB code for BackgroundAnalysis.fig
%      BACKGROUNDANALYSIS, by itself, creates a new BACKGROUNDANALYSIS or raises the existing
%      singleton*.
%
%      H = BACKGROUNDANALYSIS returns the handle to a new BACKGROUNDANALYSIS or the handle to
%      the existing singleton*.
%
%      BACKGROUNDANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BACKGROUNDANALYSIS.M with the given input arguments.
%
%      BACKGROUNDANALYSIS('Property','Value',...) creates a new BACKGROUNDANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BackgroundAnalysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BackgroundAnalysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BackgroundAnalysis

% Last Modified by GUIDE v2.5 10-Dec-2015 14:29:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BackgroundAnalysis_OpeningFcn, ...
                   'gui_OutputFcn',  @BackgroundAnalysis_OutputFcn, ...
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


% --- Executes just before BackgroundAnalysis is made visible.
function BackgroundAnalysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BackgroundAnalysis (see VARARGIN)


% Set the search path 
mfilename('fullpath');
strings = strsplit(mfilename('fullpath'), '\');
strrm = strings{end};
pathname = strrep(mfilename('fullpath'), strcat('\',strrm), '');
pathname = strcat(pathname, '\bin');
path(path, pathname);

% default value setting
handles.THRESHOLDVALUE = 0.8;


% Choose default command line output for BackgroundAnalysis
handles.output = hObject;

% set default value
set(handles.editThresholdValue, 'String', handles.THRESHOLDVALUE);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BackgroundAnalysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BackgroundAnalysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenuType.
function popupmenuType_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuType


% --- Executes during object creation, after setting all properties.
function popupmenuType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuThresholdType.
function popupmenuThresholdType_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuThresholdType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuThresholdType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuThresholdType


% --- Executes during object creation, after setting all properties.
function popupmenuThresholdType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuThresholdType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editThresholdValue_Callback(hObject, eventdata, handles)
% hObject    handle to editThresholdValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editThresholdValue as text
%        str2double(get(hObject,'String')) returns contents of editThresholdValue as a double
% if isnan(str2double(get(hObject, 'String'))) || str2double(get(hObject, 'String')) >1 || str2double(get(hObject, 'String')) < 0
%     set(hObject, 'String', handles.THRESHOLDVALUE);
% end


% --- Executes during object creation, after setting all properties.
function editThresholdValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editThresholdValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkboxClusteringCoefficient1.
function checkboxClusteringCoefficient1_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxClusteringCoefficient1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxClusteringCoefficient1

% --- Executes during object deletion, before destroying properties.
function checkboxClusteringCoefficient1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to checkboxClusteringCoefficient1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkboxGlobalEfficiency.
function checkboxGlobalEfficiency_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxGlobalEfficiency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxGlobalEfficiency


% --- Executes on button press in checkboxDegreeStrength.
function checkboxDegreeStrength_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxDegreeStrength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxDegreeStrength


% --- Executes on button press in checkboxClusteringCoefficient.
function checkboxClusteringCoefficient_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxClusteringCoefficient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxClusteringCoefficient


% --- Executes on button press in checkboxLocalEfficiency.
function checkboxLocalEfficiency_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxLocalEfficiency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxLocalEfficiency


% --- Executes on button press in checkboxBetweennessCentrality.
function checkboxBetweennessCentrality_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxBetweennessCentrality (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxBetweennessCentrality


% --- Executes on button press in checkboxEigenvectorCentrality.
function checkboxEigenvectorCentrality_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxEigenvectorCentrality (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxEigenvectorCentrality


% --- Executes on button press in pushbuttonRUN.
function pushbuttonRUN_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonRUN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

BARUN2(hObject, eventdata, handles);



function editDirectory_Callback(hObject, eventdata, handles)
% hObject    handle to editDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDirectory as text
%        str2double(get(hObject,'String')) returns contents of editDirectory as a double

% the input must be a directory
if ~isdir(get( hObject, 'String' ))
    set(hObject, 'String','');
else
    foldername = get( handles.editDirectory, 'String');
    foldername1 = strcat(foldername, '/*corx.txt');
    folders = dir(foldername1);
    names = cell(length(folders),1);
    for i = 1:length(folders)
        names{i} = strcat(foldername, '\', folders(i).name);
    end
    set(handles.listboxDirectory, 'String', names);

end



% --- Executes during object creation, after setting all properties.
function editDirectory_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonDirectory.
function pushbuttonDirectory_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% use the uigetdir to choose a directory which has data
folderName = uigetdir();
if folderName ~= 0
    set( handles.editDirectory, 'String', folderName);
% set the Directory as the default Output folder
    set(handles.editOutputFolder, 'String', folderName);

    foldername = get( handles.editDirectory, 'String');
    foldername1 = strcat(foldername, '/*corx.txt');
    folders = dir(foldername1);
    names = cell(length(folders),1);
    for i = 1:length(folders)
        names{i} = strcat(foldername, '\', folders(i).name);
    end
    set(handles.listboxDirectory, 'String', names);

end



% --- Executes on button press in checkboxCharacteristicPathLength.
function checkboxCharacteristicPathLength_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCharacteristicPathLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxCharacteristicPathLength



function editOutputFolder_Callback(hObject, eventdata, handles)
% hObject    handle to editOutputFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOutputFolder as text
%        str2double(get(hObject,'String')) returns contents of editOutputFolder as a double



% the input must be a directory
if ~isdir(get( hObject, 'String' ))
    set(hObject, 'String','');
end

% --- Executes during object creation, after setting all properties.
function editOutputFolder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOutputFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






% --- Executes on button press in pushbuttonOutputFolder.
function pushbuttonOutputFolder_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonOutputFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% use the uigetdir to choose a directory which has data
folderName = uigetdir();
if folderName ~= 0
    set( handles.editOutputFolder, 'String', folderName);
end


% --- Executes on selection change in listboxDirectory.
function listboxDirectory_Callback(hObject, eventdata, handles)
% hObject    handle to listboxDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxDirectory contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxDirectory


% --- Executes during object creation, after setting all properties.
function listboxDirectory_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonCANCEL.
function pushbuttonCANCEL_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonCANCEL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);