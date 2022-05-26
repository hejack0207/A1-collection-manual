# x(7) - a portable, network-transparent window system

Version 11, xorg-docs 1.7.1


<a name="overview"></a>

# Overview


The X Window System is a network transparent window system which runs
on a wide range of computing and graphics machines.  It should be
relatively straightforward to build the X.Org Foundation software
distribution on most ANSI C and POSIX compliant systems.  Commercial
implementations are also available for a wide range of platforms.

The X.Org Foundation requests that the following names be used when
referring to this software:

.TS
center;
c.
X
X Window System
X Version 11
X Window System, Version 11
X11
.TE

_X Window System_
is a trademark of The Open Group.

<a name="description"></a>

# Description

X Window System servers run on computers with bitmap displays.
The server distributes user input to and accepts output requests from various
client programs through a variety of different interprocess
communication channels.  Although the most common case is for the client
programs to be
running on the same machine as the server, clients can be run transparently
from other machines (including machines with different architectures and
operating systems) as well.

X supports overlapping hierarchical subwindows and text and
graphics operations, on both monochrome and color
displays.
For a full explanation of the functions that are available, see
the _Xlib - C Language X Interface_ manual,
the _X Window System Protocol_ specification,
the _X Toolkit Intrinsics - C Language Interface_ manual,
and various toolkit documents.

The number of programs that use _X_ is quite large.
Programs provided in the core X.Org Foundation distribution include:
a terminal emulator, _xterm_;
a window manager, _twm_;
a display manager, _xdm_;
a console redirect program, _xconsole_;
a mail interface, _xmh_;
a bitmap editor, _bitmap_;
resource listing/manipulation tools, _appres_, _editres_;
access control programs, _xauth_, _xhost_, and _iceauth_;
user preference setting programs, _xrdb_, _xcmsdb_,
_xset_, _xsetroot_, _xstdcmap_, and _xmodmap_;
clocks, _xclock_ and _oclock_;
a font displayer, _xfd_;
utilities for listing information about fonts, windows, and displays,
_xlsfonts_, _xwininfo_, _xlsclients_,
_xdpyinfo_, _xlsatoms_, and _xprop_;
screen image manipulation utilities, _xwd_, _xwud_, and _xmag_;
a performance measurement utility, _x11perf_;
a font compiler, _bdftopcf_;
a font server and related utilities, _xfs_, _fsinfo_, _fslsfonts_, _fstobdf_;
a display server and related utilities, _Xserver_, _rgb_, _mkfontdir_;
a clipboard manager, _xclipboard_;
keyboard description compiler and related utilities, _xkbcomp_, _setxkbmap_
_xkbprint_, _xkbbell_, _xkbevd_, _xkbvleds_, and _xkbwatch_;
a utility to terminate clients, _xkill_;
a firewall security proxy, _xfwp_;
a proxy manager to control them, _proxymngr_;
a utility to find proxies, _xfindproxy_;
web browser plug-ins, _libxrx.so_ and _libxrxnest.so_;
an RX MIME-type helper program, _xrx_;
and a utility to cause part or all of the screen to be redrawn, _xrefresh_.

Many other utilities, window managers, games, toolkits, etc. are included
as user-contributed software in the X.Org Foundation distribution, or are
available on the Internet.
See your site administrator for details.

<a name="starting-up"></a>

# Starting Up


There are two main ways of getting the X server and an initial set of
client applications started.  The particular method used depends on what
operating system you are running and whether or not you use other window
systems in addition to X.

* **Display Manager**  
  If you want to always have X running on your display, your site administrator
  can set your machine up to use a Display Manager such as _xdm_, _gdm_,
  or _kdm_.  This program
  is typically started by the system at boot time and takes care of keeping the
  server running and getting users logged in.  If you are running one of these
  display managers, you will normally see a window on the screen welcoming you
  to the system and asking for your login information.  Simply type them in as
  you would at a normal terminal.  If you make a mistake, the display manager
  will display an error message and ask you to try again.  After you
  have successfully logged in, the display manager will start up your X
  environment.  The documentation for the display manager you use can provide
  more details.
* **_xinit_ (run manually from the shell)**  
  Sites that support more than one window system might choose to use the
  _xinit_ program for starting X manually.  If this is true for your
  machine, your site administrator will probably have provided a program
  named "x11", "startx", or "xstart" that will do site-specific initialization
  (such as loading convenient default resources, running a window manager,
  displaying a clock, and starting several terminal emulators) in a nice
  way.  If not, you can build such a script using the _xinit_ program.
  This utility simply runs one user-specified program to start the server,
  runs another to start up any desired clients, and then waits for either to
  finish.  Since either or both of the user-specified programs may be a shell
  script, this gives substantial flexibility at the expense of a
  nice interface.  For this reason, _xinit_ is not intended for end users.

<a name="display-names"></a>

# Display Names


From the user's perspective, every X server has a _display name_ of the
form:

_hostname:displaynumber.screennumber_

This information is used by the application to determine how it should
connect to the server and which screen it should use by default
(on displays with multiple monitors):

* _hostname_  
  The _hostname_ specifies the name of the machine to which the display is
  physically connected.  If the hostname is not given, the most efficient way of
  communicating to a server on the same machine will be used.
* _displaynumber_  
  The phrase "display" is usually used to refer to a collection of monitors that
  share a common set of input devices (keyboard, mouse, tablet, etc.).
  Most workstations tend to only have one display.  Larger, multi-user
  systems, however, frequently have several displays so that more than
  one person can be doing graphics work at once.  To avoid confusion, each
  display on a machine is assigned a _display number_ (beginning at 0)
  when the X server for that display is started.  The display number must always
  be given in a display name.
