# xvinfo(1) - Print out X-Video extension adaptor information

X Version 11, xvinfo 1.1.3

```
"xvinfo" [-display displayname]
```

<a name="description"></a>

# Description


**xvinfo**
prints out the capabilities of any video adaptors associated
with the display that are accessible through the X-Video extension.

<a name="options"></a>

# Options



* **-display _display_**  
  This argument allows you to specify the server to query; see _X(7)_.
* **-short**  
  Output less details, to reduce the amount of text.
* **-version**  
  Output program version, then exit.

<a name="environment"></a>

# Environment



* **DISPLAY**  
  This variable may be used to specify the server to query.
  

<a name="see-also"></a>

# See Also

X(7), xdpyinfo(1), xwininfo(1),
xdriinfo(1), glxinfo(1), xprop(1)

<a name="authors"></a>

# Authors

Mark Vojkovich
