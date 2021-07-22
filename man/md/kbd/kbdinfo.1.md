# kbdinfo(1) - obtain information about the status of a console

June 2011

```
kbdinfo [-C DEVICE] getmode [text|graphics] 
 kbdinfo [-C DEVICE] gkbmode [raw|xlate|mediumraw|unicode] 
 kbdinfo [-C DEVICE] gkbmeta [metabit|escprefix] 
 kbdinfo [-C DEVICE] gkbled [scrolllock|numlock|capslock]
```

<a name="description"></a>

# Description

**kbdinfo**
is an interface to KDGETMODE, GKBMODE, GKBMETA and GKBLED ioctls.  Its
primary use case is to query the status of the given
_CONSOLE_
(or the currently active one, if no -C option is present) from a shell
script.

If the final value argument is not specified,
**kbdinfo**
will print the result of the desired ioctl to the standard output.
Otherwise, the given value is compared to the actual result, and the
utility will exit with a status code of 0 for a match, 1 otherwise.  No
text is printed for this style of invocation.

<a name="see-also"></a>

# See Also

**kbd_mode**(1)

<a name="author"></a>

# Author

kbdinfo is Copyright © 2011 Alexey Gladkov
&lt;[gladkov.alexey@gmail.com](mailto:gladkov.alexey@gmail.com)&gt;.

This manual page was written by Michael Schutte &lt;[michi@debian.org](mailto:michi@debian.org)&gt; for
the Debian GNU/Linux system (but may be used by others).
