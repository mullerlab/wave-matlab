function [xf] = generate_decay_rotating_wave( image_size, dt, T, ...
                                        frequency, lambda, sigma, varargin )
% *WAVE*
%
% GENERATE DECAY TARGET WAVE TEST DATA     generates a simple test dataset for
%                                           use with the functions in WAVE
%
%             data description:	   a 2d rotating wave with amplitude decay
%
% INPUT
% image size - length of the image square
% dt - sampling period
% T - epoch length
% frequency - oscillation frequency
% lambda - wavelength (in polar coordinate frame)
% sigma - the spatial spread of the decay (from center point)
% varargin{1} - phase offset (sc)
%
% OUTPUT
% xf - test data cube
%

if ~isempty(varargin) 
    phase_offset = varargin{1}; 
    if nargin > 7
        center_point = varargin{2};
    else
        center_point = [floor(image_size/2) floor(image_size/2)];
    end
else
    phase_offset = 0; 
    center_point = [floor(image_size/2) floor(image_size/2)];
end

% distance matrix
[X,Y] = meshgrid( (1:image_size)-center_point(2), ...
                                    (1:image_size)-center_point(1) );
[TH,R] = cart2pol(X,Y);

% time axis 
time = dt:dt:T;

xf = zeros( image_size, image_size, T/dt );
for ii = 1:image_size
    for jj = 1:image_size
   
        xf(ii,jj,:) = ...
            exp( sign(frequency).*1i.*( 2*pi*abs(frequency)*time - 2*pi/lambda*TH(ii,jj) ) );
        
    end
    
end
xf = xf .* exp( 1i .* phase_offset );  
xf = real( xf );

% amplitude mask
gF = 1 * exp( -R.^2 / (2*sigma.^2) );
xf = (1/2) .* ( xf + 1 );
xf = xf .* repmat( gF, [1 1 size(xf,3)] );
