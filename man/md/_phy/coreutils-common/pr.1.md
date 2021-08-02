# pr(1) - convert text files for printing

GNU coreutils 8.31, March 2019

```
pr [OPTION]... [FILE]...
```

<a name="description"></a>

# Description



Paginate or columnate FILE(s) for printing.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.

* +FIRST_PAGE[:LAST_PAGE], **--pages**=_FIRST\_PAGE[_:LAST_PAGE]  
  begin [stop] printing with page FIRST_[LAST_]PAGE
* **-COLUMN**, **--columns**=_COLUMN_  
  output COLUMN columns and print columns down,
  unless **-a** is used. Balance number of lines in the
  columns on each page
* **-a**, **--across**  
  print columns across rather than down, used together
  with **-COLUMN**
* **-c**, **--show-control-chars**  
  use hat notation (^G) and octal backslash notation
* **-d**, **--double-space**  
  double space the output
* **-D**, **--date-format**=_FORMAT_  
  use FORMAT for the header date
* **-e[CHAR[WIDTH]]**, **--expand-tabs**[=_CHAR[WIDTH]_]  
  expand input CHARs (TABs) to tab WIDTH (8)
* **-F**, **-f**, **--form-feed**  
  use form feeds instead of newlines to separate pages
  (by a 3-line page header with **-F** or a 5-line header
  and trailer without **-F**)
* **-h**, **--header**=_HEADER_  
  use a centered HEADER instead of filename in page header,
  **-h** "" prints a blank line, don't use **-h**""
* **-i[CHAR[WIDTH]]**, **--output-tabs**[=_CHAR[WIDTH]_]  
  replace spaces with CHARs (TABs) to tab WIDTH (8)
* **-J**, **--join-lines**  
  merge full lines, turns off **-W** line truncation, no column
  alignment, **--sep-string**[=_STRING_] sets separators
* **-l**, **--length**=_PAGE\_LENGTH_  
  set the page length to PAGE_LENGTH (66) lines
  (default number of lines of text 56, and with **-F** 63).
  implies **-t** if PAGE_LENGTH &lt;= 10
* **-m**, **--merge**  
  print all files in parallel, one in each column,
  truncate lines, but join lines of full length with **-J**
* **-n[SEP[DIGITS]]**, **--number-lines**[=_SEP[DIGITS]_]  
  number lines, use DIGITS (5) digits, then SEP (TAB),
  default counting starts with 1st line of input file
* **-N**, **--first-line-number**=_NUMBER_  
  start counting with NUMBER at 1st line of first
  page printed (see +FIRST_PAGE)
* **-o**, **--indent**=_MARGIN_  
  offset each line with MARGIN (zero) spaces, do not
  affect **-w** or **-W**, MARGIN will be added to PAGE_WIDTH
* **-r**, **--no-file-warnings**  
  omit warning when a file cannot be opened
* **-s[CHAR]**, **--separator**[=_CHAR_]  
  separate columns by a single character, default for CHAR
  is the &lt;TAB&gt; character without **-w** and 'no char' with **-w**.
  **-s[CHAR]** turns off line truncation of all 3 column
  options (**-COLUMN**|-a **-COLUMN**|-m) except **-w** is set
* **-S[STRING]**, **--sep-string**[=_STRING_]  
  separate columns by STRING,
  without **-S**: Default separator &lt;TAB&gt; with **-J** and &lt;space&gt;
  otherwise (same as **-S**" "), no effect on column options
* **-t**, **--omit-header**  
  omit page headers and trailers;
  implied if PAGE_LENGTH &lt;= 10
* **-T**, **--omit-pagination**  
  omit page headers and trailers, eliminate any pagination
  by form feeds set in input files
* **-v**, **--show-nonprinting**  
  use octal backslash notation
* **-w**, **--width**=_PAGE\_WIDTH_  
  set page width to PAGE_WIDTH (72) characters for
  multiple text-column output only, **-s[char]** turns off (72)
* **-W**, **--page-width**=_PAGE\_WIDTH_  
  set page width to PAGE_WIDTH (72) characters always,
  truncate lines, except **-J** option is set, no interference
  with **-S** or **-s**
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="author"></a>

# Author

Written by Pete TerMaat and Roland Huebner.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/pr&gt;  
or available locally via: info '(coreutils) pr invocation'
