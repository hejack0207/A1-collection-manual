# ed(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

ed
— edit text

<a name="synopsis"></a>

# Synopsis

```


```
    ed [(mip string] [(mis] [file]

<a name="description"></a>

# Description

The
_ed_
utility is a line-oriented text editor that uses two modes:
_command mode_
and
_input mode_.
In command mode the input characters shall be interpreted as commands,
and in input mode they shall be interpreted as text. See the EXTENDED
DESCRIPTION section.

If an operand is
**'\(mi'**,
the results are unspecified.

<a name="options"></a>

# Options

The
_ed_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
except for the unspecified usage of
**'\(mi'**.

The following options shall be supported:

* **\(mip&nbsp;string**  
  Use
  _string_
  as the prompt string when in command mode. By default, there shall be
  no prompt string.
* **\(mis**  
  Suppress the writing of byte counts by
  **e**,
  **E**,
  **r**,
  and
  **w**
  commands and of the
  **'!'**
  prompt after a !_command_.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  If the
  _file_
  argument is given,
  _ed_
  shall simulate an
  **e**
  command on the file named by the pathname,
  _file_,
  before accepting commands from the standard input.

<a name="stdin"></a>

# Stdin

The standard input shall be a text file consisting of commands, as
described in the EXTENDED DESCRIPTION section.

<a name="input-files"></a>

# Input Files

The input files shall be text files.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_ed_:

* _HOME_  
  Determine the pathname of the user's home directory.
* _LANG_  
  Provide a default value for the internationalization variables that are
  unset or null. (See the Base Definitions volume of POSIX.1-2008,
  _Section 8.2_, _Internationalization Variables_
  for the precedence of internationalization variables used to determine
  the values of locale categories.)
* _LC\_ALL_  
  If set to a non-empty string value, override the values of all the
  other internationalization variables.
* _LC\_COLLATE_    
  Determine the locale for the behavior of ranges, equivalence classes,
  and multi-character collating elements within regular expressions.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments and input files) and the behavior of
  character classes within regular expressions.
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error and
  informative messages written to standard output.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.

<a name="asynchronous-events"></a>

# Asynchronous Events

The
_ed_
utility shall take the standard action for all signals (see the
ASYNCHRONOUS EVENTS section in
_Section 1.4_, _Utility Description Defaults_)
with the following exceptions:

* SIGINT  
  The
  _ed_
  utility shall interrupt its current activity, write the string
  **"?\en"**
  to standard output, and return to command mode (see the EXTENDED
  DESCRIPTION section).
* SIGHUP  
  If the buffer is not empty and has changed since the last write, the
  _ed_
  utility shall attempt to write a copy of the buffer in a file. First,
  the file named
  **ed.hup**
  in the current directory shall be used; if that fails, the file named
  **ed.hup**
  in the directory named by the
  _HOME_
  environment variable shall be used. In any case, the
  _ed_
  utility shall exit without writing the file to the currently
  remembered pathname and without returning to command mode.
* SIGQUIT  
  The
  _ed_
  utility shall ignore this event.

<a name="stdout"></a>

# Stdout

Various editing commands and the prompting feature (see
**\(mip**)
write to standard output, as described in the EXTENDED DESCRIPTION
section.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

The output files shall be text files whose formats are dependent on the
editing commands given.

<a name="extended-description"></a>

# Extended Description

The
_ed_
utility shall operate on a copy of the file it is editing; changes made
to the copy shall have no effect on the file until a
**w**
(write) command is given. The copy of the text is called the
_buffer_.

Commands to
_ed_
have a simple and regular structure: zero, one, or two
_addresses_
followed by a single-character
_command_,
possibly followed by parameters to that command. These addresses
specify one or more lines in the buffer. Every command that requires
addresses has default addresses, so that the addresses very often can
be omitted. If the
**\(mip**
option is specified, the prompt string shall be written to standard
output before each command is read.

In general, only one command can appear on a line. Certain commands
allow text to be input. This text is placed in the appropriate place in
the buffer. While
_ed_
is accepting text, it is said to be in _input mode_. In this mode,
no commands shall be recognized; all input is merely collected. Input
mode is terminated by entering a line consisting of two characters: a
&lt;period&gt;
(\c
**'.'**)
followed by a
&lt;newline&gt;.
This line is not considered part of the input text.

<a name="regular-expressions-in-ed"></a>

### Regular Expressions in ed


The
_ed_
utility shall support basic regular expressions, as described in the Base Definitions volume of POSIX.1-2008,
_Section 9.3_, _Basic Regular Expressions_.
Since regular expressions in
_ed_
are always matched against single lines (excluding the terminating
&lt;newline&gt;
characters), never against any larger section of text, there is no way
for a regular expression to match a
&lt;newline&gt;.

A null RE shall be equivalent to the last RE encountered.

Regular expressions are used in addresses to specify lines, and in some
commands (for example, the
**s**
substitute command) to specify portions of a line to be substituted.

<a name="addresses-in-ed"></a>

### Addresses in ed


Addressing in
_ed_
relates to the current line. Generally, the current line is the last
line affected by a command. The current line number is the address of
the current line. If the edit buffer is not empty, the initial value
for the current line shall be the last line in the edit buffer;
otherwise, zero.

Addresses shall be constructed as follows:

*  1.  
  The
  &lt;period&gt;
  character (\c
  **'.'**)
  shall address the current line.
*  2.  
  The
  &lt;dollar-sign&gt;
  character (\c
  **'$'**)
  shall address the last line of the edit buffer.
*  3.  
  The positive decimal number
  _n_
  shall address the
  _n_th
  line of the edit buffer.
*  4.  
  The
  &lt;apostrophe&gt;-x
  character pair (\c
  **"'x"**)
  shall address the line marked with the mark name character
  _x_,
  which shall be a lowercase letter from the portable character set. It
  shall be an error if the character has not been set to mark a line or
  if the line that was marked is not currently present in the edit
  buffer.
*  5.  
  A BRE enclosed by
  &lt;slash&gt;
  characters (\c
  **'/'**)
  shall address the first line found by searching forwards from the line
  following the current line toward the end of the edit buffer and
  stopping at the first line for which the line excluding the
  terminating
  &lt;newline&gt;
  matches the BRE. The BRE consisting of a null BRE delimited by a pair of
  &lt;slash&gt;
  characters shall address the next line for which the line excluding
  the terminating
  &lt;newline&gt;
  matches the last BRE encountered. In addition, the second
  &lt;slash&gt;
  can be omitted at the end of a command line. Within the BRE, a
  &lt;backslash&gt;-\c
  &lt;slash&gt;
  pair (\c
  **"\e/"**)
  shall represent a literal
  &lt;slash&gt;
  instead of the BRE delimiter. If necessary, the search shall wrap around
  to the beginning of the buffer and continue up to and including the
  current line, so that the entire buffer is searched.
*  6.  
  A BRE enclosed by
  &lt;question-mark&gt;
  characters (\c
  **'?'**)
  shall address the first line found by searching backwards from the line
  preceding the current line toward the beginning of the edit buffer and
  stopping at the first line for which the line excluding the terminating
  &lt;newline&gt;
  matches the BRE. The BRE consisting of a null BRE delimited by a pair
  of
  &lt;question-mark&gt;
  characters (\c
  **"??"**)
  shall address the previous line for which the line excluding the
  terminating
  &lt;newline&gt;
  matches the last BRE encountered. In addition, the second
  &lt;question-mark&gt;
  can be omitted at the end of a command line. Within the
  BRE, a
  &lt;backslash&gt;-\c
  &lt;question-mark&gt;
  pair (\c
  **"\e?"**)
  shall represent a literal
  &lt;question-mark&gt;
  instead of the BRE delimiter. If necessary, the search shall wrap around
  to the end of the buffer and continue up to and including the current
  line, so that the entire buffer is searched.
*  7.  
  A
  &lt;plus-sign&gt;
  (\c
  **'\(pl'**)
  or
  &lt;hyphen&gt;
  character (\c
  **'\(mi'**)
  followed by a decimal number shall address the current line plus or
  minus the number. A
  &lt;plus-sign&gt;
  or
  &lt;hyphen&gt;
  character not followed by a decimal number shall address the current
  line plus or minus 1.

Addresses can be followed by zero or more address offsets, optionally
&lt;blank&gt;-separated.
Address offsets are constructed as follows:

*  *  
  A
  &lt;plus-sign&gt;
  or
  &lt;hyphen&gt;
  character followed by a decimal number shall add or subtract,
  respectively, the indicated number of lines to or from the address. A
  &lt;plus-sign&gt;
  or
  &lt;hyphen&gt;
  character not followed by a decimal number shall add or subtract 1 to
  or from the address.
*  *  
  A decimal number shall add the indicated number of lines to the
  address.

It shall not be an error for an intermediate address value to be less
than zero or greater than the last line in the edit buffer. It shall be
an error for the final address value to be less than zero or greater
than the last line in the edit buffer. It shall be an error if a search
for a BRE fails to find a matching line.

Commands accept zero, one, or two addresses. If more than the required
number of addresses are provided to a command that requires zero
addresses, it shall be an error. Otherwise, if more than the required
number of addresses are provided to a command, the addresses specified
first shall be evaluated and then discarded until the maximum number of
valid addresses remain, for the specified command.

Addresses shall be separated from each other by a
&lt;comma&gt;
(\c
**','**)
or
&lt;semicolon&gt;
character (\c
**';'**).
In the case of a
&lt;semicolon&gt;
separator, the current line (\c
**'.'**)
shall be set to the first address, and only then will the second
address be calculated. This feature can be used to determine the
starting line for forwards and backwards searches; see rules 5. and
6.

Addresses can be omitted on either side of the
&lt;comma&gt;
or
&lt;semicolon&gt;
separator, in which case the resulting address pairs shall be as
follows:
.TS
center box tab(!);
cB | cB
lf5 | lf5.
Specified!Resulting
_
,!1 , $
, addr!1 , addr
addr ,!addr , addr
;!. ; $
; addr!. ; addr
addr ;!addr ; addr
.TE

Any
&lt;blank&gt;
characters included between addresses, address separators, or address
offsets shall be ignored.

<a name="commands-in-ed"></a>

### Commands in ed


In the following list of
_ed_
commands, the default addresses are shown in parentheses. The number of
addresses shown in the default shall be the number expected by the
command. The parentheses are not part of the address; they show that
the given addresses are the default.

It is generally invalid for more than one command to appear on a line.
However, any command (except
**e**,
**E**,
**f**,
**q**,
**Q**,
**r**,
**w**,
and
**!**)
can be suffixed by the letter
**l**,
**n**,
or
**p**;
in which case, except for the
**l**,
**n**,
and
**p**
commands, the command shall be executed and then the new current line
shall be written as described below under the
**l**,
**n**,
and
**p**
commands. When an
**l**,
**n**,
or
**p**
suffix is used with an
**l**,
**n**,
or
**p**
command, the command shall write to standard output as described below,
but it is unspecified whether the suffix writes the current line again
in the requested format or whether the suffix has no effect. For
example, the
**pl**
command (base
**p**
command with an
**l**
suffix) shall either write just the current line or write it
twice—once as specified for
**p**
and once as specified for
**l**.
Also, the
**g**,
**G**,
**v**,
and
**V**
commands shall take a command as a parameter.

Each address component can be preceded by zero or more
&lt;blank&gt;
characters. The command letter can be preceded by zero or more
&lt;blank&gt;
characters. If a suffix letter (\c
**l**,
**n**,
or
**p**)
is given, the application shall ensure that it immediately follows the
command.

The
**e**,
**E**,
**f**,
**r**,
and
**w**
commands shall take an optional
_file_
parameter, separated from the command letter by one or more
&lt;blank&gt;
characters.

If changes have been made in the buffer since the last
**w**
command that wrote the entire buffer,
_ed_
shall warn the user if an attempt is made to destroy the editor buffer
via the
**e**
or
**q**
commands. The
_ed_
utility shall write the string:

    
    "?en"


(followed by an explanatory message if
_help mode_
has been enabled via the
**H**
command) to standard output and shall continue in command mode with the
current line number unchanged. If the
**e**
or
**q**
command is repeated with no intervening command, it shall take effect.

If a terminal disconnect (see the Base Definitions volume of POSIX.1-2008,
_Chapter 11_, _General Terminal Interface_,
Modem Disconnect and Closing a Device Terminal), is detected:

*  *  
  If accompanied by a SIGHUP signal, the
  _ed_
  utility shall operate as described in the ASYNCHRONOUS EVENTS section
  for a SIGHUP signal.
*  *  
  If not accompanied by a SIGHUP signal, the
  _ed_
  utility shall act as if an end-of-file had been detected on standard
  input.

If an end-of-file is detected on standard input:

*  *  
  If the
  _ed_
  utility is in input mode,
  _ed_
  shall terminate input mode and return to command mode. It is
  unspecified if any partially entered lines (that is, input text without
  a terminating
  &lt;newline&gt;)
  are discarded from the input text.
*  *  
  If the
  _ed_
  utility is in command mode, it shall act as if a
  **q**
  command had been entered.

If the closing delimiter of an RE or of a replacement string (for
example,
**'/'**)
in a
**g**,
**G**,
**s**,
**v**,
or
**V**
command would be the last character before a
&lt;newline&gt;,
that delimiter can be omitted, in which case the addressed line shall
be written. For example, the following pairs of commands are
equivalent:

    
    s/s1/s2   s/s1/s2/p
    g/s1      g/s1/p
    ?s1       ?s1?


If an invalid command is entered,
_ed_
shall write the string:

    
    "?en"


(followed by an explanatory message if
_help mode_
has been enabled via the
**H**
command) to standard output and shall continue in command mode with the
current line number unchanged.

<a name="append-command"></a>

### Append Command


* _Synopsis_:  


    
    (.)a
    <text>
    .


The
**a**
command shall read the given text and append it after the addressed
line; the current line number shall become the address of the last
inserted line or, if there were none, the addressed line. Address 0
shall be valid for this command; it shall cause the appended text to be
placed at the beginning of the buffer.

<a name="change-command"></a>

### Change Command


* _Synopsis_:  


    
    (.,.)c
    <text>
    .


The
**c**
command shall delete the addressed lines, then accept input text that
replaces these lines; the current line shall be set to the address of
the last line input; or, if there were none, at the line after the last
line deleted; if the lines deleted were originally at the end of the
buffer, the current line number shall be set to the address of the new
last line; if no lines remain in the buffer, the current line number
shall be set to zero. Address 0 shall be valid for this command; it
shall be interpreted as if address 1 were specified.

<a name="delete-command"></a>

### Delete Command


* _Synopsis_:  


    
    (.,.)d


The
**d**
command shall delete the addressed lines from the buffer. The address
of the line after the last line deleted shall become the current line
number; if the lines deleted were originally at the end of the buffer,
the current line number shall be set to the address of the new last
line; if no lines remain in the buffer, the current line number shall
be set to zero.

<a name="edit-command"></a>

### Edit Command


* _Synopsis_:  


    
    e [file]


The
**e**
command shall delete the entire contents of the buffer and then read in
the file named by the pathname
_file_.
The current line number shall be set to the address of the last line of
the buffer. If no pathname is given, the currently remembered pathname,
if any, shall be used (see the
**f**
command). The number of bytes read shall be written to standard output,
unless the
**\(mis**
option was specified, in the following format:

    
    "%den", <number of bytes read>


The name _file_ shall be remembered for possible use as a default
pathname in subsequent
**e**,
**E**,
**r**,
and
**w**
commands. If
_file_
is replaced by
**'!'**,
the rest of the line shall be taken to be a shell command line whose
output is to be read. Such a shell command line shall not be remembered
as the current
_file_.
All marks shall be discarded upon the completion of a successful
**e**
command. If the buffer has changed since the last time the entire
buffer was written, the user shall be warned, as described previously.

<a name="edit-without-checking-command"></a>

### Edit Without Checking Command


* _Synopsis_:  


    
    E [file]


The
**E**
command shall possess all properties and restrictions of the
**e**
command except that the editor shall not check to see whether any
changes have been made to the buffer since the last
**w**
command.

<a name="filename-command"></a>

### Filename Command


* _Synopsis_:  


    
    f [file]


If
_file_
is given, the
**f**
command shall change the currently remembered pathname to
_file_;
whether the name is changed or not, it shall then write the (possibly
new) currently remembered pathname to the standard output in the
following format:

    
    "%sen", <pathname>


The current line number shall be unchanged.

<a name="global-command"></a>

### Global Command


* _Synopsis_:  


    
    (1,$)g/RE/command list


In the
**g**
command, the first step shall be to mark every line for which the
line excluding the terminating
&lt;newline&gt;
matches the given RE. Then, going sequentially from the beginning of
the file to the end of the file, the given
_command list_
shall be executed for each marked line, with the current line number
set to the address of that line. Any line modified by the
_command list_
shall be unmarked. When the
**g**
command completes, the current line number shall have the value
assigned by the last command in the
_command list_.
If there were no matching lines, the current line number shall not be
changed. A single command or the first of a list of commands shall
appear on the same line as the global command. All lines of a
multi-line list except the last line shall be ended with a
&lt;backslash&gt;
preceding the terminating
&lt;newline&gt;;
the
**a**,
**i**,
and
**c**
commands and associated input are permitted. The
**'.'**
terminating input mode can be omitted if it would be the last line of
the _command list_. An empty _command list_ shall be equivalent
to the
**p**
command. The use of the
**g**,
**G**,
**v**,
**V**,
and
**!**
commands in the
_command list_
produces undefined results. Any character other than
&lt;space&gt;
or
&lt;newline&gt;
can be used instead of a
&lt;slash&gt;
to delimit the RE. Within the RE, the RE delimiter itself can be used
as a literal character if it is preceded by a
&lt;backslash&gt;.

<a name="interactive-global-command"></a>

### Interactive Global Command


* _Synopsis_:  


    
    (1,$)G/RE/


In the
**G**
command, the first step shall be to mark every line for which the line
excluding the terminating
&lt;newline&gt;
matches the given RE. Then, for every such line, that line shall be
written, the current line number shall be set to the address of that
line, and any one command (other than one of the
**a**,
**c**,
**i**,
**g**,
**G**,
**v**,
and
**V**
commands) shall be read and executed. A
&lt;newline&gt;
shall act as a null command (causing no action to be taken on
the current line); an
**'&'**
shall cause the re-execution of the most recent non-null command
executed within the current invocation of
**G**.
Note that the commands input as part of the execution of the
**G**
command can address and affect any lines in the buffer. Any line
modified by the command shall be unmarked. The final value
of the current line number shall be the value set by the last command
successfully executed. (Note that the last command successfully
executed shall be the
**G**
command itself if a command fails or the null command is specified.) If
there were no matching lines, the current line number shall not be
changed. The
**G**
command can be terminated by a SIGINT signal. Any character other than
&lt;space&gt;
or
&lt;newline&gt;
can be used instead of a
&lt;slash&gt;
to delimit the RE and the replacement. Within the RE, the RE delimiter
itself can be used as a literal character if it is preceded by a
&lt;backslash&gt;.

<a name="help-command"></a>

### Help Command


* _Synopsis_:  


    
    h


The
**h**
command shall write a short message to standard output that explains
the reason for the most recent
**'?'**
notification. The current line number shall be unchanged.

<a name="help-mode-command"></a>

### Help-Mode Command


* _Synopsis_:  


    
    H


The
**H**
command shall cause
_ed_
to enter a mode in which help messages (see the
**h**
command) shall be written to standard output for all subsequent
**'?'**
notifications. The
**H**
command alternately shall turn this mode on and off; it is initially
off. If the help-mode is being turned on, the
**H**
command also explains the previous
**'?'**
notification, if there was one. The current line number shall be
unchanged.

<a name="insert-command"></a>

### Insert Command


* _Synopsis_:  


    
    (.)i
    <text>
    .


The
**i**
command shall insert the given text before the addressed line; the
current line is set to the last inserted line or, if there was none, to
the addressed line. This command differs from the
**a**
command only in the placement of the input text. Address 0 shall be
valid for this command; it shall be interpreted as if address 1 were
specified.

<a name="join-command"></a>

### Join Command


* _Synopsis_:  


    
    (.,.+1)j


The
**j**
command shall join contiguous lines by removing the appropriate
&lt;newline&gt;
characters. If exactly one address is given, this command shall do
nothing. If lines are joined, the current line number shall be set to
the address of the joined line; otherwise, the current line number shall
be unchanged.

<a name="mark-command"></a>

### Mark Command


* _Synopsis_:  


    
    (.)kx


The
**k**
command shall mark the addressed line with name
_x_,
which the application shall ensure is a lowercase letter from the
portable character set. The address
**"'x"**
shall then refer to this line; the current line number shall be
unchanged.

<a name="list-command"></a>

### List Command


* _Synopsis_:  


    
    (.,.)l


The
**l**
command shall write to standard output the addressed lines in a
visually unambiguous form. The characters listed in the Base Definitions volume of POSIX.1-2008,
_Table 5-1_, _Escape Sequences and Associated Actions_
(\c
**'\e\e'**,
**'\ea'**,
**'\eb'**,
**'\ef'**,
**'\er'**,
**'\et'**,
**'\ev'**)
shall be written as the corresponding escape sequence; the
**'\en'**
in that table is not applicable. Non-printable characters not in the
table shall be written as one three-digit octal number (with a
preceding
&lt;backslash&gt;
character) for each byte in the character (most significant byte first).

Long lines shall be folded, with the point of folding indicated by
&lt;newline&gt;
preceded by a
&lt;backslash&gt;;
the length at which folding occurs is unspecified, but should be
appropriate for the output device. The end of each line shall be marked
with a
**'$'**,
and
**'$'**
characters within the text shall be written with a preceding
&lt;backslash&gt;.
An
**l**
command can be appended to any other command other than
**e**,
**E**,
**f**,
**q**,
**Q**,
**r**,
**w**,
or
**!**.
The current line number shall be set to the address of the last line
written.

<a name="move-command"></a>

### Move Command


* _Synopsis_:  


    
    (.,.)maddress


The
**m**
command shall reposition the addressed lines after the line addressed
by
_address_.
Address 0 shall be valid for
_address_
and cause the addressed lines to be moved to the beginning of the
buffer. It shall be an error if address
_address_
falls within the range of moved lines. The current line number shall be
set to the address of the last line moved.

<a name="number-command"></a>

### Number Command


* _Synopsis_:  


    
    (.,.)n


The
**n**
command shall write to standard output the addressed lines, preceding
each line by its line number and a
&lt;tab&gt;;
the current line number shall be set to the address of the last line
written. The
**n**
command can be appended to any command other than
**e**,
**E**,
**f**,
**q**,
**Q**,
**r**,
**w**,
or
**!**.

<a name="print-command"></a>

### Print Command


* _Synopsis_:  


    
    (.,.)p


The
**p**
command shall write to standard output the addressed lines; the current
line number shall be set to the address of the last line written. The
**p**
command can be appended to any command other than
**e**,
**E**,
**f**,
**q**,
**Q**,
**r**,
**w**,
or
**!**.

<a name="prompt-command"></a>

### Prompt Command


* _Synopsis_:  


    
    P


The
**P**
command shall cause
_ed_
to prompt with an
&lt;asterisk&gt;
(\c
**'*'**)
(or
_string_,
if
**\(mip**
is specified) for all subsequent commands. The
**P**
command alternatively shall turn this mode on and off; it shall be
initially on if the
**\(mip**
option is specified; otherwise, off. The current line number shall be
unchanged.

<a name="quit-command"></a>

### Quit Command


* _Synopsis_:  


    
    q


The
**q**
command shall cause
_ed_
to exit. If the buffer has changed since the last time the entire
buffer was written, the user shall be warned, as described previously.

<a name="quit-without-checking-command"></a>

### Quit Without Checking Command


* _Synopsis_:  


    
    Q


The
**Q**
command shall cause
_ed_
to exit without checking whether changes have been made in the buffer
since the last
**w**
command.

<a name="read-command"></a>

### Read Command


* _Synopsis_:  


    
    ($)r [file]


The
**r**
command shall read in the file named by the pathname
_file_
and append it after the addressed line. If no
_file_
argument is given, the currently remembered pathname, if any, shall be
used (see the
**e**
and
**f**
commands). The currently remembered pathname shall not be changed
unless there is no remembered pathname. Address 0 shall be valid for
**r**
and shall cause the file to be read at the beginning of the buffer. If
the read is successful, and
**\(mis**
was not specified, the number of bytes read shall be written to
standard output in the following format:

    
    "%den", <number of bytes read>


The current line number shall be set to the address of the last line
read in. If
_file_
is replaced by
**'!'**,
the rest of the line shall be taken to be a shell command line whose
output is to be read. Such a shell command line shall not be remembered
as the current pathname.

<a name="substitute-command"></a>

### Substitute Command


* _Synopsis_:  


    
    (.,.)s/RE/replacement/flags


The
**s**
command shall search each addressed line for an occurrence of the
specified RE and replace either the first or all (non-overlapped)
matched strings with the
_replacement_;
see the following description of the
**g**
suffix. It is an error if the substitution fails on every addressed
line. Any character other than
&lt;space&gt;
or
&lt;newline&gt;
can be used instead of a
&lt;slash&gt;
to delimit the RE and the replacement. Within the RE, the RE delimiter
itself can be used as a literal character if it is preceded by a
&lt;backslash&gt;.
The current line shall be set to the address of the last line on which
a substitution occurred.

An
&lt;ampersand&gt;
(\c
**'&'**)
appearing in the
_replacement_
shall be replaced by the string matching the RE on the current line.
The special meaning of
**'&'**
in this context can be suppressed by preceding it by
&lt;backslash&gt;.
As a more general feature, the characters
**'\en'**,
where
_n_
is a digit, shall be replaced by the text matched by the corresponding
back-reference expression. If the corresponding back-reference
expression does not match, then the characters
**'\en'**
shall be replaced by the empty string. When the character
**'%'**
is the only character in the
_replacement_,
the
_replacement_
used in the most recent substitute command shall be used as the
_replacement_
in the current substitute command; if there was no previous substitute
command, the use of
**'%'**
in this manner shall be an error. The
**'%'**
shall lose its special meaning when it is in a replacement string of
more than one character or is preceded by a
&lt;backslash&gt;.
For each
&lt;backslash&gt;
encountered in scanning
_replacement_
from beginning to end, the following character shall lose its special
meaning (if any). It is unspecified what special meaning is given to
any character other than
&lt;backslash&gt;,
**'&'**,
**'%'**,
or digits.

A line can be split by substituting a
&lt;newline&gt;
into it. The application shall ensure it escapes the
&lt;newline&gt;
in the
_replacement_
by preceding it by
&lt;backslash&gt;.
Such substitution cannot be done as part of a
**g**
or
**v**
_command list_.
The current line number shall be set to the address of the last line on
which a substitution is performed. If no substitution is performed, the
current line number shall be unchanged. If a line is split, a
substitution shall be considered to have been performed on each of the
new lines for the purpose of determining the new current line number. A
substitution shall be considered to have been performed even if the
replacement string is identical to the string that it replaces.

The application shall ensure that the value of
_flags_
is zero or more of:

* _count_  
  Substitute for the
  _count_th
  occurrence only of the RE found on each addressed line.
* **g**  
  Globally substitute for all non-overlapping instances of the RE rather
  than just the first one. If both
  **g**
  and
  _count_
  are specified, the results are unspecified.
* **l**  
  Write to standard output the final line in which a substitution was
  made. The line shall be written in the format specified for the
  **l**
  command.
* **n**  
  Write to standard output the final line in which a substitution was
  made. The line shall be written in the format specified for the
  **n**
  command.
* **p**  
  Write to standard output the final line in which a substitution was
  made. The line shall be written in the format specified for the
  **p**
  command.

<a name="copy-command"></a>

### Copy Command


* _Synopsis_:  


    
    (.,.)taddress


The
**t**
command shall be equivalent to the
**m**
command, except that a copy of the addressed lines shall be placed
after address
_address_
(which can be 0); the current line number shall be set to the address
of the last line added.

<a name="undo-command"></a>

### Undo Command


* _Synopsis_:  


    
    u


The
**u**
command shall nullify the effect of the most recent command that
modified anything in the buffer, namely the most recent
**a**,
**c**,
**d**,
**g**,
**i**,
**j**,
**m**,
**r**,
**s**,
**t**,
**u**,
**v**,
**G**,
or
**V**
command. All changes made to the buffer by a
**g**,
**G**,
**v**,
or
**V**
global command shall be undone as a single change; if no changes were
made by the global command (such as with
**g**/RE/\c
**p**),
the
**u**
command shall have no effect. The current line number shall be set to
the value it had immediately before the command being undone started.

<a name="global-non-matched-command"></a>

### Global Non-Matched Command


* _Synopsis_:  


    
    (1,$)v/RE/command list


This command shall be equivalent to the global command
**g**
except that the lines that are marked during the first step shall be
those for which the line excluding the terminating
&lt;newline&gt;
does not match the RE.

<a name="interactive-global-not-matched-command"></a>

### Interactive Global Not-Matched Command


* _Synopsis_:  


    
    (1,$)V/RE/


This command shall be equivalent to the interactive global command
**G**
except that the lines that are marked during the first step shall be
those for which the line excluding the terminating
&lt;newline&gt;
does not match the RE.

<a name="write-command"></a>

### Write Command


* _Synopsis_:  


    
    (1,$)w [file]


The
**w**
command shall write the addressed lines into the file named by the
pathname
_file_.
The command shall create the file, if it does not exist, or shall
replace the contents of the existing file. The currently remembered
pathname shall not be changed unless there is no remembered pathname.
If no pathname is given, the currently remembered pathname, if any,
shall be used (see the
**e**
and
**f**
commands); the current line number shall be unchanged. If the command
is successful, the number of bytes written shall be written to standard
output, unless the
**\(mis**
option was specified, in the following format:

    
    "%den", <number of bytes written>


If
_file_
begins with
**'!'**,
the rest of the line shall be taken to be a shell command line whose
standard input shall be the addressed lines. Such a shell command line
shall not be remembered as the current pathname. This usage of the
write command with
**'!'**
shall not be considered as a \`\`last
**w**
command that wrote the entire buffer'', as described previously; thus,
this alone shall not prevent the warning to the user if an attempt is
made to destroy the editor buffer via the
**e**
or
**q**
commands.

<a name="line-number-command"></a>

### Line Number Command


* _Synopsis_:  


    
    ($)=


The line number of the addressed line shall be written to standard
output in the following format:

    
    "%den", <line number>


The current line number shall be unchanged by this command.

<a name="shell-escape-command"></a>

### Shell Escape Command


* _Synopsis_:  


    
    !command


The remainder of the line after the
**'!'**
shall be sent to the command interpreter to be interpreted as a shell
command line. Within the text of that shell command line, the unescaped
character
**'%'**
shall be replaced with the remembered pathname; if a
**'!'**
appears as the first character of the command, it shall be replaced
with the text of the previous shell command executed via
**'!'**.
Thus,
**"!!"**
shall repeat the previous !_command_. If any replacements of
**'%'**
or
**'!'**
are performed, the modified line shall be written to the standard
output before
_command_
is executed. The
**!**
command shall write:

    
    "!en"


to standard output upon completion, unless the
**\(mis**
option is specified. The current line number shall be unchanged.

<a name="null-command"></a>

### Null Command


* _Synopsis_:  


    
    (.+1)


An address alone on a line shall cause the addressed line to be
written. A
&lt;newline&gt;
alone shall be equivalent to
**"+1p"**.
The current line number shall be set to the address of the written
line.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  Successful completion without any file or command errors.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

When an error in the input script is encountered, or when an error is
detected that is a consequence of the data (not) present in the file or
due to an external condition such as a read or write error:

*  *  
  If the standard input is a terminal device file, all input shall be
  flushed, and a new command read.
*  *  
  If the standard input is a regular file,
  _ed_
  shall terminate with a non-zero exit status.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Because of the extremely terse nature of the default error messages,
the prudent script writer begins the
_ed_
input commands with an
**H**
command, so that if any errors do occur at least some clue as to the
cause is made available.

In earlier versions of this standard, an obsolescent
**\(mi**
option was described. This is no longer specified. Applications should
use the
**\(mis**
option. Using
**\(mi**
as a
_file_
operand now produces unspecified results. This allows implementations
to continue to support the former required behavior.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The initial description of this utility was adapted from the SVID. It
contains some features not found in Version 7 or BSD-derived systems.
Some of the differences between the POSIX and BSD
_ed_
utilities include, but need not be limited to:

*  *  
  The BSD
  **\(mi**
  option does not suppress the
  **'!'**
  prompt after a
  **!**
  command.
*  *  
  BSD does not support the special meanings of the
  **'%'**
  and
  **'!'**
  characters within a
  **!**
  command.
*  *  
  BSD does not support the
  _addresses_
  **';'**
  and
  **','**.
*  *  
  BSD allows the command/suffix pairs
  **pp**,
  **ll**,
  and so on, which are unspecified in this volume of POSIX.1-2008.
*  *  
  BSD does not support the
  **'!'**
  character part of the
  **e**,
  **r**,
  or
  **w**
  commands.
*  *  
  A failed
  **g**
  command in BSD sets the line number to the last line searched if there
  are no matches.
*  *  
  BSD does not default the
  _command list_
  to the
  **p**
  command.
*  *  
  BSD does not support the
  **G**,
  **h**,
  **H**,
  **n**,
  or
  **V**
  commands.
*  *  
  On BSD, if there is no inserted text, the insert command changes the
  current line to the referenced line \(mi1; that is, the line before the
  specified line.
*  *  
  On BSD, the
  _join_
  command with only a single address changes the current line to that
  address.
*  *  
  BSD does not support the
  **P**
  command; moreover, in BSD it is synonymous with the
  **p**
  command.
*  *  
  BSD does not support the
  _undo_
  of the commands
  **j**,
  **m**,
  **r**,
  **s**,
  or
  **t**.
*  *  
  The Version 7
  _ed_
  command
  **W**,
  and the BSD
  _ed_
  commands
  **W**,
  **wq**,
  and
  **z**
  are not present in this volume of POSIX.1-2008.

The
**\(mis**
option was added to allow the functionality of the removed
**\(mi**
option in a manner compatible with the Utility Syntax Guidelines.

In early proposals there was a limit,
{ED_FILE_MAX},
that described the historical limitations of some
_ed_
utilities in their handling of large files; some of these have had
problems with files larger than 100\|000 bytes. It was this limitation
that prompted much of the desire to include a
_split_
command in this volume of POSIX.1-2008. Since this limit was removed, this volume of POSIX.1-2008 requires that
implementations document the file size limits imposed by
_ed_
in the conformance document. The limit
{ED_LINE_MAX}
was also removed; therefore, the global limit
{LINE_MAX}
is used for input and output lines.

The manner in which the
**l**
command writes non-printable characters was changed to avoid
the historical backspace-overstrike method. On video display terminals,
the overstrike is ambiguous because most terminals simply replace
overstruck characters, making the
**l**
format not useful for its intended purpose of unambiguously
understanding the content of the line. The historical
&lt;backslash&gt;-escapes
were also ambiguous. (The string
**"a\e0011"**
could represent a line containing those six characters or a line
containing the three characters
**'a'**,
a byte with a binary value of 1, and a 1.) In the format required here,
a
&lt;backslash&gt;
appearing in the line is written as
**"\e\e"**
so that the output is truly unambiguous. The method of marking the ends
of lines was adopted from the
_ex_
editor and is required for any line ending in
&lt;space&gt;
characters; the
**'$'**
is placed on all lines so that a real
**'$'**
at the end of a line cannot be misinterpreted.

Earlier versions of this standard allowed for implementations
with bytes other than eight bits, but this has been modified in this
version.

The description of how a NUL is written was removed. The NUL character
cannot be in text files, and this volume of POSIX.1-2008 should not dictate behavior in the
case of undefined, erroneous input.

Unlike some of the other editing utilities, the filenames accepted by
the
**E**,
**e**,
**R**,
and
**r**
commands are not patterns.

Early proposals stated that the
**\(mip**
option worked only when standard input was associated with a terminal
device. This has been changed to conform to historical implementations,
thereby allowing applications to interpose themselves between a user
and the
_ed_
utility.

The form of the substitute command that uses the
**n**
suffix was limited in some historical documentation (where this was
described incorrectly as \`\`backreferencing''). This limit has been
omitted because there is no reason why an editor processing lines of
{LINE_MAX}
length should have this restriction. The command
**s/x/X/2047**
should be able to substitute the 2\|047th occurrence of
**'x'**
on a line.

The use of printing commands with printing suffixes (such as
**pn**,
**lp**,
and so on) was made unspecified because BSD-based systems allow this,
whereas System V does not.

Some BSD-based systems exit immediately upon receipt of end-of-file if
all of the lines in the file have been deleted. Since this volume of POSIX.1-2008 refers
to the
**q**
command in this instance, such behavior is not allowed.

Some historical implementations returned exit status zero even if
command errors had occurred; this is not allowed by this volume of POSIX.1-2008.

Some historical implementations contained a bug that allowed a single
&lt;period&gt;
to be entered in input mode as
&lt;backslash&gt;
&lt;period&gt;
&lt;newline&gt;.
This is not allowed by
_ed_
because there is no description of escaping any of the characters in
input mode;
&lt;backslash&gt;
characters are entered into the buffer exactly as typed. The typical
method of entering a single
&lt;period&gt;
has been to precede it with another character and then use the substitute
command to delete that character.

It is difficult under some modes of some versions of historical
operating system terminal drivers to distinguish between an end-of-file
condition and terminal disconnect. POSIX.1-2008 does not require
implementations to distinguish between the two situations, which
permits historical implementations of the
_ed_
utility on historical platforms to conform. Implementations are
encouraged to distinguish between the two, if possible, and take
appropriate action on terminal disconnect.

Historically,
_ed_
accepted a zero address for the
**a**
and
**r**
commands in order to insert text at the start of the edit buffer. When
the buffer was empty the command
**.=**
returned zero. POSIX.1-2008 requires conformance to historical practice.

For consistency with the
**a**
and
**r**
commands and better user functionality, the
**i**
and
**c**
commands must also accept an address of 0, in which case 0_i_ is
treated as 1_i_ and likewise for the
**c**
command.

All of the following are valid addresses:

* +++  
  Three lines after the current line.
* /_pattern_/\(mi  
  One line before the next occurrence of pattern.
* \(mi2  
  Two lines before the current line.
* 3&nbsp;\(mi\|\(mi\|\(mi\|\(mi&nbsp;2  
  Line one (note the intermediate negative address).
* 1&nbsp;2&nbsp;3  
  Line six.

Any number of addresses can be provided to commands taking addresses;
for example,
**"1,2,3,4,5p"**
prints lines 4 and 5, because two is the greatest valid number of
addresses accepted by the
**print**
command. This, in combination with the
&lt;semicolon&gt;
delimiter, permits users to create commands based on ordered patterns
in the file. For example, the command
**"3;/foo/;+2p"**
will display the first line after line 3 that contains the pattern
_foo_,
plus the next two lines. Note that the address
**"3;"**
must still be evaluated before being discarded, because the search
origin for the
**"/foo/"**
command depends on this.

Historically,
_ed_
disallowed address chains, as discussed above, consisting solely of
&lt;comma&gt;
or
&lt;semicolon&gt;
separators; for example,
**",,,"**
or
**";;;"**
were considered an error. For consistency of address specification,
this restriction is removed. The following table lists some of the
address forms now possible:
.TS
center box tab(!);
cB | cB | cB | cB | cB
lf5 | nf5 | nf5 | l | l.
Address!Addr1!Addr2!Status!Comment
_
7,!7!7!Historical
7,5,!5!5!Historical
7,5,9!5!9!Historical
7,9!7!9!Historical
7,+!7!8!Historical
,!1!$!Historical
,7!1!7!Extension
,,!$!$!Extension
,;!$!$!Extension
7;!7!7!Historical
7;5;!5!5!Historical
7;5;9!5!9!Historical
7;5,9!5!9!Historical
7;$;4!$!4!Historical!Valid, but erroneous.
7;9!7!9!Historical
7;+!7!8!Historical
;!.!$!Historical
;7!.!7!Extension
;;!$!$!Extension
;,!$!$!Extension
.TE

Historically,
_ed_
accepted the
**'^'**
character as an address, in which case it was identical to the
&lt;hyphen&gt;
character. POSIX.1-2008 does not require or prohibit this behavior.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 1.4_, _Utility Description Defaults_,
__ex_\^_,
__sed_\^_,
__sh_\^_,
__vi_\^_

The Base Definitions volume of POSIX.1-2008,
_Table 5-1_, _Escape Sequences and Associated Actions_,
_Chapter 8_, _Environment Variables_,
_Section 9.3_, _Basic Regular Expressions_,
_Chapter 11_, _General Terminal Interface_,
_Section 12.2_, _Utility Syntax Guidelines_

<a name="copyright"></a>

# Copyright

Portions of this text are reprinted and reproduced in electronic form
from IEEE Std 1003.1, 2013 Edition, Standard for Information Technology
-- Portable Operating System Interface (POSIX), The Open Group Base
Specifications Issue 7, Copyright (C) 2013 by the Institute of
Electrical and Electronics Engineers, Inc and The Open Group.
(This is POSIX.1-2008 with the 2013 Technical Corrigendum 1 applied.) In the
event of any discrepancy between this version and the original IEEE and
The Open Group Standard, the original IEEE and The Open Group Standard
is the referee document. The original Standard can be obtained online at
http://www.unix.org/online.html .

Any typographical or formatting errors that appear
in this page are most likely
to have been introduced during the conversion of the source files to
man page format. To report such errors, see
https://www.kernel.org/doc/man-pages/reporting_bugs.html .
