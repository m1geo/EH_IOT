#Energy Harvesting For The Internet-of-Things: Measurements And Probability Models (Analysis)

The analysis folder contains Matlab code which takes CSV files produced by the Arduino, filters the data, and provides analysis as found in the paper.

The plot_fits.m file will take the sorted and trimmed data and plots the fits found in the `fits` folder.

optimise_{solar,piezo}_gs take the filterd and trimmed CSV files and use `gaoptimset` to fit the curves.

`make_analyse_spaces.m` and `remove_spaces.m` along with similarly named scripts trim and filter the raw data.

Other files are either to automate the process, since the computation takes a while, and I could let it run while I was going home, or are support files.

`min_kl.m` and `KLDiv.m` are the minimising (for the GA) and calculation scripts for KL-Divergence.

The other files are for taking the raw CSV files from the data-logger (see ../Testbed folder), removing inactive periods. Some of the scripts are not useful, since the raw processing has been done and only the trimmed tidied datafiles are presented here.

They should be easy enough to follow, and any functions can be checked on the Mathworks site.
