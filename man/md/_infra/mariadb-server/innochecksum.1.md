# \fbinnochecksum\fr(1)

MariaDB 10\&.3, 9 May 2017

.nh






<a name="name"></a>

# Name

innochecksum - offline InnoDB file checksum utility

<a name="synopsis"></a>

# Synopsis

```
.HP \w'innochecksum&nbsp;[options]&nbsp;file_name&nbsp;'u innochecksum [options] file_name
```

<a name="description"></a>

# Description


**innochecksum**
prints checksums for
InnoDB
files. This tool reads an
InnoDB
tablespace file, calculates the checksum for each page, compares the calculated checksum to the stored checksum, and reports mismatches, which indicate damaged pages. It was originally developed to speed up verifying the integrity of tablespace files after power outages but can also be used after file copies. Because checksum mismatches will cause
InnoDB
to deliberately shut down a running server, it can be preferable to use this tool rather than waiting for a server in production usage to encounter the damaged pages.

**innochecksum**
cannot be used on tablespace files that the server already has open. For such files, you should use
CHECK TABLE
to check tables within the tablespace.

If checksum mismatches are found, you would normally restore the tablespace from backup or start the server and attempt to use
**mysqldump**
to make a backup of the tables within the tablespace.

Invoke
**innochecksum**
like this:

.if n \{.RS 4
.\}
    shell> innochecksum [options] file_name
.if n \{.RE
.\}

**innochecksum**
supports the following options. For options that refer to page numbers, the numbers are zero-based.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-?, --help**

Displays help and exits.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-c, --count**

Print a count of the number of pages in the file.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-d, --debug**

Debug mode; prints checksums for each page.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-e ****num, --end-page=#**

End at this page number.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-i, --per-page-details**

Print out per-page detail information.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-I, --info**

Synonym for **--help**.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-l, --leaf**

Examine leaf index pages.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-m ****num, --merge=#**

Leaf page count if merge given number of consecutive pages.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-p ****num, --page-num=#**

Check only this page number.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-s ****num, --start-page**

Start at this page number.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-u, --skip-corrupt**

Skip corrupt pages.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-v, --verbose**

Verbose mode; print a progress indicator every five seconds.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-V, --version**

Displays version information and exits.

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
