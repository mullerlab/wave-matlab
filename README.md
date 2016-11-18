# **wave**: analysis of spatiotemporal dynamics in noisy multisite data #

**wave** is a MATLAB toolbox for analysis and visualization of noisy multisite data. Originally developed for multichannel recordings in neuroscience, where both optical imaging and multielectrode data are increasingly common, the functions in **wave** are general and will be applicable to multisite data in biology, ecology, climatology, and experimental physics. Installation should be easy and straightforward via the *pathtool* utility, and with accessible and standard data structures, the toolbox will be easy to integrate into existing MATLAB analysis code.

Install
========

Run *pathtool*, or write the **wave** directory directly into the MATLAB path with the functions *addpath* and *genpath*.

Usage
========

Consider a datacube *x*, where the first two dimensions index space and the third indexes time (with sampling frequency *Fs*). A sample analysis workflow may be:

    >> x = bandpass_filter( x, lowpass_cutoff, hipass_cutoff, filter_order, Fs );
    >> x = zscore_independent( x );
    >> X = analytic_signal( x );  % X now contains the "analytic signal"
    >> a = abs( X );  			  % a contains the "amplitude envelope" at each point in time
    >> p = angle( X );  		  % p now contains the "phase maps"
    >> f = instantaneous_frequency( a, Fs ); % f contains "instantaneous frequency"

The user would then be ready to detect waves at specified timepoints in the data by using the phase maps as input to the relevant function (e.g. *phase_correlation_distance*, *phase_correlation_rotation*).

Dependencies
========

CircStat by Philipp Berens (http://bethgelab.org/software/circstat)

export_fig by Yair Altman (http://github.com/altmany/export_fig)

Testing
========

Tested on MATLAB R2014b (8.4.0.150421) under OSX

Citing **wave**
========

If you publish work using or mentioning **wave**, I would greatly appreciate if you would cite our paper ([bibtex](http://cnl.salk.edu/~lmuller/papers/P12.bib)):

[Muller L, Piantoni G, Koller D, Cash SS, Halgren E, Sejnowski TJ (2016) Rotating waves during human sleep spindles organize global patterns of activity that repeat precisely through the night. *eLife* 5: e17267.](http://elifesciences.org/content/5/e17267)

Developer
========

Lyle Muller @ Salk Institute for Biological Studies

cnl.salk.edu/~lmuller
