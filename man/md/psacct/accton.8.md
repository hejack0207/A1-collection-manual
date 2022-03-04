# accton(8) - turns process accounting on or off

2008 November 24

```
.na .TP accton [\|OPTION\|] on\||\|off\||\|filename .TP accton [ -V | --version  ] [ -h | --help ]
```

<a name="description"></a>

# Description


**accton**
_filename_
turns on process accounting.

<a name="options"></a>

# Options


* * **-V, --version**  
  Print the version number of 
  **ac**
  to standard output and quit.
* **-h, --help**  
  Prints the usage string and default locations of system files to
  standard output and exits.
* **on**  
  Turns on process accounting using the default accounting file name.
* **off**  
  Turns off process accounting.

<a name="files"></a>

# Files


* _acct_  
  The system wide process accounting file. See
  **acct**(5)
  (or
  **pacct**(5))
  for further details.


<a name="author"></a>

# Author

The GNU accounting utilities were written by Noel Cragg
&lt;[noel@gnu.ai](mailto:noel@gnu.ai).mit.edu&gt;. The man page was adapted from the accounting
texinfo page by Susan Kleinmann &lt;[sgk@sgk.tiac](mailto:sgk@sgk.tiac).net&gt;.

<a name="see-also"></a>

# See Also

**acct**(5),
**ac**(1)
