% *WAVE*
%
% INSTANTANEOUS FREQUENCY TEST     unit test for the instantaneous frequency
%										calculation
% 13 january 2016
%

clear all; clc %#ok<CLSCR>

% parameters
dt = .001; T = 1; frequency = 3; phase_angle = 0;

% generate data
time = dt:dt:T;
xf = cos( 2*pi*frequency*time + phase_angle );

% analytic signal representation
xph = hilbert( xf );

% instantaneous frequency calculation
ft = zeros( size(xph) );
ft(1:end-1) = angle( xph(2:end) .* conj( xph(1:end-1) ) ) ./ (2*pi*dt);

% demo plot
fg1 = figure; hold on; box on
set( gca, 'fontname', 'arial', 'fontsize', 16, 'linewidth', 2 )
set( fg1, 'position', [1848 327 976 358] )
h1 = plot( time, xf, 'linewidth', 2 );
h2 = plot( time, angle(xph) ./ pi, 'linewidth', 2 );
xlabel( 'Time (s)' );

% printout
numerical_tolerance = 1e-10;
sprintf( 'fraction of IF measurements within set tolerance: %0.2f', ...
	sum( ( ft(1:end-1)>(frequency-numerical_tolerance) ) & ...
		 ( ft(1:end-1)<(frequency+numerical_tolerance) ) ) ./ numel( ft(1:end-1) ) )

le = legend( [h1 h2], { 'Test signal (a.u.)', 'Oscillation phase (1/\pi rad)' } );
set( le, 'position', [ 0.6956 0.1819 0.1865 0.1253 ] )
