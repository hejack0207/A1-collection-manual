# sort(1) - sort lines of text files

GNU coreutils 8.31, March 2019

```
sort [OPTION]... [FILE]...
sort [OPTION]... --files0-from=F
```

<a name="description"></a>

# Description



Write sorted concatenation of all FILE(s) to standard output.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.
Ordering options:

* **-b**, **--ignore-leading-blanks**  
  ignore leading blanks
* **-d**, **--dictionary-order**  
  consider only blanks and alphanumeric characters
* **-f**, **--ignore-case**  
  fold lower case to upper case characters
* **-g**, **--general-numeric-sort**  
  compare according to general numerical value
* **-i**, **--ignore-nonprinting**  
  consider only printable characters
* **-M**, **--month-sort**  
  compare (unknown) &lt; 'JAN' &lt; ... &lt; 'DEC'
* **-h**, **--human-numeric-sort**  
  compare human readable numbers (e.g., 2K 1G)
* **-n**, **--numeric-sort**  
  compare according to string numerical value
* **-R**, **--random-sort**  
  shuffle, but group identical keys.  See shuf(1)
* **--random-source**=_FILE_  
  get random bytes from FILE
* **-r**, **--reverse**  
  reverse the result of comparisons
* **--sort**=_WORD_  
  sort according to WORD:
  general-numeric **-g**, human-numeric **-h**, month **-M**,
  numeric **-n**, random **-R**, version **-V**
* **-V**, **--version-sort**  
  natural sort of (version) numbers within text

Other options:

* **--batch-size**=_NMERGE_  
  merge at most NMERGE inputs at once;
  for more use temp files
* **-c**, **--check**, **--check**=_diagnose-first_  
  check for sorted input; do not sort
* **-C**, **--check**=_quiet_, **--check**=_silent_  
  like **-c**, but do not report first bad line
* **--compress-program**=_PROG_  
  compress temporaries with PROG;
  decompress them with PROG **-d**
* **--debug**  
  annotate the part of the line used to sort,
  and warn about questionable usage to stderr
* **--files0-from**=_F_  
  read input from the files specified by
  NUL-terminated names in file F;
  If F is - then read names from standard input
* **-k**, **--key**=_KEYDEF_  
  sort via a key; KEYDEF gives location and type
* **-m**, **--merge**  
  merge already sorted files; do not sort
* **-o**, **--output**=_FILE_  
  write result to FILE instead of standard output
* **-s**, **--stable**  
  stabilize sort by disabling last-resort comparison
* **-S**, **--buffer-size**=_SIZE_  
  use SIZE for main memory buffer
* **-t**, **--field-separator**=_SEP_  
  use SEP instead of non-blank to blank transition
* **-T**, **--temporary-directory**=_DIR_  
  use DIR for temporaries, not $TMPDIR or _/tmp_;
  multiple options specify multiple directories
* **--parallel**=_N_  
  change the number of sorts run concurrently to N
* **-u**, **--unique**  
  with **-c**, check for strict ordering;
  without **-c**, output only the first of an equal run
* **-z**, **--zero-terminated**  
  line delimiter is NUL, not newline
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

KEYDEF is F[.C][OPTS][,F[.C][OPTS]] for start and stop position, where F is a
field number and C a character position in the field; both are origin 1, and
the stop position defaults to the line's end.  If neither **-t** nor **-b** is in
effect, characters in a field are counted from the beginning of the preceding
whitespace.  OPTS is one or more single-letter ordering options [bdfgiMhnRrV],
which override global ordering options for that key.  If no key is given, use
the entire line as the key.  Use **--debug** to diagnose incorrect key usage.

SIZE may be followed by the following multiplicative suffixes:
% 1% of memory, b 1, K 1024 (default), and so on for M, G, T, P, E, Z, Y.

*** WARNING ***
The locale specified by the environment affects sort order.
Set LC_ALL=C to get the traditional sort order that uses
native byte values.

<a name="author"></a>

# Author

Written by Mike Haertel and Paul Eggert.

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

shuf(1), uniq(1)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/sort&gt;  
or available locally via: info '(coreutils) sort invocation'
