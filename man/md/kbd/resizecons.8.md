# resizecons(8) - change kernel idea of the console size

Local, 17 Jan 1995

```
resizecons COLSxROWS
resizecons -lines ROWS
```

<a name="description"></a>

# Description

The
_resizecons_
command tries to change the videomode of the console.
There are several aspects to this: (a) the kernel must know about it,
(b) the hardware must know about it, (c) user programs must know
about it, (d) the console font may have to be adapted.

(a) The kernel is told about the change using the ioctl VT_RESIZE.
This causes the kernel to reallocate console screen memory for
all virtual consoles, and might fail if there is not enough memory.
(In that case, try to disallocate some virtual consoles first.)
If this ioctl succeeds, but a later step fails (e.g., because
you do not have root permissions), you may be left with a very messy
screen.

The most difficult part of this is (b), since it requires detailed
knowledge of the video card hardware, and the setting of numerous
registers. Only changing the number of rows is slightly easier, and 
_resizecons_
will try to do that itself, when given the
_-lines_
option. (Probably, root permission will be required.)
The command
_resizecons COLSxROWS_
will execute
_restoretextmode -r COLSxROWS_
(and hence requires that you have svgalib installed). Here COLSxROWS
is a file that was created earlier by
_restoretextmode -w COLSxROWS._
Again, either root permissions are required, or
_restoretextmode_
has to be suid root.

In order to deal with (c),
_resizecons_
does a \`stty rows ROWS cols COLS' for each active console (in the
range tty0..tty15), and sends a SIGWINCH signal to
_selection_
if it finds the file /tmp/selection.pid.

Finally, (d) is dealt with by executing a
_setfont_
command. Most likely, the wrong font is loaded, and you may want to
do another
_setfont_
yourself afterwards.


<a name="bugs"></a>

# Bugs

_resizecons_
does not work on all hardware.
This command used to be called
_resize,_
but was renamed to avoid conflict with another command with the same name.


<a name="see-also"></a>

# See Also

**setfont**(8),
**stty**(1),
**selection**(1),
**restoretextmode**(8),
**disalloc**(8)

