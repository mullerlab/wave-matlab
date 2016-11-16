% *WAVE*
%
% PHASE GRADIENT TEST SCRIPT     takes the phase gradient of a test
%                                   test signal (here, a 2d target wave)
%

clear all; clc %#ok<CLSCR>

% parameters
T = 1; %s
Fs = 1000; freq = 13.5; %Hz
image_size = 8; %px
pixel_spacing = 1; %a.u.
direction = +1; % +1/-1

% generate data
xf = generate_rotating_wave( image_size, 1/Fs, T, freq, direction );

% z-score data
xf = zscore_independent( xf );

% form analytic signal
xph = analytic_signal( xf );

% calculate instantaneous frequency 
[wt,signIF] = instantaneous_frequency( xph, Fs );

% calculate phase gradient
[pm,pd,dx,dy] = phase_gradient_complex_multiplication( xph, pixel_spacing, signIF );

% plot resulting vector field
plot_vector_field( exp( 1i .* pd(:,:,100) ), 1 );
