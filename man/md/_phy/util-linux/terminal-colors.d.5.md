# terminal_colors.d(5) - Configure output colorization for various utilities

util-linux, January 2014

```
/etc/terminal-colors.d/[[name][@term].][type]
```

<a name="description"></a>

# Description

Files in this directory determine the default behavior for utilities
when coloring output.

The
_name_
is a utility name.  The name is optional and when none is specified then the
file is used for all unspecified utilities.

The
_term_
is a terminal identifier (the TERM environment variable).
The terminal identifier is optional and when none is specified then the file
is used for all unspecified terminals.

The
_type_
is a file type.  Supported file types are:

* **disable**  
  Turns off output colorization for all compatible utilities.
* **enable**  
  Turns on output colorization; any matching
  **disable**
  files are ignored.
* **scheme**  
  Specifies colors used for output.  The file format may be specific to the utility,
  the default format is described below.

If there are more files that match for a utility, then the file with the more
specific filename wins.  For example, the filename "@xterm.scheme" has less
priority than "dmesg@xterm.scheme".  The lowest priority are those files without a
utility name and terminal identifier (e.g. "disable").

The user-specific
_$XDG_CONFIG_HOME/terminal-colors.d_
or
_$HOME/.config/terminal-colors.d_
overrides the global setting.


<a name="examples"></a>

# Examples

Disable colors for all compatible utilities:  
**touch /etc/terminal-colors.d/disable**  

Disable colors for all compatible utils on a vt100 terminal:  
**touch /etc/terminal-colors.d/@vt100.disable**  

Disable colors for all compatible utils except dmesg(1):  
**touch /etc/terminal-colors.d/disable**

**touch /etc/terminal-colors.d/dmesg.enable**  


<a name="default-scheme-files-format"></a>

# Default Scheme Files Format

The following statement is recognized:
  
**name color-sequence**  

The
**name**
is a logical name of color sequence (for example "error").  The names are
specific to the utilities.  For more details always see the COLORS section
in the man page for the utility.

The
**color-sequence**
is a color name, ASCII color sequences or escape sequences.


<a name="color-names"></a>

### Color names

black, blink, blue, bold, brown, cyan, darkgray, gray, green, halfbright,
lightblue, lightcyan, lightgray, lightgreen, lightmagenta, lightred, magenta,
red, reset, reverse, and yellow.


<a name="ansi-color-sequences"></a>

### ANSI color sequences

The color sequences are composed of sequences of numbers
separated by semicolons.  The most common codes are:

.TS
l l.
 0	to restore default color
 1	for brighter colors
 4	for underlined text
 5	for flashing text
30	for black foreground
31	for red foreground
32	for green foreground
33	for yellow (or brown) foreground
34	for blue foreground
35	for purple foreground
36	for cyan foreground
37	for white (or gray) foreground
40	for black background
41	for red background
42	for green background
43	for yellow (or brown) background
44	for blue background
45	for purple background
46	for cyan background
47	for white (or gray) background
.TE

<a name="escape-sequences"></a>

### Escape sequences

To specify control or blank characters in the color sequences,
C-style \e-escaped notation can be used:

.TS
lb l.
\ea	Bell (ASCII 7)
\eb	Backspace (ASCII 8)
\ee	Escape (ASCII 27)
\ef	Form feed (ASCII 12)
\en	Newline (ASCII 10)
\er	Carriage Return (ASCII 13)
\et	Tab (ASCII 9)
\ev	Vertical Tab (ASCII 11)
\e?	Delete (ASCII 127)
\e_	Space
\e\e	Backslash (\e)
\e^	Caret (^)
\e#	Hash mark (#)
.TE

Please note that escapes are necessary to enter a space, backslash,
caret, or any control character anywhere in the string, as well as a
hash mark as the first character.

For example, to use a red background for alert messages in the output of
**dmesg**(1),
use:
  
**echo 'alert 37;41' &gt;&gt; /etc/terminal-colors.d/dmesg.scheme**  


<a name="comments"></a>

### Comments

Lines where the first non-blank character is a # (hash) are ignored.
Any other use of the hash character is not interpreted as introducing
a comment.


<a name="files"></a>

# Files

_$XDG_CONFIG_HOME/terminal-colors.d_  
_$HOME/.config/terminal-colors.d_  
_/etc/terminal-colors.d_


<a name="environment"></a>

# Environment


* TERMINAL_COLORS_DEBUG=all  
  enables debug output.
  

<a name="compatibility"></a>

# Compatibility

The terminal-colors.d functionality is currently supported by all util-linux
utilities which provides colorized output.  For more details always see the
COLORS section in the man page for the utility.


<a name="availability"></a>

# Availability

terminal-colors.d is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
