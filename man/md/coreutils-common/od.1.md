# od(1) - dump files in octal and other formats

GNU coreutils 8.31, March 2019

```
od [OPTION]... [FILE]...
od [-abcdfilosx]... [FILE] [[+]OFFSET[.][b]]
od --traditional [OPTION]... [FILE] [[+]OFFSET[.][b] [+][LABEL][.][b]]
```

<a name="description"></a>

# Description



Write an unambiguous representation, octal bytes by default,
of FILE to standard output.  With more than one FILE argument,
concatenate them in the listed order to form the input.

With no FILE, or when FILE is -, read standard input.

If first and second call formats both apply, the second format is assumed
if the last operand begins with + or (if there are 2 operands) a digit.
An OFFSET operand means **-j** OFFSET.  LABEL is the pseudo-address
at first byte printed, incremented when dump is progressing.
For OFFSET and LABEL, a 0x or 0X prefix indicates hexadecimal;
suffixes may be . for octal and b for multiply by 512.

Mandatory arguments to long options are mandatory for short options too.

* **-A**, **--address-radix**=_RADIX_  
  output format for file offsets; RADIX is one
  of [doxn], for Decimal, Octal, Hex or None
* **--endian=**{big|little}  
  swap input bytes according the specified order
* **-j**, **--skip-bytes**=_BYTES_  
  skip BYTES input bytes first
* **-N**, **--read-bytes**=_BYTES_  
  limit dump to BYTES input bytes
* **-S** BYTES, **--strings**[=_BYTES_]  
  output strings of at least BYTES graphic chars;
  3 is implied when BYTES is not specified
* **-t**, **--format**=_TYPE_  
  select output format or formats
* **-v**, **--output-duplicates**  
  do not use * to mark line suppression
* **-w[BYTES]**, **--width**[=_BYTES_]  
  output BYTES bytes per output line;
  32 is implied when BYTES is not specified
* **--traditional**  
  accept arguments in third form above
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="traditional-format-specifications-may-be-intermixed-they-accumulate"></a>

### Traditional format specifications may be intermixed; they accumulate:


* **-a**  
  same as **-t** a,  select named characters, ignoring high-order bit
* **-b**  
  same as **-t** o1, select octal bytes
* **-c**  
  same as **-t** c,  select printable characters or backslash escapes
* **-d**  
  same as **-t** u2, select unsigned decimal 2-byte units
* **-f**  
  same as **-t** fF, select floats
* **-i**  
  same as **-t** dI, select decimal ints
* **-l**  
  same as **-t** dL, select decimal longs
* **-o**  
  same as **-t** o2, select octal 2-byte units
* **-s**  
  same as **-t** d2, select decimal 2-byte units
* **-x**  
  same as **-t** x2, select hexadecimal 2-byte units

<a name="type-is-made-up-of-one-or-more-of-these-specifications"></a>

### TYPE is made up of one or more of these specifications:


* a  
  named character, ignoring high-order bit
* c  
  printable character or backslash escape
* d[SIZE]  
  signed decimal, SIZE bytes per integer
* f[SIZE]  
  floating point, SIZE bytes per float
* o[SIZE]  
  octal, SIZE bytes per integer
* u[SIZE]  
  unsigned decimal, SIZE bytes per integer
* x[SIZE]  
  hexadecimal, SIZE bytes per integer

SIZE is a number.  For TYPE in [doux], SIZE may also be C for
sizeof(char), S for sizeof(short), I for sizeof(int) or L for
sizeof(long).  If TYPE is f, SIZE may also be F for sizeof(float), D
for sizeof(double) or L for sizeof(long double).

Adding a z suffix to any type displays printable characters at the end of
each output line.

<a name="bytes-is-hex-with-0x-or-0x-prefix-and-may-have-a-multiplier-suffix"></a>

### BYTES is hex with 0x or 0X prefix, and may have a multiplier suffix:


* b  
  512
* KB  
  1000
* K  
  1024
* MB  
  1000*1000
* M  
  1024*1024

and so on for G, T, P, E, Z, Y.
Binary prefixes can be used, too: KiB=K, MiB=M, and so on.

<a name="examples"></a>

# Examples


* **od -A x -t x1z -v**  
  Display hexdump format output
* **od -A o -t oS -w16**  
  The default output format used by od

<a name="author"></a>

# Author

Written by Jim Meyering.

<a name="reporting-bugs"></a>

# Reporting Bugs

GNU coreutils online help: &lt;https://www.gnu.org/software/coreutils/&gt;  
Report any translation bugs to &lt;https://translationproject.org/team/&gt;

<a name="copyright"></a>

# Copyright

Copyright © 2019 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later &lt;https://gnu.org/licenses/gpl.html&gt;.  
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

<a name="see-also"></a>

# See Also

Full documentation &lt;https://www.gnu.org/software/coreutils/od&gt;  
or available locally via: info '(coreutils) od invocation'
