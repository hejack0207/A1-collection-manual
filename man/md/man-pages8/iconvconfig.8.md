# iconvconfig(8) - create iconv module configuration cache

GNU, 2018-02-02

```
iconvconfig [options] [directory]...
```

<a name="description"></a>

# Description

The
**iconv**(3)
function internally uses
_gconv_
modules to convert to and from a character set.
A configuration file is used to determine the needed modules
for a conversion.
Loading and parsing such a configuration file would slow down
programs that use
**iconv**(3),
so a caching mechanism is employed.

The
**iconvconfig**
program reads iconv module configuration files and writes
a fast-loading gconv module configuration cache file.

In addition to the system provided gconv modules, the user can specify
custom gconv module directories with the environment variable
**GCONV_PATH**.
However, iconv module configuration caching is used only when
the environment variable
**GCONV_PATH**
is not set.

<a name="options"></a>

# Options


* **--nostdlib**  
  Do not search the system default gconv directory,
  only the directories provided on the command line.
* **-o**_ outputfile_**, --output=**_outputfile_  
  Use
  _outputfile_
  for output instead of the system default cache location.
* **--prefix=**_pathname_  
  Set the prefix to be prepended to the system pathnames.
  See FILES, below.
  By default, the prefix is empty.
  Setting the prefix to
  _foo_,
  the gconv module configuration would be read from
  _foo/usr/lib/gconv/gconv-modules_
  and the cache would be written to
  _foo/usr/lib/gconv/gconv-modules.cache_.
* **-?**, **--help**  
  Print a usage summary and exit.
* **--usage**  
  Print a short usage summary and exit.
* **-V**, **--version**  
  Print the version number, license, and disclaimer of warranty for
  **iconv**.

<a name="exit-status"></a>

# Exit Status

Zero on success, nonzero on errors.

<a name="files"></a>

# Files


* _/usr/lib/gconv_  
  Usual default gconv module path.
* _/usr/lib/gconv/gconv-modules_  
  Usual system default gconv module configuration file.
* _/usr/lib/gconv/gconv-modules.cache_  
  Usual system gconv module configuration cache.

<a name="see-also"></a>

# See Also

**iconv**(1),
**iconv**(3)

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
