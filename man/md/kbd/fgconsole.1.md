# fgconsole(1) - print the number of the active VT.

"", 14 Feburary 2002

```
fgconsole [ -h --help | -V --version | -n --next-available ]
```

<a name="description"></a>

# Description

If the active Virtual Terminal is
_/dev/ttyN_,
then prints
_N_
on standard output.

If the console is a serial console, then 
"serial" 
is printed instead.

* _-h --help_  
  Prints short usage message and exits.
* _-V --version_  
  Prints version number and exits.
* _--next-available_  
  Will show the next unallocated virtual terminal. Normally 6 virtual
  terminals are allocated, with number 7 used for X; this will return
  "8" in this case.
  

<a name="notes"></a>

# Notes

Under 
_devfs_,
the consoles are in 
_/dev/vc/N_.
_devfsd_
may maintain symlinks for compatibility.

<a name="see-also"></a>

# See Also

**chvt**(1).





