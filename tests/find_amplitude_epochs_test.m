% *WAVE*
%
% FIND AMPLIUDE EPOCHS TEST SCRIPT     tests the find amplitude epochs function
%										with some simple exmaple data
%

clear all; clc %#ok<CLSCR>

% generate test data
a = zeros( 1, 1000 );
for ii = 1:4, a( (1:100)+(100*2*ii) ) = 1; end
a = repmat( a, [64 1] ); a = reshape( a, 8, 8, 1000 );

% test find amplitude epochs
epochs = find_amplitude_epochs( a, 0.5 );

% test
assert( all( [epochs.epoch_length] == 100 ), 'durations unequal' )
