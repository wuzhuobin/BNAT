function varargout = ResidualEstimation(varargin)
% RESIDUALESTIMATION MATLAB code for ResidualEstimation.fig
%      RESIDUALESTIMATION, by itself, creates a new RESIDUALESTIMATION or raises the existing
%      singleton*.
%
%      H = RESIDUALESTIMATION returns the handle to a new RESIDUALESTIMATION or the handle to
%      the existing singleton*.
%
%      RESIDUALESTIMATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESIDUALESTIMATION.M with the given input arguments.
%
%      RESIDUALESTIMATION('Property','Value',...) creates a new RESIDUALESTIMATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ResidualEstimation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ResidualEstimation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ResidualEstimation

% Last Modified by GUIDE v2.5 19-Nov-2015 20:04:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ResidualEstimation_OpeningFcn, ...
                   'gui_OutputFcn',  @ResidualEstimation_OutputFcn, ...
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


% --- Executes just before ResidualEstimation is made visible.
function ResidualEstimation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ResidualEstimation (see VARARGIN)



% Set the search path 
mfilename('fullpath');
strings = strsplit(mfilename('fullpath'), '\');
strrm = strings{end};
pathname = strrep(mfilename('fullpath'), strcat('\',strrm), '');
pathname = strcat(pathname, '\bin');
path(path, pathname);

% Choose default command line output for ResidualEstimation
handles.output = hObject;

% Initialise SPM's jobs configuration and set MATLAB path accordingly.
spm_jobman('initcfg');

% Set unnecessary parameters to invisible
set(handles.editFactorialDesign, 'Visible', 'off');
set(handles.pushbuttonFactorialDesing, 'Visible', 'off');
set(handles.popupmenuWriteResiduals, 'Visible', 'off');
set(handles.popupmenuMethod, 'Visible', 'off');
set(handles.pushbuttonRUN, 'Visible', 'off');
set(handles.editWindowLength, 'Visible', 'off');
set(handles.textWindowlength, 'Visible', 'off');
set(handles.editOrder, 'Visible', 'off');
set(handles.textOrder, 'Visible', 'off');

% Set default values
handles.MICROTIME_RESOLUTION = 16;
handles.MICROTIME_ONSET = 8;
handles.INTERSCAN_INTERVAL = 0;
handles.HIGH_PASS_FILTER = 128;
handles.MASKING_THRESHOLD = 0.8;

set(handles.editHighPassFilter, 'String', handles.HIGH_PASS_FILTER);
set(handles.editInterscanInterval, 'String', handles.INTERSCAN_INTERVAL);
set(handles.editMicrotimeResolution, 'String', handles.MICROTIME_RESOLUTION);
set(handles.editMicrotimeOnset, 'String', handles.MICROTIME_ONSET);
set(handles.editMaskingThreshold, 'String', handles.MASKING_THRESHOLD);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ResidualEstimation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ResidualEstimation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function editDataDesign_Callback(hObject, eventdata, handles)
% hObject    handle to editDataDesign (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDataDesign as text
%        str2double(get(hObject,'String')) returns contents of editDataDesign as a double


% Input must be a directory
if ~isdir(get( hObject, 'String' ))
    set(hObject, 'String','');
    display = {''};    
else
    folderName = get(hObject, 'String');
    try
        % Read the folder
        people = readMultiSess(folderName, 0, true);
        display = displayMultiSess(people);
    catch err
        % Read error
        display = { 'No session or subject exists in this folder. ', ...
            'Or the position of sessions is wrong'};
    end
   
end
% Display content of display
 set(handles.listboxDataDesign, 'String', display);




% --- Executes during object creation, after setting all properties.
function editDataDesign_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDataDesign (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonDataDesign.
function pushbuttonDataDesign_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonDataDesign (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% use the uigetdir to choose a directory which has data
folderName = uigetdir();
% Input must be a directory
if folderName ~= 0
    set( handles.editDataDesign, 'String', folderName);
    try
        % Read the folder
        [people, folderP]= readMultiSess(folderName, 0, true);
        display = displayMultiSess(people);
    catch err
        % Read error
        display = { 'No session or subject exists in this folder. ', ...
            'Or the position of sessions is wrong'};
    end
else
    set( handles.editDataDesign, 'String', '');
    display = {''};
end
% Display content of display
set(handles.listboxDataDesign, 'String', display);

% --- Executes on selection change in listboxDataDesign.
function listboxDataDesign_Callback(hObject, eventdata, handles)
% hObject    handle to listboxDataDesign (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxDataDesign contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxDataDesign


% --- Executes during object creation, after setting all properties.
function listboxDataDesign_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxDataDesign (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editHighPassFilter_Callback(hObject, eventdata, handles)
% hObject    handle to editHighPassFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editHighPassFilter as text
%        str2double(get(hObject,'String')) returns contents of editHighPassFilter as a double

% the input must be number
if isnan(str2double(get(hObject, 'String'))) 
    set(hObject, 'String', handles.HIGH_PASS_FILTER);
end

% --- Executes during object creation, after setting all properties.
function editHighPassFilter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editHighPassFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuUnitsForDesign.
function popupmenuUnitsForDesign_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuUnitsForDesign (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuUnitsForDesign contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuUnitsForDesign



% --- Executes during object creation, after setting all properties.
function popupmenuUnitsForDesign_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuUnitsForDesign (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editInterscanInterval_Callback(hObject, eventdata, handles)
% hObject    handle to editInterscanInterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInterscanInterval as text
%        str2double(get(hObject,'String')) returns contents of editInterscanInterval as a double

% the input must be number
if isnan(str2double(get(hObject, 'String'))) 
    set(hObject, 'String', handles.INTERSCAN_INTERVAL);
end




% --- Executes during object creation, after setting all properties.
function editInterscanInterval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInterscanInterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editMicrotimeResolution_Callback(hObject, eventdata, handles)
% hObject    handle to editMicrotimeResolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMicrotimeResolution as text
%        str2double(get(hObject,'String')) returns contents of editMicrotimeResolution as a double

% the input must be number
if isnan(str2double(get(hObject, 'String'))) 
    set(hObject, 'String', handles.MICROTIME_RESOLUTION);
end


% --- Executes during object creation, after setting all properties.
function editMicrotimeResolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMicrotimeResolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editMicrotimeOnset_Callback(hObject, eventdata, handles)
% hObject    handle to editMicrotimeOnset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMicrotimeOnset as text
%        str2double(get(hObject,'String')) returns contents of editMicrotimeOnset as a double

% the input must be number
if isnan(str2double(get(hObject, 'String'))) 
    set(hObject, 'String', handles.MICROTIME_ONSET);
end


% --- Executes during object creation, after setting all properties.
function editMicrotimeOnset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMicrotimeOnset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editDirectory_Callback(hObject, eventdata, handles)
% hObject    handle to editDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDirectory as text
%        str2double(get(hObject,'String')) returns contents of editDirectory as a double

% the input must be a directory
if ~isdir(get( hObject, 'String' ))
    set(hObject, 'String','');
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


% --- Executes on button press in pushbuttonDir.
function pushbuttonDir_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% the input must be a directory
folderName = uigetdir();
if folderName == 0
    set( handles.editDirectory, 'String', '');
else
    set(handles.editDirectory, 'String', folderName);
end








function editFactorialDesign_Callback(hObject, eventdata, handles)
% hObject    handle to editFactorialDesign (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFactorialDesign as text
%        str2double(get(hObject,'String')) returns contents of editFactorialDesign as a double

% the input must be a directory
if ~isdir(get( hObject, 'String' ))
    set(hObject, 'String','');
end


% --- Executes during object creation, after setting all properties.
function editFactorialDesign_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFactorialDesign (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonFactorialDesing.
function pushbuttonFactorialDesing_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonFactorialDesing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Use the uigetdir to choose a directory which has data
folderName = uigetdir();
% The input must be a directoru
if folderName ~= 0
    set( handles.editDirectory, 'String', folderName);
else
    set( handles.editDirectory, 'String', '');
end


% --- Executes on selection change in popupmenuBasisFunction.
function popupmenuBasisFunction_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuBasisFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuBasisFunction contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuBasisFunction

% Choosing Canonical HRF
if get(hObject, 'Value') == 1
   set(handles.editWindowLength, 'Visible', 'off');
   set(handles.textWindowlength, 'Visible', 'off');   
   set(handles.editOrder, 'Visible', 'off');
   set(handles.textOrder, 'Visible', 'off');
   set(handles.popupmenuModelDerivatives, 'Visible', 'on');
   set(handles.textModelDerivatives, 'Visible', 'on');

% Choosing None
elseif get(hObject, 'Value') == 6
       set(handles.editWindowLength, 'Visible', 'off');
   set(handles.textWindowlength, 'Visible', 'off');   
   set(handles.editOrder, 'Visible', 'off');
   set(handles.textOrder, 'Visible', 'off');
   set(handles.popupmenuModelDerivatives, 'Visible', 'off');
   set(handles.textModelDerivatives, 'Visible', 'on');
   set(handles.textModelDerivatives, 'Visible', 'off'); 
% Choosing Fourier set, Fourier set(Hanning), Gamma Funtions, Finite
% Impulse Response 
else
   set(handles.editWindowLength, 'Visible', 'on');
   set(handles.textWindowlength, 'Visible', 'on');   
   set(handles.editOrder, 'Visible', 'on');
   set(handles.textOrder, 'Visible', 'on');
   set(handles.popupmenuModelDerivatives, 'Visible', 'off');
   set(handles.textModelDerivatives, 'Visible', 'off'); 
end




% --- Executes during object creation, after setting all properties.
function popupmenuBasisFunction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuBasisFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuModelDerivatives.
function popupmenuModelDerivatives_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuModelDerivatives (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuModelDerivatives contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuModelDerivatives


% --- Executes during object creation, after setting all properties.
function popupmenuModelDerivatives_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuModelDerivatives (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editWindowLength_Callback(hObject, eventdata, handles)
% hObject    handle to editWindowLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editWindowLength as text
%        str2double(get(hObject,'String')) returns contents of editWindowLength as a double

% The input must be number
if isnan(str2double(get(hObject, 'String'))) 
    set(hObject, 'String', '');
end

% --- Executes during object creation, after setting all properties.
function editWindowLength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editWindowLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOrder_Callback(hObject, eventdata, handles)
% hObject    handle to editOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOrder as text
%        str2double(get(hObject,'String')) returns contents of editOrder as a double
% the input must be number
if isnan(str2double(get(hObject, 'String'))) 
    set(hObject, 'String', '');
end

% --- Executes during object creation, after setting all properties.
function editOrder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popupmenuModelInteractions.
function popupmenuModelInteractions_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuModelInteractions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuModelInteractions contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuModelInteractions




% --- Executes during object creation, after setting all properties.
function popupmenuModelInteractions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuModelInteractions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popupmenuGlobalNormalization.
function popupmenuGlobalNormalization_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuGlobalNormalization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuGlobalNormalization contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuGlobalNormalization




% --- Executes during object creation, after setting all properties.
function popupmenuGlobalNormalization_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuGlobalNormalization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editMaskingThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to editMaskingThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMaskingThreshold as text
%        str2double(get(hObject,'String')) returns contents of editMaskingThreshold as a double

% The input must be number
if isnan(str2double(get(hObject, 'String'))) 
    set(hObject, 'String', handles.MASKING_THRESHOLD);
end


% --- Executes during object creation, after setting all properties.
function editMaskingThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMaskingThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editExplicitMask_Callback(hObject, eventdata, handles)
% hObject    handle to editExplicitMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editExplicitMask as text
%        str2double(get(hObject,'String')) returns contents of editExplicitMask as a double


% The input must be a file
if exist(get( hObject, 'String'), 'file') == 0
    set(hObject, 'String','');
end


% --- Executes during object creation, after setting all properties.
function editExplicitMask_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editExplicitMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonExplicitMask.
function pushbuttonExplicitMask_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonExplicitMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% use the uigetfile to choose a file
[ FileName, PathName, FilterIndex ] = uigetfile({'*.nii; *.img', 'MRI Images'});
% the input must be a file
if FileName ~= 0
    set( handles.editExplicitMask, 'String', strcat(PathName, FileName));
else
    set( handles.editExplicitMask, 'String', '');
end


% --- Executes on selection change in popupmenuSerialCorrelations.
function popupmenuSerialCorrelations_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuSerialCorrelations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuSerialCorrelations contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuSerialCorrelations



% --- Executes during object creation, after setting all properties.
function popupmenuSerialCorrelations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuSerialCorrelations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonRUN.
function pushbuttonRUN_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonRUN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Begin running status
set(handles.textRunning, 'Visible', 'on');
pause(1);
% Read parameters and start the program
runCalculation( hObject, eventdata, handles );

% End running status
set(handles.textRunning, 'Visible', 'off');


% --- Executes on selection change in popupmenuWriteResiduals.
function popupmenuWriteResiduals_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuWriteResiduals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuWriteResiduals contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuWriteResiduals


% --- Executes during object creation, after setting all properties.
function popupmenuWriteResiduals_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuWriteResiduals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuMethod.
function popupmenuMethod_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuMethod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuMethod


% --- Executes during object creation, after setting all properties.
function popupmenuMethod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbuttonEstimate.
function pushbuttonEstimate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonEstimate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Begin running status
set(handles.textRunning, 'Visible', 'on');
pause(1);

% Data % Design must be a directory
% Read parameters and start the program
if isdir(get( handles.editDataDesign, 'String' ))
    runCalculation( hObject, eventdata, handles );
end
estimate( hObject, eventdata, handles );

% End runnning status
set(handles.textRunning, 'Visible', 'off');


function editResFolder_Callback(hObject, eventdata, handles)
% hObject    handle to editResFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editResFolder as text
%        str2double(get(hObject,'String')) returns contents of editResFolder as a double

% the input must be a directory
if ~isdir(get( hObject, 'String' ))
    set(hObject, 'String','');
end


% --- Executes during object creation, after setting all properties.
function editResFolder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editResFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonResFolder.
function pushbuttonResFolder_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonResFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% use the uigetdir to choose a directory which has data
resFolderName = uigetdir();
if resFolderName ~= 0
    set( handles.editResFolder, 'String', resFolderName);
 end


function editCalMeans_Callback(hObject, eventdata, handles)
% hObject    handle to editCalMeans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editCalMeans as text
%        str2double(get(hObject,'String')) returns contents of editCalMeans as a double

% the input must be a file
if exist(get( hObject, 'String'), 'file') == 0
    set(hObject, 'String','');
end

% --- Executes during object creation, after setting all properties.
function editCalMeans_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editCalMeans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonCalMeansBrowser.
function pushbuttonCalMeansBrowser_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonCalMeansBrowser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% use the uigetfile to choose a file
[ FileName, PathName, FilterIndex ] = uigetfile('*.nii','Select a mask' ,'specified mask');
% The input must be a file
if FileName ~= 0
    set( handles.editCalMeans, 'String', strcat(PathName, FileName));
else
    set( handles.editCalMeans, 'String', '');
end

% --- Executes on button press in pushbuttonCalMeans.
function pushbuttonCalMeans_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonCalMeans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Begin running status
set(handles.textRunning, 'Visible', 'on');
pause(1);

% Read parameters and start the program
folderName1 = get(handles.editResFolder, 'String');
maskFile = get(handles.editCalMeans, 'String');
calMeans(folderName1, maskFile);

% End running status
set(handles.textRunning, 'Visible', 'off');




% --- Executes on button press in pushbuttonCANCEL.
function pushbuttonCANCEL_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonCANCEL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% close the window and exit
close(gcf);
