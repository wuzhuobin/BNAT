function BARUN2(hObject, eventdata, handles)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


% Directory
foldername = get(handles.editDirectory, 'String');
corxs = dir(strcat(foldername, '\*corx.txt'));

% Output folder: 
outputFolder = get(handles.editOutputFolder, 'String');


% Threshold value
thresholdValueString = get(handles.editThresholdValue, 'String');
thresholdValueString = strcat('thresholdValue = [ ', thresholdValueString, '];');
thresholdValue = 0;
eval(thresholdValueString);
% thresholdValue = get(handles.editThresholdValue, 'String');

% Threshold type
thresholdType = cellstr(get(handles.popupmenuThresholdType,'String'));

%Type
type = cellstr(get(handles.popupmenuType,'String'));



for i = 1:length(corxs)
    filename = strcat(foldername, '\', corxs(i).name);
    corx = load(filename);
    output = struct;

    for ii = 1:length(thresholdValue)
        [corxCal ,isBinary ]= singleFileTrans(corx,thresholdValue(ii));

    
    
% Small World Measures
        if(get(handles.checkboxClusteringCoefficient1,'Value'))
            if isBinary
                output.smallWorldMeasures.clusteringCoefficient(:,ii) = mean(clustering_coef_bu(corxCal));
            else
                output.smallWorldMeasures.clusteringCoefficient(:,ii) = mean(clustering_coef_wu(corxCal));
            end
            
        end
    
        if(get(handles.checkboxGlobalEfficiency,'Value'))
            if isBinary
                output.smallWorldMeasures.globalCoefficient(:,ii) = efficiency_bin(corxCal);
            else
                output.smallWorldMeasures.globalCoefficient(:,ii) = efficiency_wei(corxCal);
            end
        end
    
        if(get(handles.checkboxCharacteristicPathLength,'Value'))
            if isBinary
                A = distance_bin(corxCal);
            else
                A = distance_wei(weight_conversion( corxCal, 'lengths' ));
            end
            lambda = charpath(A);
            output.smallWorldMeasures.characteristicPathLength(:,ii) = lambda;
       
        end
    
        if(get(handles.checkboxLocalEfficiency,'Value'))
            if isBinary
                output.smallWorldMeasures.localCoefficient(:,ii) = mean(efficiency_bin(corxCal, 1));
            else
                output.smallWorldMeasures.localCoefficient(:,ii) = mean(efficiency_wei(corxCal, 1));
            end
        
        end
    
%  Nodal Measures
        if(get(handles.checkboxDegreeStrength,'Value'))
            degrees = degrees_und(corxCal);
            output.nodalMeasures.degrees(:,ii) = degrees;
            strengths = strengths_und(corxCal);
            output.nodalMeasures.strengths(:,ii) = strengths;
            
        end
    
        if(get(handles.checkboxClusteringCoefficient,'Value'))
            if isBinary
                output.nodalMeasures.clusteringCoefficient(:,ii) = clustering_coef_bu(corxCal);
            else
                output.nodalMeasures.clusteringCoefficient(:,ii) = clustering_coef_wu(corxCal);
            end
        end
    
        if(get(handles.checkboxBetweennessCentrality,'Value'))
            if isBinary
                output.nodalMeasures.betweennessCentrality(:,ii) = betweenness_bin(corxCal);
            else
                output.nodalMeasures.betweennessCentrality(:,ii) = betweenness_wei(corxCal);
            end
        end
    
        if(get(handles.checkboxEigenvectorCentrality,'Value'))
            output.nodalMeasures.eigenvectorCentrality(:,ii) = eigenvector_centrality_und(corxCal);
        end

    end
    filename1 = strsplit(corxs(i).name, '.');
    filename1 = filename1{1};
    
    filename = strcat(outputFolder, '\output_', filename1);
    save(filename, 'output');
end



function [corxCal, isBinary] = singleFileTrans(corx, thresholdValue)
%   for selecting Threshold type
%   INPUT: 
%   corx£º the loaded .txt file
% 
%   OUTPUT: 
%   isBinary, if in Binary model isBinary = 1. Otherwise, in Weighted isBinary = 0
%   corxCal: the data has thresholded and gone through conversation
% 


        switch thresholdType{get(handles.popupmenuThresholdType,'Value')}
            case 'Coefficient'
                
                corx = threshold_absolute(corx, thresholdValue );
        
            case 'Cost'
                corx = threshold_proportional(corx, thresholdValue );
        end
        
        switch type{get(handles.popupmenuType,'Value')}
            case 'Binary'
                corxCal = weight_conversion(corx, 'binarize');
                % type flag, 1 binary, 0 weighted
                isBinary = 1;
            case 'Weighted'
                corxCal = corx;
%                 corxCal = weight_conversion(corx, 'normalize');
                % type flag, 1 binary, 0 weighted
                isBinary = 0;
                
        end

        
       
end


end

