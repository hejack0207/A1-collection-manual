# stap\-merge(1) - systemtap per-cpu binary merger



<a name="synopsis"></a>

# Synopsis


```

stap-merge [ OPTIONS ] [ INPUT FILENAMES ]
```


<a name="description"></a>

# Description


The stap-merge executable applies when the -b option has been used 
while running a 
_stap_
script.  The -b option will generate files 
per-cpu, based on the timestamp field. Then stap-merge will 
merge and sort through the per-cpu files based on the timestamp
field.


<a name="options"></a>

# Options


The systemtap merge executable supports the following options.

* **-v**  
  Verbose mode, displays three extra fields per set of collected data.
  .SAMPLE
  **[cpu**number,**sequence**number**of**data,**the**length**of**the**data**set]
  .ESAMPLE
* **-o**_ OUTPUT_FILENAME_  
  
  Specify the name of the file you would like the output to be 
  redirected into.  If this option is not specified than the
  output will be pushed to standard out.
  

<a name="examples"></a>

# Examples

.SAMPLE
$ stap -v -b -e 'probe syscall.open { printf("%s(%d) open\\n",
execname(), pid()) }' 

.ESAMPLE

This should result in several
_stpd_cpu_
files (each labled with a number 
representing which cpu the file was produced from).

.SAMPLE
$ stap-merge -v stpd_cpu0 stpd_cpu1

.ESAMPLE

Running the stap-merge program in the same directory as the stap 
script earlier in the example, will produce an ordered sequence of 
packets with the three part label for each set of data.  This
result will be pushed through the standard output.  An output file 
could have been specified using the "-o" option.


<a name="files"></a>

# Files



* Important files and their corresponding paths can be located in the   
  stappaths (7) manual page.
  

<a name="see-also"></a>

# See Also

.nh
    stapprobes(3stap),
    stappaths(7),
    staprun(8),
    stapvars(3stap),
    stapex(3stap),
    stap-server(8),
    gdb(1)
    

<a name="bugs"></a>

# Bugs

Use the Bugzilla link of the project web page or our mailing list.
.nh
**http://sourceware.org/systemtap/**,**&lt;systemtap@sourceware.org&gt;**.
