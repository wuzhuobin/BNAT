function [ success ] = calMeans( foldername1, maskFile )

% foldername1 = 'D:\MSC project\myspm\Res_testRes';
% 
% maskFile = 'D:\MSC project\myspm\AAL_90_3mm.nii';

maskV = spm_vol(maskFile);
maskY = spm_read_vols(maskV);
maskXLength = maskV.dim(1);
maskYLength = maskV.dim(2);
maskZLength = maskV.dim(3);

stepIntensity = unique(maskY);


allFolders1 = dir(foldername1);
for i = 1:length(allFolders1)
    if (allFolders1(i).isdir) && (~strcmp(allFolders1(i).name,'.'))...
            && (~strcmp(allFolders1(i).name,'..'))
        %   the file of every subject
        foldername2 = strcat(foldername1, '\', allFolders1(i).name);
        %   open the people's folders
        allFolders2 = dir(foldername2);
        for ii = 1:length(allFolders2)
            if (allFolders2(ii).isdir) && (~strcmp(allFolders2(ii).name,'.'))...
                    && (~strcmp(allFolders2(ii).name,'..'))
                foldername3 = strcat(foldername2, '\', allFolders2(ii).name);
                fprintf('Calculating folders: %s\n', foldername3);
                allFolders3 = dir(strcat(foldername3,'\*.nii'));
                
                %   the file for the means output
                outputMeans = strcat(foldername3, '\', allFolders1(i).name,...
                    '_', allFolders2(ii).name, '_', 'ROISigs.txt');
                fid = fopen(outputMeans, 'w+');
                %   traverse all files
                for iii = 1:length(allFolders3)
                    fprintf('.');
                    imgFile = strcat(foldername3,'\', allFolders3(iii).name);
                    meaN = calMean(imgFile);
                    fprintf(fid, '%f\t', meaN);
                    fprintf(fid,'\n');
                end
                fclose(fid);
                correlation = calCor( outputMeans );
                outputCor = strcat(foldername3, '\', allFolders1(i).name,...
                    '_', allFolders2(ii).name, '_', 'corx.txt');
                
                fid = fopen(outputCor, 'w+');
                [outputY, outputX] = size(correlation);
                %   traverse all files
                for iii = 1:outputY
                    %                     fprintf('%f\t',iii);
                    fprintf(fid, '%f\t', correlation(iii,:));
                    fprintf(fid,'\n');
                end
                fclose(fid);
                
                fprintf('\n');
            end
        end
    end
end
% imgFile = 'Res_swraFunImg_C03_Cued_007.nii'
% tic;
% success = calMean(imgFile);
% success = toc;


    function meaN = calMean(imgFile)
        
%         imgFile = 'Res_swraFunImg_C03_Cued_007.nii'
        imgV = spm_vol(imgFile);
        imgY = spm_read_vols(imgV);
        
        store = zeros(2, length(stepIntensity)-1);
        
        for int = 1:length(stepIntensity)-1
            %     fprintf('%d',i);
            imgY1 = imgY;
            imgY1(maskY ~= stepIntensity(int+1)) = 0;
            store(2, int) = length(nonzeros(imgY1));
            imgY1(isnan(imgY1)) = 0;
            store(1, int) = sum(imgY1(:));

%             for x = 1:maskXLength
%                 for y = 1:maskYLength
%                     for z = 1:maskZLength
%                         if maskY(x,y,z) == stepIntensity(int+1)
%                             if ~isnan(imgY(x,y,z))
%                                 store(1, int) = store(1, int) + imgY(x,y,z);
%                             end
%                             store(2, int) = store(2, int) + 1;
%                         end
%                     end
%                 end
%             end
        end
        meaN = store(1,:)./store(2,:);
    end
    function correlation = calCor( outputMeans )
        means = load(outputMeans);
        correlation = corr(means);
    end


end

