function [rho,theta] = generate_noisy_oscillator( dt, T, base_amplitude, base_frequency, ...
                                                    amp_noise_sigma, ...
                                                    freq_noise_sigma )
% *WAVE*
%
% GENERATE NOISY OSCILLATOR     generates an oscillation with defined
%                                   amplitude and frequency noise
%
% INPUT
% dt - time step
% T - epoch length
% base_amplitude - A_0
% base_frequency - omega_0
% amp_noise_sigma - standard deviation of amplitude noise
% freq_noise_sigma - standard deviation of frequency noise (Hz)
%
% OUTPUT
% rho - amplitude output
% theta - phase output
%                                           
                                            
time_axis = dt:dt:T;

frequency_vector = base_frequency + freq_noise_sigma.*randn(1,length(time_axis));

rho = base_amplitude + amp_noise_sigma.*randn(1,length(time_axis));
theta = cumtrapz( 2 * pi * frequency_vector * dt );
