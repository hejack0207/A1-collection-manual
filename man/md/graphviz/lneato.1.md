# lneato(1) - A Customizable Graph Editor

```
lneato [ -V ] [ -lmmode ] [ -ellev ] [ file ]
```

<a name="description"></a>

# Description

**lneato**
is a graph editor for the X Window System.  It may be run as a standalone
editor, or as a front end for applications that use graphs.  It can control
multiple windows viewing different graphs.

**lneato**
is written on top of
**neato**
and
**lefty**.
**lefty**
is a general-purpose programmable editor for technical pictures.  It has an
interpretive programming language similar to AWK and C.  The user interface and
graph editing operations of
**lneato**
are written as
**lefty**
functions.
Programmer-defined graph operations may be loaded as well.  Graph layouts are
made by
**neato**,
which runs as a separate process that communicates with
**lefty**
through pipes.

If the input graph contains xdot attributes,
**lneato**
will use that to display the graph. Otherwise, it runs
**neato**
to obtain layout information.

<a name="usage"></a>

# Usage

The file name is optional. If present, the graph contained in that file is
displayed in the
**lneato**
window.

<a name="options"></a>

# Options


* **-V**  
  Prints the version.
* **-lm**_mode_  
  Sets the layout mode. The _mode_ can be **sync** or **async**. The default is **async**.
* **-el**_lev_  
  Sets the mesage level. The _lev_ can be **0** or **1**. The default is **0**.

<a name="see-also"></a>

# See Also

neato(1), lefty(1), dotty(1), xdot(3),  
_dotty_
user guide.
