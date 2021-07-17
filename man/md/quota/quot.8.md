# quot(8) - summarize filesystem ownership

    quot [ -acfguvi ] [ filesystem... ]

<a name="description"></a>

# Description

_quot_
displays the number of kilobytes in the named
_filesystem_
currently owned by each user or group. Note that this utility
currently works only for XFS.

<a name="options"></a>

# Options


* **-a**  
  Generate a report for all mounted filesystems giving the number of
  kilobytes used by each user or group.
* **-c**  
  Display three columns giving file size in kilobytes, number of
  files of that size, and cumulative total of kilobytes
  in that size or smaller file.
  The last row is used as an overflow
  bucket and is the total of all files greater than 500 kilobytes.
* **-f**  
  Display count of kilobytes and number of files owned by each user or group.
* **-g**  
  Report on groups.
* **-u**  
  Report on users (the default).
* **-v**  
  Display three columns containing the number of kilobytes not accessed in
  the last 30, 60, and 90 days.
* **-i**  
  Ignore mountpoints mounted by automounter.
* **-T**  
  Avoid truncation of user names longer than 8 characters.
* **-q**  
  Do not sort the output.

<a name="files"></a>

# Files


* /etc/mtab  
  mounted filesystem table
* /etc/passwd  
  default set of users
* /etc/group  
  default set of groups

<a name="see-also"></a>

# See Also

du(1),
ls(1).

<a name="bugs"></a>

# Bugs

Currently, only the XFS filesystem type is supported.
