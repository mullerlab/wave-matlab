function play_movie( x, varargin )
% *WAVE*
%
% PLAY MOVIE    image/surface animation of the input datacube
%
% INPUT:
% x - datacube (r,c,t)
%
% -- optional string-identified arguments:
%
% plot_method - choose either imagesc or surf plot
% color_range - z-axis scale
% time_range - sample numbers to plot
% ydir - y-direction for the plot
% pause_duration - duration between frames
%
% OUTPUT
% animated plot
%

assert( ndims(x) == 3, 'datacube input required' );

% default parameter structure
def.plot_method = 'imagesc';                % imagesc | surf | dots
def.color_range = [min(x(:)) max(x(:))];
def.time_range = [1 size(x,3)];
def.ydir = 'normal';                        % normal | reverse
def.pause_duration = 0.05;                  % controls frame rate

% parse input parameters
parserObj = inputParser;
parserObj.FunctionName = 'play_movie';
if ~isempty(varargin)
    
    parserObj.addOptional( 'plot_method', def.plot_method );
    parserObj.addOptional( 'color_range', def.color_range );
    parserObj.addOptional( 'time_range', def.time_range );
    parserObj.addOptional( 'ydir', def.ydir );
    parserObj.addOptional( 'pause_duration', def.pause_duration );
    
    parserObj.parse(varargin{:});
    opt = parserObj.Results;
    
else
    
    % take the defaults
    opt = def;
    
end

assert( isvector( opt.time_range ), 'vector input required for time vector' )

% color range
if ( ( length( opt.time_range ) ~= size(x,3) ) && ( isequal( opt.color_range, def.color_range ) ) )
    
    opt.color_range = [ min( reshape(x(:,:,opt.time_range(1):opt.time_range(2)),1,[]) ) ...
        max( reshape(x(:,:,opt.time_range(1):opt.time_range(2)),1,[]) ) ];
    
end

% plotting method
if strcmp( opt.plot_method, 'imagesc' )
    
    image_plot = imagesc( x(:,:,opt.time_range(1)) );
    axis image; caxis(opt.color_range); colormap('bone'); axis on
    set( gca, 'ydir', opt.ydir )
    for ii = opt.time_range(1):opt.time_range(2)
        
        set( image_plot, 'cdata', x(:,:,ii) )
        str = sprintf( '%d', ii ); title(str)
        pause( opt.pause_duration ); % defines the frame rate
        
    end
    
elseif strcmp( opt.plot_method, 'surf' )
    
    h1 = surf( x(:,:,opt.time_range(1)) ); 
    zlim(opt.color_range); caxis(opt.color_range); 
    view( [45 45] ); colorbar; colormap( 'bone' )
    for ii = opt.time_range(1):opt.time_range(2)
        
        set( h1, 'zdata', x(:,:,ii) )
        pause( opt.pause_duration );
        
    end
    
elseif strcmp( opt.plot_method, 'dots' )
    
    [X1,X2] = meshgrid( 1:size(x,2), 1:size(x,1) );
    
    for ii = opt.time_range(1):opt.time_range(2)
        
        plot3( X1, X2, x(:,:,ii), 'k.', 'markersize', 20 );
        zlim( opt.color_range ); caxis(opt.color_range); view( [45 45] ); grid on
        pause( opt.pause_duration );
        
    end
    
end

