function [x] = shuffle_channels( x )
% *WAVE*
%
% SHUFFLE CHANNELS      randomizes the spatial position of channels in a
%                           datacube, so that any spatial autocorrelation
%                           is destroyed while leaving the temporal
%                           structure intact
%
% INPUT: 
% x - original datacube
%
% OUTPUT:
% x - output datacube, with channels shuffled in space
%

assert( ndims(x) >= 2, 'matrix/datacube input required' );

[d1,d2,d3] = size( x );

x = reshape( x, d1*d2, d3 ); 
x = x( randperm( d1*d2 ), : );
x = reshape( x, d1, d2, d3 );
