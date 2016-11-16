function epochs = find_amplitude_epochs( amp, threshold )
% *WAVE*
%
% FIND AMPLITUDE EPOCHS      locate epochs in a logical datacube, as with
%                               find_epochs()
%
% INPUT
% amp - input datacube (r,c,t)
% threshold - thresholding value, to produce a logical array (sc)
%
% OUTPUT
% epochs - structure with epoch start/end times
%

assert( ndims(amp) == 3, 'datacube input required, amp' )
assert( isscalar(threshold), 'scalar input required, threshold' )

% init
epochs = struct([]); epochs(1).start_time = []; epochs(1).end_time = [];

% threshold the logical array
L = ( amp > threshold );

% loop through L
epoch_found = 0;
epoch_number = 0;

for kk = 1:size(L,3)
    
    if ~all( ~reshape( L( :, :, kk ), 1, [] ) ) % if all NOT zero
        
        if ~epoch_found
            
            epoch_found = 1;
            epoch_number = epoch_number + 1;
            
            epochs(epoch_number).start_time = kk;
            [index_row,index_col] = find( L( :, :, kk ) );
            epochs(epoch_number).index_row = index_row;
            epochs(epoch_number).index_column = index_col;
            
        elseif epoch_found
            
            % do nothing
            
        end
        
    elseif all( ~reshape( L( :, :, kk ), 1, [] ) ) % if all zero
        
        if epoch_found
            
            epochs(epoch_number).end_time = kk - 1;
            epoch_found = 0;
            
        end
        
    end
    
end

% calculate durations
for ii = 1:length(epochs)
    
    epochs(ii).epoch_length = length( epochs(ii).start_time:epochs(ii).end_time );
    
end

