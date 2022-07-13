# xrefresh(1) - refresh all or part of an X screen

X Version 11, xrefresh 1.0.6

```
"xrefresh" [-option ...]
```

<a name="description"></a>

# Description


_Xrefresh_
is a simple X program that causes all or part of your screen to be repainted.
This is useful when system messages have messed up your screen.
_Xrefresh_
maps a window on top of the desired area of the screen and then immediately
unmaps it,
causing refresh events to be sent to all applications.  By default,
a window with no background is used, causing all applications to repaint
\`\`smoothly.''
However, the various options can be used to indicate that a solid background
(of any color) or the root window background should be used instead.

<a name="arguments"></a>

# Arguments



* **-white**  
  Use a white background.  The screen just appears to flash quickly, and then
  repaint.


* **-black**  
  Use a black background (in effect, turning off all of the electron guns to
  the tube).  This can be somewhat disorienting as everything goes black for
  a moment.


* **-solid _color_**  
  Use a solid background of the specified color.  Try green.


* **-root**  
  Use the root window background.


* **-none**  
  This is the default.  All of the windows simply repaint.


* **-geometry _WxH+X+Y_**  
  Specifies the portion of the screen to be repainted; see _X(7)_.


* **-display _display_**  
  This  argument  allows  you  to  specify the server and screen to
  refresh; see _X(7)_.


* **-version**  
  This argument prints the program version and exits.

<a name="x-defaults"></a>

# X Defaults

The
_xrefresh_
program uses the routine
_XGetDefault(3)_
to read defaults, so its resource names are all capitalized.


* **Black, **White**, **Solid**, **None**, **Root****  
  Determines what sort of window background to use.


* **Geometry**  
  Determines the area to refresh.  Not very useful.

<a name="environment"></a>

# Environment



* DISPLAY - To get default host and display number.  

<a name="see-also"></a>

# See Also

X(7)

<a name="bugs"></a>

# Bugs


It should have just one default type for the background.

<a name="authors"></a>

# Authors

Jim Gettys, Digital Equipment Corp., MIT Project Athena
