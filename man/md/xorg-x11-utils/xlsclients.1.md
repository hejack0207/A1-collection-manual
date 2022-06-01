# xlsclients(1) - list client applications running on a display

X Version 11, xlsclients 1.1.4

```
"xlsclients" [-display displayname] [-a] [-l] [-m maxcmdlen] [-version]
```

<a name="description"></a>

# Description


_Xlsclients_
is a utility for listing information about the client applications
running on a display.  It may be used to generate scripts representing
a snapshot of the user's current session.

<a name="options"></a>

# Options


* **-display _displayname_**  
  This option specifies the X server to contact.
* **-a**  
  This option indicates that clients on all screens should be listed.  By
  default, only those clients on the default screen are listed.
* **-l**  
  List in long format, giving the window name, icon name,
  and class hints in addition to the machine name and command string shown in
  the default format.
* **-m _maxcmdlen_**  
  This option specifies the maximum number of characters in a command to
  print out.  The default is 10000.
* **-version**  
  Print the program version and exit.

<a name="environment"></a>

# Environment



* **DISPLAY**  
  To get the default host, display number, and screen.

<a name="see-also"></a>

# See Also

X(7), xwininfo(1), xprop(1)

<a name="author"></a>

# Author

Jim Fulton, MIT X Consortium
