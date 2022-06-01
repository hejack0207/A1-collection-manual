# xsetroot(1) - root window parameter setting utility for X

X Version 11, xsetroot 1.1.2

```
xsetroot [-help] [-version] [-def] [-display display] [-cursor cursorfile maskfile] [-cursor_name cursorfontname] [-xcf cursorfile cursorsize] [-bitmap filename | -mod x y | -gray | -grey | -solid color] [-bg color] [-fg color] [-rv] [-name string] [-d display]
```

<a name="description"></a>

# Description

The
_xsetroot_
program
allows you to tailor the appearance of the background ("root")
window on a workstation display running X.  Normally, you experiment with
_xsetroot_
until you find a personalized look that you like, then put the
_xsetroot_
command that produces it into your X startup file.
If no options are specified, or if
_-def_
is specified, the window is reset to its default state.  The
_-def_
option can be specified along with other options and only the non-specified
characteristics will be reset to the default state.

Only one of the background color/tiling changing options
(-solid, -gray, -grey, -bitmap, and -mod) may be specified at a time.

<a name="options"></a>

# Options


The various options are as follows:

* **-help**  
  Print a usage message and exit.
* **-version**  
  Print a version message and exit.
* **-def, -default**  
  Reset unspecified attributes to the default values.  (Restores the background
  to the familiar gray mesh and the cursor to the hollow x shape.)
* **-cursor** _cursorfile_ _maskfile_  
  This lets you change the pointer cursor to whatever
  you want when the pointer cursor is outside of any window.
  Cursor and mask files are bitmaps (little pictures), and can be made with the
  _bitmap(1)_
  program.  You probably want the mask file to be all black until you
  get used to the way masks work.
* **-cursor\_name** _cursorfontname_  
  This lets you change the pointer cursor to one of the standard
  cursors from the cursor font.  Refer to appendix B of the X protocol for
  the names (except that the XC_ prefix is elided for this option).
* **-xcf** _cursorfile_ _cursorsize_  
  This lets you change the pointer cursor to one loaded from an Xcursor file
  as defined by libXcursor, at the specified size.
* **-bitmap** _filename_  
  Use the bitmap specified in the file to set the window pattern.  You can
  make your own bitmap files (little pictures) using the
  _bitmap(1)_
  program.  The entire background will be made up of repeated "tiles" of
  the bitmap.
* **-mod** _x_ _y_  
  This is used if you want a plaid-like grid pattern on your screen.
  x and y are integers ranging from 1 to 16.  Try the different combinations.
  Zero and negative numbers are taken as 1.
* **-gray, -grey**  
  Make the entire background gray (Easier on the eyes).
* **-bg, -background** _color_  
  Use \`\`color'' as the background color.
* **-fg, -foreground** _color_  
  Use \`\`color'' as the foreground color.  Foreground and background colors
  are meaningful only in combination with -cursor, -bitmap, or -mod.
* **-rv, -reverse**  
  This exchanges the foreground and background colors.  Normally the foreground
  color is black and the background color is white.
* **-solid** _color_  
  This sets the background of the root window to the specified color.  This
  option is only useful on color servers.
* **-name** _string_  
  Set the name of the root window to \`\`string''.  There is no default value.
  Usually a name is assigned to a window so that the
  window manager can use a text representation when the window is iconified.
  This option is unused since you can't iconify the background.
* **-d, -display** _display_  
  Specifies the server to connect to; see _X(7)_.

<a name="see-also"></a>

# See Also

X(7), xset(1), xrdb(1), Xcursor(3)

<a name="author"></a>

# Author

Mark Lillibridge, MIT Project Athena
