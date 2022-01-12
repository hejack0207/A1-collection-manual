# fio_generate_plots(1) - Generate plots for Flexible I/O Tester

May 19, 2009

```
fio_generate_plots  title

```

<a name="description"></a>

# Description

This manual page documents briefly the
**fio_generate_plots**
command. This manual page was written for the Debian distribution
because the original program does not have a manual page.




**fio\_generate\_plots** is a shell script that uses gnuplot to
generate plots from fio run with --latency-log (-l) and/or 
--bandwidth-log (-w). It expects the log files that fio
generated in the current directory.

<a name="options"></a>

# Options

The script takes the title of the plot as only argument. It does
not offer any additional options.

<a name="author"></a>

# Author

fio_generate_plots was written by Jens Axboe &lt;[axboe@kernel.dk](mailto:axboe@kernel.dk)&gt;

This manual page was written by Martin Steigerwald &lt;[ms@teamix.de](mailto:ms@teamix.de)&gt;,
for the Debian project (but may be used by others).
