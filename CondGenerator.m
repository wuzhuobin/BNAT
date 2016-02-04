function CondGenerator()
% This script is for generating 'Conditions' parameters, 'Cond*.mat' files.
%%
% =========================================================================
% This script is for generating 'Conditions' parameters, 'Cond*.mat' files.
% You need to input your parameters in this script. Pleas read the
% instructions.
% =========================================================================
% 
% Every session folder should contain a specified 'Cond*.mat' file to
% contain your 'Conditions' parameters. After running it, the file will 
% generate in the same folder of this script. 
% Parameters here are actually the same as the ones in 'SPM'. You can read 
% the manual of 'SPM' as reference.
%
% Every parameters must be in same size. Otherwise the program may be in
% error.
%
% =========================================================================
% Parameters
% =========================================================================
% 
% 
% CondName: The '*' part of the name of the 'Cond*.mat' file
% It is a string or a char array. The frontal part 'Cond' has already done 
% for you.
% e.g. CondName = 'itions'; output:'Condition.mat'
% CondName = '_p1s1'; output: 'Cond_p1s1.mat'
%
% names: Name. Condition Name
% It is a cell array. Each array inside should be a string or a char array.
% e.g. names = {'listening', 'hearing', 'talking'};
%
% onsets: Onsets. Specify a vector of onset times for this condition type.
% It is a cell array. Each array inside should be a double array.
% e.g. onsets = {[1 2 3 4], [1:2:7], [1:5]};
%
% duarations: Durations. Specify the event durations.
% It is a cell array. Each array inside should be a double number.
% e.g. durations = {0, 2.5, 7};
% 
% tmod: Time Modulation. This option allows for the characterisation of 
% nonstationary responses.  
% It is a cell array. Each array inside should be a double number.
% e.g. tmod = {0, 0, 0};
% 
% pmod: Parametric Modulations.
% It is a cell array. Each array inside should be a double number. It can
% be kept empty. 
% e.g. pmod = {0, 0, 0};
%
%%
% =========================================================================
% Please input your parameters in the following script.
% =========================================================================
clc;clear;
CondName = '';
names = {};
onsets = {};
durations = {};
tmod = {};
pmod = {};

% Checking whether your parameters are in the same size. 
a = isequal(size(names), size(durations),size(onsets), size(tmod));
b = isequal(size(pmod),[0 0]);
c = isequal(size(names), size(durations),size(onsets), size(tmod),...
    size(pmod));
if  (a*b+c)
    CondName = strcat('Cond', CondName, '.mat');
    save(CondName, 'names', 'durations', 'onsets', 'tmod', 'pmod');
    clear;clc;
else 
    error('Your parameters are not in the same size!!');
end

end
