# setvtrgb(8) - set the virtual terminal RGB colors

Set Virtual Terminal RGB Colors, 3 Mar 2011

```
setvtrgb -h|-V|vga|FILE|-
```

<a name="description"></a>

# Description

The
_setvtrgb_
command takes a single argument, either the string
**vga**
, or a path to a file
containing the red, green, and blue colors to be used by the Linux virtual terminals.

If you use the
**FILE**
parameter,
**FILE**
should be exactly 3 lines of 16
comma-separated decimal values for RED, GREEN, and BLUE.

To seed a valid
**FILE**
:
**cat /sys/module/vt/parameters/default_{red,grn,blu} &gt; FILE**

And then edit the values in
**FILE**


<a name="other-options"></a>

# Other Options


* -h  
  Prints usage message and exits.
* -V  
  Prints version number and exists.
  

<a name="author"></a>

# Author

The utility is written by Alexey Gladkov, Seth Forshee, Dustin Kirkland.


<a name="documentation"></a>

# Documentation

Documentation by Dustin Kirkland.
