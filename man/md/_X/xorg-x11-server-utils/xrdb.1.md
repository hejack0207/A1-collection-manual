# xrdb(1) - X server resource database utility

X Version 11, xrdb 1.1.1

```
xrdb [-option ...] [filename]
```

<a name="description"></a>

# Description

_Xrdb_
is used to get or set the contents of the RESOURCE_MANAGER property
on the root window of screen 0, or the SCREEN_RESOURCES property on
the root window of any or all screens, or everything combined.
You would normally run this program from your X startup file.

Most X clients use the RESOURCE_MANAGER and SCREEN_RESOURCES properties to
get user preferences about
color, fonts, and so on for applications.  Having this information in
the server (where it is available to all clients) instead of on disk,
solves the problem in previous versions of X that required you to
maintain _defaults_ files on every machine that you might use.
It also allows for dynamic changing of defaults without editing files.

The RESOURCE_MANAGER property is used for resources that apply to all
screens of the display.  The SCREEN_RESOURCES property on each screen
specifies additional (or overriding) resources to be used for that screen.
(When there is only one screen, SCREEN_RESOURCES is normally not used,
all resources are just placed in the RESOURCE_MANAGER property.)

The file specified by
_filename_
(or the contents from standard input if - or no filename is given)
is optionally passed through the C preprocessor with the
following symbols defined, based on the capabilities of the server
being used:

* **SERVERHOST=_hostname_**  
  the hostname portion of the display to which you are connected.
* **SRVR\_name**  
  the SERVERHOST hostname string turned into a legal identifier.
  For example, "my-dpy.lcs.mit.edu" becomes SRVR_my_dpy_lcs_mit_edu.
* **HOST=_hostname_**  
  the same as
  **SERVERHOST**.
* **DISPLAY\_NUM=_num_**  
  the number of the display on the server host.
* **CLIENTHOST=_hostname_**  
  the name of the host on which
  _xrdb_
  is running.
* **CLNT\_name**  
  the CLIENTHOST hostname string turned into a legal identifier.
  For example, "expo.lcs.mit.edu" becomes CLNT_expo_lcs_mit_edu.
* **RELEASE=_num_**  
  the vendor release number for the server.  The interpretation of this
  number will vary depending on VENDOR.
* **REVISION=_num_**  
  the X protocol minor version supported by this server (currently 0).
* **VERSION=_num_**  
  the X protocol major version supported by this server (should always be 11).
* **VENDOR="_vendor_"**  
  a string literal specifying the vendor of the server.
* **VNDR\__name_**  
  the VENDOR name string turned into a legal identifier.
  For example, "MIT X Consortium" becomes VNDR_MIT_X_Consortium.
* **EXT\__name_**  
  A symbol is defined for each protocol extension supported by the server.
  Each extension string name is turned into a legal identifier.
  For example, "X3D-PEX" becomes EXT_X3D_PEX.
* **NUM\_SCREENS=_num_**  
  the total number of screens.
* **SCREEN\_NUM=_num_**  
  the number of the current screen (from zero).
* **BITS\_PER\_RGB=_num_**  
  the number of significant bits in an RGB color specification.  This is the
  log base 2 of the number of distinct shades of each primary that the hardware
  can generate.  Note that it usually is not related to PLANES.
* **CLASS=_visualclass_**  
  one of StaticGray, GrayScale, StaticColor, PseudoColor, TrueColor,
  DirectColor.  This is the visual class of the root window.
* **CLASS\__visualclass_=_visualid_**  
  the visual class of the root window in a form you can _#ifdef_ on.
  The value is the numeric id of the visual.
* **COLOR**  
  defined only if CLASS is one of StaticColor, PseudoColor, TrueColor, or
  DirectColor.
* **CLASS\__visualclass_\__depth_=_num_**  
  A symbol is defined for each visual supported for the screen.
  The symbol includes the class of the visual and its depth;
  the value is the numeric id of the visual.
  (If more than one visual has the same class and depth, the numeric id
  of the first one reported by the server is used.)
* **HEIGHT=_num_**  
  the height of the root window in pixels.
* **WIDTH=_num_**  
  the width of the root window in pixels.
* **PLANES=_num_**  
  the number of bit planes (the depth) of the root window.
* **X\_RESOLUTION=_num_**  
  the x resolution of the screen in pixels per meter.
* **Y\_RESOLUTION=_num_**  
  the y resolution of the screen in pixels per meter.

SRVR\__name_, CLNT\__name_, VNDR\__name_, and EXT\__name_
identifiers are formed by changing all characters other than letters
and digits into underscores (_).

Lines that begin with an exclamation mark (!) are ignored and may
be used as comments.

Note that since
_xrdb_
can read from standard input, it can be used to
the change the contents of properties directly from
a terminal or from a shell script.

<a name="options"></a>

# Options


