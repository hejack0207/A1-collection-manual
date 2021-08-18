# patch(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

patch
— apply changes to files

<a name="synopsis"></a>

# Synopsis

```


```
    patch [(miblNR] [(mic|(mie|(min|(miu] [(mid dir] [(miD define] [(mii patchfile]
        [(mio outfile] [(mip num] [(mir rejectfile] [file]

<a name="description"></a>

# Description

The
_patch_
utility shall read a source (patch) file containing any of four
forms of difference (diff) listings produced by the
_diff_
utility (normal, copied context, unified context, or in the style of
_ed_)
and apply those differences to a file. By default,
_patch_
shall read from the standard input.

The
_patch_
utility shall attempt to determine the type of the
_diff_
listing, unless overruled by a
**\(mic**,
**\(mie**,
**\(min**,
or
**\(miu**
option.

If the patch file contains more than one patch,
_patch_
shall attempt to apply each of them as if they came from separate patch
files. (In this case, the application shall ensure that the name of the
patch file is determinable for each
_diff_
listing.)

<a name="options"></a>

# Options

The
_patch_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mib**  
  Save a copy of the original contents of each modified file, before the
  differences are applied, in a file of the same name with the suffix
  **.orig**
  appended to it. If the file already exists, it shall be overwritten;
  if multiple patches are applied to the same file, the
  **.orig**
  file shall be written only for the first patch. When the
  **\(mio**
  _outfile_
  option is also specified,
  _file_\c
  **.orig**
  shall not be created but, if
  _outfile_
  already exists,
  _outfile_\c
  **.orig**
  shall be created.
* **\(mic**  
  Interpret the patch file as a copied context difference (the output
  of the utility
  _diff_
  when the
  **\(mic**
  or
  **\(miC**
  options are specified).
* **\(mid&nbsp;dir**  
  Change the current directory to
  _dir_
  before processing as described in the EXTENDED DESCRIPTION section.
* **\(miD&nbsp;define**  
  Mark changes with one of the following C preprocessor constructs:

    
    #ifdef define
    ...
    #endif
    
    #ifndef define
    ...
    #endif


optionally combined with the C preprocessor construct
**#else**.
If the patched file is processed with the C preprocessor, where the
macro
_define_
is defined, the output shall contain the changes from the patch file;
otherwise, the output shall not contain the patches specified in the
patch file.

* **\(mie**  
  Interpret the patch file as an
  _ed_
  script, rather than a
  _diff_
  script.
* **\(mii&nbsp;patchfile**  
  Read the patch information from the file named by the pathname
  _patchfile_,
  rather than the standard input.
* **\(mil**  
  (The letter ell.) Cause any sequence of
  &lt;blank&gt;
  characters in the difference script to match any sequence of
  &lt;blank&gt;
  characters in the input file. Other characters shall be matched exactly.
* **\(min**  
  Interpret the script as a normal difference.
* **\(miN**  
  Ignore patches where the differences have already been applied to the
  file; by default, already-applied patches shall be rejected.
* **\(mio&nbsp;outfile**  
  Instead of modifying the files (specified by the
  _file_
  operand or the difference listings) directly, write a copy of the file
  referenced by each patch, with the appropriate differences applied, to
  _outfile_.
  Multiple patches for a single file shall be applied to the intermediate
  versions of the file created by any previous patches, and shall result
  in multiple, concatenated versions of the file being written to
  _outfile_.
* **\(mip&nbsp;num**  
  For all pathnames in the patch file that indicate the names of files to
  be patched, delete
  _num_
  pathname components from the beginning of each pathname. If the
  pathname in the patch file is absolute, any leading
  &lt;slash&gt;
  characters shall be considered the first component (that is,
  **\(mip&nbsp;1**
  shall remove the leading
  &lt;slash&gt;
  characters). Specifying
  **\(mip&nbsp;0**
  shall cause the full pathname to be used. If
  **\(mip**
  is not specified, only the basename (the final pathname component)
  shall be used.
* **\(miR**  
  Reverse the sense of the patch script; that is, assume that the
  difference script was created from the new version to the old version.
  The
  **\(miR**
  option cannot be used with
  _ed_
  scripts. The
  _patch_
  utility shall attempt to reverse each portion of the script before
  applying it. Rejected differences shall be saved in swapped format. If
  this option is not specified, and until a portion of the patch file is
  successfully applied,
  _patch_
  attempts to apply each portion in its reversed sense as well as in its
  normal sense. If the attempt is successful, the user shall be prompted
  to determine whether the
  **\(miR**
  option should be set.
* **\(mir&nbsp;rejectfile**  
  Override the default reject filename. In the default case, the reject
  file shall have the same name as the output file, with the suffix
  **.rej**
  appended to it; see
  _Patch Application_.
* **\(miu**  
  Interpret the patch file as a unified context difference (the output
  of the
  _diff_
  utility when the
  **\(miu**
  or
  **\(miU**
  options are specified).

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of a file to patch.

<a name="stdin"></a>

# Stdin

See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

Input files shall be text files.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_patch_:

* _LANG_  
  Provide a default value for the internationalization variables that are
  unset or null. (See the Base Definitions volume of POSIX.1-2008,
  _Section 8.2_, _Internationalization Variables_
  the precedence of internationalization variables used to determine the
  values of locale categories.)
* _LC\_ALL_  
  If set to a non-empty string value, override the values of all the
  other internationalization variables.
* _LC\_COLLATE_    
  Determine the locale for the behavior of ranges, equivalence classes,
  and multi-character collating elements used in the extended regular
  expression defined for the
  **yesexpr**
  locale keyword in the
  _LC_MESSAGES_
  category.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of text
  data as characters (for example, single-byte as opposed to multi-byte
  characters in arguments and input files), and the behavior of character
  classes used in the extended regular expression defined for the
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
* _LC\_TIME_  
  Determine the locale for recognizing the format of file timestamps
  written by the
  _diff_
  utility in a context-difference input file.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

Not used.

<a name="stderr"></a>

# Stderr

The standard error shall be used for diagnostic and informational
messages.

<a name="output-files"></a>

# Output Files

The output of the
_patch_
utility, the save files (\c
**.orig**
suffixes), and the reject files (\c
**.rej**
suffixes) shall be text files.

<a name="extended-description"></a>

# Extended Description

A patch file may contain patching instructions for more than one file;
filenames shall be determined as specified in
_Filename Determination_.
When the
**\(mib**
option is specified, for each patched file, the original shall be saved
in a file of the same name with the suffix
**.orig**
appended to it.

For each patched file, a reject file may also be created as noted in
_Patch Application_.
In the absence of a
**\(mir**
option, the name of this file shall be formed by appending the suffix
**.rej**
to the original filename.

<a name="patch-file-format"></a>

### Patch File Format


The patch file shall contain zero or more lines of header information
followed by one or more patches. Each patch shall contain zero or more
lines of filename identification in the format produced by the
**\(mic**,
**\(miC**,
**\(miu**,
or
**\(miU**
options of the
_diff_
utility, and one or more sets of
_diff_
output, which are customarily called _hunks_.

The
_patch_
utility shall recognize the following expression in the header
information:

* **Index:&nbsp;pathname**    
  The file to be patched is named
  _pathname_.

If all lines (including headers) within a patch begin with the same
leading sequence of
&lt;blank&gt;
characters, the
_patch_
utility shall remove this sequence before proceeding. Within each
patch, if the type of difference is common context, the
_patch_
utility shall recognize the following expressions:

* ***&nbsp;_filename&nbsp;timestamp_    
  The patches arose from
  _filename_.
* \(mi\|\(mi\|\(mi&nbsp;_filename&nbsp;timestamp_    
  The patches should be applied to
  _filename_.

If the type of difference is unified context, the
_patch_
utility shall recognize the following expressions:

* \(mi\|\(mi\|\(mi&nbsp;_filename&nbsp;timestamp_    
  The patches arose from
  _filename_.
* +\|+\|+&nbsp;_filename&nbsp;timestamp_    
  The patches should be applied to
  _filename_.

Each hunk within a patch shall be the
_diff_
output to change a line range within the original file. The line
numbers for successive hunks within a patch shall occur in ascending
order.

<a name="filename-determination"></a>

### Filename Determination


If no
_file_
operand is specified,
_patch_
shall perform the following steps to determine the filename to use:

*  1.  
  If the type of
  _diff_
  is context, the
  _patch_
  utility shall delete pathname components (as specified by the
  **\(mip**
  option) from the filename on the line beginning with
  **"***"**
  (if copied context) or
  **"\(mi\|\(mi\|\(mi"**
  (if unified context), then test for the existence of this file relative
  to the current directory (or the directory specified with the
  **\(mid**
  option). If the file exists, the
  _patch_
  utility shall use this filename.
*  2.  
  If the type of
  _diff_
  is context, the
  _patch_
  utility shall delete the pathname components (as specified by the
  **\(mip**
  option) from the filename on the line beginning with
  **"\(mi\|\(mi\|\(mi"**
  (if copied context) or
  **"+\|+\|+"**
  (if unified context), then test for the existence of this file relative
  to the current directory (or the directory specified with the
  **\(mid**
  option). If the file exists, the
  _patch_
  utility shall use this filename.
*  3.  
  If the header information contains a line beginning with the string
  **Index:**,
  the
  _patch_
  utility shall delete pathname components (as specified by the
  **\(mip**
  option) from this line, then test for the existence of this file
  relative to the current directory (or the directory specified with the
  **\(mid**
  option). If the file exists, the
  _patch_
  utility shall use this filename.
*  4.  
  If an
  **SCCS**
  directory exists in the current directory,
  _patch_
  shall attempt to perform a
  _get_
  **\(mie**
  **SCCS/s.**\c
  _filename_
  command to retrieve an editable version of the file. If the file
  exists, the
  _patch_
  utility shall use this filename.
*  5.  
  The
  _patch_
  utility shall write a prompt to standard output and request a filename
  interactively from the controlling terminal (for example,
  **/dev/tty**).

<a name="patch-application"></a>

### Patch Application


If the
**\(mic**,
**\(mie**,
**\(min**,
or
**\(miu**
option is present, the
_patch_
utility shall interpret information within each hunk as a copied context
difference, an
_ed_
difference, a normal difference, or a unified context difference,
respectively. In the absence of any of these options, the
_patch_
utility shall determine the type of difference based on the format of
information within the hunk.

For each hunk, the
_patch_
utility shall begin to search for the place to apply the patch at the
line number at the beginning of the hunk, plus or minus any offset used
in applying the previous hunk. If lines matching the hunk context are
not found,
_patch_
shall scan both forwards and backwards at least 1\|000 bytes for a set
of lines that match the hunk context.

If no such place is found and it is a context difference, then another
scan shall take place, ignoring the first and last line of context. If
that fails, the first two and last two lines of context shall be
ignored and another scan shall be made. Implementations may search
more extensively for installation locations.

If no location can be found, the
_patch_
utility shall append the hunk to the reject file. A rejected hunk that
is a copied context difference, an
_ed_
difference, or a normal difference shall be written in
copied-context-difference format regardless of the format of the patch
file. It is implementation-defined whether a rejected hunk that is
a unified context difference is written in copied-context-difference
format or in unified-context-difference format.
If the input was a normal or
_ed_-style
difference, the reject file may contain differences with zero lines of
context. The line numbers on the hunks in the reject file may be
different from the line numbers in the patch file since they shall
reflect the approximate locations for the failed hunks in the new file
rather than the old one.

If the type of patch is an
_ed_
diff, the implementation may accomplish the patching by invoking the
_ed_
utility.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  Successful completion.
* \01  
  One or more lines were written to a reject file.
* &gt;1  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Patches that cannot be correctly placed in the file shall be written to
a reject file.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The
**\(miR**
option does not work with
_ed_
scripts because there is too little information to reconstruct the
reverse operation.

The
**\(mip**
option makes it possible to customize a patch file to local user
directory structures without manually editing the patch file. For
example, if the filename in the patch file was:

    
    /curds/whey/src/blurfl/blurfl.c


Setting
**\(mip&nbsp;0**
gives the entire pathname unmodified;
**\(mip&nbsp;1**
gives:

    
    curds/whey/src/blurfl/blurfl.c


without the leading
&lt;slash&gt;,
**\(mip&nbsp;4**
gives:

    
    blurfl/blurfl.c


and not specifying
**\(mip**
at all gives:

    
    blurfl.c .


<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

Some of the functionality in historical
_patch_
implementations was not specified. The following documents those
features present in historical implementations that have not been
specified.

A deleted piece of functionality was the
**'\(pl'**
pseudo-option allowing an additional set of options and a patch file
operand to be given. This was seen as being insufficiently useful to
standardize.

In historical implementations, if the string
**"Prereq:"**
appeared in the header, the
_patch_
utility would search for the corresponding version information (the
string specified in the header, delimited by
&lt;blank&gt;
characters or the beginning or end of a line or the file) anywhere in
the original file. This was deleted as too simplistic and insufficiently
trustworthy a mechanism to standardize. For example, if:

    
    Prereq: 1.2


were in the header, the presence of a delimited 1.2 anywhere in the
file would satisfy the prerequisite.

The following options were dropped from historical implementations of
_patch_
as insufficiently useful to standardize:

* **\(mib**  
  The
  **\(mib**
  option historically provided a method for changing the name extension
  of the backup file from the default
  **.orig**.
  This option has been modified and retained in this volume of POSIX.1-2008.
* **\(miF**  
  The
  **\(miF**
  option specified the number of lines of a context diff to ignore when
  searching for a place to install a patch.
* **\(mif**  
  The
  **\(mif**
  option historically caused
  _patch_
  not to request additional information from the user.
* **\(mir**  
  The
  **\(mir**
  option historically provided a method of overriding the extension of
  the reject file from the default
  **.rej**.
* **\(mis**  
  The
  **\(mis**
  option historically caused
  _patch_
  to work silently unless an error occurred.
* **\(mix**  
  The
  **\(mix**
  option historically set internal debugging flags.

In some file system implementations, the saving of a
**.orig**
file may produce unwanted results. In the case of 12, 13, or
14-character filenames (on file systems supporting 14-character
maximum filenames), the
**.orig**
file overwrites the new file. The reject file may also exceed this
filename limit. It was suggested, due to some historical practice,
that a
&lt;tilde&gt;
(\c
**'~'**)
suffix be used instead of
**.orig**
and some other character instead of the
**.rej**
suffix. This was rejected because it is not obvious to the user which
file is which. The suffixes
**.orig**
and
**.rej**
are clearer and more understandable.

The
**\(mib**
option has the opposite sense in some historical implementations—do
not save the
**.orig**
file. The default case here is not to save the files, making
_patch_
behave more consistently with the other standard utilities.

The
**\(miw**
option in early proposals was changed to
**\(mil**
to match historical practice.

The
**\(miN**
option was included because without it, a non-interactive application
cannot reject previously applied patches. For example, if a user is
piping the output of
_diff_
into the
_patch_
utility, and the user only wants to patch a file to a newer version
non-interactively, the
**\(miN**
option is required.

Changes to the
**\(mil**
option description were proposed to allow matching across
&lt;newline&gt;
characters in addition to just
&lt;blank&gt;
characters. Since this is not historical practice, and since some
ambiguities could result, it is suggested that future developments in
this area utilize another option letter, such as
**\(miL**.

The
**\(miu**
option of GNU
_patch_
has been added, along with support for unified context formats.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__diff_\^_,
__ed_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
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
