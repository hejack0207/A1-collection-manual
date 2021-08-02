# more(1) - file perusal filter for crt viewing

util-linux, February 2014

```
more [options] file...
```

<a name="description"></a>

# Description

**more**
is a filter for paging through text one screenful at a time.  This version is
especially primitive.  Users should realize that
**less**(1)
provides
**more**(1)
emulation plus extensive enhancements.

<a name="options"></a>

# Options

Options are also taken from the environment variable
**MORE**
(make sure to precede them with a dash
(**-**))
but command-line options will override those.

* **-d**  
  Prompt with "[Press space to continue, 'q' to quit.]",
  and display "[Press 'h' for instructions.]" instead of ringing
  the bell when an illegal key is pressed.
* **-l**  
  Do not pause after any line containing a
  **^L**
  (form feed).
* **-f**  
  Count logical lines, rather than screen lines (i.e., long lines are not folded).
* **-p**  
  Do not scroll.  Instead, clear the whole screen and then display the text.
  Notice that this option is switched on automatically if the executable is
  named
  **page**.
* **-c**  
  Do not scroll.  Instead, paint each screen from the top, clearing the
  remainder of each line as it is displayed.
* **-s**  
  Squeeze multiple blank lines into one.
* **-u**  
  Suppress underlining.
* **-**_number_  
  The screen size to use, in
  _number_
  of lines.
* **+**_number_  
  Start displaying each file at line
  _number_.
* **+/**_string_  
  The
  _string_
  to be searched in each file before starting to display it.
* **--help**  
  Display help text and exit.
* **-V**, **--version**  
  Display version information and exit.

<a name="commands"></a>

# Commands

Interactive commands for
**more**
are based on
**vi**(1).
Some commands may be preceded by a decimal number, called k in the
descriptions below.  In the following descriptions,
**^X**
means
**control-X**.


* **h**&nbsp;or**&nbsp;?**  
  Help; display a summary of these commands.  If you forget all other
  commands, remember this one.
* **SPACE**  
  Display next k lines of text.  Defaults to current screen size.
* **z**  
  Display next k lines of text.  Defaults to current screen size.  Argument
  becomes new default.
* **RETURN**  
  Display next k lines of text.  Defaults to 1.  Argument becomes new default.
* **d**&nbsp;or**&nbsp;^D**  
  Scroll k lines.  Default is current scroll size, initially 11.  Argument
  becomes new default.
* **q**&nbsp;or**&nbsp;Q**&nbsp;or**&nbsp;INTERRUPT**  
  Exit.
* **s**  
  Skip forward k lines of text.  Defaults to 1.
* **f**  
  Skip forward k screenfuls of text.  Defaults to 1.
* **b**&nbsp;or**&nbsp;^B**  
  Skip backwards k screenfuls of text.  Defaults to 1.  Only works with files,
  not pipes.
* **'**  
  Go to the place where the last search started.
* **=**  
  Display current line number.
* **/pattern**  
  Search for kth occurrence of regular expression.  Defaults to 1.
* **n**  
  Search for kth occurrence of last regular expression.  Defaults to 1.
* **!command**&nbsp;or**&nbsp;:!command**  
  Execute
  _command_
  in a subshell.
* **v**  
  Start up an editor at current line.  The editor is taken from the environment
  variable
  **VISUAL**
  if defined, or
  **EDITOR**
  if
  **VISUAL**
  is not defined, or defaults
  to
  **vi**
  if neither
  **VISUAL**
  nor
  **EDITOR**
  is defined.
* **^L**  
  Redraw screen.
* **:n**  
  Go to kth next file.  Defaults to 1.
* **:p**  
  Go to kth previous file.  Defaults to 1.
* **:f**  
  Display current file name and line number.
* **.**  
  Repeat previous command.

<a name="environment"></a>

# Environment

The
**more**
command respects the following environment variables, if they exist:

* **MORE**  
  This variable may be set with favored options to
  **more**.
* **SHELL**  
  Current shell in use (normally set by the shell at login time).
* **TERM**  
  The terminal type used by **more** to get the terminal
  characteristics necessary to manipulate the screen.
* **VISUAL**  
  The editor the user prefers.  Invoked when command key
  _v_
  is pressed.
* **EDITOR**  
  The editor of choice when
  **VISUAL**
  is not specified.

<a name="see-also"></a>

# See Also

**less**(1),
**vi**(1)

<a name="authors"></a>

# Authors

Eric Shienbrood, UC Berkeley  
Modified by Geoff Peck, UCB to add underlining, single spacing  
Modified by John Foderaro, UCB to add -c and MORE environment variable

<a name="history"></a>

# History

The
**more**
command appeared in 3.0BSD.  This man page documents
**more**
version 5.19 (Berkeley 6/29/88), which is currently in use in the Linux
community.  Documentation was produced using several other versions of the
man page, and extensive inspection of the source code.

<a name="availability"></a>

# Availability

The more command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
