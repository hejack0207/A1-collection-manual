# repertoiremap(5) - map symbolic character names to Unicode code points

GNU, 2016-07-17


<a name="description"></a>

# Description

A repertoire map defines mappings between symbolic character names
(mnemonics) and Unicode code points when compiling a locale with
**localedef**(1).
Using a repertoire map is optional, it is needed only when symbolic
names are used instead of now preferred Unicode code points.

<a name="syntax"></a>

### Syntax

The repertoiremap file starts with a header that may consist of the
following keywords:

* _comment_char_  
  is followed by a character that will be used as the
  comment character for the rest of the file.
  It defaults to the number sign (#).
* _escape_char_  
  is followed by a character that should be used as the escape character
  for the rest of the file to mark characters that should be interpreted
  in a special way.
  It defaults to the backslash (\.

The mapping section starts with the keyword
_CHARIDS_
in the first column.

The mapping lines have the following form:

* _&lt;symbolic-name&gt; &lt;code-point&gt; comment_  
  This defines exactly one mapping,
  _comment_
  being optional.

The mapping section ends with the string
_END CHARIDS_.

<a name="files"></a>

# Files


* _/usr/share/i18n/repertoiremaps_  
  Usual default repertoire map path.

<a name="conforming-to"></a>

# Conforming to

POSIX.2.

<a name="notes"></a>

# Notes

Repertoire maps are deprecated in favor of Unicode code points.

<a name="example"></a>

# Example

A mnemonic for the Euro sign can be defined as follows:

    <Eu> <U20AC> EURO SIGN

<a name="see-also"></a>

# See Also

**locale**(1),
**localedef**(1),
**charmap**(5),
**locale**(5)

<a name="colophon"></a>

# Colophon

This page is part of release 4.16 of the Linux
_man-pages_
project.
A description of the project,
information about reporting bugs,
and the latest version of this page,
can be found at
https://www.kernel.org/doc/man-pages/.
