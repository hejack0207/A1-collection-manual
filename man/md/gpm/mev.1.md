# mev(1)

February 1995

.UC 4

<a name="name"></a>

# Name

mev - a program to report mouse events

<a name="synopsis"></a>

# Synopsis

```
mev [ options ]

```

<a name="description"></a>

# Description

The \`mev' program is part of the gpm package.
The information below is extracted from the texinfo file, which is the
preferred source of information.


The mev program is modeled after xev. It prints to stdout the
mouse console events it gets.


mev's default behaviour is to get anything, but command line switches
can be used to set the various fields in the Gpm_Connect structure, in
order to customize the program's behaviour. I'm using mev to
handle mouse events to Emacs.


Command line switches for mev are the following:

* -C **number**  
  Select a virtual console to get events from.
  This is intended to be used for debugging.
* -d **number**  
  Choose a default mask. By default the server gets
  any events not belonging to the event mask. The mask can be
  provided either as a
  decimal number, or as a symbolic string.
* -e **number**  
  Choose the event mask. By default any event
  is received. The mask can be provided either as a
  decimal number, or as a symbolic string.
* -E  
  Enter emacs mode. In emacs mode events are reported as
  lisp forms rather than numbers. This is the format used by the
  t-mouse package within emacs.
* -f  
  Fit events inside the screen before reporting them. This options
  re-fits drag events, which are allowed to exit the screen border,
  
* -i  
  Interactive. Accepts input from stdin to change connection
  parameters.
* -m **number**  
  Choose the minimum modifier mask. Any event with
  fewer modifiers will not be reported to mev. It defaults to 0.
  The mask must be provided either as a
  decimal number, or as a symbolic string.
* -M **number**  
  Choose the maximum modifier mask. Any event with
  more modifier than specified will not be reported to mev.
  It defaults to &nbsp;~0, i.e. all events are received.
  The mask must be provided either as a
  decimal number, or as a symbolic string.
* -p  
  Requests to draw the pointer during drags. This option is used
  by emacs to avoid invoking ioctl() from lisp code.
  

When the arguments are not decimal integers, they are considered lists
of alphanumeric characters, separated by a single non-alphanumeric
character. I use the comma (,), but any will do.


Allowed names for events are move, drag, down or
press, up or release, motion (which is both
move and drag), and hard.


Allowed names for modifiers are shift, leftAlt,
rightAlt, anyAlt (one or the other), control.


When the -i switch is specified, mev looks at its standard input as
command lines rather than events. The input lines are parsed, and the
commands push and pop are recognized.


The push command, then, accepts the options -d, -e, -m
and -M, with the same meaning described above. Unspecified options
retain the previous value and the resulting masks are used to reopen
the connection with the server. pop is used to pop the connection
stack. If an empty stack is popped the program exits.


Other commands recognized are info, used to return the stack
depth; quit to prematurely terminate the program; and
snapshot to get some configuration information from the server.



<a name="bugs"></a>

# Bugs

Beginning with release 1.16, **mev** no longer works under xterm.
Please use the **rmev** program (provided in the **sample**
directory) to watch gpm events under xterm or rxvt.  **rmev** also
displays keyboard events besides mouse events.



<a name="author"></a>

# Author

Alessandro Rubini &lt;[rubini@linux.it](mailto:rubini@linux.it)&gt;  
Ian Zimmerman &lt;[itz@speakeasy.org](mailto:itz@speakeasy.org)&gt;



<a name="files"></a>

# Files

    /dev/gpmctl The socket used to connect to gpm.



<a name="see-also"></a>

# See Also

     gpm(8)       The mouse server
     gpm-root(1)  An handler for Control-Mouse events.
    
The info file about \`gpm', which gives more complete information and
explains how to write a gpm client.
