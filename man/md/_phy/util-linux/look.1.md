# look(1) - display lines beginning with a given string

util-linux, June 2011

```
look [options] string [file]
```

<a name="description"></a>

# Description

The
**look**
utility displays any lines in
_file_
which contain
_string_.
As
**look**
performs a binary search, the lines in
_file_
must be sorted (where
**sort**(1)
was given the same options
**-d **and/or** -f **that
**look**
is invoked with).

If
_file_
is not specified, the file
_/usr/share/dict/words_
is used, only alphanumeric characters are compared and the case of
alphabetic characters is ignored.

<a name="options"></a>

# Options


* **-a**,** --alternative**  
  Use the alternative dictionary file.
* **-d**,** --alphanum**  
  Use normal dictionary character set and order, i.e. only blanks and
  alphanumeric characters are compared.  This is on by default if no file is
  specified.
  
  Note that blanks have been added to dictionary character set for
  compatibility with **sort -d** command since version 2.28.
* **-f**,** --ignore-case**  
  Ignore the case of alphabetic characters.  This is on by default if no file is
  specified.
* **-t**,** --terminate **_character_  
  Specify a string termination character, i.e. only the characters
  in _string_ up to and including the first occurrence of _character_
  are compared.
* **-V**,** --version**  
  Display version information and exit.
* **-h**,** --help**  
  Display help text and exit.

The
**look**
utility exits 0 if one or more lines were found and displayed, 1 if
no lines were found, and &gt;1 if an error occurred.

<a name="example"></a>

# Example

    sort -d /etc/passwd -o /tmp/look.dict
    look -t: root:foobar /tmp/look.dict
    .nf
    .RE

<a name="environment"></a>

# Environment


* **WORDLIST**  
  Path to a dictionary file.  The environment variable has greater priority
  than the dictionary path defined in FILES segment.

<a name="files"></a>

# Files


* **/usr/share/dict/words**  
  the dictionary
* **/usr/share/dict/web2**  
  the alternative dictionary

<a name="see-also"></a>

# See Also

**grep**(1),
**sort**(1)

<a name="history"></a>

# History

The
**look**
utility appeared in Version 7 AT&T Unix.

<a name="availability"></a>

# Availability

The look command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