* _screennumber_  
  Some displays share their input devices among two or more monitors.
  These may be configured as a single logical screen, which allows windows to
  move across screens, or as individual screens, each with their own set of
  windows.  If configured such that each monitor has its own set of windows,
  each screen is assigned a
  _screen number_ (beginning at 0) when the X server for that display is
  started.  If the screen number is not given, screen 0 will be used.

On POSIX systems, the default display name is stored
in your DISPLAY environment variable.  This variable is set automatically
by the _xterm_ terminal emulator.  However, when you log into another
machine on a network, you may need to set DISPLAY by hand to point to your
display.  For example,

        % setenv DISPLAY myws:0
        $ DISPLAY=myws:0; export DISPLAY

The _ssh_ program can be used to start an X program on a remote machine;
it automatically sets the DISPLAY variable correctly.

Finally, most X programs accept a command line option of
**-display displayname** to temporarily override the contents of
DISPLAY.  This is most commonly used to pop windows on another person's
screen or as part of a "remote shell" command to start an xterm pointing back
to your display.  For example,

        % xeyes -display joesws:0 -geometry 1000x1000+0+0
        % rsh big xterm -display myws:0 -ls </dev/null &

X servers listen for connections on a variety of different
communications channels (network byte streams, shared memory, etc.).
Since there can be more than one way of contacting a given server,
The _hostname_ part of the display name is used to determine the
type of channel
(also called a transport layer) to be used.  X servers generally
support the following types of connections:

* _local_    
  The hostname part of the display name should be the empty string.
  For example:  _:0_, _:1_, and _:0.1_.  The most efficient
  local transport will be chosen.
* _TCPIP_    
  The hostname part of the display name should be the server machine's
  hostname or IP address.  Full Internet names, abbreviated names, IPv4
  addresses, and IPv6 addresses are all allowed.  For example:
  _x.org:0_, _expo:0_, _[::1]:0_,
  _198.112.45.11:0_, _bigmachine:1_, and _hydra:0.1_.


<a name="access-control"></a>

# Access Control

An X server can use several types of access control.  Mechanisms provided
in Release 7 are:
.TS
l l.
Host Access     	Simple host-based access control.
MIT-MAGIC-COOKIE-1	Shared plain-text "cookies".
XDM-AUTHORIZATION-1	Secure DES based private-keys.
SUN-DES-1     	Based on Sun's secure rpc system.
Server Interpreted	Server-dependent methods of access control
.TE

_Xdm_ initializes access control for the server and also places
authorization information in a file accessible to the user.

Normally, the list of hosts from
which connections are always accepted should be empty, so that only clients
with are explicitly authorized can connect to the display.  When you add
entries to the host list (with _xhost_), the server no longer performs any
authorization on connections from those machines.  Be careful with this.

The file from which _Xlib_ extracts authorization data can be
specified with the environment variable **XAUTHORITY**, and defaults to
the file **.Xauthority** in the home directory.  _Xdm_ uses
**$HOME/.Xauthority** and will create it or merge in authorization records
if it already exists when a user logs in.

