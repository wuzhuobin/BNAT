function [ resFolderName ] = renameRes2( foldername1 )
%RENAMERES Summary of this function goes here
%   Detailed explanation goes here


% foldername1 = 'D:\matlab\myspm\test2Res';
allFolders1 = dir(foldername1);

for i = 1:size(allFolders1)
    if (allFolders1(i).isdir) && (~strcmp(allFolders1(i).name,'.'))...
            && (~strcmp(allFolders1(i).name,'..'))
        
        foldername2 = strcat(foldername1, '\', allFolders1(i).name);
        matlabbatch = dir(strcat(foldername2, '\*Matlabbatch*'));
        load(strcat(foldername2, '\', matlabbatch(1).name));
        sess = matlabbatch{1,1}.spm.stats.fmri_spec.sess;
        orginal = dir(strcat(foldername2, '\Res_*'));
        counterOriginal = 0;
        
        fprintf(strcat('Moving files from\t', strrep(foldername2,'\', '\\')));
        fprintf('\n');
        
        for ii = 1:length(sess)

            for iii = 1:length(sess(ii).scans)
                counterOriginal = counterOriginal + 1;
% remove the ',1'                
                fakeName = strsplit(sess(ii).scans{iii}, ',');
                fakeName = fakeName{1};
% keep the name of the folder                 
                fakeName = strsplit(fakeName, '\');
                fakeNameLen = length(fakeName);
% new folder for Res_files
                sp = strsplit(foldername1, '\');
                splength = length(sp);
                resFolderName = strrep(foldername1, sp{splength}, strcat('Res_', sp{splength}) );
% if the folder doesn't exist, it will make a new folder                
                foldername3 = strcat(resFolderName, '\', fakeName{fakeNameLen-2} ,...
                    '\', fakeName{fakeNameLen-1});
                if ~isdir(foldername3)
                   mkdir(foldername3); 
                end
% make the destination location & source                
                fakepreName = strsplit(fakeName{fakeNameLen}, '.');
                name = strcat( 'Res_', fakepreName{1}, '.nii');
                
                destination = strcat(foldername3, '\', name);
                source = strcat(foldername2, '\', orginal(counterOriginal).name);
                
                movefile(source, destination );
%                 copyfile(source, destination );
                fprintf('.');
            end
            
        end
        fprintf('\n')
        
      
    end
end
