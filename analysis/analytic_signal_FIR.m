function [xo] = analytic_signal_fir( x )
% *WAVE*
%
% ANALYTIC SIGNAL FIR   returns the analytic signal representation
%                           using FIR filter implementation
%
% INPUT:
% x - datacube (r,c,t)
%
% OUTPUT:
% xo - output datacube
%

assert(ndims(x) == 3,'datacube input required');
[dim1,dim2,dim3] = size(x);

% filter design
N = 231 - 1;
Hb = firpm( N, [.02 .98], [1 1], 'Hilbert' );

assert( rem(N,2) == 0, 'even filter order required' )

% init
x = reshape( x, [dim1*dim2, dim3] );
xo = zeros( size(x) );

for ii = 1:size(x,1)
    xo(ii,:) = [zeros(1,N/2) x(ii,(1:size(x(ii,:),2)-(N/2)) )] + ...
                                                1i*filter( Hb, 1, x(ii,:) );
end
xo = reshape( xo, [dim1,dim2,dim3] );
