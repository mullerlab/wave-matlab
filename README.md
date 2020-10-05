# **wave**: spatiotemporal analysis of noisy multisite data #

**wave** is a MATLAB toolbox for unsupervised analysis and visualization of noisy multisite data. Originally developed for multichannel recordings in neuroscience, where both optical imaging and multielectrode data are increasingly common, the functions in **wave** are general and will be applicable to multisite data in biology, ecology, climatology, and experimental physics. Installation is straightforward via the *pathtool* utility, and with accessible and standard data structures, the toolbox will be easy to integrate into existing MATLAB analysis code.

## Install

Run *pathtool*, or write the **wave** directory directly into the MATLAB path with the functions *addpath* and *genpath*.

## Usage

Consider a datacube **X**, where the first two dimensions index space and the third indexes time (with sampling frequency *Fs*): 

<p align="center">
	<img src="https://mullerlab.ca/assets/img/gp-demo/datacube.png">
</p>

A sample analysis workflow may be:

    >> x = bandpass_filter( x, lowpass_cutoff, hipass_cutoff, filter_order, Fs );
    >> x = zscore_independent( x );
    >> X = analytic_signal( x );  % X now contains the "analytic signal"
    >> a = abs( X );  % a contains the "amplitude envelope" at each point in time
    >> p = angle( X );  % p now contains the "phase maps"
    >> f = instantaneous_frequency( a, Fs ); % f contains "instantaneous frequency"

The user would then be ready to detect waves at specified timepoints in the data by using the phase maps as input to the relevant function (e.g. *phase_correlation_distance*, *phase_correlation_rotation*).

## Dependencies

The functions in this repository depend on [CircStat](http://bethgelab.org/software/circstat) by Philipp Berens and [export_fig](http://github.com/altmany/export_fig) by Yair Altman.

## Testing

Tested on MATLAB under OSX and Linux.

## Citing **wave**

If you publish work using or mentioning **wave**, I would greatly appreciate if you would cite our paper ([bibtex](http://cnl.salk.edu/~lmuller/papers/P12.bib)):

[Muller L, Piantoni G, Koller D, Cash SS, Halgren E, Sejnowski TJ (2016) Rotating waves during human sleep spindles organize global patterns of activity that repeat precisely through the night. *eLife* 5: e17267.](http://elifesciences.org/content/5/e17267)

## Developer

[Lyle Muller](http://mullerlab.ca) (Western University)
