# \fbreplace\fr(1)

MariaDB 10\&.3, 9 May 2017

.nh







<a name="name"></a>

# Name

replace - a string-replacement utility

<a name="synopsis"></a>

# Synopsis

```
.HP \w'replace&nbsp;arguments&nbsp;'u replace arguments
```

<a name="description"></a>

# Description


The
**replace**
utility program changes strings in place in files or on the standard input.

Invoke
**replace**
in one of the following ways:

.if n \{.RS 4
.\}
    shell> replace from to [from to] ... -- file_name [file_name] ...
    shell> replace from to [from to] ... < file_name
.if n \{.RE
.\}

_from_
represents a string to look for and
_to_
represents its replacement. There can be one or more pairs of strings.

Use the
**--**
option to indicate where the string-replacement list ends and the file names begin. In this case, any file named on the command line is modified in place, so you may want to make a copy of the original before converting it.
_replace_
prints a message indicating which of the input files it actually modifies.

If the
**--**
option is not given,
**replace**
reads the standard input and writes to the standard output.

**replace**
uses a finite state machine to match longer strings first. It can be used to swap strings. For example, the following command swaps
a
and
b
in the given files,
file1
and
file2:

.if n \{.RS 4
.\}
    shell> replace a b b a -- file1 file2 ...
.if n \{.RE
.\}

The
**replace**
program is used by
**msql2mysql**. See
**msql2mysql**(1).

**replace**
supports the following options.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-?**,
  **-I**

Display a help message and exit.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-#****debug\_options**

Enable debugging.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-s**

Silent mode. Print less information what the program does.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-v**

Verbose mode. Print more information about what the program does.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-V**

Display version information and exit.

<a name="copyright"></a>

# Copyright
  

Copyright 2007-2008 MySQL AB, 2008-2010 Sun Microsystems, Inc., 2010-2015 MariaDB Foundation

This documentation is free software; you can redistribute it and/or modify it only under the terms of the GNU General Public License as published by the Free Software Foundation; version 2 of the License.

This documentation is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with the program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1335 USA or see http://www.gnu.org/licenses/.


<a name="see-also"></a>

# See Also

For more information, please refer to the MariaDB Knowledge Base, available online at https://mariadb.com/kb/

<a name="author"></a>

# Author

MariaDB Foundation (http://www.mariadb.org/).
