function  stimate( hObject, eventdata, handles )
%ESTIMATE Summary of this function goes here
%   Detailed explanation goes here

allFolders = dir(get(handles.editDirectory, 'String'));

counter = 0;
for i = 1:length(allFolders)
    if (allFolders(i).isdir) && (~strcmp(allFolders(i).name,'.'))...
            && (~strcmp(allFolders(i).name,'..'))
        counter = counter + 1;
        fmri_est.spmmat = {strcat(get(handles.editDirectory, 'String'), '\',...
            allFolders(i).name, '\SPM.mat')};
%   Write residuals
        contents = cellstr(get(handles.popupmenuWriteResiduals,'String')) ;
            switch contents{get(handles.popupmenuWriteResiduals,'Value')} 
                case 'No'
                        fmri_est.write_residuals = 0;
                case 'Yes'
                        fmri_est.write_residuals = 1;
            end
%   Method
            switch get(handles.popupmenuMethod, 'String')
                case 'Classical'
                    fmri_est.method.Classical = 1;
            end
        A.spm.stats.fmri_est = fmri_est;
        matlabbatch(counter) = {A}; 

        
    end
end
spm_jobman('run', matlabbatch); 
if fmri_est.write_residuals == 1
    resFolderName = renameRes(get(handles.editDirectory, 'String'));
    set(handles.editResFolder, 'String', resFolderName);
end
end

