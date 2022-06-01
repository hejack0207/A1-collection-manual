# xlsatoms(1) - list interned atoms defined on server

X Version 11, xlsatoms 1.1.2

```
xlsatoms [-options ...]
```

<a name="description"></a>

# Description

_Xlsatoms_
lists the interned atoms.  By default, all atoms starting from 1 (the lowest
atom value defined by the protocol) are listed until unknown atom is found.
If an explicit range is given, _xlsatoms_ will try all atoms in the range,
regardless of whether or not any are undefined.

<a name="options"></a>

# Options



* **-display _dpy_**  
  This option specifies the X server to which to connect.
* **-format _string_**  
  This option specifies a _printf_-style string used to list each atom
  _&lt;value,name&gt;_ pair, printed in that order (_value_ is an unsigned
  long and _name_ is a _char *_).  _Xlsatoms_ will supply a
  newline at the end of each line.  The default is _%ld\\t%s_.
* **-range _[low]-[high]_**  
  This option specifies the range of atom values to check.  If _low_ is not
  given, a value of 1 assumed.  If _high_ is not given, _xlsatoms_ will
  stop at the first undefined atom at or above _low_.
* **-name _string_**  
  This option specifies the name of an atom to list.  If the atom does not
  exist, a message will be printed on the standard error.
* **-version**  
  Print out the program version and exit.


<a name="see-also"></a>

# See Also

X(7), Xserver(1), xprop(1)

<a name="environment"></a>

# Environment


* **DISPLAY**  
  to get the default host and display to use.

<a name="author"></a>

# Author

Jim Fulton, MIT X Consortium
