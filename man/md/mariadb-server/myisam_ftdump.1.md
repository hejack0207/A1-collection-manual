# \fbmyisam_ftdump\fr(1)

MariaDB 10\&.3, 9 May 2017

.nh






<a name="name"></a>

# Name

myisam_ftdump - display full-text index information

<a name="synopsis"></a>

# Synopsis

```
.HP \w'myisam_ftdump&nbsp;[options]&nbsp;tbl_name&nbsp;index_num&nbsp;'u myisam_ftdump [options] tbl_name index_num
```

<a name="description"></a>

# Description


**myisam\_ftdump**
displays information about
FULLTEXT
indexes in
MyISAM
tables. It reads the
MyISAM
index file directly, so it must be run on the server host where the table is located. Before using
**myisam\_ftdump**, be sure to issue a
FLUSH TABLES
statement first if the server is running.

**myisam\_ftdump**
scans and dumps the entire index, which is not particularly fast. On the other hand, the distribution of words changes infrequently, so it need not be run often.

Invoke
**myisam\_ftdump**
like this:

.if n \{.RS 4
.\}
    shell> myisam_ftdump [options] tbl_name index_num
.if n \{.RE
.\}

The
_tbl\_name_
argument should be the name of a
MyISAM
table. You can also specify a table by naming its index file (the file with the
.MYI
suffix). If you do not invoke
**myisam\_ftdump**
in the directory where the table files are located, the table or index file name must be preceded by the path name to the table\'s database directory. Index numbers begin with 0.

Example: Suppose that the
test
database contains a table named
mytexttablel
that has the following definition:

.if n \{.RS 4
.\}
    CREATE TABLE mytexttable
    (
      id   INT NOT NULL,
      txt  TEXT NOT NULL,
      PRIMARY KEY (id),
      FULLTEXT (txt)
    );
.if n \{.RE
.\}

The index on
id
is index 0 and the
FULLTEXT
index on
txt
is index 1. If your working directory is the
test
database directory, invoke
**myisam\_ftdump**
as follows:

.if n \{.RS 4
.\}
    shell> myisam_ftdump mytexttable 1
.if n \{.RE
.\}

If the path name to the
test
database directory is
/usr/local/mysql/data/test, you can also specify the table name argument using that path name. This is useful if you do not invoke
**myisam\_ftdump**
in the database directory:

.if n \{.RS 4
.\}
    shell> myisam_ftdump /usr/local/mysql/data/test/mytexttable 1
.if n \{.RE
.\}

You can use
**myisam\_ftdump**
to generate a list of index entries in order of frequency of occurrence like this:

.if n \{.RS 4
.\}
    shell> myisam_ftdump -c mytexttable 1 | sort -r
.if n \{.RE
.\}

**myisam\_ftdump**
supports the following options:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--help**,
  **-h**
  **-?**

Display a help message and exit.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--count**,
  **-c**

Calculate per-word statistics (counts and global weights).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--dump**,
  **-d**

Dump the index, including data offsets and word weights.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--length**,
  **-l**

Report the length distribution.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--stats**,
  **-s**

Report global index statistics. This is the default operation if no other operation is specified.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--verbose**,
  **-v**

Verbose mode. Print more output about what the program does.

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
