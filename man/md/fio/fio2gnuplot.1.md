# fio2gnuplot(1)

August 2013

**fio2gnuplot **- Render fio's output files with gnuplot

<a name="synopsis"></a>

# Synopsis

    .fam C
    fio2gnuplot [-ghbiodvk] [-t title] [-o outputfile]
                   [-d output_dir] [-p pattern]
                   [-G type] [-m min_time] [-M max_time]
    
    .fam T
```
.fam T
```

<a name="description"></a>

# Description

**fio2gnuplot** analyze a set of fio's log files to turn them into a set of graphical traces using gnuplot tool.
Several flavor of plotting are produced

* .B  
  Individual 2D Graph
  Each file is plotted in a separate image file with several option
    * ·  
      raw : Plot the exact reported performance. This plotting could be difficult to read
    * ·  
      smooth :a smoother version of the raw print
      Using csplines option of gnuplot, the rendering is
      filtered to get an easier to read graph.
    * ·  
      trend : an even smoother version of the raw print to get trends
      Bezier's curves makes much more filtered plots
      The resulting graph helps at understanding trends.
* .B  
  Grouped 2D graph
  All files are plotted in a single image to ease the comparaison. The same rendering options as per the individual 2D graph are used :
    * ·  
      raw
    * ·  
      smooth
    * ·  
      trend
* .B  
  Grouped 3D graph
  All files are plotted into a single 3D graph.
  The 3D plotting generates a 'surface' to estimate how close were
  the performance.
  A flat surface means a good coherency between traces.
  A rugged surface means a lack of coherency between traces
* .B  
  Mathemical Plotting
    * .B  
      Average graph
      A bar graph to show the average performance of each file.
      A green line is added to show the global average performance.
      This green line helps at understanding how far from the average is
      every individual file.
    * .B  
      Min graph
      A green line is added to show the global average of minimal performance.
      This green line helps at understanding how far from the average is
      every individual file.
    * .B  
      Max graph
      A bar graph to show the maximum performance of each file.
      A green line is added to show the global average of maximal performance.
      This green line helps at understanding how far from the average is
      every individual file.
    * .B  
      Standard Deviation
      A bar graph to show the standard deviation of each file.
      A green line is added to show the global average of standard deviation.
      This green line helps at understanding how far from the average is
      every individual file.

<a name="options"></a>

# Options


* .B  
  **-h** or **--help**
  The option **-h** displays help
* .B  
  **-p** '_pattern_' or --_pattern_ '_pattern_'
  A _pattern_ in regexp to select fio input files.
  Don't forget the simple quotes to avoid shell's interactions
* .B  
  **-b** or **--bandwidth**
  A predefined _pattern_ for selecting *_bw.log files
* .B  
  **-i** or **--iops**
  A predefined _pattern_ for selecting *_iops.log files
* .B  
  **-g** or **--gnuplot**
  Render gnuplot traces before exiting
* .B  
  **-o** file or --_outputfile_ file
  The basename for gnuplot traces (set with the _pattern_ if defined)
* .B  
  **-d** dir or **--outputdir** dir
  The directory where gnuplot shall render files.
* .B  
  **-t** _title_ or --_title_ _title_
  The _title_ of the gnuplot traces.
  Title is set with the block size detected in fio trace
* .B  
  **-G** _type_ or **--Global** _type_
  Search for '_type_' in .global files match by a _pattern_.
  Available types are : min, max, avg, stddev.
  The .global extension is added automatically to the _pattern_
* .B  
  **-m** time or --_min\_time_ time
  Only consider data starting from 'time' seconds. Default is 0
* .B  
  **-M** time or --_max\_time_ time
  Only consider data ending before 'time' seconds. Default is **-1** aka nolimit
* .B  
  **-v** or **--verbose**
  Increasing verbosity
* .B  
  **-k** or **--keep**
  Keep all temporary files from gnuplot's output dir

<a name="example"></a>

# Example


* .B  
  To plot all the traces named like 'host*_read_4k_iops.log'
  $ **fio2gnuplot** **-p** 'host*_read_4k_iops.log' **-g**
* .B  
  To plot all IO oriented log files from the current directory
  $ **fio2gnuplot** **-g** **-i**
* .B  
  To plot all Bandwidth oriented log files from the current directory
  $ **fio2gnuplot** **-g** **-b**
* .B  
  To plot all Bandwidth oriented log files in a directory name 'outdir'
  $ **fio2gnuplot** **-g** **-b** **-d** outdir

<a name="author"></a>

# Author

Erwan Velu &lt;[erwan@enovance.com](mailto:erwan@enovance.com)&gt;
