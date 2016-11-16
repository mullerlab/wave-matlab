function [cc,pv] = phase_correlation_distance( pl, source, spacing )
% *WAVE*
%
% PHASE CORRELATION DISTANCE    correlation of phase with distance
%                                   (circular-linear), given an input 
%                                   phase map
%
% INPUT
% pl - phase map (r,c)
% source - source point (sc)
% spacing - pixel spacing (sc)
%
% OUTPUT
% cc - circular-linear correlation coefficient, phase correlation w/ distance
% pv - p-value of the correlation (H0: rho == 0, H1: rho != 0)
%

assert( ismatrix(pl), 'data matrix input required' )
assert( ( source(1) <= size(pl,2) ) && ( source(2) <= size(pl,1) ), ...
    'source point out of bounds' )

% make matrix of distances from wave center
[r,c] = size(pl); [X,Y] = meshgrid( (1:c)-source(1), (1:r)-source(2) );
D = sqrt( X.^2 + Y.^2 ); D = D .* spacing;

% flatten, remove NaNs
D = D(:); pl = pl(:); D( isnan(pl) ) = []; pl( isnan(pl) ) = [];

% phase correlation with distance
[ cc, pv ] = circ_corrcl( pl, D );