If you use several machines and share a common home directory
across all of the machines by means of a network file system,
you never really have to worry about authorization files,
the system should work correctly by default.
Otherwise, as the authorization files are machine-independent,
you can simply copy the files to share them.
To manage authorization files, use _xauth_.
This program allows you to extract
records and insert them into other files.  Using this, you can send
authorization to remote machines when you login,
if the remote machine does not share a common home directory with
your local machine.
Note that authorization information transmitted
\`\`in the clear'' through a network file system or
using _ftp_ or _rcp_ can be \`\`stolen''
by a network eavesdropper, and as such may enable unauthorized access.
In many environments, this level of security is not a concern, but if it is,
you need to know the exact semantics of the particular authorization
data to know if this is actually a problem.

For more information on access control, see the
_Xsecurity_(7) manual page.

<a name="geometry-specifications"></a>

# Geometry Specifications

One of the advantages of using window systems instead of
hardwired terminals is that
applications don't have to be restricted to a particular size or location
on the screen.
Although the layout of windows on a display is controlled
by the window manager that the user is running (described below),
most X programs accept
a command line argument of the form **-geometry WIDTHxHEIGHT+XOFF+YOFF**
(where _WIDTH_, _HEIGHT_, _XOFF_, and _YOFF_ are numbers)
for specifying a preferred size and location for this application's main
window.

The _WIDTH_ and _HEIGHT_ parts of the geometry specification are
usually measured in either pixels or characters, depending on the application.
The _XOFF_ and _YOFF_ parts are measured in pixels and are used to
specify the distance of the window from the left or right and top and bottom
edges of the screen, respectively.  Both types of offsets are measured from the
indicated edge of the screen to the corresponding edge of the window.  The X
offset may be specified in the following ways:

* _+XOFF_  
  The left edge of the window is to be placed _XOFF_ pixels in from the
  left edge of the screen (i.e., the X coordinate of the window's origin will be
  _XOFF_).  _XOFF_ may be negative, in which case the window's left edge
  will be off the screen.
* _-XOFF_  
  The right edge of the window is to be placed _XOFF_ pixels in from the
  right edge of the screen.  _XOFF_ may be negative, in which case the
  window's right edge will be off the screen.

The Y offset has similar meanings:

* _+YOFF_  
  The top edge of the window is to be _YOFF_ pixels below the
  top edge of the screen (i.e., the Y coordinate of the window's origin will be
  _YOFF_).  _YOFF_ may be negative, in which case the window's top edge
  will be off the screen.
* _-YOFF_  
  The bottom edge of the window is to be _YOFF_ pixels above the
  bottom edge of the screen.  _YOFF_ may be negative, in which case
  the window's bottom edge will be off the screen.

Offsets must be given as pairs; in other words, in order to specify either
_XOFF_ or _YOFF_ both must be present.  Windows can be placed in the
four corners of the screen using the following specifications:

* _+0+0_  
  upper left hand corner.
* _-0+0_  
  upper right hand corner.
* _-0-0_  
  lower right hand corner.
* _+0-0_  
  lower left hand corner.

In the following examples, a terminal emulator is placed in roughly
the center of the screen and
a load average monitor, mailbox, and clock are placed in the upper right
hand corner:

        xterm -fn 6x10 -geometry 80x24+30+200 &
        xclock -geometry 48x48-0+0 &
        xload -geometry 48x48-96+0 &
        xbiff -geometry 48x48-48+0 &


<a name="window-managers"></a>

# Window Managers

The layout of windows on the screen is controlled by special programs called
_window managers_.  Although many window managers will honor geometry
specifications as given, others may choose to ignore them (requiring the user
to explicitly draw the window's region on the screen with the pointer, for
example).

Since window managers are regular (albeit complex) client programs,
a variety of different user interfaces can be built.  The X.Org Foundation distribution
comes with a window manager named _twm_ which supports overlapping windows,
popup menus, point-and-click or click-to-type input models, title bars, nice
icons (and an icon manager for those who don't like separate icon windows).

See the user-contributed software in the X.Org Foundation distribution for other
popular window managers.

<a name="font-names"></a>

# Font Names

Collections of characters for displaying text and symbols in X are known as
_fonts_.  A font typically contains images that share a common appearance
and look nice together (for example, a single size, boldness, slant, and
character set).  Similarly, collections of fonts that are based on a common
type face (the variations are usually called roman, bold, italic, bold italic,
oblique, and bold oblique) are called _families_.

Fonts come in various sizes.  The X server supports _scalable_ fonts,
meaning it is possible to create a font of arbitrary size from a single
source for the font.  The server supports scaling from _outline_
fonts and _bitmap_ fonts.  Scaling from outline fonts usually produces
significantly better results than scaling from bitmap fonts.

An X server can obtain fonts from individual files stored in directories
in the file system, or from one or more font servers,
or from a mixtures of directories and font servers.
The list of places the server looks when trying to find
a font is controlled by its _font path_.  Although most installations
will choose to have the server start up with all of the commonly used font
directories in the font path, the font path can be changed at any time
with the _xset_ program.
However, it is important to remember that the directory names are
on the **server**'s machine, not on the application's.

Bitmap font files are usually created by compiling a textual font description
into binary form, using _bdftopcf_.
Font databases are created by running the _mkfontdir_ program in the
directory containing the source or compiled versions of the fonts.
Whenever fonts are added to a directory, _mkfontdir_ should be rerun
so that the server can find the new fonts.  To make the server reread the
font database, reset the font path with the _xset_ program.  For example,
to add a font to a private directory, the following commands could be used:

        % cp newfont.pcf ~/myfonts
        % mkfontdir ~/myfonts
        % xset fp rehash

The _xfontsel_ and _xlsfonts_ programs can be used to browse
through the fonts available on a server.
Font names tend to be fairly long as they contain all of the information
needed to uniquely identify individual fonts.  However, the X server
supports wildcarding of font names, so the full specification

        -adobe-courier-medium-r-normal--10-100-75-75-m-60-iso8859-1

might be abbreviated as:

        -*-courier-medium-r-normal--*-100-*-*-*-*-iso8859-1

Because the shell also has special meanings for _* and ?_,
wildcarded font names should be quoted:

        % xlsfonts -fn '-*-courier-medium-r-normal--*-100-*-*-*-*-*-*'

The _xlsfonts_ program can be used to list all of the fonts that
match a given pattern.  With no arguments, it lists all available fonts.
This will usually list the same font at many different sizes.  To see
just the base scalable font names, try using one of the following patterns:

        -*-*-*-*-*-*-0-0-0-0-*-0-*-*
        -*-*-*-*-*-*-0-0-75-75-*-0-*-*
        -*-*-*-*-*-*-0-0-100-100-*-0-*-*

To convert one of the resulting names into a font at a specific size,
replace one of the first two zeros with a nonzero value.
The field containing the first zero is for the pixel size; replace it
with a specific height in pixels to name a font at that size.
Alternatively, the field containing the second zero is for the point size;
replace it with a specific size in decipoints (there are 722.7 decipoints to
the inch) to name a font at that size.
The last zero is an average width field, measured in tenths of pixels;
some servers will anamorphically scale if this value is specified.

<a name="font-server-names"></a>

# Font Server Names

One of the following forms can be used to name a font server that
accepts TCP connections:

        tcp/hostname:port
        tcp/hostname:port/cataloguelist

The _hostname_ specifies the name (or decimal numeric address)
of the machine on which the font server is running.  The _port_
is the decimal TCP port on which the font server is listening for connections.
The _cataloguelist_ specifies a list of catalogue names,
with '+' as a separator.

Examples: _tcp/x.org:7100_, _tcp/198.112.45.11:7100/all_.

<a name="color-names"></a>

# Color Names

Most applications provide ways of tailoring (usually through resources or
command line arguments) the colors of various elements
in the text and graphics they display.
A color can be specified either by an abstract color name,
or by a numerical color specification.
The numerical specification can identify a color in either
device-dependent (RGB) or device-independent terms.
Color strings are case-insensitive.

X supports the use of abstract color names, for example, "red", "blue".
A value for this abstract name is obtained by searching one or more color
name databases.
_Xlib_ first searches zero or more client-side databases;
the number, location, and content of these databases is
implementation dependent.
If the name is not found, the color is looked up in the
X server's database.
The text form of this database is commonly stored in the file
_usr/share/X11/rgb.txt_.

A numerical color specification
consists of a color space name and a set of values in the following syntax:

        <color_space_name>:<value>/.../<value>

An RGB Device specification is identified by
the prefix "rgb:" and has the following syntax:

        rgb:<red>/<green>/<blue>
    
            <red>, <green>, <blue> := h | hh | hhh | hhhh
            h := single hexadecimal digits

Note that _h_ indicates the value scaled in 4 bits,
_hh_ the value scaled in 8 bits,
_hhh_ the value scaled in 12 bits,
and _hhhh_ the value scaled in 16 bits, respectively.
These values are passed directly to the X server,
and are assumed to be gamma corrected.

The eight primary colors can be represented as:

.TS
center;
l l.
black	rgb:0/0/0
red	rgb:ffff/0/0
green	rgb:0/ffff/0
blue	rgb:0/0/ffff
yellow	rgb:ffff/ffff/0
magenta	rgb:ffff/0/ffff
cyan	rgb:0/ffff/ffff
white	rgb:ffff/ffff/ffff
.TE

For backward compatibility, an older syntax for RGB Device is
supported, but its continued use is not encouraged.
The syntax is an initial sharp sign character followed by
a numeric specification, in one of the following formats:

.TS
center;
l l.
#RGB    	(4 bits each)
#RRGGBB  	(8 bits each)
#RRRGGGBBB	(12 bits each)
#RRRRGGGGBBBB	(16 bits each)
.TE

The R, G, and B represent single hexadecimal digits.
When fewer than 16 bits each are specified,
they represent the most-significant bits of the value
(unlike the "rgb:" syntax, in which values are scaled).
For example, #3a7 is the same as #3000a0007000.

An RGB intensity specification is identified
by the prefix "rgbi:" and has the following syntax:

        rgbi:<red>/<green>/<blue>

The red, green, and blue are floating point values
between 0.0 and 1.0, inclusive.
They represent linear intensity values, with
1.0 indicating full intensity, 0.5 half intensity, and so on.
These values will be gamma corrected by _Xlib_
before being sent to the X server.
The input format for these values is an optional sign,
a string of numbers possibly containing a decimal point,
and an optional exponent field containing an E or e
followed by a possibly signed integer string.

The standard device-independent string specifications have
the following syntax:

.TS
center;
l l.
CIEXYZ:_&lt;X&gt;/&lt;Y&gt;/&lt;Z&gt;_	(_none_, 1, _none_)
CIEuvY:_&lt;u&gt;/&lt;v&gt;/&lt;Y&gt;_	(~.6, ~.6, 1)
CIExyY:_&lt;x&gt;/&lt;y&gt;/&lt;Y&gt;_	(~.75, ~.85, 1)
CIELab:_&lt;L&gt;/&lt;a&gt;/&lt;b&gt;_	(100, _none_, _none_)
CIELuv:_&lt;L&gt;/&lt;u&gt;/&lt;v&gt;_	(100, _none_, _none_)
TekHVC:_&lt;H&gt;/&lt;V&gt;/&lt;C&gt;_	(360, 100, 100)
.TE

All of the values (C, H, V, X, Y, Z, a, b, u, v, y, x) are
floating point values.  Some of the values are constrained to
be between zero and some upper bound; the upper bounds are
given in parentheses above.
The syntax for these values is an optional '+' or '-' sign,
a string of digits possibly containing a decimal point,
and an optional exponent field consisting of an 'E' or 'e'
followed by an optional '+' or '-' followed by a string of digits.

For more information on device independent color,
see the _Xlib_ reference manual.

<a name="keyboards"></a>

# Keyboards


The X keyboard model is broken into two layers:  server-specific codes
(called _keycodes_) which represent the physical keys, and
server-independent symbols (called _keysyms_) which
represent the letters or words that appear on the keys.
Two tables are kept in the server for converting keycodes to keysyms:

* _modifier list_  
  Some keys (such as Shift, Control, and Caps Lock) are known as _modifier_
  and are used to select different symbols that are attached to a single key
  (such as Shift-a generates a capital A, and Control-l generates a control
  character ^L).  The server keeps a list of keycodes corresponding to the
  various modifier keys.  Whenever a key is pressed or released, the server
  generates an _event_ that contains the keycode of the indicated key as
  well as a mask that specifies which of the modifier keys are currently pressed.
  Most servers set up this list to initially contain
  the various shift, control, and shift lock keys on the keyboard.
* _keymap table_  
  Applications translate event keycodes and modifier masks into keysyms
  using a _keysym table_ which contains one row for each keycode and one
  column for various modifier states.  This table is initialized by the server
  to correspond to normal typewriter conventions.  The exact semantics of
  how the table is interpreted to produce keysyms depends on the particular
  program, libraries, and language input method used, but the following
  conventions for the first four keysyms in each row are generally adhered to:

The first four elements of the list are split into two groups of keysyms.
Group 1 contains the first and second keysyms;
Group 2 contains the third and fourth keysyms.
Within each group,
if the first element is alphabetic and the
the second element is the special keysym _NoSymbol_,
then the group is treated as equivalent to a group in which
the first element is the lowercase letter and the second element
is the uppercase letter.

Switching between groups is controlled by the keysym named MODE SWITCH,
by attaching that keysym to some key and attaching
that key to any one of the modifiers Mod1 through Mod5.
This modifier is called the \`\`group modifier.''
Group 1 is used when the group modifier is off,
and Group 2 is used when the group modifier is on.

Within a group,
the modifier state determines which keysym to use.
The first keysym is used when the Shift and Lock modifiers are off.
The second keysym is used when the Shift modifier is on,
when the Lock modifier is on and the second keysym is uppercase alphabetic,
or when the Lock modifier is on and is interpreted as ShiftLock.
Otherwise, when the Lock modifier is on and is interpreted as CapsLock,
the state of the Shift modifier is applied first to select a keysym;
but if that keysym is lowercase alphabetic,
then the corresponding uppercase keysym is used instead.

<a name="options"></a>

# Options

Most X programs attempt to use the same names for command line options and
arguments.  All applications written with the X Toolkit Intrinsics
automatically accept the following options:

* **-display _display_**  
  This option specifies the name of the X server to use.
* **-geometry _geometry_**  
  This option specifies the initial size and location of the window.
* **-bg _color_, **-background color****  
  Either option specifies the color to use for the window background.
* **-bd _color_, **-bordercolor color****  
  Either option specifies the color to use for the window border.
* **-bw _number_, **-borderwidth number****  
  Either option specifies the width in pixels of the window border.
* **-fg _color_, **-foreground color****  
  Either option specifies the color to use for text or graphics.
* **-fn _font_, **-font font****  
  Either option specifies the font to use for displaying text.
* **-iconic**    
  This option indicates that the user would prefer that the application's
  windows initially not be visible as if the windows had be immediately
  iconified by the user.  Window managers may choose not to honor the
  application's request.
* **-name**    
  This option specifies the name under which resources for the
  application should be found.  This option is useful in shell
  aliases to distinguish between invocations of an application,
  without resorting to creating links to alter the executable file name.
* **-rv, **-reverse****  
  Either option indicates that the program should simulate reverse video if
  possible, often by swapping the foreground and background colors.  Not all
  programs honor this or implement it correctly.  It is usually only used on
  monochrome displays.
* **\+rv**    
  This option indicates that the program should not simulate reverse video.
  This is used to
  override any defaults since reverse video doesn't always work properly.
* **-selectionTimeout**  
  This option specifies the timeout in milliseconds within which two
  communicating applications must respond to one another for a selection
  request.
* **-synchronous**  
  This option indicates that requests to the X server should be sent
  synchronously, instead of asynchronously.  Since
  _Xlib_
  normally buffers requests to the server, errors do not necessarily get reported
  immediately after they occur.  This option turns off the buffering so that
  the application can be debugged.  It should never be used with a working
  program.
* **-title _string_**  
  This option specifies the title to be used for this window.  This information
  is sometimes
  used by a window manager to provide some sort of header identifying the window.
* **-xnllanguage _language[\_territory][.codeset]_**  
  This option specifies the language, territory, and codeset for use in
  resolving resource and other filenames.
* **-xrm _resourcestring_**  
  This option specifies a resource name and value to override any defaults.  It
  is also very useful for setting resources that don't have explicit command
  line arguments.

<a name="resources"></a>

# Resources

To make the tailoring of applications to personal preferences easier, X
provides a mechanism for storing default values for program resources
(e.g. background color, window title, etc.) that is used by programs that
use toolkits based on the X Toolkit Intrinsics library libXt.  (Programs
using the common Gtk+ and Qt toolkits use other configuration mechanisms.)
Resources are specified as strings
that are read in from various places when an application is run.
Program components are named in a hierarchical fashion,
with each node in the hierarchy identified by a class and an instance name.
At the top level is the class and instance name of the application itself.
By convention, the class name of the application is the same as the program
name, but with  the first letter capitalized (e.g. _Bitmap_ or _Emacs_)
although some programs that begin with the letter \`\`x'' also capitalize the
second letter for historical reasons.

The precise syntax for resources is:

    ResourceLine    =       Comment | IncludeFile | ResourceSpec | <empty line>
    Comment         =       "!" {<any character except null or newline>}
    IncludeFile     =       "#" WhiteSpace "include" WhiteSpace FileName WhiteSpace
    FileName        =       <valid filename for operating system>
    ResourceSpec    =       WhiteSpace ResourceName WhiteSpace ":" WhiteSpace Value
    ResourceName    =       [Binding] {Component Binding} ComponentName
    Binding         =       "." | "*"
    WhiteSpace      =       {<space> | <horizontal tab>}
    Component       =       "?" | ComponentName
    ComponentName   =       NameChar {NameChar}
    NameChar        =       "a"-"z" | "A"-"Z" | "0"-"9" | "_" | "-"
    Value           =       {<any character except null or unescaped newline>}

Elements separated by vertical bar (|) are alternatives.
Curly braces ({...}) indicate zero or more repetitions
of the enclosed elements.
Square brackets ([...]) indicate that the enclosed element is optional.
Quotes ("...") are used around literal characters.

IncludeFile lines are interpreted by replacing the line with the
contents of the specified file.  The word "include" must be in lowercase.
The filename is interpreted relative to the directory of the file in
which the line occurs (for example, if the filename contains no
directory or contains a relative directory specification).

If a ResourceName contains a contiguous sequence of two or more Binding
characters, the sequence will be replaced with single "." character
if the sequence contains only "." characters,
otherwise the sequence will be replaced with a single "*" character.

A resource database never contains more than one entry for a given
ResourceName.  If a resource file contains multiple lines with the
same ResourceName, the last line in the file is used.

Any whitespace character before or after the name or colon in a ResourceSpec
are ignored.
To allow a Value to begin with whitespace,
the two-character sequence \`\`\\\^_space_'' (backslash followed by space)
is recognized and replaced by a space character,
and the two-character sequence \`\`\\\^_tab_''
(backslash followed by horizontal tab)
is recognized and replaced by a horizontal tab character.
To allow a Value to contain embedded newline characters,
the two-character sequence \`\`\\\^n'' is recognized and replaced by a
newline character.
To allow a Value to be broken across multiple lines in a text file,
the two-character sequence \`\`\\\^_newline_''
(backslash followed by newline) is
recognized and removed from the value.
To allow a Value to contain arbitrary character codes,
the four-character sequence \`\`\\\^_nnn_'',
where each _n_ is a digit character in the range of \`\`0''-\`\`7'',
is recognized and replaced with a single byte that contains
the octal value specified by the sequence.
Finally, the two-character sequence \`\`\\\\'' is recognized
and replaced with a single backslash.

When an application looks for the value of a resource, it specifies
a complete path in the hierarchy, with both class and instance names.
However, resource values are usually given with only partially specified
names and classes, using pattern matching constructs.
An asterisk (*) is a loose binding and is used to represent any number
of intervening components, including none.
A period (.) is a tight binding and is used to separate immediately
adjacent components.
A question mark (?) is used to match any single component name or class.
A database entry cannot end in a loose binding;
the final component (which cannot be "?") must be specified.
The lookup algorithm searches the resource database for the entry that most
closely matches (is most specific for) the full name and class being queried.
When more than one database entry matches the full name and class,
precedence rules are used to select just one.

The full name and class are scanned from left to right (from highest
level in the hierarchy to lowest), one component at a time.
At each level, the corresponding component and/or binding of each
matching entry is determined, and these matching components and
bindings are compared according to precedence rules.
Each of the rules is applied at each level,
before moving to the next level,
until a rule selects a single entry over all others.
The rules (in order of precedence) are:

* 1.  
  An entry that contains a matching component (whether name, class, or "?")
  takes precedence over entries that elide the level (that is, entries
  that match the level in a loose binding).
* 2.  
  An entry with a matching name takes precedence over both
  entries with a matching class and entries that match using "?".
  An entry with a matching class takes precedence over
  entries that match using "?".
* 3.  
  An entry preceded by a tight binding takes precedence over entries
  preceded by a loose binding.

Programs based on the X Toolkit Intrinsics
obtain resources from the following sources
(other programs usually support some subset of these sources):

* **RESOURCE_MANAGER root window property**  
  Any global resources that should be available to clients on all machines
  should be stored in the RESOURCE_MANAGER property on the
  root window of the first screen using the _xrdb_ program.
  This is frequently taken care
  of when the user starts up X through the display manager or _xinit_.
* **SCREEN_RESOURCES root window property**  
  Any resources specific to a given screen (e.g. colors)
  that should be available to clients on all machines
  should be stored in the SCREEN_RESOURCES property on the
  root window of that screen.
  The _xrdb_ program will sort resources automatically and place them
  in RESOURCE_MANAGER or SCREEN_RESOURCES, as appropriate.
* **application-specific files**  
  Directories named by the environment variable XUSERFILESEARCHPATH
  or the environment variable XAPPLRESDIR (which names a single
  directory and should end with a '/' on POSIX systems), plus directories in a
  standard place (usually under /usr/share/X11/,
  but this can be overridden with the XFILESEARCHPATH environment variable)
  are searched for for application-specific resources.
  For example, application default resources are usually kept in
  /usr/share/X11/app-defaults/.
  See the _X Toolkit Intrinsics - C Language Interface_ manual for
  details.
* **XENVIRONMENT**  
  Any user- and machine-specific resources may be specified by setting
  the XENVIRONMENT environment variable to the name of a resource file
  to be loaded by all applications.  If this variable is not defined,
  a file named _$HOME_/.Xdefaults-_hostname_ is looked for instead,
  where _hostname_ is the name of the host where the application
  is executing.
* **-xrm _resourcestring_**  
  Resources can also be specified from the
  command line.  The _resourcestring_ is a single resource name and value as
  shown above.  Note that if the string contains characters interpreted by
  the shell (e.g., asterisk), they must be quoted.
  Any number of **-xrm** arguments may be given on the
  command line.

Program resources are organized into groups called _classes_, so that
collections of individual resources (each of which are
called _instances_)
can be set all at once.  By convention, the instance name of a resource
begins with a lowercase letter and class name with an upper case letter.
Multiple word resources are concatenated with the first letter of the
succeeding words capitalized.  Applications written with the X Toolkit
Intrinsics will have at least the following resources:


* **background (class Background)**  
  This resource specifies the color to use for the window background.


* **borderWidth (class BorderWidth)**  
  This resource specifies the width in pixels of the window border.


* **borderColor (class BorderColor)**  
  This resource specifies the color to use for the window border.

Most applications using the X Toolkit Intrinsics also have the resource
**foreground**
(class **Foreground**), specifying the color to use for text
and graphics within the window.

By combining class and instance specifications, application preferences
can be set quickly and easily.  Users of color displays will frequently
want to set Background and Foreground classes to particular defaults.
Specific color instances such as text cursors can then be overridden
without having to define all of the related resources.  For example,

        bitmap*Dashed:  off
        XTerm*cursorColor:  gold
        XTerm*multiScroll:  on
        XTerm*jumpScroll:  on
        XTerm*reverseWrap:  on
        XTerm*curses:  on
        XTerm*Font:  6x10
        XTerm*scrollBar: on
        XTerm*scrollbar*thickness: 5
        XTerm*multiClickTime: 500
        XTerm*charClass:  33:48,37:48,45-47:48,64:48
        XTerm*cutNewline: off
        XTerm*cutToBeginningOfLine: off
        XTerm*titeInhibit:  on
        XTerm*ttyModes:  intr ^c erase ^? kill ^u
        XLoad*Background: gold
        XLoad*Foreground: red
        XLoad*highlight: black
        XLoad*borderWidth: 0
        emacs*Geometry:  80x65-0-0
        emacs*Background:  rgb:5b/76/86
        emacs*Foreground:  white
        emacs*Cursor:  white
        emacs*BorderColor:  white
        emacs*Font:  6x10
        xmag*geometry: -0-0
        xmag*borderColor:  white

If these resources were stored in a file called _.Xresources_ in your home
directory, they could be added to any existing resources in the server with
the following command:

        % xrdb -merge $HOME/.Xresources

This is frequently how user-friendly startup scripts merge user-specific
defaults
into any site-wide defaults.  All sites are encouraged to set up convenient
ways of automatically loading resources. See the _Xlib_
manual section _Resource Manager Functions_ for more information.

<a name="environment"></a>

# Environment


* **DISPLAY**  
  This is the only mandatory environment variable. It must point to an
  X server. See section "Display Names" above.
* **XAUTHORITY**  
  This must point to a file that contains authorization data. The default
  is _$HOME/.Xauthority_. See
  **Xsecurity**(7),
  **xauth**(1),
  **xdm**(1),
  **Xau**(3).
* **ICEAUTHORITY**  
  This must point to a file that contains authorization data. The default
  is _$HOME/.ICEauthority_.
* **LC_ALL**, **LC_CTYPE**, **LANG**  
  The first non-empty value among these three determines the current
  locale's facet for character handling, and in particular the default
  text encoding. See
  **locale**(7),
  **setlocale**(3),
  **locale**(1).
* **XMODIFIERS**  
  This variable can be set to contain additional information important
  for the current locale setting. Typically set to _@im=&lt;input-method&gt;_
  to enable a particular input method. See
  **XSetLocaleModifiers**(3).
* **XLOCALEDIR**  
  This must point to a directory containing the locale.alias file and
  Compose and XLC_LOCALE file hierarchies for all locales. The default value
  is_ /usr/share/X11/locale_.
* **XENVIRONMENT**  
  This must point to a file containing X resources. The default is
  _$HOME/.Xdefaults-&lt;hostname&gt;_. Unlike _$HOME/.Xresources_,
  it is consulted each time an X application starts.
* **XFILESEARCHPATH**  
  This must contain a colon separated list of path templates, where libXt
  will search for resource files. The default value consists of

        /etc/X11/%L/%T/%N%C%S:&nbsp;   /etc/X11/%l/%T/%N%C%S:&nbsp;   /etc/X11/%T/%N%C%S:&nbsp;   /etc/X11/%L/%T/%N%S:&nbsp;   /etc/X11/%l/%T/%N%S:&nbsp;   /etc/X11/%T/%N%S:&nbsp;   /usr/share/X11/%L/%T/%N%C%S:&nbsp;   /usr/share/X11/%l/%T/%N%C%S:&nbsp;   /usr/share/X11/%T/%N%C%S:&nbsp;   /usr/share/X11/%L/%T/%N%S:&nbsp;   /usr/share/X11/%l/%T/%N%S:&nbsp;   /usr/share/X11/%T/%N%S:&nbsp;   /usr/lib/X11/%L/%T/%N%C%S:&nbsp;   /usr/lib/X11/%l/%T/%N%C%S:&nbsp;   /usr/lib/X11/%T/%N%C%S:&nbsp;   /usr/lib/X11/%L/%T/%N%S:&nbsp;   /usr/lib/X11/%l/%T/%N%S:&nbsp;   /usr/lib/X11/%T/%N%S

A path template is transformed to a pathname by substituting:

        %D => the implementation-specific default path
        %N => name (basename) being searched for
        %T => type (dirname) being searched for
        %S => suffix being searched for
        %C => value of the resource "customization"
              (class "Customization")
        %L => the locale name
        %l => the locale's language (part before '_')
        %t => the locale's territory (part after '_` but before '.')
        %c => the locale's encoding (part after '.')

