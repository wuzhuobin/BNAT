function [ display ] = displayMultiSess( people )
%DISPLAYMULTISESS2 Summary of this function goes here
%   Detailed explanation goes here

seperator = {'----------------------------------------------------------------------------------------------'};
% seperator = {'_______________________________________________'};
%-----------------------------------------------
len = length(people);
counter = 0;

%   For cell array 'display' initialization
for i = 1:len
    
    counter = length(people{i}) + counter;
    counter = counter + 1;

end

display = cell(counter,1);
counter = 0;
for i = 1:len
    for ii = 1:length(people{i})
        counter = counter + 1;
        listing = dir(strcat(people{1,i}{1,ii}, '\*.img'));
        display(counter) = {strcat(people{1,i}{1,ii},', ',...
            int2str(length(listing)), ' images')};
        
    end
    counter = counter + 1;
    display(counter) = seperator;

end

