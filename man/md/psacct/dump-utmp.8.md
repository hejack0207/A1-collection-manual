# dump_utmp(8) - print a utmp file in human-readable format

Linux accounting system, 2009 December 2


<a name="synopsys"></a>

# Synopsys

**dump-utmp** [**-hrR**] [**-n** &lt;_recs_&gt;] &lt;**files**&gt;
      [**--num** &lt;_recs_&gt;] [**--raw**] [**--reverse**] [**--help**]


<a name="options"></a>

# Options

The following options are supported:

* **-h, --help**  
  Print a help message and the default location of the process accounting file
  and exit.
* **-r, --reverse**  
  Print the output in reverse order.
* **-R, --raw**  
  The records will be printed without any parsing.
* **-n, --num NUMRECS**  
  Display only the first NUMRECS number of records.
  

<a name="see-also"></a>

# See Also

accton (8), lastcomm (1), utmp (5)