* **XUSERFILESEARCHPATH**  
  This must contain a colon separated list of path templates,
  where libXt will search for user dependent resource files. The default
  value is:

        $XAPPLRESDIR/%L/%N%C:&nbsp;   $XAPPLRESDIR/%l/%N%C:&nbsp;   $XAPPLRESDIR/%N%C:&nbsp;   $HOME/%N%C:&nbsp;   $XAPPLRESDIR/%L/%N:&nbsp;   $XAPPLRESDIR/%l/%N:&nbsp;   $XAPPLRESDIR/%N:&nbsp;   $HOME/%N

$XAPPLRESDIR defaults to _$HOME_, see below.

A path template is transformed to a pathname by substituting:

        %D => the implementation-specific default path
        %N => name (basename) being searched for
        %T => type (dirname) being searched for
        %S => suffix being searched for
        %C => value of the resource "customization"
              (class "Customization")
        %L => the locale name
        %l => the locale's language (part before '_')
        %t => the locale's territory (part after '_` but before '.')
        %c => the locale's encoding (part after '.')

* **XAPPLRESDIR**  
  This must point to a base directory where the user stores the application
  dependent resource files. The default value is _$HOME_. Only used if
  XUSERFILESEARCHPATH is not set.
* **XKEYSYMDB**  
  This must point to a file containing nonstandard keysym definitions.
  The default value is_ /usr/share/X11/XKeysymDB_.
* **XCMSDB**  
  This must point to a color name database file. The default value is
  _ /usr/lib/X11/Xcms.txt_.
* **RESOURCE_NAME**  
  This serves as main identifier for resources belonging to the program
  being executed. It defaults to the basename of pathname of the program.
* **SESSION_MANAGER**  
  Denotes the session manager to which the application should connect. See
  **xsm**(1),
  **rstart**(1).
* **XF86BIGFONT_DISABLE**  
  Setting this variable to a non-empty value disables the XFree86-Bigfont
  extension. This extension is a mechanism to reduce the memory consumption
  of big fonts by use of shared memory.

**XKB_FORCE**  
**XKB_DISABLE**  
**XKB_DEBUG**  
**_XKB_CHARSET**  
**_XKB_LOCALE_CHARSETS**  
**_XKB_OPTIONS_ENABLE**  
**_XKB_LATIN1_LOOKUP**  
**_XKB_CONSUME_LOOKUP_MODS**  
**_XKB_CONSUME_SHIFT_AND_LOCK**  
**_XKB_IGNORE_NEW_KEYBOARDS**  
**_XKB_CONTROL_FALLBACK**  
**_XKB_COMP_LED**
**_XKB_COMP_FAIL_BEEP**

These variables influence the X Keyboard Extension.

<a name="examples"></a>

# Examples

The following is a collection of sample command lines for some of the
more frequently used commands.  For more information on a particular command,
please refer to that command's manual page.

        %  xrdb $HOME/.Xresources
        %  xmodmap -e "keysym BackSpace = Delete"
        %  mkfontdir /usr/local/lib/X11/otherfonts
        %  xset fp+ /usr/local/lib/X11/otherfonts
        %  xmodmap $HOME/.keymap.km
        %  xsetroot -solid 'rgbi:.8/.8/.8'
        %  xset b 100 400 c 50 s 1800 r on
        %  xset q
        %  twm
        %  xmag
        %  xclock -geometry 48x48-0+0 -bg blue -fg white
        %  xeyes -geometry 48x48-48+0
        %  xbiff -update 20
        %  xlsfonts '*helvetica*'
        %  xwininfo -root
        %  xdpyinfo -display joesworkstation:0
        %  xhost -joesworkstation
        %  xrefresh
        %  xwd | xwud
        %  bitmap companylogo.bm 32x32
        %  xcalc -bg blue -fg magenta
        %  xterm -geometry 80x66-0-0 -name myxterm $*

<a name="diagnostics"></a>

# Diagnostics

A wide variety of error messages are generated from various programs.
The default error handler in _Xlib_ (also used by many toolkits) uses
standard resources to construct diagnostic messages when errors occur.  The
defaults for these messages are usually stored in
_usr/share/X11/XErrorDB_.  If this file is not present,
error messages will be rather terse and cryptic.

When the X Toolkit Intrinsics encounter errors converting resource strings to
the
appropriate internal format, no error messages are usually printed.  This is
convenient when it is desirable to have one set of resources across a variety
of displays (e.g. color vs. monochrome, lots of fonts vs. very few, etc.),
although it can pose problems for trying to determine why an application might
be failing.  This behavior can be overridden by the setting the
_StringConversionWarnings_ resource.

To force the X Toolkit Intrinsics to always print string conversion error
messages,
the following resource should be placed in the file that gets
loaded onto the RESOURCE_MANAGER property
using the _xrdb_ program (frequently called _.Xresources_
or _.Xres_ in the user's home directory):

        *StringConversionWarnings: on

To have conversion messages printed for just a particular application,
the appropriate instance name can be placed before the asterisk:

        xterm*StringConversionWarnings: on

<a name="see-also"></a>

# See Also



**XOrgFoundation**(7),
**XStandards**(7),
**Xsecurity**(7),

**appres**(1),
**bdftopcf**(1),
**bitmap**(1),
**editres**(1),
**fsinfo**(1),
**fslsfonts**(1),
**fstobdf**(1),
**iceauth**(1),
**imake**(1),
**makedepend**(1),
**mkfontdir**(1),
**oclock**(1),
**proxymngr**(1),
**rgb**(1),
**resize**(1),
**rstart**(1),
**smproxy**(1),
**twm**(1),
**x11perf**(1),
**x11perfcomp**(1),
**xauth**(1),
**xclipboard**(1),
**xclock**(1),
**xcmsdb**(1),
**xconsole**(1),
**xdm**(1),
**xdpyinfo**(1),
**xfd**(1),
**xfindproxy**(1),
**xfs**(1),
**xfwp**(1),
**xhost**(1),
**xinit**(1),
**xkbbell**(1),
**xkbcomp**(1),
**xkbevd**(1),
**xkbprint**(1),
**xkbvleds**(1),
**xkbwatch**(1),
**xkill**(1),
**xlogo**(1),
**xlsatoms**(1),
**xlsclients**(1),
**xlsfonts**(1),
**xmag**(1),
**xmh**(1),
**xmodmap**(1),
**xprop**(1),
**xrdb**(1),
**xrefresh**(1),
**xrx**(1),
**xset**(1),
**xsetroot**(1),
**xsm**(1),
**xstdcmap**(1),
**xterm**(1),
**xwd**(1),
**xwininfo**(1),
**xwud**(1).

**Xserver**(1),
**Xorg**(1),
**Xdmx**(1),
**Xephyr**(1),
**Xnest**(1),
**Xquartz**(1),
**Xvfb**(1),
**Xvnc**(1),
**XWin**(1).

_Xlib - C Language X Interface,_
and
_X Toolkit Intrinsics - C Language Interface_

<a name="trademarks"></a>

# Trademarks


X Window System is a trademark of The Open Group.

<a name="authors"></a>

# Authors


A cast of thousands, literally.  Releases 6.7 and later are
brought to you by the X.Org Foundation. The names of all people who
made it a reality will be found in the individual documents and
source files.

Releases 6.6 and 6.5 were done by The X.Org Group.  Release 6.4 was done by
The X Project Team.  The Release 6.3 distribution was from The X Consortium,
Inc.  The staff members at the X Consortium responsible for that release
were: Donna Converse (emeritus), Stephen Gildea (emeritus), Kaleb Keithley,
Matt Landau (emeritus), Ralph Mor (emeritus), Janet O'Halloran, Bob
Scheifler, Ralph Swick, Dave Wiggins (emeritus), and Reed Augliere.

The X Window System standard was originally developed at the
Laboratory for Computer Science at the Massachusetts Institute
of Technology, and all rights thereto were assigned to the X Consortium
on January 1, 1994.
X Consortium, Inc. closed its doors on December 31, 1996.  All rights to the
X Window System have been assigned to The Open Group.
