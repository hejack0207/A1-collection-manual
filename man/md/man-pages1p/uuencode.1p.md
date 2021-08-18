# uuencode(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

uuencode
— encode a binary file

<a name="synopsis"></a>

# Synopsis

```


```
    uuencode [(mim] [file] decode_pathname

<a name="description"></a>

# Description

The
_uuencode_
utility shall write an encoded version of the named input file, or
standard input if no
_file_
is specified, to standard output. The output shall be encoded using
one of the algorithms described in the STDOUT section and shall
include the file access permission bits (in
_chmod_
octal or symbolic notation) of the input file and the
_decode_pathname_,
for re-creation of the file on another system that conforms to this volume of POSIX.1-2008.

<a name="options"></a>

# Options

The
_uuencode_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following option shall be supported by the implementation:

* **\(mim**  
  Encode the output using the MIME Base64 algorithm described in STDOUT.
  If
  **\(mim**
  is not specified, the historical algorithm described in STDOUT shall be
  used.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _decode\_pathname_    
  The pathname of the file into which the
  _uudecode_
  utility shall place the decoded file. Specifying a
  _decode_pathname_
  operand of
  **/dev/stdout**
  shall indicate that
  _uudecode_
  is to use standard output. If there are characters in
  _decode_pathname_
  that are not in the portable filename character set the results are
  unspecified.
* _file_  
  A pathname of the file to be encoded.

<a name="stdin"></a>

# Stdin

See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

Input files can be files of any type.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_uuencode_:

* _LANG_  
  Provide a default value for the internationalization variables that are
  unset or null. (See the Base Definitions volume of POSIX.1-2008,
  _Section 8.2_, _Internationalization Variables_
  for the precedence of internationalization variables used to determine
  the values of locale categories.)
* _LC\_ALL_  
  If set to a non-empty string value, override the values of all the
  other internationalization variables.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments and input files).
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout


<a name="uuencode-base64-algorithm"></a>

### uuencode Base64 Algorithm


The standard output shall be a text file (encoded in the character set
of the current locale) that begins with the line:

    
    "begin-base64 %s %sen", <mode>, <decode_pathname>


and ends with the line:

    
    "====en"


In both cases, the lines shall have no preceding or trailing
&lt;blank&gt;
characters.

The encoding process represents 24-bit groups of input bits as output
strings of four encoded characters. Proceeding from left to right, a
24-bit input group shall be formed by concatenating three 8-bit input
groups. Each 24-bit input group then shall be treated as four
concatenated 6-bit groups, each of which shall be translated into a
single digit in the Base64 alphabet. When encoding a bit stream via the
Base64 encoding, the bit stream shall be presumed to be ordered with
the most-significant bit first. That is, the first bit in the stream
shall be the high-order bit in the first byte, and the eighth bit shall
be the low-order bit in the first byte, and so on. Each 6-bit group is
used as an index into an array of 64 printable characters, as shown in
_Table 4-22, uuencode Base64 Values_.

.ce 1
**Table 4-22: uuencode Base64 Values**
.TS
center box tab(!);
cB | cB || cB | cB || cB | cB || cB | cB
n | cf5 || n | cf5 || n | cf5 || n | cf5.
Value!Encoding!Value!Encoding!Value!Encoding!Value!Encoding
_
0!A!17!R!34!i!51!z
1!B!18!S!35!j!52!0
2!C!19!T!36!k!53!1
3!D!20!U!37!l!54!2
4!E!21!V!38!m!55!3
5!F!22!W!39!n!56!4
6!G!23!X!40!o!57!5
7!H!24!Y!41!p!58!6
8!I!25!Z!42!q!59!7
9!J!26!a!43!r!60!8
10!K!27!b!44!s!61!9
11!L!28!c!45!t!62!+
12!M!29!d!46!u!63!/
13!N!30!e!47!v
14!O!31!f!48!w!(pad)!=
15!P!32!g!49!x
16!Q!33!h!50!y
.TE

The character referenced by the index shall be placed in the output
string.

The output stream (encoded bytes) shall be represented in lines of no
more than 76 characters each. All line breaks or other characters not
found in the table shall be ignored by decoding software (see
__uudecode_\^_).

Special processing shall be performed if fewer than 24 bits are
available at the end of a message or encapsulated part of a message. A
full encoding quantum shall always be completed at the end of a
message. When fewer than 24 input bits are available in an input group,
zero bits shall be added (on the right) to form an integral number of
6-bit groups. Output character positions that are not required to
represent actual input data shall be set to the character
**'='**.
Since all Base64 input is an integral number of octets, only the
following cases can arise:

*  1.  
  The final quantum of encoding input is an integral multiple of 24 bits;
  here, the final unit of encoded output shall be an integral multiple of
  4 characters with no
  **'='**
  padding.
*  2.  
  The final quantum of encoding input is exactly 16 bits; here, the final
  unit of encoded output shall be three characters followed by one
  **'='**
  padding character.
*  3.  
  The final quantum of encoding input is exactly 8 bits; here, the final
  unit of encoded output shall be two characters followed by two
  **'='**
  padding characters.

A terminating
**"===="**
evaluates to nothing and denotes the end of the encoded data.

<a name="uuencode-historical-algorithm"></a>

### uuencode Historical Algorithm


The standard output shall be a text file (encoded in the character set
of the current locale) that begins with the line:

    
    "begin %s %sen" <mode>, <decode_pathname>


and ends with the line:

    
    "enden"


In both cases, the lines shall have no preceding or trailing
&lt;blank&gt;
characters.

The algorithm that shall be used for lines in between
**begin**
and
**end**
takes three octets as input and writes four characters of output by
splitting the input at six-bit intervals into four octets, containing
data in the lower six bits only. These octets shall be converted to
characters by adding a value of 0x20 to each octet, so that each octet
is in the range [0x20,0x5f], and then it shall be assumed to represent
a printable character in the ISO/IEC&nbsp;646:\|1991 standard encoded character set. It then
shall be translated into the corresponding character codes for the
codeset in use in the current locale. (For example, the octet 0x41,
representing
**'A'**,
would be translated to
**'A'**
in the current codeset, such as 0xc1 if it were EBCDIC.)

Where the bits of two octets are combined, the least significant bits
of the first octet shall be shifted left and combined with the most
significant bits of the second octet shifted right. Thus the three
octets
_A_,
_B_,
_C_
shall be converted into the four octets:

    
    0x20 + (( A >> 2                    ) & 0x3F)
    0x20 + (((A << 4) |h'n(XX' ((B >> 4) & 0xF)) & 0x3F)
    0x20 + (((B << 2) |h'n(XX' ((C >> 6) & 0x3)) & 0x3F)
    0x20 + (( C                         ) & 0x3F)


These octets then shall be translated into the local character set.

Each encoded line contains a length character, equal to the number of
characters to be decoded plus 0x20 translated to the local character
set as described above, followed by the encoded characters. The
maximum number of octets to be encoded on each line shall be 45.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

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
  Successful completion.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The file is expanded by 35 percent (each three octets become four, plus
control information) causing it to take longer to transmit.

Since this utility is intended to create files to be used for data
interchange between systems with possibly different codesets, and to
represent binary data as a text file, the ISO/IEC&nbsp;646:\|1991 standard was chosen for a
midpoint in the algorithm as a known reference point. The output from
_uuencode_
is a text file on the local system. If the output were in the ISO/IEC&nbsp;646:\|1991 standard
codeset, it might not be a text file (at least because the
&lt;newline&gt;
characters might not match), and the goal of creating a text file would
be defeated. If this text file was then carried to another machine with
the same codeset, it would be perfectly compatible with that system's
_uudecode_.
If it was transmitted over a mail system or sent to a machine with a
different codeset, it is assumed that, as for every other text file,
some translation mechanism would convert it (by the time it reached a
user on the other system) into an appropriate codeset. This
translation only makes sense from the local codeset, not if the file
has been put into a ISO/IEC&nbsp;646:\|1991 standard representation first. Similarly, files
processed by
_uuencode_
can be placed in
_pax_
archives, intermixed with other text files in the same codeset.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

A new algorithm was added at the request of the international community
to parallel work in RFC&nbsp;2045 (MIME). As with the historical
_uuencode_
format, the Base64 Content-Transfer-Encoding is designed to represent
arbitrary sequences of octets in a form that is not humanly readable. A
65-character subset of the ISO/IEC&nbsp;646:\|1991 standard is used, enabling 6 bits to be
represented per printable character. (The extra 65th character,
**'='**,
is used to signify a special processing function.)

This subset has the important property that it is represented
identically in all versions of the ISO/IEC&nbsp;646:\|1991 standard, including US ASCII, and all
characters in the subset are also represented identically in all
versions of EBCDIC. The historical
_uuencode_
algorithm does not share this property, which is the reason that a
second algorithm was added to the ISO&nbsp;POSIX-2 standard.

The string
**"===="**
was used for the termination instead of the end used in the original
format because the latter is a string that could be valid encoded
input.

In an early draft, the
**\(mim**
option was named
**\(mib**
(for Base64), but it was renamed to reflect its relationship to the
RFC&nbsp;2045. A
**\(miu**
was also present to invoke the default algorithm, but since this was
not historical practice, it was omitted as being unnecessary.

See the RATIONALE section in
__uudecode_\^_
for the derivation of the
**/dev/stdout**
symbol.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__chmod_\^_,
__mailx_\^_,
__uudecode_\^_

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
