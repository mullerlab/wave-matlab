function [pm,pd,dx,dy] = ...
    phase_gradient_complex_multiplication( xph, pixel_spacing, varargin )
% *WAVE*
%
% PHASE GRADIENT COMPLEX MULTIPLICATION     take the gradient of the phase maps,
%                                             returning datacubes of direction
%                                             and magnitude
%
%                   For a 2D analytic signal V_{x,y} = v_{x,y} + iHb[v_{x,y}],
%
%                   and V_{x,y} = A_{x,y} exp( i \Phi{x,y} )
%
%                   \nabla Phi ≡ ∂Phi/∂x + ∂Phi/∂y
%
%                   ∂Phi/∂x ≈ \delta Phi_x = Arg( V_{x,y} V*_{x+1,y} )
%
%                       and
%
%                   ∂Phi/∂y ≈ \delta Phi_y = Arg( V_{x,y} V*_{x,y+1} )
%
%                   where * indicates complex conjugate.
%
%                   Reference: Feldman (2011) Hilbert Transform
%                       Applications in Mechanical Vibration.
%                       Algorithm 3, p. 18.
%
% INPUT
% xph - analytic signal representation of the datacube (r,c,t)
% pixel_spacing - pixel spacing
% signIF - instantaneous frequency sign (+1/-1, optional)
%
% OUTPUT
% pm - phase gradient magnitude
% pd - phase gradient direction
% dx - gradient component in the x-direction
% dy - gradient component in the y-direction
%

assert( ndims(xph) >= 2, 'matrix/datacube input required' );

% parse inputs
if nargin < 2, signIF = 1;, else signIF = varargin{1}; end

% init
pm = zeros( size(xph) ); pd = zeros( size(xph) );
dx = zeros( size(xph) ); dy = zeros( size(xph) );
dim = size(xph);

for tt = 1:size(xph,3)
    
    %%% dx
    tmp_dx = zeros( size(xph(:,:,1)) );
    
    % forward differences on left and right edges
    tmp_dx(:,1) = angle( xph(:,2,tt) .* conj( xph(:,1,tt) ) ) ./ pixel_spacing; 
    tmp_dx(:,dim(2)) = angle( xph(:,dim(2),tt) .* conj( xph(:,dim(2)-1,tt) ) ) ./ pixel_spacing; 
    
    % centered differences on interior points
    tmp_dx(:,2:dim(2)-1) = ...
        angle( xph(:,3:dim(2),tt) .* conj( xph(:,1:dim(2)-2,tt) ) ) ./ (2*pixel_spacing); 
    
    % save dx
    dx(:,:,tt) = -signIF .* tmp_dx;

    %%% dy
    tmp_dy = zeros( size(xph(:,:,1)) );
    
    % forward differences on top and bottom edges
    tmp_dy(1,:) = angle( xph(2,:,tt) .* conj( xph(1,:,tt) ) ) ./ pixel_spacing; 
    tmp_dy(dim(1),:) = angle( xph(dim(1),:,tt) .* conj( xph(dim(1)-1,:,tt) ) ) ./ pixel_spacing; 
    
    % centered differences on interior points
    tmp_dy(2:dim(1)-1,:) = angle( xph(3:dim(1),:,tt) .* conj( xph(1:dim(1)-2,:,tt) ) ) ./ (2*pixel_spacing); 

    % save dy
    dy(:,:,tt) = -signIF .* tmp_dy;
    
end

pm = sqrt( dx.^2 + dy.^2 ) ./ (2*pi);
pd = atan2( dy, dx );
