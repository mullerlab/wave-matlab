function [xf] = generate_plane_wave( image_size, dt, T, ...
                                        frequency, lambda, orientation, varargin )
% *WAVE*
%
% GENERATE PLANE WAVE TEST DATA     generates a simple test dataset for
%                                           use with the functions in WAVE
%
%             data description:     a 2d plane wave
%
% INPUT
% image size - length of the image square
% dt - sampling period
% T - epoch length
% frequency - oscillation frequency
% lambda - wavelength (in polar coordinate frame)
% orientation - orientation angle (0, 2pi)
% varargin{1} - phase offset (sc)
%
% OUTPUT
% xf - the movie of the plane wave
%

if ~isempty(varargin), phase_offset = varargin{1}; else phase_offset = 0; end;

% X,Y coordinate matrices
[X,Y] = meshgrid( (1:image_size)-floor(image_size/2), ...
                                    (1:image_size)-floor(image_size/2) );
M = zeros( size(X) );
R = [ cos(orientation) -sin(orientation); sin(orientation) cos(orientation) ];
for ii = 1:image_size
	for jj = 1:image_size

		tmp_M = R * [ X(ii,jj) Y(ii,jj) ]';
        M(ii,jj) = tmp_M(1);
        
	end
end


xf = zeros( image_size, image_size, T/dt );
time = dt:dt:T;
for ii = 1:image_size
    for jj = 1:image_size
   
        xf(ii,jj,:) = sin( 2*pi*frequency*time - 2*pi/lambda*M(ii,jj) + ...
                                                            phase_offset );
        
    end
    
end
