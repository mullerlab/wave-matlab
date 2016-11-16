function [xf] = generate_alpha_damped_sin( dt, T, frequency, tau, phase_angle )
% *WAVE*
%
% GENERATE ALPHA DAMPED SINE WAVE TEST DATA     generates a simple test damped 
%                                                   sine wave for use with the 
%                                                   functions in WAVE
%
%
% INPUT
% dt - timestep
% T  - epoch length (s)
% frequency - frequency
% tau - decay time constant
%
% OUPTUT
% xf - output test data
%

x = dt:dt:T;

if nargin == 4
    xf = ( (exp(1)/tau) .* x ) .* exp(-x/tau) .* sin(2*pi*frequency*x);
elseif nargin > 4
    xf = ( (exp(1)/tau) .* x ) .* exp(-x/tau) .* sin(2*pi*frequency*x + phase_angle);
elseif nargin < 4
    error('Wrong number of inputs')
end
