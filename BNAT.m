function BNAT()
% This is the main function for opening the interface
% welcome sentences
welcome ={ ...
    '恭喜发财',...
    '身体健康', ...
    'happy new year', ...
    'marry christmas'};

for i = 1:length(welcome)
    fprintf('%s\n', welcome{i});
end

% loading 
for i = 1:5
    fprintf('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n');
    if exist('spm','file')*exist('spm_jobman','file') ~= 4
       error('Please install SPM first!!!!'); 
    end
    pause(0.5);
end

BNAToolbox;