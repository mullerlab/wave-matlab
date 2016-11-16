function [ft,signIF] = instantaneous_frequency( xph, Fs )
% *WAVE*
%
% INSTANTANEOUS FREQUENCY  returns the instantaneous frequency estimation
%                          from the formula:
%
%           d(Psi)/dt = \Delta(Psi_n)/dt = Arg(X_{n+1}*X_{n})/dt   (2.11)
%
%                           where X is the analytic signal of x.
%
%                           Given in: Feldman (2011) Hilbert Transform
%                                     Applications in Mechanical Vibration.
%                                     Algorithm 3, p. 18.
%
%                           Which allows direct computation of the IF, 
%                           without phase unwrapping. 
%
% INPUT: 
% xph - analytic signal representation of x (r,c,t)
% Fs - sampling frequency
%
% OUTPUT:
% ft - instantaneous frequency (r,c,t),  N.B. ft(:,:,end) == zeros( r, c )
% signIF - instantaneous frequency sign
% 

assert( ndims(xph) == 3, 'datacube input required' );

thresh_tol = 0.9;

ft = zeros( size(xph) );
ft(:,:,1:end-1) = angle( xph(:,:,2:end) .* conj( xph(:,:,1:end-1) ) ) ./ (2*pi/Fs);

if ( sum( ft(ft~=0) > 0 ) / numel( ft(ft~=0) ) ) > thresh_tol			 % positive frequency
	signIF = +1; 
elseif ( sum( ft(ft~=0) < 0 ) / numel( ft(ft~=0) ) ) > thresh_tol		 % negative frequency
	signIF = -1; 
else 																	 % mixed/indeterminate
	signIF = NaN;
end
