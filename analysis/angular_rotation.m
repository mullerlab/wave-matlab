function [xo] = angular_rotation( xph, angle )
% *WAVE* 
%
% ANGULAR ROTATION     rotates the angular data in the datacube xph a given
%                           angle
%
% INPUT: 
% xph - datacube (r,c,t) (probably complex)
% angle - rotation angle
%
% OUTPUT
% xo - output datacube
%

assert( ndims(xph) == 3, 'datacube input required' );

xo = xph .* exp( 1i * angle );
