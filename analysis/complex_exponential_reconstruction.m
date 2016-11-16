function [xn] = complex_exponential_reconstruction( amplitude, phase )
% *WAVE*
%
% COMPLEX EXPONENTIAL RECONSTRUCTION    reconstructs a real-valued datacube
%                                       from its instantaneous amplitudes
%                                       and phases
%
%                                       N.B. the x2 gain modulation of the
%                                       Hilbert transform is explicitly
%                                       accounted for here by the amp/2
%                                       factor
%
% INPUT
% amplitude - instantaneous amplitudes
% phases - instantaneous phases
%
% OUTPUT
% xn - reconstructed datacube (r,c,t)
%

assert( ndims(amplitude) == 3, 'datacube input required' );
assert( ndims(phase) == 3, 'datacube input required' );

xn = amplitude .* cos( phase );
