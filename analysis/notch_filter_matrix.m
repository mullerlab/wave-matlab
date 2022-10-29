function [xo] = notch_filter_matrix(x, f1, f2, filter_order, Fs)
% *WAVE* 
%
% NOTCH FILTER    notch filter a datacube between frequencies f1 and f2
%
% INPUT: 
% x - datacube (r,c,t)
% f1 - low frequency for notch
% f2 - high frequency
% filter_order - filter order ( x2 for bandpass filter )
% Fs - sampling frequency
%
% OUTPUT
% xo - output datacube
%

assert(ndims(x) == 2,'matrix input required');
xo = zeros(size(x));

% construct filter
ct = [f1 f2];
ct = ct / (Fs/2);
[b,a] = butter(filter_order,ct,'stop'); 

% proceed with filtering
for rr = 1:size(x,1)
	xo(rr,:) = filtfilt(b,a,x(rr,:));
end
