function [xo] = bandpass_filter_matrix(x, f1, f2, filter_order, Fs)
% *WAVE*
%
% BANDPASS FILTER MATRIX   filter a matrix between frequencies f1 and f2
%
% INPUT:
% x - matrix (r,t)
% f1 - low-frequency cutoff
% f2 - high-frequency cutoff
% filter_order - filter order (N.B. doubled for forward-reverse filter)
% Fs - sampling frequency
%
% OUTPUT
% xo - output matrix
%

assert( ndims(x) == 2, 'matrix input required' );
xo = zeros( size(x) );

% construct filter
ct = [f1 f2];
ct = ct / (Fs/2);
[b,a] = butter( filter_order, ct );

% proceed with filtering
for ii = 1:size(x,1)
    xo(ii,:) = filtfilt( b, a, x(ii,:) ); 
end
