% function [ D, V ] = spmRead( img )
%SPMREAD Summary of this function goes here
%   Detailed explanation goes here

img = 'AAL_90_3mm.nii';
spm_image('Display', img);
V = spm_vol(img);
[D, XYZ] = spm_read_vols(V);

% end

