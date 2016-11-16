function [xph] = rectify_rotation( xph )
% *WAVE*
%
% RECTIFY ROTATION      rectifies the sign of rotation in the complex plane,
%                           so that the resulting datacube has rotation in
%                           the positive-frequency direction 
%
% INPUT: 
% xph - analytic signal representation of x (r,c,t)
%
% OUTPUT:
% xph - rectified analytic signal datacube (r,c,t)
%           with rotation in the positive direction
%

assert( ndims(xph) == 3, 'datacube input required' );

tolerance_threshold = 0.975;

% determine IF sign (above tolerance threshold)
sign_if = sign( diff( unwrap(angle(xph),[],3), 1, 3 ) );
sign_if( ~isfinite(sign_if) ) = [];
prc_if_sign = sum( sign_if(:) < 0 ) / numel( sign_if );
if ( prc_if_sign > tolerance_threshold ), sign_if = -1; else sign_if = 1; end

% reconstruct 
modulus = abs( xph ); ang = sign_if .* angle( xph );
xph = modulus .* exp( 1i .* ang );
