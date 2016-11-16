function [cc,pv,center_point] = phase_correlation_rotation( pl, cl, center_point, varargin )
% *WAVE*
%
% PHASE CORRELATION ROTATION    correlation of phase with rotation angle
%                                   theta (circular-circular), given the curl
%                                   of the phase gradient vector field
%
% INPUT
% pl - phase field (r,c)
% cl - curl field (r,c)
% center_point - center point (x,y) (optional, can be empty)
% varargin{1} - signIF
%
% OUTPUT
% cc - circular-circular correlation coefficient, phase w/ rotation about curl point
% pv - p-value of the correlation (H0: rho == 0, H1: rho != 0)
%

assert( ( ismatrix(pl) & ismatrix(cl) ), 'data matrix input required, pl cl' )

% parse inputs
if isempty( center_point )
	center_point = zeros( 1, 2 );
    [center_point(2),center_point(1)] = find( abs(cl) == max(abs(cl(:))), 1, 'first' );
end

if ( nargin > 3 )
	assert( (varargin{1}==1) || (varargin{1}==(-1)), 'IF sign must be +1 or -1' )
	signIF = varargin{1};
else
	signIF = 1;
end

% make matrix of distances from curl point
[X,Y] = meshgrid( (1:size(pl,2))-center_point(1), (1:size(pl,1))-center_point(2) );
[T,~] = cart2pol( X, Y );

% flatten, remove NaNs
T = T(:); pl = pl(:); T( isnan(pl) ) = []; pl( isnan(pl) ) = [];

% phase correlation with distance
[ cc, pv ] = circ_corrcc( pl, T );

% return correct sign (right-handed coordinate system)
cc = -signIF .* cc;
