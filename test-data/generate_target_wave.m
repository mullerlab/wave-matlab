function [xf] = generate_target_wave( image_size, dt, T, frequency, lambda, varargin )
% *WAVE*
%
% GENERATE TARGET WAVE TEST DATA     generates a simple test dataset for
%                                           use with the functions in WAVE
%
%             data description:    a 2d target wave
%
% INPUT
% image size - length of the image square
% dt - sampling period
% T - epoch length
% frequency - oscillation frequency
% lambda - wavelength
% varargin{1} - phase offset (sc)
%
% OUTPUT
% xf - test data cube
%

if ~isempty(varargin), phase_offset = varargin{1}; else phase_offset = 0; end;

% distance matrix
[X,Y] = meshgrid( (1:image_size)-floor(image_size/2), ...
                                    (1:image_size)-floor(image_size/2) );
D = sqrt( X.^2 + Y.^2 );

freq_sign = sign(frequency);
xf = zeros( image_size, image_size, T/dt );
time = dt:dt:T;
for ii = 1:image_size
    for jj = 1:image_size
   
        xf(ii,jj,:) = ...
        	exp( sign(frequency) .*1i.*( 2*pi*abs(frequency)*time - 2*pi/lambda*D(ii,jj) ) );
        
    end
    
end
xf = xf .* exp( 1i .* phase_offset );  
xf = real( xf );