_xrdb_
program accepts the following options:

* **-help**  
  This option (or any unsupported option) will cause a brief description of
  the allowable options and parameters to be printed.
* **-version**  
  This option will cause the xrdb version to be printed and the program to exit
  without performing any other operations.
* **-display _display_**  
  This option specifies the X server to be used; see _X(7)_.
  It also specifies the screen to use for the _-screen_ option,
  and it specifies the screen from which preprocessor symbols are
  derived for the _-global_ option.
* **-all**  
  This option indicates that operation should be performed on the
  screen-independent resource property (RESOURCE_MANAGER), as well as
  the screen-specific property (SCREEN_RESOURCES) on every screen of the
  display.  For example, when used in conjunction with _-query_,
  the contents of all properties are output.  For _-load_, _-override_
  and _-merge_,
  the input file is processed once for each screen.  The resources which occur
  in common in the output for every screen are collected, and these are applied
  as the screen-independent resources.  The remaining resources are applied
  for each individual per-screen property.  This the default mode of operation.
* **-global**  
  This option indicates that the operation should only be performed on
  the screen-independent RESOURCE_MANAGER property.
* **-screen**  
  This option indicates that the operation should only be performed on
  the SCREEN_RESOURCES property of the default screen of the display.
* **-screens**  
  This option indicates that the operation should be performed on
  the SCREEN_RESOURCES property of each screen of the display.
  For _-load_, _-override_ and _-merge_, the input file is
  processed for each screen.
* **-n**  
  This option indicates that changes to the specified properties (when used with
  _-load_, _-override_ or _-merge_)
  or to the resource file (when used with _-edit_) should be shown on the
  standard output, but should not be performed.
* **-quiet**  
  This option indicates that warning about duplicate entries should not be
  displayed.
* **-cpp _filename_**  
  This option specifies the pathname of the C preprocessor program to be used.
  Although
  _xrdb_
  was designed to use CPP, any program that acts as a filter
  and accepts the -D, -I, and -U options may be used.
* **-nocpp**  
  This option indicates that
  _xrdb_
  should not run the input file through a preprocessor before loading it
  into properties.
* **-undef**  
  This option is passed to the C preprocessor if used. It prevents it from
  predefining any system specific macros.
* **-symbols**  
  This option indicates that the symbols that are defined for the preprocessor
  should be printed onto the standard output.
* **-query**  
  This option indicates that the current contents of the specified
  properties should be printed onto the standard output.  Note that since
  preprocessor commands in the input resource file are part of the input
  file, not part of the property, they won't appear in the output from this
  option.  The
  **-edit**
  option can be used to merge the contents of properties back into the input
  resource file without damaging preprocessor commands.
* **-load**  
  This option indicates that the input should be loaded as the new value
  of the specified properties, replacing whatever was there (i.e.
  the old contents are removed).  This is the default action.
* **-override**  
  This option indicates that the input should be added to, instead of
  replacing, the current contents of the specified properties.
  New entries override previous entries.
* **-merge**  
  This option indicates that the input should be merged and lexicographically
  sorted with, instead of replacing, the current contents of the specified
  properties.
* **-remove**  
  This option indicates that the specified properties should be removed
  from the server.
* **-retain**  
  This option indicates that the server should be instructed not to reset if
  _xrdb_ is the first client.  This should never be necessary under normal
  conditions, since _xdm_ and _xinit_ always act as the first client.
* **-edit _filename_**  
  This option indicates that the contents of the specified properties
  should be edited into the given file, replacing any values already listed
  there.  This allows you to put changes that you have made to your defaults
  back into your resource file, preserving any comments or preprocessor lines.
* **-backup _string_**  
  This option specifies a suffix to be appended to the filename used with
  **-edit**
  to generate a backup file.
* **-D_name[=value]_**  
  This option is passed through to the preprocessor and is used to define
  symbols for use with conditionals such as
  _#ifdef._
* **-U_name_**  
  This option is passed through to the preprocessor and is used to remove
  any definitions of this symbol.
* **-I_directory_**  
  This option is passed through to the preprocessor and is used to specify
  a directory to search for files that are referenced with
  _#include._

<a name="files"></a>

# Files

_Xrdb_
does not load any files on its own, but many desktop environments use
xrdb to load _~/.Xresources_ files on session startup to initialize
the resource database, as a generalized replacement for _~/.Xdefaults_
files.

<a name="see-also"></a>

# See Also

X(7), appres(1), listres(1),
Xlib Resource Manager documentation, Xt resource documentation

<a name="environment"></a>

# Environment


* **DISPLAY**  
  to figure out which display to use.

<a name="bugs"></a>

# Bugs


The default for no arguments should be to query, not to overwrite, so that
it is consistent with other programs.

<a name="authors"></a>

# Authors

Bob Scheifler, Phil Karlton, rewritten from the original by Jim Gettys
