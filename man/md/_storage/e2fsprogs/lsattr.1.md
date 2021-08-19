# lsattr(1) - list file attributes on a Linux second extended file system

E2fsprogs version 1.45.6, March 2020

```
lsattr [ -RVadlpv ] [ files... ]
```

<a name="description"></a>

# Description

**lsattr**
lists the file attributes on a second extended file system.  See
**chattr**(1)
for a description of the attributes and what they mean.

<a name="options"></a>

# Options


* **-R**  
  Recursively list attributes of directories and their contents.
* **-V**  
  Display the program version.
* **-a**  
  List all files in directories, including files that start with \`.'.
* **-d**  
  List directories like other files, rather than listing their contents.
* **-l**  
  Print the options using long names instead of single
  character abbreviations.
* **-p**  
  List the file's project number.
* **-v**  
  List the file's version/generation number.

<a name="author"></a>

# Author

**lsattr**
was written by Remy Card &lt;[Remy.Card@linux.org](mailto:Remy.Card@linux.org)&gt;.  It is currently being
maintained by Theodore Ts'o &lt;[tytso@alum.mit](mailto:tytso@alum.mit).edu&gt;.

<a name="bugs"></a>

# Bugs

There are none :-).

<a name="availability"></a>

# Availability

**lsattr**
is part of the e2fsprogs package and is available from
http://e2fsprogs.sourceforge.net.

<a name="see-also"></a>

# See Also

**chattr**(1)
