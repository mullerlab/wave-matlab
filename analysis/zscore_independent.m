function [xo] = zscore_independent( x )
% *WAVE*
%
% ZSCORE INDEPENDENT  returns the z-score of each channel in the datacube
%
% INPUT
% x - datacube (r,c,t)
%
% OUTPUT
% xo - z-scored datacube (r,c,t)
%

assert( ndims(x) == 3, 'datacube input required' );

% get matrices of mean and std
mu = mean( x, 3 ); sigma = std( x, [], 3 );
mu = repmat( mu, [1 1 size(x,3)] ); sigma = repmat( sigma, [1 1 size(x,3)] );

% make z-score
xo = ( x - mu ) ./ sigma;
