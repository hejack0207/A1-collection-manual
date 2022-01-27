# sln(8) - create symbolic links

GNU, 2017-09-15

```
sln source dest
sln filelist
```

<a name="description"></a>

# Description

The
**sln**
program creates symbolic links.
Unlike the
**ln**(1)
program, it is statically linked.
This means that if for some reason the dynamic linker is not working,
**sln**
can be used to make symbolic links to dynamic libraries.

The command line has two forms.
In the first form, it creates
_dest_
as a new symbolic link to
_source_.

In the second form,
_filelist_
is a list of space-separated pathname pairs,
and the effect is as if
**sln**
was executed once for each line of the file,
with the two pathnames as the arguments.

The
**sln**
program supports no command-line options.

<a name="see-also"></a>

# See Also

**ln**(1),
**ld.so**(8),
**ldconfig**(8)

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
