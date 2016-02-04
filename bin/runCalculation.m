function runCalculation( hObject, eventdata, handles )
%RUNCALCULATION Summary of this function goes here
%   Detailed explanation goes here
% Data & Design with High-pass Filter
[people, folderP] = readMultiSess(get(handles.editDataDesign, 'String'),...
    str2double(get(handles.editHighPassFilter, 'String')),false);
% Units for design

contents = cellstr(get(handles.popupmenuUnitsForDesign,'String'));
fmri_spec.timing.units = contents{get(handles.popupmenuUnitsForDesign,'Value')};
switch  contents{get(handles.popupmenuUnitsForDesign,'Value')}
    case 'Seconds'
        fmri_spec.timing.units = 'secs';
    case 'Scans'
         fmri_spec.timing.units = 'scans';
end
% Interscan interval
fmri_spec.timing.RT = str2double(get(handles.editInterscanInterval, 'String'));
% Microtime resolution
fmri_spec.timing.fmri_t = str2double(get(handles.editMicrotimeResolution, 'String'));
% Microtime onset
fmri_spec.timing.fmri_t0 = str2double(get(handles.editMicrotimeOnset, 'String'));


% Factorial Design
fmri_spec.fact = struct([]);
% Directory
dir =  get( handles.editDirectory, 'String' ) ;
% Basis Function
switch get(handles.popupmenuBasisFunction, 'Value')
    case 1
        switch get(handles.popupmenuModelDerivatives, 'Value')
            case 1
                fmri_spec.bases.hrf.derivs = [0,0];
            case 2
                fmri_spec.bases.hrf.derivs = [1,0];
            case 3
                fmri_spec.bases.hrf.derivs = [1,1];
        end
    case 2
        fmri_spec.bases.fourier.length = get(handles.editWindowLength, 'String');
        fmri_spec.bases.fourier.order = get(handles.editOrder, 'String');
    case 3
        fmri_spec.bases.fourier_han.length = get(handles.editWindowLength, 'String');
        fmri_spec.bases.fourier_han.order = get(handles.editOrder, 'String');
    case 4
        fmri_spec.bases.gamma.length = get(handles.editWindowLength, 'String');
        fmri_spec.bases.gamma.order = get(handles.editOrder, 'String');
    case 5
        fmri_spec.bases.fir.length = get(handles.editWindowLength, 'String');
        fmri_spec.bases.fir.order = get(handles.editOrder, 'String');
    case 6
        fmri_spec.bases.none = true;
       
end

% Model Interactions(Volterra)
fmri_spec.volt = get(handles.popupmenuModelInteractions,'Value');

% Global normalization
contents = cellstr(get(handles.popupmenuGlobalNormalization,'String'));
fmri_spec.global = contents{get(handles.popupmenuGlobalNormalization,'Value')};
% Masking threshold
fmri_spec.mthresh = str2double(get(handles.editMaskingThreshold, 'String'));
% Explicit mask
mask = get(handles.editExplicitMask, 'String');
fmri_spec.mask = { mask };
% Serial correlations
contents = cellstr(get(handles.popupmenuSerialCorrelations,'String'));
fmri_spec.cvi = contents{get(handles.popupmenuSerialCorrelations,'Value')};




% for testing only
A = cell(length(people),1);
for i = 1:length(people)
    
    fmri_spec.sess = people{i};
    fmri_spec.dir = {strcat(dir, '\', folderP{i})};
    B.spm.stats.fmri_spec = fmri_spec;
    matlabbatch = {B};
    if ~isdir(fmri_spec.dir{1})
        mkdir(fmri_spec.dir{1});
    end
    save(strcat(fmri_spec.dir{1}, '\', folderP{i}, 'Matlabbatch'), 'matlabbatch');
    A(i) = {matlabbatch};
    
end
matlabbatch = A;
spm_jobman('run', matlabbatch);   

end

