function [people, folderP]= readMultiSess(foldername1 , hpf, folderOnly)

% foldername1 = 'D:\matlab\myspm\Ê²Ã´¹í'; hpf = 28; folderOnly = false;
allFolders1 = dir(foldername1);
%   count the number of the people
counterP = 0;
%   traverse all people
for i = 1:length(allFolders1)
    if (allFolders1(i).isdir) && (~strcmp(allFolders1(i).name,'.'))...
            && (~strcmp(allFolders1(i).name,'..'))
        counterP = counterP + 1;
%   the file of every subject
        folderP(counterP) =  {allFolders1(i).name};
        foldername2 = strcat(foldername1, '\', allFolders1(i).name);
%   open the people's folders
        allFolders2 = dir(foldername2);
        
%   traverse all sessions
        counterS = 0;
        for ii = 1:length(allFolders2)
            if (allFolders2(ii).isdir) && (~strcmp(allFolders2(ii).name,'.'))...
                && (~strcmp(allFolders2(ii).name,'..'))
%   count the number of the sessions
                counterS = counterS + 1;
                foldername3 = strcat(foldername2, '\', allFolders2(ii).name);

                if folderOnly
                    sess{counterS} = foldername3;
                else
%   open the sessions' folders and find out all '*.img'
                    allFolders3 = dir(strcat(foldername3,'\*.img'));
                    scans = cell(length(allFolders3),1);
%   traverse all files
                    for iii = 1:length(allFolders3)                
                        scans{iii} = strcat(foldername3,'\', allFolders3(iii).name, ',1');
                    end
%   every session folder mave have a Conditions.mat & 
%   Regressors.txt/Regressor.mat & Hpf.mat
%   save scans to sess
                    sess(counterS).scans = scans;
                    sess(counterS).cond = struct([]);
                    sess(counterS).regress = struct([]);
%   find the condition file whose name should conclude Cond
%   find the regressor file whose name should conclude Reg
                    cond = dir(strcat(foldername3,'\*Cond*'));
                    reg = dir(strcat(foldername3,'\*Reg*'));
                    sess(counterS).multi = {strcat(foldername3, '\', cond(1).name)};
                    sess(counterS).multi_reg = {strcat(foldername3, '\', reg(1).name)};
                    sess(counterS).hpf = hpf;
                    
                end

            
            end 
        end
    
        people{counterP} = sess;
    end
end