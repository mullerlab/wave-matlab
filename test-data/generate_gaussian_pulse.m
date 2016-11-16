function [xf] = ...
	generate_gaussian_pulse( image_size, dt, T, amplitude, frequency, sigma, varargin )
% *WAVE*
%
% GENERATE GAUSSIAN PULSE     generates a simple test dataset, following
%                               the model of a space-time separable
%                               Gaussian pulse.
%
%                             f(x,t) = g(x) * h(t), where
%                               
%                                    g(x) = exp(-(x-x_0)^2/2*sigma^2)
%                                    h(t) = A*sin(2*pi*f*t)
%
% INPUT
% image size - length of the image square
% dt - sampling period
% T - epoch length
% amplitude - oscillation amplitude
% frequency - oscillation frequency
% sigma - standard deviation of the gaussian
%
% OUTPUT
% xf_movie - the movie of the gaussian pulse
%

if ~isempty(varargin), phase_offset = varargin{1}; else phase_offset = 0; end;

gaussianFilter = fspecial( 'gaussian', image_size, sigma );
gaussianFilter = gaussianFilter ./ max(gaussianFilter(:));

% distance matrix
[X,Y] = meshgrid( (1:image_size)-floor(image_size/2), ...
                                    (1:image_size)-floor(image_size/2) );
D = sqrt( X.^2 + Y.^2 );

freq_sign = sign(frequency);
xf = zeros( image_size, image_size, T/dt );
time = dt:dt:T;
for ii = 1:image_size
    for jj = 1:image_size
   
        xf(ii,jj,:) = gaussianFilter(ii,jj) .* ...
        		exp( sign(frequency) .*1i.*( 2*pi*abs(frequency)*time ) );
        
    end
    
end
xf = xf .* exp( 1i .* phase_offset );  
xf = real( xf );
