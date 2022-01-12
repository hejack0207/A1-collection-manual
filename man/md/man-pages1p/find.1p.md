# find(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

find
— find files

<a name="synopsis"></a>

# Synopsis

```


```
    find [(miH|(miL] path... [operand_expression...]

<a name="description"></a>

# Description

The
_find_
utility shall recursively descend the directory hierarchy from each
file specified by
_path_,
evaluating a Boolean expression composed of the primaries described in
the OPERANDS section for each file encountered. Each
_path_
operand shall be evaluated unaltered as it was provided, including
all trailing
&lt;slash&gt;
characters; all pathnames for other files encountered in the hierarchy
shall consist of the concatenation of the current
_path_
operand, a
&lt;slash&gt;
if the current
_path_
operand did not end in one, and the filename relative to the
_path_
operand. The relative portion shall contain no dot or dot-dot components,
no trailing
&lt;slash&gt;
characters, and only single
&lt;slash&gt;
characters between pathname components.

The
_find_
utility shall be able to descend to arbitrary depths in a file
hierarchy and shall not fail due to path length limitations (unless a
_path_
operand specified by the application exceeds
{PATH_MAX}
requirements).

The
_find_
utility shall detect infinite loops; that is, entering a previously
visited directory that is an ancestor of the last file encountered.
When it detects an infinite loop,
_find_
shall write a diagnostic message to standard error and shall either
recover its position in the hierarchy or terminate.

If a file is removed from or added to the directory hierarchy being
searched it is unspecified whether or not
_find_
includes that file in its search.

<a name="options"></a>

# Options

The
_find_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported by the implementation:

* **\(miH**  
  Cause the file information and file type evaluated for each symbolic
  link encountered as a
  _path_
  operand on the command line to be those of the file referenced by the
  link, and not the link itself. If the referenced file does not exist, the
  file information and type shall be for the link itself. File information
  and type for symbolic links encountered during the traversal of a file
  hierarchy shall be that of the link itself.
* **\(miL**  
  Cause the file information and file type evaluated for each symbolic
  link encountered as a
  _path_
  operand on the command line or encountered during the traversal of
  a file hierarchy to be those of the file referenced by the link, and
  not the link itself. If the referenced file does not exist, the file
  information and type shall be for the link itself.

Specifying more than one of the mutually-exclusive options
**\(miH**
and
**\(miL**
shall not be considered an error. The last option specified shall
determine the behavior of the utility. If neither the
**\(miH**
nor the
**\(miL**
option is specified, then the file information and type for symbolic
links encountered as a
_path_
operand on the command line or encountered during the traversal of a
file hierarchy shall be that of the link itself.

<a name="operands"></a>

# Operands

The following operands shall be supported:

The first operand and subsequent operands up to but not including the
first operand that starts with a
**'\(mi'**,
or is a
**'!'**
or a
**'('**,
shall be interpreted as
_path_
operands. If the first operand starts with a
**'\(mi'**,
or is a
**'!'**
or a
**'('**,
the behavior is unspecified. Each
_path_
operand is a pathname of a starting point in the file hierarchy.

The first operand that starts with a
**'\(mi'**,
or is a
**'!'**
or a
**'('**,
and all subsequent arguments shall be interpreted as an
_expression_
made up of the following primaries and operators. In the descriptions,
wherever
_n_
is used as a primary argument, it shall be interpreted as a decimal
integer optionally preceded by a plus (\c
**'\(pl'**)
or minus-sign (\c
**'\(mi'**)
sign, as follows:

* +_n_  
  More than
  _n_.
* _n_  
  Exactly
  _n_.
* \(mi_n_  
  Less than
  _n_.

The following primaries shall be supported:

* **\(miname&nbsp;pattern**    
  The primary shall evaluate as true if the basename of the current
  pathname matches
  _pattern_
  using the pattern matching notation described in
  _Section 2.13_, _Pattern Matching Notation_.
  The additional rules in
  _Section 2.13.3_, _Patterns Used for Filename Expansion_
  do not apply as this is a matching operation, not an expansion.
* **\(mipath&nbsp;pattern**    
  The primary shall evaluate as true if the current pathname matches
  _pattern_
  using the pattern matching notation described in
  _Section 2.13_, _Pattern Matching Notation_.
  The additional rules in
  _Section 2.13.3_, _Patterns Used for Filename Expansion_
  do not apply as this is a matching operation, not an expansion.
* **\(minouser**  
  The primary shall evaluate as true if the file belongs to a user ID for
  which the
  _getpwuid_()
  function defined in the System Interfaces volume of POSIX.1-2008 (or equivalent) returns NULL.
* **\(minogroup**  
  The primary shall evaluate as true if the file belongs to a group ID
  for which the
  _getgrgid_()
  function defined in the System Interfaces volume of POSIX.1-2008 (or equivalent) returns NULL.
* **\(mixdev**  
  The primary shall always evaluate as true; it shall cause
  _find_
  not to continue descending past directories that have a different
  device ID (\c
  _st_dev_,
  see the
  _stat_()
  function defined in the System Interfaces volume of POSIX.1-2008). If any
  **\(mixdev**
  primary is specified, it shall apply to the entire expression even if
  the
  **\(mixdev**
  primary would not normally be evaluated.
* **\(miprune**  
  The primary shall always evaluate as true; it shall cause
  _find_
  not to descend the current pathname if it is a directory. If the
  **\(midepth**
  primary is specified, the
  **\(miprune**
  primary shall have no effect.
* **\(miperm&nbsp;[\(mi]mode**    
  The
  _mode_
  argument is used to represent file mode bits. It shall be identical in
  format to the
  _symbolic_mode_
  operand described in
  _chmod_,
  and shall be interpreted as follows. To start, a template shall be
  assumed with all file mode bits cleared. An
  _op_
  symbol of
  **'\(pl'**
  shall set the appropriate mode bits in the template;
  **'\(mi'**
  shall clear the appropriate bits;
  **'='**
  shall set the appropriate mode bits, without regard to the contents of
  the file mode creation mask of the process. The
  _op_
  symbol of
  **'\(mi'**
  cannot be the first character of
  _mode_;
  this avoids ambiguity with the optional leading
  &lt;hyphen&gt;.
  Since the initial mode is all bits off, there are not any symbolic modes
  that need to use
  **'\(mi'**
  as the first character.

If the
&lt;hyphen&gt;
is omitted, the primary shall evaluate as true when the file permission
bits exactly match the value of the resulting template.

Otherwise, if
_mode_
is prefixed by a
&lt;hyphen&gt;,
the primary shall evaluate as true if at least all the bits in the
resulting template are set in the file permission bits.

* **\(miperm&nbsp;[\(mi]onum**    
  If the
  &lt;hyphen&gt;
  is omitted, the primary shall evaluate as true when the file mode bits
  exactly match the value of the octal number
  _onum_
  (see the description of the octal
  _mode_
  in
  _chmod_).
  Otherwise, if
  _onum_
  is prefixed by a
  &lt;hyphen&gt;,
  the primary shall evaluate as true if at least all of the bits specified in
  _onum_
  are set. In both cases, the behavior is unspecified when
  _onum_
  exceeds 07777.
* **\(mitype&nbsp;c**  
  The primary shall evaluate as true if the type of the file is
  _c_,
  where
  _c_
  is
  **'b'**,
  **'c'**,
  **'d'**,
  **'l'**,
  **'p'**,
  **'f'**,
  or
  **'s'**
  for block special file, character special file, directory, symbolic
  link, FIFO, regular file, or socket, respectively.
* **\(milinks&nbsp;n**  
  The primary shall evaluate as true if the file has
  _n_
  links.
* **\(miuser&nbsp;uname**  
  The primary shall evaluate as true if the file belongs to the user
  _uname._
  If
  _uname_
  is a decimal integer and the
  _getpwnam_()
  (or equivalent) function does not return a valid user name,
  _uname_
  shall be interpreted as a user ID.
* **\(migroup&nbsp;gname**    
  The primary shall evaluate as true if the file belongs to the group
  _gname_.
  If
  _gname_
  is a decimal integer and the
  _getgrnam_()
  (or equivalent) function does not return a valid group name,
  _gname_
  shall be interpreted as a group ID.
* **\(misize&nbsp;n[c]**  
  The primary shall evaluate as true if the file size in bytes, divided
  by 512 and rounded up to the next integer, is
  _n_.
  If
  _n_
  is followed by the character
  **'c'**,
  the size shall be in bytes.
* **\(miatime&nbsp;n**  
  The primary shall evaluate as true if the file access time subtracted
  from the initialization time, divided by 86\|400 (with any remainder
  discarded), is
  _n_.
* **\(mictime&nbsp;n**  
  The primary shall evaluate as true if the time of last change of file
  status information subtracted from the initialization time, divided by
  86\|400 (with any remainder discarded), is
  _n_.
* **\(mimtime&nbsp;n**  
  The primary shall evaluate as true if the file modification time
  subtracted from the initialization time, divided by 86\|400 (with any
  remainder discarded), is
  _n_.
* **\(miexec&nbsp;utility_name&nbsp;[argument**&nbsp;.\|.\|.**]&nbsp;;**  
* **\(miexec&nbsp;utility_name&nbsp;[argument**&nbsp;.\|.\|.**]&nbsp;&nbsp;**{\|}\0+    
  The end of the primary expression shall be punctuated by a
  &lt;semicolon&gt;
  or by a
  &lt;plus-sign&gt;.
  Only a
  &lt;plus-sign&gt;
  that immediately follows an argument containing only the two characters
  **"{}"**
  shall punctuate the end of the primary expression. Other uses of the
  &lt;plus-sign&gt;
  shall not be treated as special.

If the primary expression is punctuated by a
&lt;semicolon&gt;,
the utility
_utility_name_
shall be invoked once for each pathname and the primary shall evaluate
as true if the utility returns a zero value as exit status. A
_utility_name_
or
_argument_
containing only the two characters
**"{}"**
shall be replaced by the current pathname. If a
_utility_name_
or
_argument_
string contains the two characters
**"{}"**,
but not just the two characters
**"{}"**,
it is implementation-defined whether
_find_
replaces those two characters or uses the string without change.

If the primary expression is punctuated by a
&lt;plus-sign&gt;,
the primary shall always evaluate as true, and the pathnames for which
the primary is evaluated shall be aggregated into sets. The utility
_utility_name_
shall be invoked once for each set of aggregated pathnames. Each
invocation shall begin after the last pathname in the set is
aggregated, and shall be completed before the
_find_
utility exits and before the first pathname in the next set (if any) is
aggregated for this primary, but it is otherwise unspecified whether
the invocation occurs before, during, or after the evaluations of other
primaries. If any invocation returns a non-zero value as exit status,
the
_find_
utility shall return a non-zero exit status. An argument containing
only the two characters
**"{}"**
shall be replaced by the set of aggregated pathnames, with each
pathname passed as a separate argument to the invoked utility in the
same order that it was aggregated. The size of any set of two or more
pathnames shall be limited such that execution of the utility does not
cause the system's
{ARG_MAX}
limit to be exceeded. If more than one argument containing the two
characters
**"{}"**
is present, the behavior is unspecified.

The current directory for the invocation of
_utility_name_
shall be the same as the current directory when the
_find_
utility was started. If the
_utility_name_
names any of the special built-in utilities (see
_Section 2.14_, _Special Built-In Utilities_),
the results are undefined.

* **\(miok&nbsp;utility_name&nbsp;[argument**&nbsp;.\|.\|.**]&nbsp;;**    
  The
  **\(miok**
  primary shall be equivalent to
  **\(miexec**,
  except that the use of a
  &lt;plus-sign&gt;
  to punctuate the end of the primary expression need not be supported, and
  _find_
  shall request affirmation of the invocation of
  _utility_name_
  using the current file as an argument by writing to standard error as
  described in the STDERR section. If the response on standard input is
  affirmative, the utility shall be invoked. Otherwise, the command
  shall not be invoked and the value of the
  **\(miok**
  operand shall be false.
* **\(miprint**  
  The primary shall always evaluate as true; it shall cause the current
  pathname to be written to standard output.
* **\(minewer&nbsp;file**  
  The primary shall evaluate as true if the modification time of the
  current file is more recent than the modification time of the file
  named by the pathname
  _file_.
* **\(midepth**  
  The primary shall always evaluate as true; it shall cause descent of
  the directory hierarchy to be done so that all entries in a directory
  are acted on before the directory itself. If a
  **\(midepth**
  primary is not specified, all entries in a directory shall be acted on
  after the directory itself. If any
  **\(midepth**
  primary is specified, it shall apply to the entire expression even if
  the
  **\(midepth**
  primary would not normally be evaluated.

The primaries can be combined using the following operators (in order
of decreasing precedence):

* (&nbsp;_expression_&nbsp;)  
  True if
  _expression_
  is true.
* **!&nbsp;expression**  
  Negation of a primary; the unary NOT operator.
* expression&nbsp;**[\(mia]&nbsp;expression**    
  Conjunction of primaries; the AND operator is implied by the
  juxtaposition of two primaries or made explicit by the optional
  **\(mia**
  operator. The second expression shall not be evaluated if the first
  expression is false.
* expression&nbsp;**\(mio&nbsp;expression**    
  Alternation of primaries; the OR operator. The second expression shall
  not be evaluated if the first expression is true.

If no
_expression_
is present,
**\(miprint**
shall be used as the expression. Otherwise, if the given expression
does not contain any of the primaries
**\(miexec**,
**\(miok**,
or
**\(miprint**,
the given expression shall be effectively replaced by:

    
    ( given_expression ) (miprint


The
**\(miuser**,
**\(migroup**,
and
**\(minewer**
primaries each shall evaluate their respective arguments only once.

When the file type evaluated for the current file is a symbolic link,
the results of evaluating the
**\(miperm**
primary are implementation-defined.

<a name="stdin"></a>

# Stdin

If the
**\(miok**
primary is used, the response shall be read from the standard input.
An entire line shall be read as the response. Otherwise, the standard
input shall not be used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_find_:

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
  and multi-character collating elements used in the pattern matching
  notation for the
  **\(min**
  option and in the extended regular expression defined for the
  **yesexpr**
  locale keyword in the
  _LC_MESSAGES_
  category.
* _LC\_CTYPE_  
  This variable determines the locale for the interpretation of sequences
  of bytes of text data as characters (for example, single-byte
  as opposed to multi-byte characters in arguments), the behavior of
  character classes within the pattern matching notation used for the
  **\(min**
  option, and the behavior of character classes within regular
  expressions used in the extended regular expression defined for the
  **yesexpr**
  locale keyword in the
  _LC_MESSAGES_
  category.
* _LC\_MESSAGES_    
  Determine the locale used to process affirmative responses, and the
  locale used to affect the format and contents of diagnostic messages
  and prompts written to standard error.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _PATH_  
  Determine the location of the
  _utility_name_
  for the
  **\(miexec**
  and
  **\(miok**
  primaries, as described in the Base Definitions volume of POSIX.1-2008,
  _Chapter 8_, _Environment Variables_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

The
**\(miprint**
primary shall cause the current pathnames to be written to standard
output. The format shall be:

    
    "%sen", <path>


<a name="stderr"></a>

# Stderr

The
**\(miok**
primary shall write a prompt to standard error containing at least the
_utility_name_
to be invoked and the current pathname. In the POSIX locale, the last
non-\c
&lt;blank&gt;
in the prompt shall be
**'?'**.
The exact format used is unspecified.

Otherwise, the standard error shall be used only for diagnostic
messages.

<a name="output-files"></a>

# Output Files

None.

<a name="extended-description"></a>

# Extended Description

None.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  All
  _path_
  operands were traversed successfully.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

When used in operands, pattern matching notation,
&lt;semicolon&gt;,
&lt;left-parenthesis&gt;,
and
&lt;right-parenthesis&gt;
characters are special to the shell and must be quoted (see
_Section 2.2_, _Quoting_).

The bit that is traditionally used for sticky (historically 01000) is
specified in the
**\(miperm**
primary using the octal number argument form. Since this bit is not
defined by this volume of POSIX.1-2008, applications must not assume that it actually refers
to the traditional sticky bit.

<a name="examples"></a>

# Examples


*  1.  
  The following commands are equivalent:

    
    find .
    find . (miprint


They both write out the entire directory hierarchy from the current
directory.

*  2.  
  The following command:

    
    find / e( (miname tmp (mio (miname '*.xx' e) (miatime +7 (miexec rm {} e;


removes all files named
**tmp**
or ending in
**.xx**
that have not been accessed for seven or more 24-hour periods.

*  3.  
  The following command:

    
    find . (miperm (mio+w,+s


prints (\c
**\(miprint**
is assumed) the names of all files in or below the current directory,
with all of the file permission bits S_ISUID, S_ISGID, and S_IWOTH set.

*  4.  
  The following command:

    
    find . (miname SCCS (miprune (mio (miprint


recursively prints pathnames of all files in the current directory and
below, but skips directories named SCCS and files in them.

*  5.  
  The following command:

    
    find . (miprint (miname SCCS (miprune


behaves as in the previous example, but prints the names of the SCCS
directories.

*  6.  
  The following command is roughly equivalent to the
  **\(mint**
  extension to
  _test_:

    
    if [ (min "$(find file1 (miprune (minewer file2)" ]; then
        printf %seen "file1 is newer than file2"
    fi


*  7.  
  The descriptions of
  **\(miatime**,
  **\(mictime**,
  and
  **\(mimtime**
  use the terminology
  _n_
  \`\`86\|400 second periods (days)''. For example, a file accessed at 23:59
  is selected by:

    
    find . (miatime (mi1 (miprint


at 00:01 the next day (less than 24 hours later, not more than one day
ago); the midnight boundary between days has no effect on the 24-hour
calculation.

*  8.  
  The following command:

    
    find . ! (miname . (miprune (miname '*.old' (miexec e
        sh (mic 'mv "$@" ../old/' sh {} +


performs the same task as:

    
    mv ./*.old ./.old ./.*.old ../old/


while avoiding an \`\`Argument list too long'' error if there are
a large number of files ending with
**.old**
and without running
_mv_
if there are no such files (and avoiding \`\`No such file or directory''
errors if
**./.old**
does not exist or no files match
**./*.old**
or
**./.*.old**).

The alternative:

    
    find . ! (miname . (miprune (miname '*.old' (miexec mv {} ../old/ e;


is less efficient if there are many files to move because it executes one
_mv_
command per file.

*  9.  
  On systems configured to mount removable media on directories under
  **/media**,
  the following command searches the file hierarchy for files larger
  than 100\|000 KB without searching any mounted removable media:

    
    find / (mipath /media (miprune (mio (misize +200000 (miprint


* 10.  
  Except for the root directory, and
  **"//"**
  on implementations where
  **"//"**
  does not refer to the root directory, no pattern given to
  **\(miname**
  will match a
  &lt;slash&gt;,
  because trailing
  &lt;slash&gt;
  characters are ignored when computing the basename of the file under
  evaluation. Given two empty directories named
  **foo**
  and
  **bar**,
  the following command:

    
    find foo/// bar/// (miname foo (mio (miname 'bar?*'


prints only the line
**"foo///"**.

<a name="rationale"></a>

# Rationale

The
**\(mia**
operator was retained as an optional operator for compatibility with
historical shell scripts, even though it is redundant with expression
concatenation.

The descriptions of the
**'\(mi'**
modifier on the
_mode_
and
_onum_
arguments to the
**\(miperm**
primary agree with historical practice on BSD and System V
implementations. System V and BSD documentation both describe it in
terms of checking additional bits; in fact, it uses the same bits, but
checks for having at least all of the matching bits set instead of
having exactly the matching bits set.

The exact format of the interactive prompts is unspecified. Only the
general nature of the contents of prompts are specified because:

*  *  
  Implementations may desire more descriptive prompts than those
  used on historical implementations.
*  *  
  Since the historical prompt strings do not terminate with
  &lt;newline&gt;
  characters, there is no portable way for another program to interact
  with the prompts of this utility via pipes.

Therefore, an application using this prompting option relies on the
system to provide the most suitable dialog directly with the user,
based on the general guidelines specified.

The
**\(miname**
_file_
operand was changed to use the shell pattern matching notation
so that
_find_
is consistent with other utilities using pattern matching.

The
**\(misize**
operand refers to the size of a file, rather than the number of blocks
it may occupy in the file system. The intent is that the
_st_size_
field defined in the System Interfaces volume of POSIX.1-2008 should be used, not the
_st_blocks_
found in historical implementations. There are at least two reasons for
this:

*  1.  
  In both System V and BSD,
  _find_
  only uses
  _st_size_
  in size calculations for the operands specified by this volume of POSIX.1-2008. (BSD uses
  _st_blocks_
  only when processing the
  **\(mils**
  primary.)
*  2.  
  Users usually think of file size in terms of bytes, which is also the
  unit used by the
  _ls_
  utility for the output from the
  **\(mil**
  option. (In both System V and BSD,
  _ls_
  uses
  _st_size_
  for the
  **\(mil**
  option size field and uses
  _st_blocks_
  for the
  _ls_
  **\(mis**
  calculations. This volume of POSIX.1-2008 does not specify
  _ls_
  **\(mis**.)

The descriptions of
**\(miatime**,
**\(mictime**,
and
**\(mimtime**
were changed from the SVID description of
_n_
\`\`days'' to
_n_
being the result of the integer division of the time difference in
seconds by 86\|400. The description is also different in terms of the
exact timeframe for the
_n_
case (_versus_ the
_+n_
or
_\(min_),
but it matches all known historical implementations. It refers to one
86\|400 second period in the past, not any time from the beginning of
that period to the current time. For example,
**\(miatime**
2 is true if the file was accessed any time in the period from 72 hours
to 48 hours ago.

Historical implementations do not modify
**"{}"**
when it appears as a substring of an
**\(miexec**
or
**\(miok**
_utility_name_
or argument string. There have been numerous user requests for this
extension, so this volume of POSIX.1-2008 allows the desired behavior. At least one recent
implementation does support this feature, but encountered several
problems in managing memory allocation and dealing with multiple
occurrences of
**"{}"**
in a string while it was being developed, so it is not yet required
behavior.

Assuming the presence of
**\(miprint**
was added to correct a historical pitfall that plagues novice users, it
is entirely upwards-compatible from the historical System V
_find_
utility. In its simplest form (\c
_find_
_directory_),
it could be confused with the historical BSD fast
_find_.
The BSD developers agreed that adding
**\(miprint**
as a default expression was the correct decision and have added the
fast
_find_
functionality within a new utility called
_locate_.

Historically, the
**\(miL**
option was implemented using the primary
**\(mifollow**.
The
**\(miH**
and
**\(miL**
options were added for two reasons. First, they offer a finer
granularity of control and consistency with other programs that walk
file hierarchies. Second, the
**\(mifollow**
primary always evaluated to true. As they were historically really
global variables that took effect before the traversal began, some
valid expressions had unexpected results. An example is the expression
**\(miprint**
**\(mio**
**\(mifollow**.
Because
**\(miprint**
always evaluates to true, the standard order of evaluation implies that
**\(mifollow**
would never be evaluated. This was never the case. Historical practice
for the
**\(mifollow**
primary, however, is not consistent. Some implementations always follow
symbolic links on the command line whether
**\(mifollow**
is specified or not. Others follow symbolic links on the command line
only if
**\(mifollow**
is specified. Both behaviors are provided by the
**\(miH**
and
**\(miL**
options, but scripts using the current
**\(mifollow**
primary would be broken if the
**\(mifollow**
option is specified to work either way.

Since the
**\(miL**
option resolves all symbolic links and the
**\(mitype**
_l_
primary is true for symbolic links that still exist after symbolic
links have been resolved, the command:

    
    find (miL . (mitype l


prints a list of symbolic links reachable from the current directory
that do not resolve to accessible files.

A feature of SVR4's
_find_
utility was the
**\(miexec**
primary's
**+**
terminator. This allowed filenames containing special characters
(especially
&lt;newline&gt;
characters) to be grouped together without the problems that occur if
such filenames are piped to
_xargs_.
Other implementations have added other ways to get around this problem,
notably a
**\(miprint0**
primary that wrote filenames with a null byte terminator. This was
considered here, but not adopted. Using a null terminator meant that
any utility that was going to process
_find_'s
**\(miprint0**
output had to add a new option to parse the null terminators it would
now be reading.

The
**"\(miexec**...**{}**+"
syntax adopted was a result of IEEE PASC Interpretation 1003.2 #210. It
should be noted that this is an incompatible change to IEEE&nbsp;Std 1003.2-1992. For example,
the following command printed all files with a
**'\(mi'**
after their name if they are regular files, and a
**'\(pl'**
otherwise:

    
    find / (mitype f (miexec echo {} (mi ';' (mio (miexec echo {} + ';'


The change invalidates usage like this. Even though the previous
standard stated that this usage would work, in practice many did not
support it and the standard developers felt it better to now state that
this was not allowable.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 2.2_, _Quoting_,
_Section 2.13_, _Pattern Matching Notation_,
_Section 2.14_, _Special Built-In Utilities_,
__chmod_\^_,
__mv_\^_,
__pax_\^_,
__sh_\^_,
__test_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__fstatat_\^(\|)_,
__getgrgid_\^(\|)_,
__getpwuid_\^(\|)_

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
