# tabs(1)

""

.ie \n(.g .ds \`\` “
.el       .ds \`\` \`\`
.ie \n(.g .ds '' ”
.el       .ds '' ''

<a name="name"></a>

# Name

**tabs** - set tabs on a terminal

<a name="synopsis"></a>

# Synopsis

```
tabs [options]] [tabstop-list]
```

<a name="description"></a>

# Description


The **tabs** program clears and sets tab-stops on the terminal.
This uses the terminfo _clear\_all\_tabs_ and _set\_tab_ capabilities.
If either is absent, **tabs** is unable to clear/set tab-stops.
The terminal should be configured to use hard tabs, e.g.,
.NS
stty tab0
.NE

Like **clear**(1), **tabs** writes to the standard output.
You can redirect the standard output to a file (which prevents
**tabs** from actually changing the tabstops),
and later **cat** the file to the screen, setting tabstops at that point.

<a name="options"></a>

# Options


<a name="general-options"></a>

### General Options


* **-T**_name_  
  Tell **tabs** which terminal type to use.
  If this option is not given, **tabs** will use the **$TERM**
  environment variable.
  If that is not set, it will use the _ansi+tabs_ entry.
* **-d**  
  The debugging option shows a ruler line, followed by two data lines.
  The first data line shows the expected tab-stops marked with asterisks.
  The second data line shows the actual tab-stops, marked with asterisks.
* **-n**  
  This option tells **tabs** to check the options and run any debugging
  option, but not to modify the terminal settings.
* **-V**  
  reports the version of ncurses which was used in this program, and exits.

The **tabs** program processes a single list of tab stops.
The last option to be processed which defines a list is the one that
determines the list to be processed.

<a name="implicit-lists"></a>

### Implicit Lists

Use a single number as an option,
e.g., \`**-5**\*('' to set tabs at the given
interval (in this case 1, 6, 11, 16, 21, etc.).
Tabs are repeated up to the right margin of the screen.

Use \`**-0**\*('' to clear all tabs.

Use \`**-8**\*('' to set tabs to the standard interval.

<a name="explicit-lists"></a>

### Explicit Lists

An explicit list can be defined after the options
(this does not use a \`-\*('').
The values in the list must be in increasing numeric order,
and greater than zero.
They are separated by a comma or a blank, for example,
.NS
tabs 1,6,11,16,21  
tabs 1 6 11 16 21
.NE

Use a \`+\*('' to treat a number
as an increment relative to the previous value,
e.g.,
.NS
tabs 1,+5,+5,+5,+5
.NE

which is equivalent to the 1,6,11,16,21 example.

<a name="predefined-tab-stops"></a>

### Predefined Tab-Stops

X/Open defines several predefined lists of tab stops.

* **-a**  
  Assembler, IBM S/370, first format
* **-a2**  
  Assembler, IBM S/370, second format
* **-c**  
  COBOL, normal format
* **-c2**  
  COBOL compact format
* **-c3**  
  COBOL compact format extended
* **-f**  
  FORTRAN
* **-p**  
  PL/I
* **-s**  
  SNOBOL
* **-u**  
  UNIVAC 1100 Assembler

<a name="portability"></a>

# Portability


_IEEE Std 1003.1/The Open Group Base Specifications Issue 7_ (POSIX.1-2008)
describes a **tabs** utility.
However
.bP
This standard describes a **+m** option, to set a terminal's left-margin.
Very few of the entries in the terminal database provide this capability.
.bP
There is no counterpart in X/Open Curses Issue 7 for this utility,
unlike **tput(1)**.

The **-d** (debug) and **-n** (no-op) options are extensions not provided
by other implementations.

Documentation for other implementations states that there is a limit on the
number of tab stops.
While some terminals may not accept an arbitrary number
of tab stops, this implementation will attempt to set tab stops up to the
right margin of the screen, if the given list happens to be that long.

<a name="see-also"></a>

# See Also

**tset**(1),
**infocmp**(1M),
**curses**(3X),
**terminfo**(5).

This describes **ncurses**
version 6.1 (patch 20180923).
