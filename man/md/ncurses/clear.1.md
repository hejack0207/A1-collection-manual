# clear(1)

""

.ie \n(.g .ds \`\` “
.el       .ds \`\` \`\`
.ie \n(.g .ds '' ”
.el       .ds '' ''

<a name="name"></a>

# Name

**clear** - clear the terminal screen

<a name="synopsis"></a>

# Synopsis

```
clear [-Ttype] [-V] [-x]

```

<a name="description"></a>

# Description

**clear** clears your screen if this is possible,
including its scrollback buffer
(if the extended \`E3\*('' capability is defined).
**clear** looks in the environment for the terminal type
given by the environment variable **TERM**,
and then in the
**terminfo** database to determine how to clear the screen.

**clear** writes to the standard output.
You can redirect the standard output to a file (which prevents
**clear** from actually clearing the screen),
and later **cat** the file to the screen, clearing it at that point.

<a name="options"></a>

# Options



* **-T _type_**  
  indicates the _type_ of terminal.
  Normally this option is
  unnecessary, because the default is taken from the environment
  variable **TERM**.
  If **-T** is specified, then the shell
  variables **LINES** and **COLUMNS** will also be ignored.
* **-V**  
  reports the version of ncurses which was used in this program, and exits.
  The options are as follows:
* **-x**  
  do not attempt to clear the terminal's scrollback buffer
  using the extended \`E3\*('' capability.

<a name="history"></a>

# History

A **clear** command appeared in 2.79BSD dated February 24, 1979.
Later that was provided in Unix 8th edition (1985).

AT&T adapted a different BSD program (**tset**) to make
a new command (**tput**),
and used this to replace the **clear** command with a shell script
which calls **tput clear**, e.g.,
.NS
/usr/bin/tput ${1:+-T$1} clear 2&gt; /dev/null
exit
.NE

In 1989, when Keith Bostic revised the BSD **tput** command
to make it similar to the AT&T **tput**,
he added a shell script for the **clear** command:
.NS
exec tput clear
.NE

The remainder of the script in each case is a copyright notice.

The ncurses **clear** command began in 1995 by adapting the original
BSD **clear** command (with terminfo, of course).

The **E3** extension came later:
.bP
In June 1999, xterm provided an extension to the standard control
sequence for clearing the screen.
Rather than clearing just the visible part of the screen using
.NS
printf '\\033[2J'
.NE

* one could clear the _scrollback_ using
  .NS
  printf '\\033[**3**J'
  .NE
* This is documented in _XTerm Control Sequences_ as a feature originating
  with xterm.
  .bP
  A few other terminal developers adopted the feature, e.g., PuTTY in 2006.
  .bP
  In April 2011, a Red Hat developer submitted a patch to the Linux
  kernel, modifying its console driver to do the same thing.
  The Linux change, part of the 3.0 release, did not mention xterm,
  although it was cited in the Red Hat bug report (#683733)
  which led to the change.
  .bP
  Again, a few other terminal developers adopted the feature.
  But the
  next relevant step was a change to the **clear** program in 2013
  to incorporate this extension.
  .bP
  In 2013, the **E3** extension was overlooked in **tput** with
  the \`clear\*('' parameter.
  That was addressed in 2016 by reorganizing **tput** to share
  its logic with **clear** and **tset**.

<a name="portability"></a>

# Portability

Neither IEEE Std 1003.1/The Open  Group  Base  Specifications  Issue  7
(POSIX.1-2008) nor X/Open Curses Issue 7 documents tset or reset.

The latter documents **tput**, which could be used to replace this utility
either via a shell script or by an alias (such as a symbolic link) to
run **tput** as **clear**.

<a name="see-also"></a>

# See Also

**tput**(1), **terminfo**(5)

This describes **ncurses**
version 6.1 (patch 20180923).
