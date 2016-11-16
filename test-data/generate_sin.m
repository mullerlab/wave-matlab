function [xf] = generate_sin( dt, T, frequency, phase_angle )
% *WAVE*
%
% GENERATE SINE WAVE TEST DATA     generates a simple test sine wave for
%                                       use with the functions in WAVE
%
%
% INPUT
% dt - timestep
% T  - epoch length (s)
% frequency - frequency
% (optional) phase_angle - phase_angle
%
% OUPTUT
% xf - output test data
%

x = dt:dt:T;

if nargin == 3
    xf = sin(2*pi*frequency*x);
elseif nargin > 3
    xf = sin(2*pi*frequency*x + phase_angle);
end
