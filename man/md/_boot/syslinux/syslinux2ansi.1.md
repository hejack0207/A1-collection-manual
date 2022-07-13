# syslinux2ansi(1) - converts a syslinux-format screen to pc-ansi

```
syslinux2ansi < filename.input > filename.output
```

<a name="description"></a>

# Description

_Syslinux2ansi_
is a filter which converts a screen formatted for syslinux to one
compatible with PC ANSI.  It will only read from standard in, and has
no command line options.

<a name="bugs"></a>

# Bugs

Help and version command line options would be useful.

The ability to put input and output filenames on the command line might
be good as well.

<a name="bug-reports"></a>

### Bug reports

I would appreciate hearing of any problems you have with SYSLINUX.  I
would also like to hear from you if you have successfully used SYSLINUX,
especially if you are using it for a distribution.

If you are reporting problems, please include all possible information
about your system and your BIOS; the vast majority of all problems
reported turn out to be BIOD or hardware bugs, and I need as much
information as possible in order to diagnose the problems.

There is a mailing list for discussion among SYSLINUX users and for
announcements of new and test versions.   To join, send a message to
majordomo@linux.kernel.org with the line:

**subscribe syslinux**

in the body of the message.  The submission address is
syslinux@linux.kernel.org.

<a name="see-also"></a>

# See Also

**syslinux(1),**
**perl(1)**

<a name="author"></a>

# Author

This manual page is a quick write-up for Debian done by Kevin Kreamer
&lt;[kkreamer@etherhogz.org](mailto:kkreamer@etherhogz.org)&gt;, by looking over the 1 screenful of Perl that is
**syslinux2ansi.**
