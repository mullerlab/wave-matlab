% *WAVE*
%
% PLOT VECTOR FIELD DISTRIBUTION     unit test for the vector field plotting 
%										functions
% 12 january 2016
%

clear all; clc %#ok<CLSCR>

% parameters
rotation_sign = -1; alpha = 1;
center_point = [ 4 4 ];

% generate coordinate system
[XX,YY] = meshgrid( 1:8, 1:8 ); 
[X,Y] = meshgrid( (1:8)-center_point(1), (1:8)-center_point(2) );
[T,R] = cart2pol( X, Y );

% generate vector field (as complex values)
phi = exp( 1i*( T + alpha.*(R./max(R(:))) ) ) .* exp( 1i*(pi/2) );

% plot vector field
plot_vector_field( phi, 1 );
