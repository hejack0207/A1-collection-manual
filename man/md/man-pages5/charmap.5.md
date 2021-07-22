# charmap(5) - character set description file

GNU, 2016-07-17


<a name="description"></a>

# Description

A character set description (charmap) defines all available characters
and their encodings in a character set.
**localedef**(1)
can use charmaps to create locale variants for different character sets.

<a name="syntax"></a>

### Syntax

The charmap file starts with a header that may consist of the
following keywords:

* &lt;_code_set_name_&gt;  
  is followed by the name of the character map.
* &lt;_comment_char_&gt;  
  is followed by a character that will be used as the comment character
  for the rest of the file.
  It defaults to the number sign (#).
* &lt;_escape_char_&gt;  
  is followed by a character that should be used as the escape character
  for the rest of the file to mark characters that should be interpreted
  in a special way.
  It defaults to the backslash (\.
* &lt;_mb_cur_max_&gt;  
  is followed by the maximum number of bytes for a character.
  The default value is 1.
* &lt;_mb_cur_min_&gt;  
  is followed by the minimum number of bytes for a character.
  This value must be less than or equal than
  &lt;_mb_cur_max_&gt;.
  If not specified, it defaults to
  &lt;_mb_cur_max_&gt;.

The character set definition section starts with the keyword
_CHARMAP_
in the first column.

The following lines may have one of the two following forms to
define the character set:

* &lt;_character_&gt;&nbsp;_byte-sequence&nbsp;comment_  
  This form defines exactly one character and its byte sequence,
  _comment_
  being optional.
* &lt;_character_&gt;..&lt;_character_&gt;&nbsp;_byte-sequence&nbsp;comment_  
  This form defines a character range and its byte sequence,
  _comment_
  being optional.

The character set definition section ends with the string
_END CHARMAP_.

The character set definition section may optionally be followed by a
section to define widths of characters.

The
_WIDTH_DEFAULT_
keyword can be used to define the default width for all characters
not explicitly listed.
The default character width is 1.

The width section for individual characters starts with the keyword
_WIDTH_
in the first column.

The following lines may have one of the two following forms to
define the widths of the characters:

* &lt;_character_&gt;&nbsp;_width_  
  This form defines the width of exactly one character.
* &lt;_character_&gt;...&lt;_character_&gt;&nbsp;_width_  
  This form defines the width for all the characters in the range.

The width definition section ends with the string
_END WIDTH_.

<a name="files"></a>

# Files


* _/usr/share/i18n/charmaps_  
  Usual default character map path.

<a name="conforming-to"></a>

# Conforming to

POSIX.2.

<a name="example"></a>

# Example

The Euro sign is defined as follows in the
_UTF-8_
charmap:

    <U20AC>     /xe2/x82/xac EURO SIGN

<a name="see-also"></a>

# See Also

**iconv**(1),
**locale**(1),
**localedef**(1),
**locale**(5),
**charsets**(7)

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
