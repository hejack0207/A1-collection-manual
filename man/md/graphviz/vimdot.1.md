# vimdot(1) - Combined text editor and dot viewer

Jan 31, 2010

```
vimdot [file]
```

<a name="description"></a>

# Description


**vimdot** is a simple script which launches the gvim or vim editor along with a GUI window showing the
dot output of the edited file.  The dot output window automatically refreshes everytime the file is saved
in the editor.

If no filename is given, vimdot will use 'noname.gv' and initialise it with an example graph to get you
started.

The GUI window (provided by "dot -Txlib") supports zooming using the mouse scroll-wheel, and panning by holding the scroll-wheel down and dragging.

<a name="see-also"></a>

# See Also
  
vim(1), dot(1)

<a name="author"></a>

# Author

vimdot was written by John Ellson &lt;[ellson@research.att](mailto:ellson@research.att).com&gt;

This manual page was written by David Claughton &lt;[dave@eclecticdave.com](mailto:dave@eclecticdave.com)&gt;,
for the Debian project (but may be used by others).
