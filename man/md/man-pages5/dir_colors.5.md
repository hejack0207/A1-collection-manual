# dir_colors(5) - configuration file for dircolors(1)

GNU, 2013-08-09


<a name="description"></a>

# Description

The program
**ls**(1)
uses the environment variable
**LS_COLORS**
to determine the colors in which the filenames are to be displayed.
This environment variable is usually set by a command like

eval \\`dircolors some_path/dir_colors\\`

found in a system default shell initialization file, like
_/etc/profile_
or
_/etc/csh.cshrc_.
(See also
**dircolors**(1).)
Usually, the file used here is
_/etc/DIR_COLORS_
and can be overridden by a
_.dir_colors_
file in one's home directory.

This configuration file consists of several statements, one per line.
Anything right of a hash mark (#) is treated as a comment, if the
hash mark is at the beginning of a line or is preceded by at least one
whitespace.
Blank lines are ignored.

The
_global_
section of the file consists of any statement before the first
**TERM**
statement.
Any statement in the global section of the file is
considered valid for all terminal types.
Following the global section
is one or more
_terminal-specific_
sections, preceded by one or more
**TERM**
statements which specify the terminal types (as given by the
**TERM**
environment variable) the following declarations apply to.
It is always possible to override a global declaration by a subsequent
terminal-specific one.

The following statements are recognized; case is insignificant:

* **TERM _terminal-type_**  
  Starts a terminal-specific section and specifies which terminal it
  applies to.
  Multiple
  **TERM**
  statements can be used to create a section which applies for several
  terminal types.
* **COLOR yes|all|no|none|tty**  
  (Slackware only; ignored by GNU
  **dircolors**(1).)
  Specifies that colorization should always be enabled (_yes_ or
  _all_), never enabled (_no_ or _none_), or enabled only if
  the output is a terminal (_tty_).
  The default is _no_.
* **EIGHTBIT yes|no**  
  (Slackware only; ignored by GNU
  **dircolors**(1).)
  Specifies that eight-bit ISO 8859 characters should be enabled by
  default.
  For compatibility reasons, this can also be specified as 1 for
  _yes_ or 0 for _no_.
  The default is _no_.
* **OPTIONS _options_**  
  (Slackware only; ignored by GNU
  **dircolors**(1).)
  Adds command-line options to the default
  **ls**
  command line.
  The options can be any valid
  **ls**
  command-line options, and should include the leading minus sign.
  Note that
  **dircolors**
  does not verify the validity of these options.
* **NORMAL _color-sequence_**  
  Specifies the color used for normal (nonfilename) text.
* Synonym:
  **NORM**.
* **FILE _color-sequence_**  
  Specifies the color used for a regular file.
* **DIR _color-sequence_**  
  Specifies the color used for directories.
* **LINK _color-sequence_**  
  Specifies the color used for a symbolic link.
* Synonyms:
  **LNK**,
  **SYMLINK**.
* **ORPHAN _color-sequence_**  
  Specifies the color used for an orphaned symbolic link (one which
  points to a nonexistent file).
  If this is unspecified,
  **ls**
  will use the
  **LINK**
  color instead.
* **MISSING _color-sequence_**  
  Specifies the color used for a missing file (a nonexistent file which
  nevertheless has a symbolic link pointing to it).
  If this is unspecified,
  **ls**
  will use the
  **FILE**
  color instead.
* **FIFO _color-sequence_**  
  Specifies the color used for a FIFO (named pipe).
* Synonym:
  **PIPE**.
* **SOCK _color-sequence_**  
  Specifies the color used for a socket.
* **DOOR _color-sequence_**  
  (Supported since fileutils 4.1)
  Specifies the color used for a door (Solaris 2.5 and later).
* **BLK _color-sequence_**  
  Specifies the color used for a block device special file.
* Synonym:
  **BLOCK**.
* **CHR _color-sequence_**  
  Specifies the color used for a character device special file.
* Synonym:
  **CHAR**.
* **EXEC _color-sequence_**  
  Specifies the color used for a file with the executable attribute set.
* **SUID _color-sequence_**  
  Specifies the color used for a file with the set-user-ID attribute set.
* Synonym:
  **SETUID**.
* **SGID _color-sequence_**  
  Specifies the color used for a file with the set-group-ID attribute set.
* Synonym:
  **SETGID**.
* **STICKY _color-sequence_**  
  Specifies the color used for a directory with the sticky attribute set.
* **STICKY_OTHER_WRITABLE _color-sequence_**  
  Specifies the color used for an other-writable directory with the executable attribute set.
* Synonym:
  **OWT**.
* **OTHER_WRITABLE _color-sequence_**  
  Specifies the color used for an other-writable directory without the executable attribute set.
* Synonym:
  **OWR**.
* **LEFTCODE _color-sequence_**  
  Specifies the
  _left code_
  for non-ISO&nbsp;6429 terminals (see below).
* Synonym:
  **LEFT**.
* **RIGHTCODE _color-sequence_**  
  Specifies the
  _right code_
  for non-ISO&nbsp;6429 terminals (see below).
* Synonym:
  **RIGHT**.
* **ENDCODE _color-sequence_**  
  Specifies the
  _end code_
  for non-ISO&nbsp;6429 terminals (see below).
* Synonym:
  **END**.
* ***_extension** color-sequence_  
  Specifies the color used for any file that ends in _extension_.
* ** ._extension** color-sequence_  
  Same as ***.extension**.
  Specifies the color used for any file that
  ends in ._extension_.
  Note that the period is included in the
  extension, which makes it impossible to specify an extension not
  starting with a period, such as
  **~**
  for
  **emacs**
  backup files.
  This form should be considered obsolete.

<a name="iso-6429-ansi-color-sequences"></a>

### ISO 6429 (ANSI) color sequences

Most color-capable ASCII terminals today use ISO 6429 (ANSI) color sequences,
and many common terminals without color capability, including
**xterm**
and the widely used and cloned DEC VT100, will recognize ISO 6429 color
codes and harmlessly eliminate them from the output or emulate them.
**ls**
uses ISO 6429 codes by default, assuming colorization is enabled.

ISO 6429 color sequences are composed of sequences of numbers
separated by semicolons.
The most common codes are:
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

Not all commands will work on all systems or display devices.

**ls**
uses the following defaults:
.TS
lb l l.
NORMAL	0       	Normal (nonfilename) text
FILE	0       	Regular file
DIR	32      	Directory
LINK	36      	Symbolic link
ORPHAN	undefined	Orphaned symbolic link
MISSING	undefined	Missing file
FIFO	31      	Named pipe (FIFO)
SOCK	33      	Socket
BLK	44;37   	Block device
CHR	44;37   	Character device
EXEC	35      	Executable file
.TE

A few terminal programs do not recognize the default
properly.
If all text gets colorized after you do a directory
listing, change the
**NORMAL**
and
**FILE**
codes to the numerical codes for your normal foreground and background
colors.

<a name="other-terminal-types-advanced-configuration"></a>

### Other terminal types (advanced configuration)

If you have a color-capable (or otherwise highlighting) terminal (or
printer!) which uses a different set of codes, you can still generate
a suitable setup.
To do so, you will have to use the
**LEFTCODE**,
**RIGHTCODE**,
and
**ENDCODE**
definitions.

When writing out a filename,
**ls**
generates the following output sequence:
**LEFTCODE**
_typecode_
**RIGHTCODE**
_filename_
**ENDCODE**,
where the
_typecode_
is the color sequence that depends on the type or name of file.
If the
**ENDCODE**
is undefined, the sequence
**LEFTCODE NORMAL RIGHTCODE**
will be used instead.
The purpose of the left- and rightcodes is
merely to reduce the amount of typing necessary (and to hide ugly
escape codes away from the user).
If they are not appropriate for
your terminal, you can eliminate them by specifying the respective
keyword on a line by itself.

**NOTE:**
If the
**ENDCODE**
is defined in the global section of the setup file, it
_cannot_
be undefined in a terminal-specific section of the file.
This means any
**NORMAL**
definition will have no effect.
A different
**ENDCODE**
can, however, be specified, which would have the same effect.

<a name="escape-sequences"></a>

### Escape sequences

To specify control- or blank characters in the color sequences or
filename extensions, either C-style \e-escaped notation or
**stty**-style
^-notation can be used.
The C-style notation
includes the following characters:
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
\ennn	Any character (octal notation)
\exnnn	Any character (hexadecimal notation)
\e_	Space
\e\e	Backslash (\e)
\e^	Caret (^)
\e#	Hash mark (#)
.TE

Note that escapes are necessary to enter a space, backslash,
caret, or any control character anywhere in the string, as well as a
hash mark as the first character.

<a name="files"></a>

# Files


* _/etc/DIR_COLORS_  
  System-wide configuration file.
* _~/.dir_colors_  
  Per-user configuration file.

This page describes the
**dir_colors**
file format as used in the fileutils-4.1 package;
other versions may differ slightly.

<a name="notes"></a>

# Notes

The default
**LEFTCODE**
and
**RIGHTCODE**
definitions, which are used by ISO 6429 terminals are:
.TS
lb l.
LEFTCODE	\ee[
RIGHTCODE	m
.TE

The default
**ENDCODE**
is undefined.

<a name="see-also"></a>

# See Also

**dircolors**(1),
**ls**(1),
**stty**(1),
**xterm**(1)

<a name="colophon"></a>

# Colophon

This page is part of release 4.16 of the Linux
_man-pages_
project.
A description of the project,
information about reporting bugs,
and the latest version of this page,
can be found at
https://www.kernel.org/doc/man-pages/.
