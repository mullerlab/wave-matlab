function epoch_movie( ...
    x, row, col, color_axis, plot_axis, Fs, save_option, normalized_flag, bound )
% *WAVE*
%
% EPOCH MOVIE    image/surface animation of a wave propagation epoch
%
% INPUT:
% x - datacube (r,c,t)
% row - row in x for channel plot
% col - column in x for channel plot
% color_axis - caxis for imagesc plot [lo hi]
% plot_axis - range for the line plot [lo hi]
% Fs - sampling frequency (s) Hz
% save_option - either plot or save the files
%
% OUTPUT
% animated plot
%

% init
assert( ndims(x) == 3, 'datacube input required' );
if nargin > 7,
    if strcmp( normalized_flag, 'normalized' ), norm_flag=1; else norm_flag=0; end
else norm_flag = 0;
end 

timvec = (1/Fs):(1/Fs):(size(x,3)/Fs);

f1 = figure;set( f1, 'position', [1512 199 455 505] )
h1 = subplot(211);h2 = subplot(212);
set( h1, 'position', [0.0465    0.0350    0.8436    0.6091] )
set( h2, 'position', [0.4549    0.7347    0.4830    0.2412] )

set( f1, 'currentaxes', h1 );
image_plot = imagesc( x(:,:,1) );hold on;
cb = colorbar;
set( cb, 'position', [0.9011    0.4951    0.0286    0.1360] )
set( get(cb,'ylabel'), 'string', 'z-score' )
if norm_flag;
    set( cb, 'ytick', [-1 0 1] );
    set( get(cb,'ylabel'), 'string', 'norm. amplitude' )
end
    
set( h1, 'fontname', 'arial', 'fontsize', 14 )
set( h2, 'fontname', 'arial', 'fontsize', 13 )

set( gca, 'xtick', [] );set( gca, 'ytick', [] )
caxis( color_axis );axis image;colormap bone;
plot( col, row, 'r.', 'markersize', 40 );

if nargin > 8
    [yc,xc] = find( bwconvhull( bound ) ); K = convhull( xc, yc );
    plot( xc(K), yc(K), 'color', [.75 .75 .75] )
end    

set( f1, 'currentaxes', h2 );hold on; box on
plot( timvec, reshape( x, size(x,1)*size(x,2), [] )', ...
    'color', [.7 .7 .7], 'linewidth', 1 );
plot( timvec, reshape( x(row,col,:), 1, [] ), 'k', 'linewidth', 2 );
dot_plot = plot( timvec(1), x(row,col,1), 'r.', 'markersize', 20 );
ylim( plot_axis );xlim( [timvec(1) timvec(end)] );
xlabel( 'time (s)' );ylabel( 'z-score' );

if norm_flag;set( gca, 'ytick', [-1 0 1] );ylabel( 'norm. amplitude' );end

for ii = 1:size(x,3)

    set( f1, 'currentaxes', h1 );hold on
    set( image_plot, 'cdata', x(:,:,ii) )
    set( f1, 'currentaxes', h2 );hold off;
    set( dot_plot, 'xdata', timvec(ii) );
    set( dot_plot, 'ydata', x(row,col,ii) );
    
    if save_option == 0
        pause(.01)
    elseif save_option == 1
        export_fig( ...
           sprintf( './frame_%03d.jpg', ii ), '-r150', '-nocrop', '-transparent' )
    end
        
end

