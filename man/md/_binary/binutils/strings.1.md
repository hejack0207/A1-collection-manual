# strings(1)

binutils-2.30.90, 2018-07-09

.if n .ad l
.nh

<a name="name"></a>

# Name

strings - print the strings of printable characters in files.

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" strings [-afovV] [-min-len]         [-n min-len] [--bytes=min-len]         [-t radix] [--radix=radix]         [-e encoding] [--encoding=encoding]         [-] [--all] [--print-file-name]         [-T bfdname] [--target=bfdname]         [-w] [--include-all-whitespace]         [-s] [--output-separatorsep_string]         [--help] [--version] file...
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
For each _file_ given, \s-1GNU\s0 **strings** prints the
printable character sequences that are at least 4 characters long (or
the number given with the options below) and are followed by an
unprintable character.

Depending upon how the strings program was configured it will default
to either displaying all the printable sequences that it can find in
each file, or only those sequences that are in loadable, initialized
data sections.  If the file type in unrecognizable, or if strings is
reading from stdin then it will always display all of the printable
sequences that it can find.

For backwards compatibility any file that occurs after a command line
option of just **-** will also be scanned in full, regardless of
the presence of any **-d** option.

**strings** is mainly useful for determining the contents of
non-text files.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-a**  
  .IX Item "-a"
* **--all**  
  .IX Item "--all"
* **-**  
  .IX Item "-"
  Scan the whole file, regardless of what sections it contains or
  whether those sections are loaded or initialized.  Normally this is
  the default behaviour, but strings can be configured so that the
  **-d** is the default instead.
  .Sp
  The **-** option is position dependent and forces strings to
  perform full scans of any file that is mentioned after the **-**
  on the command line, even if the **-d** option has been
  specified.
* **-d**  
  .IX Item "-d"
* **--data**  
  .IX Item "--data"
  Only print strings from initialized, loaded data sections in the
  file.  This may reduce the amount of garbage in the output, but it
  also exposes the strings program to any security flaws that may be
  present in the \s-1BFD\s0 library used to scan and load sections.  Strings
  can be configured so that this option is the default behaviour.  In
  such cases the **-a** option can be used to avoid using the \s-1BFD\s0
  library and instead just print all of the strings found in the file.
* **-f**  
  .IX Item "-f"
* **--print-file-name**  
  .IX Item "--print-file-name"
  Print the name of the file before each string.
* **--help**  
  .IX Item "--help"
  Print a summary of the program usage on the standard output and exit.
* **-**_min-len_  
  .IX Item "-min-len"
* **-n** _min-len_  
  .IX Item "-n min-len"
* **--bytes=**_min-len_  
  .IX Item "--bytes=min-len"
  Print sequences of characters that are at least _min-len_ characters
  long, instead of the default 4.
* **-o**  
  .IX Item "-o"
  Like **-t o**.  Some other versions of **strings** have **-o**
  act like **-t d** instead.  Since we can not be compatible with both
  ways, we simply chose one.
* **-t** _radix_  
  .IX Item "-t radix"
* **--radix=**_radix_  
  .IX Item "--radix=radix"
  Print the offset within the file before each string.  The single
  character argument specifies the radix of the offset---**o** for
  octal, **x** for hexadecimal, or **d** for decimal.
* **-e** _encoding_  
  .IX Item "-e encoding"
* **--encoding=**_encoding_  
  .IX Item "--encoding=encoding"
  Select the character encoding of the strings that are to be found.
  Possible values for _encoding_ are: **s** = single-7-bit-byte
  characters (\s-1ASCII, ISO 8859,\s0 etc., default), **S** =
  single-8-bit-byte characters, **b** = 16-bit bigendian, **l** =
  16-bit littleendian, **B** = 32-bit bigendian, **L** = 32-bit
  littleendian.  Useful for finding wide character strings. (**l**
  and **b** apply to, for example, Unicode \s-1UTF-16/UCS-2\s0 encodings).
* **-T** _bfdname_  
  .IX Item "-T bfdname"
* **--target=**_bfdname_  
  .IX Item "--target=bfdname"
  Specify an object code format other than your system's default format.
* **-v**  
  .IX Item "-v"
* **-V**  
  .IX Item "-V"
* **--version**  
  .IX Item "--version"
  Print the program version number on the standard output and exit.
* **-w**  
  .IX Item "-w"
* **--include-all-whitespace**  
  .IX Item "--include-all-whitespace"
  By default tab and space characters are included in the strings that
  are displayed, but other whitespace characters, such a newlines and
  carriage returns, are not.  The **-w** option changes this so
  that all whitespace characters are considered to be part of a string.
* **-s**  
  .IX Item "-s"
* **--output-separator**  
  .IX Item "--output-separator"
  By default, output strings are delimited by a new-line. This option
  allows you to supply any string to be used as the output record
  separator.  Useful with --include-all-whitespace where strings
  may contain new-lines internally.
* **@**_file_  
  .IX Item "@file"
  Read command-line options from _file_.  The options read are
  inserted in place of the original @_file_ option.  If _file_
  does not exist, or cannot be read, then the option will be treated
  literally, and not removed.
  .Sp
  Options in _file_ are separated by whitespace.  A whitespace
  character may be included in an option by surrounding the entire
  option in either single or double quotes.  Any character (including a
  backslash) may be included by prefixing the character to be included
  with a backslash.  The _file_ may itself contain additional
  @_file_ options; any such options will be processed recursively.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
_ar_\|(1), _nm_\|(1), _objdump_\|(1), _ranlib_\|(1), _readelf_\|(1)
and the Info entries for _binutils_.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (c) 1991-2018 Free Software Foundation, Inc.

Permission is granted to copy, distribute and/or modify this document
under the terms of the \s-1GNU\s0 Free Documentation License, Version 1.3
or any later version published by the Free Software Foundation;
with no Invariant Sections, with no Front-Cover Texts, and with no
Back-Cover Texts.  A copy of the license is included in the
section entitled \s-1GNU\s0 Free Documentation License\*(R".
