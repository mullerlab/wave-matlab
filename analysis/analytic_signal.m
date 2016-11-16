function [xo] = analytic_signal( x )
% *WAVE*
%
% ANALYTIC SIGNAL    put a datacube into its analytic signal representation
%
% INPUT:
% x - datacube (r,c,t)
%
% OUTPUT:
% xo - output datacube
%

assert( ndims(x) == 3, 'datacube input required' );
[dim1,dim2,dim3] = size(x);

x = reshape( x, [dim1*dim2, dim3] );
xo = hilbert( x' ); xo = xo';
xo = reshape( xo, [dim1,dim2,dim3] );
